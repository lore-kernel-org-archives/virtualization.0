From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Thu, 21 Jun 2018 21:20:13 +0300
Message-ID: <20180621211712-mutt-send-email-mst__18832.5129369789$1529605118$gmane$org@kernel.org>
References: <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180621165913.7e3f4faa.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:
> On Wed, 20 Jun 2018 22:48:58 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
> > > In any case, I'm not sure anymore why we'd want the extra uuid.  
> > 
> > It's mostly so we can have e.g. multiple devices with same MAC
> > (which some people seem to want in order to then use
> > then with different containers).
> > 
> > But it is also handy for when you assign a PF, since then you
> > can't set the MAC.
> > 
> 
> OK, so what about the following:
> 
> - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
>   that we have a new uuid field in the virtio-net config space
> - in QEMU, add a property for virtio-net that allows to specify a uuid,
>   offer VIRTIO_NET_F_STANDBY_UUID if set
> - when configuring, set the property to the group UUID of the vfio-pci
>   device
> - in the guest, use the uuid from the virtio-net device's config space
>   if applicable; else, fall back to matching by MAC as done today
> 
> That should work for all virtio transports.

True. I'm a bit unhappy that it's virtio net specific though
since down the road I expect we'll have a very similar feature
for scsi (and maybe others).

But we do not have a way to have fields that are portable
both across devices and transports, and I think it would
be a useful addition. How would this work though? Any idea?

-- 
MST
