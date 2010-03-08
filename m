From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] virtio: console: Fix type of 'len' as unsigned int
Date: Mon,  8 Mar 2010 14:16:59 +0530
Message-ID: <1268038020-12539-2-git-send-email-amit.shah@redhat.com>
References: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@linux-foundation.org, quintela@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We declare 'len' as int type but it should be 'unsigned int', as
get_buf() wants it to be.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reported-by: Juan Quintela <quintela@redhat.com>
---
 drivers/char/virtio_console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 213373b..2bd6a9c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -379,7 +379,7 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	struct scatterlist sg[1];
 	struct virtio_console_control cpkt;
 	struct virtqueue *vq;
-	int len;
+	unsigned int len;
 
 	if (!use_multiport(port->portdev))
 		return 0;
-- 
1.6.2.5
