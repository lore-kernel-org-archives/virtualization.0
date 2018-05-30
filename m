From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [net] vhost: Use kzalloc() to allocate vhost_msg_node
Date: Wed, 30 May 2018 06:01:09 +0300
Message-ID: <20180530055704-mutt-send-email-mst@kernel.org>
References: <20180427154502.GA22544@la.guarana.org>
	<20180529221908.GA22742@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180529221908.GA22742@roeck-us.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kevin Easton <kevin@guarana.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 29, 2018 at 03:19:08PM -0700, Guenter Roeck wrote:
> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
> > The struct vhost_msg within struct vhost_msg_node is copied to userspace,
> > so it should be allocated with kzalloc() to ensure all structure padding
> > is zeroed.
> > 
> > Signed-off-by: Kevin Easton <kevin@guarana.org>
> > Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
> 
> Is this patch going anywhere ?
> 
> The patch fixes CVE-2018-1118. It would be useful to understand if and when
> this problem is going to be fixed.
> 
> Thanks,
> Guenter
> > ---
> >  drivers/vhost/vhost.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index f3bd8e9..1b84dcff 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
> >  /* Create a new message. */
> >  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
> >  {
> > -	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
> > +	struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
> >  	if (!node)
> >  		return NULL;
> >  	node->vq = vq;

As I pointed out, we don't need to init the whole structure. The proper
fix is thus (I think) below.

Could you use your testing infrastructure to confirm this fixes the issue?

Thanks!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f3bd8e941224..58d9aec90afb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2342,6 +2342,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
 	if (!node)
 		return NULL;
+
+	/* Make sure all padding within the structure is initialized. */
+	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
