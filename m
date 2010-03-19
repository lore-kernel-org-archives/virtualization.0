From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 6/9] virtio-serial: Remove redundant check for 0-sized write
	request
Date: Fri, 19 Mar 2010 17:28:43 +0530
Message-ID: <1268999926-29560-7-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-6-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The check for a 0-sized write request to a guest port is not necessary;
the while loop below won't be executed in this case and all will be
fine.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-serial-bus.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index 19e8c59..2603dcd 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -83,9 +83,6 @@ static size_t write_to_port(VirtIOSerialPort *port,
     if (!virtio_queue_ready(vq)) {
         return 0;
     }
-    if (!size) {
-        return 0;
-    }
 
     while (offset < size) {
         int i;
-- 
1.6.2.5
