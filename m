From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Mon, 25 Jun 2018 11:55:12 +0200
Message-ID: <20180625115512.2f29844e.cohuck@redhat.com>
References: <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
	<20180622214259-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180622214259-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 22 Jun 2018 22:05:50 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
> > On Thu, 21 Jun 2018 21:20:13 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:  
> > > > OK, so what about the following:
> > > > 
> > > > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
> > > >   that we have a new uuid field in the virtio-net config space
> > > > - in QEMU, add a property for virtio-net that allows to specify a uuid,
> > > >   offer VIRTIO_NET_F_STANDBY_UUID if set
> > > > - when configuring, set the property to the group UUID of the vfio-pci
> > > >   device
> > > > - in the guest, use the uuid from the virtio-net device's config space
> > > >   if applicable; else, fall back to matching by MAC as done today
> > > > 
> > > > That should work for all virtio transports.    
> > > 
> > > True. I'm a bit unhappy that it's virtio net specific though
> > > since down the road I expect we'll have a very similar feature
> > > for scsi (and maybe others).
> > > 
> > > But we do not have a way to have fields that are portable
> > > both across devices and transports, and I think it would
> > > be a useful addition. How would this work though? Any idea?  
> > 
> > Can we introduce some kind of device-independent config space area?
> > Pushing back the device-specific config space by a certain value if the
> > appropriate feature is negotiated and use that for things like the uuid?  
> 
> So config moves back and forth?
> Reminds me of the msi vector mess we had with pci.

Yes, that would be a bit unfortunate.

> I'd rather have every transport add a new config.

You mean via different mechanisms?

> 
> > But regardless of that, I'm not sure whether extending this approach to
> > other device types is the way to go. Tying together two different
> > devices is creating complicated situations at least in the hypervisor
> > (even if it's fairly straightforward in the guest). [I have not come
> > around again to look at the "how to handle visibility in QEMU"
> > questions due to lack of cycles, sorry about that.]
> > 
> > So, what's the goal of this approach? Only to allow migration with
> > vfio-pci, or also to plug in a faster device and use it instead of an
> > already attached paravirtualized device?  
> 
> These are two sides of the same coin, I think the second approach
> is closer to what we are doing here.

Thinking about it, do we need any knob to keep the vfio device
invisible if the virtio device is not present? IOW, how does the
hypervisor know that the vfio device is supposed to be paired with a
virtio device? It seems we need an explicit tie-in.

> 
> > What about migration of vfio devices that are not easily replaced by a
> > paravirtualized device? I'm thinking of vfio-ccw, where our main (and
> > currently only) supported device is dasd (disks) -- which can do a lot
> > of specialized things that virtio-blk does not support (and should not
> > or even cannot support).  
> 
> But maybe virtio-scsi can?

I don't think so. Dasds have some channel commands that don't map
easily to scsi commands.

> 
> > Would it be more helpful to focus on generic
> > migration support for vfio instead of going about it device by device?
> > 
> > This network device approach already seems far along, so it makes sense
> > to continue with it. But I'm not sure whether we want to spend time and
> > energy on that for other device types rather than working on a general
> > solution for vfio migration.  
> 
> I'm inclined to say finalizing this feature would be a good first step
> and will teach us how we can move forward.

I'm not opposed to figuring out this one, but I'm not sure whether we
want to extend it to more device types.

Are people looking into generic migration support? I have it on my
things-to-look-at list (figuring out what needs to be device specific
and what can be generic, figuring out how we can support vfio-ccw,
etc.).
