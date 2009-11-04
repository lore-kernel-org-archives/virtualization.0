From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 4 Nov 2009 14:10:09 +0200
Message-ID: <20091104121009.GF8398__44716.3091660061$1257336920$gmane$org@redhat.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091103172422.GD5591@redhat.com>
	<878wema6o0.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878wema6o0.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 12:08:47PM +0100, Andi Kleen wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> Haven't really read the whole thing, just noticed something at a glance.
> 
> > +/* Expects to be always run from workqueue - which acts as
> > + * read-size critical section for our kind of RCU. */
> > +static void handle_tx(struct vhost_net *net)
> > +{
> > +	struct vhost_virtqueue *vq = &net->dev.vqs[VHOST_NET_VQ_TX];
> > +	unsigned head, out, in, s;
> > +	struct msghdr msg = {
> > +		.msg_name = NULL,
> > +		.msg_namelen = 0,
> > +		.msg_control = NULL,
> > +		.msg_controllen = 0,
> > +		.msg_iov = vq->iov,
> > +		.msg_flags = MSG_DONTWAIT,
> > +	};
> > +	size_t len, total_len = 0;
> > +	int err, wmem;
> > +	size_t hdr_size;
> > +	struct socket *sock = rcu_dereference(vq->private_data);
> > +	if (!sock)
> > +		return;
> > +
> > +	wmem = atomic_read(&sock->sk->sk_wmem_alloc);
> > +	if (wmem >= sock->sk->sk_sndbuf)
> > +		return;
> > +
> > +	use_mm(net->dev.mm);
> 
> I haven't gone over all this code in detail, but that isolated reference count
> use looks suspicious. What prevents the mm from going away before
> you increment, if it's not the current one?

We take a reference to it before we start any virtqueues,
and stop all virtqueues before we drop the reference:
/* Caller should have device mutex */
static long vhost_dev_set_owner(struct vhost_dev *dev)
{
        /* Is there an owner already? */
        if (dev->mm)
                return -EBUSY;
        /* No owner, become one */
        dev->mm = get_task_mm(current);
        return 0;
}

And 
vhost_dev_cleanup:
....

        if (dev->mm)
                mmput(dev->mm);
        dev->mm = NULL;
}


Fine?

> -Andi 
> 
> -- 
> ak@linux.intel.com -- Speaking for myself only.
