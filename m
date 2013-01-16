From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] virtio-net: introduce a new control
	to set macaddr
Date: Wed, 16 Jan 2013 11:17:09 +0200
Message-ID: <20130116091709.GB12723@redhat.com>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
	<1357829141-25455-3-git-send-email-akong@redhat.com>
	<50EED6C1.1040608@redhat.com>
	<20130116052326.GA4279@t430s.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130116052326.GA4279@t430s.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 16, 2013 at 01:23:26PM +0800, Amos Kong wrote:
> On Thu, Jan 10, 2013 at 10:57:05PM +0800, Jason Wang wrote:
> > On 01/10/2013 10:45 PM, akong@redhat.com wrote:
> > > From: Amos Kong <akong@redhat.com>
> > >
> > > Currently we write MAC address to pci config space byte by byte,
> > > this means that we have an intermediate step where mac is wrong.
> > > This patch introduced a new control command to set MAC address
> > > in one time.
> > >
> > > VIRTIO_NET_F_CTRL_MAC_ADDR is a new feature bit for compatibility.
> > >
> > > Signed-off-by: Amos Kong <akong@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c        | 16 +++++++++++++++-
> > >  include/uapi/linux/virtio_net.h |  8 +++++++-
> > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 395ab4f..ff22bcd 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -803,13 +803,26 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > >  	struct virtio_device *vdev = vi->vdev;
> > >  	int ret;
> > >  
> > > +	struct scatterlist sg;
> > > +
> > >  	ret = eth_mac_addr(dev, p);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC))
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > +		/* Set MAC address by sending vq command */
> > > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > > +		virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > > +				     VIRTIO_NET_CTRL_MAC_ADDR_SET,
> > > +				     &sg, 1, 0);
> > > +		return 0;
> > > +	}
> > > +
> > 
> > Better to check the return of virtnet_send_command() and give a warn
> > like other command. Btw, need we fail back to try the old way then?
> 
> Yes, it's necessary to check the return value of
> virtnet_send_command().
> 
> In fail case, I like to return -EINVAL to userspace, because we don't
> only want to set mac successfully, we also want to resolve the
> addr inconsistent issue by this feature (vq cmd).

It's really a device error but I guess we can.
We probably should print a warning too.

-- 
MST
