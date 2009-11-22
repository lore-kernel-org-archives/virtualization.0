From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: Fix warnings and bad type handling
Date: Sun, 22 Nov 2009 12:28:01 +0200
Message-ID: <20091122102801.GA13644__10074.9060664841$1258885980$gmane$org@redhat.com>
References: <20091117154213.3683.94554.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091117154213.3683.94554.stgit@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] vhost: fix warnings on 32 bit systems

Fix compiler warning about discarding top 32 bit
of data on 32 bit systems, and document that
dicarded bits must be 0.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

So I think the below slightly tweaked version of
Alan's patch is a bit better. OK?

 drivers/vhost/vhost.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 97233d5..e7b4dea 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -322,6 +322,8 @@ static long vhost_set_vring(struct vhost_dev *d, int ioctl, void __user *argp)
 			r = -EOPNOTSUPP;
 			break;
 		}
+		/* For 32bit, verify that the top 32bits of the user
+		   data are set to zero. */
 		if ((u64)(unsigned long)a.desc_user_addr != a.desc_user_addr ||
 		    (u64)(unsigned long)a.used_user_addr != a.used_user_addr ||
 		    (u64)(unsigned long)a.avail_user_addr != a.avail_user_addr) {
@@ -334,7 +336,8 @@ static long vhost_set_vring(struct vhost_dev *d, int ioctl, void __user *argp)
 			r = -EINVAL;
 			break;
 		}
-		r = init_used(vq, (struct vring_used __user *)a.used_user_addr);
+		r = init_used(vq, (struct vring_used __user *)(unsigned long)
+			      a.used_user_addr);
 		if (r)
 			break;
 		vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
-- 
1.6.5.2.143.g8cc62
