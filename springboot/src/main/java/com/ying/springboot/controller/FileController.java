package com.ying.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

@RestController
@RequestMapping("/file")
public class FileController {

    private static final String UPLOAD_DIRECTORY = "D:/AHub/WYZ001/file";

    @PostMapping("/upload")
    public ResponseEntity<?> handleFileUpload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return ResponseEntity.badRequest().body("上传文件不能为空");
        }
        try {
            String fileName = saveFile(file, UPLOAD_DIRECTORY);
            return ResponseEntity.ok("http://localhost:9090/file/" + fileName);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("文件上传失败: " + e.getMessage());
        }
    }
    // 从配置文件中读取文件上传路径
    private String fileUploadPath = "D:/AHub/WYZ001/file/";

    @PostMapping("/uploadImg")
    public ResponseEntity<Map<String, Object>> uploadImg(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        List<Map<String, String>> dataList = new ArrayList<>();

        if (file.isEmpty()) {
            response.put("errno", 1);
            response.put("data", dataList); // 空数组
            response.put("message", "文件不能为空");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            // 获取文件原始名称
            String originalFilename = file.getOriginalFilename();
            // 获取文件类型
            String type = FileUtil.extName(originalFilename);
            // 生成文件名
            String filename = IdUtil.fastSimpleUUID() + "." + type;
            // 文件存储路径
            Path filePath = Paths.get(fileUploadPath, filename);
            // 确保父目录存在
            File parentDir = filePath.toFile().getParentFile();
            if (!parentDir.exists()) {
                parentDir.mkdirs();
            }
            // 写入文件到磁盘
            File dest = filePath.toFile();
            file.transferTo(dest);

            // 构建Response的data部分
            Map<String, String> dataItem = new HashMap<>();
            dataItem.put("url", "http://localhost:9090/file/" + filename);
            dataItem.put("alt", originalFilename); // 可以根据实际情况提供或为空字符串
            dataItem.put("href", ""); // 可以根据实际情况提供或为空字符串
            dataList.add(dataItem);

            // 设置errno和data
            response.put("errno", 0);
            response.put("data", dataList);

            // `ResponseEntity<Map<String, Object>>` 显式指定了响应体的类型
            return ResponseEntity.ok().body(response);

        } catch (IOException e) {
            response.put("errno", 1);
            response.put("data", dataList); // 空数组
            response.put("message", "文件上传失败: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
//    @PostMapping("/uploadImg")
//    public ResponseEntity<?> uploadImg(@RequestParam("image") MultipartFile image) {
//        if (image.isEmpty()) {
//            return ResponseEntity.badRequest().body("{\"errno\": 1, \"message\": \"文件不能为空\"}");
//        }
//
//        try {
//            // 获取文件原始名字
//            String originalFilename = image.getOriginalFilename();
//            // 获取文件类型
//            String type = FileUtil.extName(originalFilename);
//            // 生成文件名
//            String filename = IdUtil.fastSimpleUUID() + "." + type;
//            // 文件存储路径
//            Path filePath = Paths.get(fileUploadPath, filename);
//            // 确保父目录存在
//            File parentDir = filePath.toFile().getParentFile();
//            if (!parentDir.exists()) {
//                parentDir.mkdirs();
//            }
//            // 写入文件到磁盘
//            File dest = filePath.toFile();
//            image.transferTo(dest);
//
//            // 构建Response的data部分
//            List<Map<String, String>> dataList = new ArrayList<>();
//            Map<String, String> dataItem = new HashMap<>();
//            dataItem.put("url", "http://localhost:9090/file/" + filename);
//            dataItem.put("alt", originalFilename);
//            dataItem.put("href", "");
//            dataList.add(dataItem);
//
//            // 构建整个Response
//            Map<String, Object> response = new HashMap<>();
//            response.put("errno", 0); // "errno"为0表示没有错误
//            response.put("data", dataList);
//
//            return ResponseEntity.ok(response);
//
//        } catch (IOException e) {
//            e.printStackTrace();
//            return ResponseEntity.internalServerError().body("{\"errno\": 1, \"message\": \"文件上传失败\"}");
//        }
//    }

    // Util method for saving files
    private String saveFile(MultipartFile file, String uploadDir) throws IOException {
        String originalFileName = file.getOriginalFilename();
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String storedFileName = UUID.randomUUID().toString() + fileExtension;
        Path destinationFilePath = Paths.get(uploadDir, storedFileName);
        Files.copy(file.getInputStream(), destinationFilePath, StandardCopyOption.REPLACE_EXISTING);
        return storedFileName;
    }

    @GetMapping("/export")
    public ResponseEntity<Resource> handleFileExport() {
        // Mocked file name of an existing file for demo. This should be dynamic based on your application logic.
        String filename = "sample-export.xlsx";
        Path file = Paths.get(UPLOAD_DIRECTORY).resolve(filename);
        Resource resource;
        try {
            resource = new UrlResource(file.toUri());
        } catch (MalformedURLException e) {
            return ResponseEntity.badRequest().body(null);
        }

        if (resource.exists() || resource.isReadable()) {
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(resource);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    private final Path fileStorageLocation = Paths.get("D:/AHub/WYZ001/file");

    @GetMapping("/{filename:.+}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String filename) {
        try {
            Path filePath = fileStorageLocation.resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok().body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}