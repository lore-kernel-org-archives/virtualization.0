From: Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH 0/1] Add uvirtio for testing
Date: Tue, 28 Apr 2020 13:47:28 -0700
Message-ID: <20200428204729.64569-1-ytht.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
Cc: Lepton Wu <ytht.net@gmail.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This is a way to create virtio based devices from user space. This is the
background for this patch:

We have some images works fine under qemu, we'd like to also run the same image
on Google Cloud. Currently Google Cloud doesn't support virtio-vga. I had a 
patch to create a virtio-vga from kernel directly:
https://www.spinics.net/lists/dri-devel/msg248573.html

Then I got feedback from Gerd that maybe it's better to change that to something
like uvirtio. Since I really don't have other use cases for now, I just implemented the minimal stuff which work for my use case.

Lepton Wu (1):
  virtio: Add uvirtio driver

 drivers/virtio/Kconfig        |   8 +
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/uvirtio.c      | 405 ++++++++++++++++++++++++++++++++++
 include/linux/uvirtio.h       |   8 +
 include/uapi/linux/uvirtio.h  |  69 ++++++
 samples/uvirtio/Makefile      |   9 +
 samples/uvirtio/uvirtio-vga.c |  63 ++++++
 7 files changed, 563 insertions(+)
 create mode 100644 drivers/virtio/uvirtio.c
 create mode 100644 include/linux/uvirtio.h
 create mode 100644 include/uapi/linux/uvirtio.h
 create mode 100644 samples/uvirtio/Makefile
 create mode 100644 samples/uvirtio/uvirtio-vga.c

-- 
2.26.2.303.gf8c07b1a785-goog
