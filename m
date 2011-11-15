From: Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH] virtio-mmio: Correct the name of the guest features selector
Date: Tue, 15 Nov 2011 16:17:18 +0200
Message-ID: <1321366638-28408-1-git-send-email-levinsasha928@gmail.com>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Guest features selector spelling mistake.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---

Hopefully not too late to fix, should possibly be done in one of the next RCs
since it's user facing.

 include/linux/virtio_mmio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/virtio_mmio.h b/include/linux/virtio_mmio.h
index 27c7ede..5c7b6f0 100644
--- a/include/linux/virtio_mmio.h
+++ b/include/linux/virtio_mmio.h
@@ -63,7 +63,7 @@
 #define VIRTIO_MMIO_GUEST_FEATURES	0x020
 
 /* Activated features set selector - Write Only */
-#define VIRTIO_MMIO_GUEST_FEATURES_SET	0x024
+#define VIRTIO_MMIO_GUEST_FEATURES_SEL	0x024
 
 /* Guest's memory page size in bytes - Write Only */
 #define VIRTIO_MMIO_GUEST_PAGE_SIZE	0x028
-- 
1.7.8.rc1
