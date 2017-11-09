From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] vhost/vsock: fix uninitialized vhost_vsock->guest_cid
Date: Thu,  9 Nov 2017 13:29:10 +0000
Message-ID: <20171109132910.23150-1-stefanha__23573.5517497689$1510234161$gmane$org@redhat.com>
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
To: kvm@vger.kernel.org
Cc: Gao feng <omarapazanadi@gmail.com>, Peng Tao <bergwolf@gmail.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The vhost_vsock->guest_cid field is uninitialized when /dev/vhost-vsock
is opened until the VHOST_VSOCK_SET_GUEST_CID ioctl is called.

kvmalloc(..., GFP_KERNEL | __GFP_RETRY_MAYFAIL) does not zero memory.
All other vhost_vsock fields are initialized explicitly so just
initialize this field too.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c9de9c41aa97..5a5e981bd8e4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -518,6 +518,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vsock->guest_cid = 0; /* no CID assigned yet */
+
 	atomic_set(&vsock->queued_replies, 0);
 
 	vqs[VSOCK_VQ_TX] = &vsock->vqs[VSOCK_VQ_TX];
-- 
2.13.6
