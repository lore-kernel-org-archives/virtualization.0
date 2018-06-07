From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Date: Thu, 7 Jun 2018 19:04:49 +0100
Message-ID: <20180607180449.GS30522__20817.5709740773$1528394603$gmane$org@ZenIV.linux.org.uk>
References: <000000000000a5b2b1056a86e98c@google.com>
	<000000000000cf4578056ab12452@google.com>
	<20180607183627-mutt-send-email-mst@kernel.org>
	<20180607174355.GR30522@ZenIV.linux.org.uk>
	<20180607205611-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180607205611-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemb@google.com, avagin@openvz.org, kvm@vger.kernel.org, netdev@vger.kernel.org, matthew@mjdsystems.ca, linux-kernel@vger.kernel.org, mingo@kernel.org, syzkaller-bugs@googlegroups.com, edumazet@google.com, dingtianhong@huawei.com, syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>, pabeni@redhat.com, virtualization@lists.linux-foundation.org, davem@davemloft.net, elena.reshetova@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 07, 2018 at 08:59:06PM +0300, Michael S. Tsirkin wrote:
> On Thu, Jun 07, 2018 at 06:43:55PM +0100, Al Viro wrote:
> > On Thu, Jun 07, 2018 at 06:38:48PM +0300, Michael S. Tsirkin wrote:
> > > #syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617
> > > 
> > > Subject: vhost: fix info leak
> > > 
> > > Fixes: CVE-2018-1118
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index f0be5f35ab28..9beefa6ed1ce 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
> > >  	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
> > >  	if (!node)
> > >  		return NULL;
> > > +
> > > +	/* Make sure all padding within the structure is initialized. */
> > > +	memset(&node->msg, 0, sizeof node->msg);
> > 
> > Umm...  Maybe kzalloc(), then?  You have
> > 
> > struct vhost_msg_node {
> >   struct vhost_msg msg;
> >   struct vhost_virtqueue *vq;
> >   struct list_head node;
> > };
> > 
> > and that's what, 68 bytes in msg, then either 4 bytes pointer or
> > 4 bytes padding + 8 bytes pointer, then two pointers?  How much
> > does explicit partial memset() save you here?
> 
> Yes but 0 isn't a nop here so if this struct is used without
> a sensible initialization, it will crash elsewhere.
> I prefer KASAN to catch such uses.
> 
> 
> > >  	node->vq = vq;
> > >  	node->msg.type = type;

IDGI - what would your variant catch that kzalloc + 2 assignments won't?
Accesses to uninitialized ->node?  Because that's the only difference in
what is and is not initialized between those variants...
