From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Wed, 12 Aug 2009 10:19:22 -0700
Message-ID: <20090812171921.GC24151__20056.217237334$1250198399$gmane$org@ovro.caltech.edu>
References: <cover.1249930169.git.mst@redhat.com>
	<20090810185340.GC13924@redhat.com>
	<200908121903.22325.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908121903.22325.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 07:03:22PM +0200, Arnd Bergmann wrote:
> On Monday 10 August 2009, Michael S. Tsirkin wrote:
> 
> > +struct workqueue_struct *vhost_workqueue;
> 
> [nitpicking] This could be static. 
> 
> > +/* The virtqueue structure describes a queue attached to a device. */
> > +struct vhost_virtqueue {
> > +	struct vhost_dev *dev;
> > +
> > +	/* The actual ring of buffers. */
> > +	struct mutex mutex;
> > +	unsigned int num;
> > +	struct vring_desc __user *desc;
> > +	struct vring_avail __user *avail;
> > +	struct vring_used __user *used;
> > +	struct file *kick;
> > +	struct file *call;
> > +	struct file *error;
> > +	struct eventfd_ctx *call_ctx;
> > +	struct eventfd_ctx *error_ctx;
> > +
> > +	struct vhost_poll poll;
> > +
> > +	/* The routine to call when the Guest pings us, or timeout. */
> > +	work_func_t handle_kick;
> > +
> > +	/* Last available index we saw. */
> > +	u16 last_avail_idx;
> > +
> > +	/* Last index we used. */
> > +	u16 last_used_idx;
> > +
> > +	/* Outstanding buffers */
> > +	unsigned int inflight;
> > +
> > +	/* Is this blocked? */
> > +	bool blocked;
> > +
> > +	struct iovec iov[VHOST_NET_MAX_SG];
> > +
> > +} ____cacheline_aligned;
> 
> We discussed this before, and I still think this could be directly derived
> from struct virtqueue, in the same way that vring_virtqueue is derived from
> struct virtqueue. That would make it possible for simple device drivers
> to use the same driver in both host and guest, similar to how Ira Snyder
> used virtqueues to make virtio_net run between two hosts running the
> same code [1].
> 
> Ideally, I guess you should be able to even make virtio_net work in the
> host if you do that, but that could bring other complexities.

I have no comments about the vhost code itself, I haven't reviewed it.

It might be interesting to try using a virtio-net in the host kernel to
communicate with the virtio-net running in the guest kernel. The lack of
a management interface is the biggest problem you will face (setting MAC
addresses, negotiating features, etc. doesn't work intuitively). Getting
the network interfaces talking is relatively easy.

Ira
