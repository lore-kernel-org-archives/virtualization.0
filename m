From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC v3] vhost: introduce mdev based hardware vhost backend
Date: Wed, 4 Sep 2019 10:48:01 +0800
Message-ID: <20190904024801.GA5671__2117.5750460074$1567565445$gmane$org@___>
References: <20190828053712.26106-1-tiwei.bie@intel.com>
	<20190903043704-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190903043704-mutt-send-email-mst@kernel.org>
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

On Tue, Sep 03, 2019 at 07:26:03AM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 28, 2019 at 01:37:12PM +0800, Tiwei Bie wrote:
> > Details about this can be found here:
> > 
> > https://lwn.net/Articles/750770/
> > 
> > What's new in this version
> > ==========================
> > 
> > There are three choices based on the discussion [1] in RFC v2:
> > 
> > > #1. We expose a VFIO device, so we can reuse the VFIO container/group
> > >     based DMA API and potentially reuse a lot of VFIO code in QEMU.
> > >
> > >     But in this case, we have two choices for the VFIO device interface
> > >     (i.e. the interface on top of VFIO device fd):
> > >
> > >     A) we may invent a new vhost protocol (as demonstrated by the code
> > >        in this RFC) on VFIO device fd to make it work in VFIO's way,
> > >        i.e. regions and irqs.
> > >
> > >     B) Or as you proposed, instead of inventing a new vhost protocol,
> > >        we can reuse most existing vhost ioctls on the VFIO device fd
> > >        directly. There should be no conflicts between the VFIO ioctls
> > >        (type is 0x3B) and VHOST ioctls (type is 0xAF) currently.
> > >
> > > #2. Instead of exposing a VFIO device, we may expose a VHOST device.
> > >     And we will introduce a new mdev driver vhost-mdev to do this.
> > >     It would be natural to reuse the existing kernel vhost interface
> > >     (ioctls) on it as much as possible. But we will need to invent
> > >     some APIs for DMA programming (reusing VHOST_SET_MEM_TABLE is a
> > >     choice, but it's too heavy and doesn't support vIOMMU by itself).
> > 
> > This version is more like a quick PoC to try Jason's proposal on
> > reusing vhost ioctls. And the second way (#1/B) in above three
> > choices was chosen in this version to demonstrate the idea quickly.
> > 
> > Now the userspace API looks like this:
> > 
> > - VFIO's container/group based IOMMU API is used to do the
> >   DMA programming.
> > 
> > - Vhost's existing ioctls are used to setup the device.
> > 
> > And the device will report device_api as "vfio-vhost".
> > 
> > Note that, there are dirty hacks in this version. If we decide to
> > go this way, some refactoring in vhost.c/vhost.h may be needed.
> > 
> > PS. The direct mapping of the notify registers isn't implemented
> >     in this version.
> > 
> > [1] https://lkml.org/lkml/2019/7/9/101
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> ....
> 
> > +long vhost_mdev_ioctl(struct mdev_device *mdev, unsigned int cmd,
> > +		      unsigned long arg)
> > +{
> > +	void __user *argp = (void __user *)arg;
> > +	struct vhost_mdev *vdpa;
> > +	unsigned long minsz;
> > +	int ret = 0;
> > +
> > +	if (!mdev)
> > +		return -EINVAL;
> > +
> > +	vdpa = mdev_get_drvdata(mdev);
> > +	if (!vdpa)
> > +		return -ENODEV;
> > +
> > +	switch (cmd) {
> > +	case VFIO_DEVICE_GET_INFO:
> > +	{
> > +		struct vfio_device_info info;
> > +
> > +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> > +
> > +		if (copy_from_user(&info, (void __user *)arg, minsz)) {
> > +			ret = -EFAULT;
> > +			break;
> > +		}
> > +
> > +		if (info.argsz < minsz) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		info.flags = VFIO_DEVICE_FLAGS_VHOST;
> > +		info.num_regions = 0;
> > +		info.num_irqs = 0;
> > +
> > +		if (copy_to_user((void __user *)arg, &info, minsz)) {
> > +			ret = -EFAULT;
> > +			break;
> > +		}
> > +
> > +		break;
> > +	}
> > +	case VFIO_DEVICE_GET_REGION_INFO:
> > +	case VFIO_DEVICE_GET_IRQ_INFO:
> > +	case VFIO_DEVICE_SET_IRQS:
> > +	case VFIO_DEVICE_RESET:
> > +		ret = -EINVAL;
> > +		break;
> > +
> > +	case VHOST_MDEV_SET_STATE:
> > +		ret = vhost_set_state(vdpa, argp);
> > +		break;
> > +	case VHOST_GET_FEATURES:
> > +		ret = vhost_get_features(vdpa, argp);
> > +		break;
> > +	case VHOST_SET_FEATURES:
> > +		ret = vhost_set_features(vdpa, argp);
> > +		break;
> > +	case VHOST_GET_VRING_BASE:
> > +		ret = vhost_get_vring_base(vdpa, argp);
> > +		break;
> > +	default:
> > +		ret = vhost_dev_ioctl(&vdpa->dev, cmd, argp);
> > +		if (ret == -ENOIOCTLCMD)
> > +			ret = vhost_vring_ioctl(&vdpa->dev, cmd, argp);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(vhost_mdev_ioctl);
> 
> 
> I don't have a problem with this approach. A small question:
> would it make sense to have two fds: send vhost ioctls
> on one and vfio ioctls on another?
> We can then pass vfio fd to the vhost fd with a
> SET_BACKEND ioctl.
> 
> What do you think?

I like this idea! I will give it a try.
So we can introduce /dev/vhost-mdev to have the vhost fd, and let
userspace pass vfio fd to the vhost fd with a SET_BACKEND ioctl.

Thanks a lot!
Tiwei

> 
> -- 
> MST
