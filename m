From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Date: Thu, 7 Jun 2018 20:10:01 +0300
Message-ID: <20180607183629-mutt-send-email-mst__19409.644304733$1528391296$gmane$org@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com>
	<000000000000cf4578056ab12452@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <000000000000cf4578056ab12452@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
Cc: willemb@google.com, avagin@openvz.org, kvm@vger.kernel.org, netdev@vger.kernel.org, matthew@mjdsystems.ca, linux-kernel@vger.kernel.org, mingo@kernel.org, syzkaller-bugs@googlegroups.com, edumazet@google.com, viro@zeniv.linux.org.uk, dingtianhong@huawei.com, pabeni@redhat.com, virtualization@lists.linux-foundation.org, davem@davemloft.net, elena.reshetova@intel.com
List-Id: virtualization@lists.linuxfoundation.org

#syz test: https://github.com/google/kmsan.git master

Subject: vhost: fix info leak

Fixes: CVE-2018-1118
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f0be5f35ab28..9beefa6ed1ce 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
 	if (!node)
 		return NULL;
+
+	/* Make sure all padding within the structure is initialized. */
+	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
