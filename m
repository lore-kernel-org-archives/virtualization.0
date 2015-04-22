From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 7/8] vhost: feature to set the vring endianness
Date: Wed, 22 Apr 2015 11:08:54 +0200
Message-ID: <20150422110854.74988416__31110.8391768814$1429693769$gmane$org@bahia.local>
References: <20150410101500.31843.61248.stgit@bahia.local>
	<20150410101627.31843.21710.stgit@bahia.local>
	<20150421155753-mutt-send-email-mst@redhat.com>
	<20150421174820.78c150b7@bahia.local>
	<20150421201636-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150421201636-mutt-send-email-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 21 Apr 2015 20:25:03 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:
[ ... ]
> > > > @@ -630,6 +634,53 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_VHOST_SET_ENDIAN_LEGACY
> > > > +static long vhost_set_vring_big_endian(struct vhost_virtqueue *vq,
> > > > +				       int __user *argp)
> > > > +{
> > > > +	struct vhost_vring_state s;
> > > > +
> > > > +	if (vq->private_data)
> > > > +		return -EBUSY;
> > > > +
> > > > +	if (copy_from_user(&s, argp, sizeof(s)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	if (s.num && s.num != 1)
> > > 
> > > s.num & ~0x1
> > > 
> > 
> > Since s.num is unsigned and I assume this won't change, what about
> > s.num > 1 as suggested by Cornelia ?
> 
> I just tried and gcc optimizes
> s.num != 0 && s.num != 1 to s.num > 1
> 
> The former will be more readable once we
> replace 0 and 1 with defines.
> 
> So ignore my advice, keep code as is but use defines.
> 

Ok.

[ ... ] 
> > > > --- a/include/uapi/linux/vhost.h
> > > > +++ b/include/uapi/linux/vhost.h
> > > > @@ -103,6 +103,15 @@ struct vhost_memory {
> > > >  /* Get accessor: reads index, writes value in num */
> > > >  #define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
> > > >  
> > > > +/* Set the vring byte order in num. This is a legacy only API that is simply
> > > > + * ignored when VIRTIO_F_VERSION_1 is set.
> > > > + * 0 to set to little-endian
> > > > + * 1 to set to big-endian
> > > 
> > > How about defines for these?
> > > 
> > 
> > Ok. I'll put the defines here so that all the cross-endian stuff
> > lies in the same hunk. Is it ok for you ?
> 
> Fine.
> 
> > > > + * other values return EINVAL.
> 
> Pls also add a note saying that not all kernel configurations support this ioctl,
> but all configurations that support SET also support GET.
> 

Ok.

> > > > + */
> > > > +#define VHOST_SET_VRING_BIG_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> > > > +#define VHOST_GET_VRING_BIG_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> > > > +
> > > >  /* The following ioctls use eventfd file descriptors to signal and poll
> > > >   * for events. */
> > > >  
> > > 
> 
> I'm inclined to think VHOST_SET_VRING_ENDIAN is a slightly better name.
> What do you think?
> 

Or VHOST_SET_VRING_CROSS_ENDIAN ? I like the idea to keep a hint that this
API is for cross-endian only... like the rest of this series.

--
Greg
