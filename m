From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Date: Thu, 26 Sep 2019 21:14:39 +0800
Message-ID: <20190926131439.GA11652__16841.4551926375$1569503862$gmane$org@___>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
	<20190926042156-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190926042156-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zhihong.wang@intel.com, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, netdev@vger.kernel.org, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 26, 2019 at 04:35:18AM -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 26, 2019 at 12:54:27PM +0800, Tiwei Bie wrote:
[...]
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index 40d028eed645..5afbc2f08fa3 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -116,4 +116,12 @@
> >  #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
> >  #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
> >  
> > +/* VHOST_MDEV specific defines */
> > +
> > +#define VHOST_MDEV_SET_STATE	_IOW(VHOST_VIRTIO, 0x70, __u64)
> > +
> > +#define VHOST_MDEV_S_STOPPED	0
> > +#define VHOST_MDEV_S_RUNNING	1
> > +#define VHOST_MDEV_S_MAX	2
> > +
> >  #endif
> 
> So assuming we have an underlying device that behaves like virtio:

I think they are really good questions/suggestions. Thanks!

> 
> 1. Should we use SET_STATUS maybe?

I like this idea. I will give it a try.

> 2. Do we want a reset ioctl?

I think it is helpful. If we use SET_STATUS, maybe we
can use it to support the reset.

> 3. Do we want ability to enable rings individually?

I will make it possible at least in the vhost layer.

> 4. Does device need to limit max ring size?
> 5. Does device need to limit max number of queues?

I think so. It's helpful to have ioctls to report the max
ring size and max number of queues.

Thanks!
Tiwei


> 
> -- 
> MST
