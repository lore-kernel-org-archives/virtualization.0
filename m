From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/6] virtio: get rid of redundant VIRTIO_ID_9P definition
Date: Mon, 21 Sep 2009 16:28:25 +0930
Message-ID: <200909211628.26135.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org

From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?=

VIRTIO_ID_9P is already defined in include/linux/virtio_9p.h
so use that definition instead.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
---
 net/9p/trans_virtio.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -337,8 +337,6 @@ static void p9_virtio_remove(struct virt
 	}
 }
 
-#define VIRTIO_ID_9P 9
-
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_9P, VIRTIO_DEV_ANY_ID },
 	{ 0 },
