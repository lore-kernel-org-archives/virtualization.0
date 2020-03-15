From: Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH 0/2] doc: zh_CN: facilitate translation for filesystems
Date: Sun, 15 Mar 2020 02:27:58 -0700
Message-ID: <20200315092810.87008-1-wenhu.wang@vivo.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Biggers <ebiggers@google.com>, Wang Wenhu <wenhu.wang@vivo.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: kernel@vivo.com
List-Id: virtualization@lists.linuxfoundation.org

This patch series set up the basic facility for the translation work
of the docs residing on filesystems into Chinese, indexing the filesystems
directory and adding one indexed translation into it. The virtiofs.rst
added is not only a translation itself but also an simple example that
future developers would take.

The detailed diff info also shows the basic essential markups of
the toctree and reStructuredText, at least for the most simple occasions.
More translations of filesystems are on their way, and futher,
of more subsystems.

---
Wang Wenhu (2):
  doc: zh_CN: index files in filesystems subdirectory
  doc: zh_CN: add translation for virtiofs

 Documentation/filesystems/index.rst           |  2 +
 Documentation/filesystems/virtiofs.rst        |  2 +
 .../translations/zh_CN/filesystems/index.rst  | 29 +++++++++
 .../zh_CN/filesystems/virtiofs.rst            | 62 +++++++++++++++++++
 Documentation/translations/zh_CN/index.rst    |  1 +
 5 files changed, 96 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
 create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs.rst

-- 
2.17.1
