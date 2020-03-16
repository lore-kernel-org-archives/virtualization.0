From: Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v3,1/2] doc: zh_CN: index files in filesystems subdirectory
Date: Mon, 16 Mar 2020 04:01:31 -0700
Message-ID: <20200316110143.97848-1-wenhu.wang@vivo.com>
References: <20200315155258.91725-1-wenhu.wang@vivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200315155258.91725-1-wenhu.wang@vivo.com>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jaskaran Singh <jaskaransingh7654321@gmail.com>, "Tobin C. Harding" <tobin@kernel.org>, Wang Wenhu <wenhu.wang@vivo.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: kernel@vivo.com
List-Id: virtualization@lists.linuxfoundation.org

Add filesystems subdirectory into the table of Contents for zh_CN,
all translations residing on it would be indexed conveniently.

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changelog since v1:
 - v2: added SPDX header
 - v3: rm raw latex field in translations/zh_CN/filesystems/index.rst
        for none compatibility test with Sphinx 1.7.9 or later.
       Actually only Sphinx v1.6.7 avalible for me currently.
       Reviewed-by labels added
---
 Documentation/filesystems/index.rst           |  2 ++
 .../translations/zh_CN/filesystems/index.rst  | 25 +++++++++++++++++++
 Documentation/translations/zh_CN/index.rst    |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 386eaad008b2..ab47d5b1f092 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -1,3 +1,5 @@
+.. _filesystems_index:
+
 ===============================
 Filesystems in the Linux kernel
 ===============================
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
new file mode 100644
index 000000000000..f5adcdc5fa1c
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
+:Translator: Wang Wenhu <wenhu.wang@vivo.com>
+
+.. _cn_filesystems_index:
+
+========================
+Linux Kernel中的文件系统
+========================
+
+这份正在开发的手册或许在未来某个辉煌的日子里以易懂的形式将Linux虚拟\
+文件系统（VFS）层以及基于其上的各种文件系统如何工作呈现给大家。当前\
+可以看到下面的内容。
+
+文件系统
+========
+
+文件系统实现文档。
+
+.. toctree::
+   :maxdepth: 2
+
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index d3165535ec9e..76850a5dd982 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -14,6 +14,7 @@
    :maxdepth: 2
 
    process/index
+   filesystems/index
 
 目录和表格
 ----------
-- 
2.17.1
