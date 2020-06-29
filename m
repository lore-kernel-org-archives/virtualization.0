From: Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
Date: Mon, 29 Jun 2020 03:00:08 +0000
Message-ID: <DB6PR0402MB2760B02A5EA92A24D5703344886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
>=20
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > > >
> > > > > > > Use xen_swiotlb to determine when vring should use dma APIs
> > > > > > > to map the
> > > > > > > ring: when xen_swiotlb is enabled the dma API is required.
> > > > > > > When it is disabled, it is not required.
> > > > > > >
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > > > > Xen was there first, but everyone else is using that now.
> > > > >
> > > > > Unfortunately it is complicated and it is not related to
> > > > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > > >
> > > > >
> > > > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to
> > > > > translate foreign mappings (memory coming from other VMs) to
> physical addresses.
> > > > > On x86, it also uses dma_ops to translate Linux's idea of a
> > > > > physical address into a real physical address (this is unneeded
> > > > > on ARM.)
> > > > >
> > > > >
> > > > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be
> used
> > > > > on Xen/x86 always and on Xen/ARM if Linux is Dom0 (because it
> > > > > has foreign
> > > > > mappings.) That is why we have the if (xen_domain) return true;
> > > > > in vring_use_dma_api.
> > > >
> > > > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > > >
> > > > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also* forces
> DMA
> > > > ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> > > >
> > > > Unfortunately as a result Xen never got around to properly setting
> > > > VIRTIO_F_IOMMU_PLATFORM.
> > >
> > > I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this
> > > because the usage of swiotlb_xen is not a property of virtio,
> >
> >
> > Basically any device without VIRTIO_F_ACCESS_PLATFORM (that is it's
> > name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is what linux
> > calls it) is declared as "special, don't follow normal rules for
> > access".
> >
> > So yes swiotlb_xen is not a property of virtio, but what *is* a
> > property of virtio is that it's not special, just a regular device from=
 DMA POV.
>=20
> I am trying to understand what you meant but I think I am missing somethi=
ng.
>=20
> Are you saying that modern virtio should always have
> VIRTIO_F_ACCESS_PLATFORM, hence use normal dma_ops as any other
> devices?
>=20
> If that is the case, how is it possible that virtio breaks on ARM using t=
he
> default dma_ops? The breakage is not Xen related (except that Xen turns
> dma_ops on). The original message from Peng was:
>=20
>   vring_map_one_sg -> vring_use_dma_api
>                    -> dma_map_page
>   		       -> __swiotlb_map_page
>   		                ->swiotlb_map_page
>   				->__dma_map_area(phys_to_virt(dma_to_phys(dev,
> dev_addr)), size, dir);
>   However we are using per device dma area for rpmsg, phys_to_virt
>   could not return a correct virtual address for virtual address in
>   vmalloc area. Then kernel panic.
>=20
> I must be missing something. Maybe it is because it has to do with RPMesg=
?

I am not going to fix the rpmsg issue with this patch. It is when ARM DomU
Android os communicate with secure world trusty os using virtio, the
vring_use_dma_api will return true for xen domu, but I no need it return
true and fall into swiotlb.

Thanks,
Peng.

>=20
>=20
> > > > > You might have noticed that I missed one possible case above:
> > > > > Xen/ARM DomU :-)
> > > > >
> > > > > Xen/ARM domUs don't need swiotlb_xen, it is not even
> > > > > initialized. So if
> > > > > (xen_domain) return true; would give the wrong answer in that cas=
e.
> > > > > Linux would end up calling the "normal" dma_ops, not
> > > > > swiotlb-xen, and the "normal" dma_ops fail.
> > > > >
> > > > >
> > > > > The solution I suggested was to make the check in
> > > > > vring_use_dma_api more flexible by returning true if the
> > > > > swiotlb_xen is supposed to be used, not in general for all Xen
> > > > > domains, because that is what the check was really meant to do.
> > > >
> > > > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is
> wrong with that?
> > >
> > > swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
> > > ones that are used. So you are saying, why don't we fix the default
> > > dma_ops to work with virtio?
> > >
> > > It is bad that the default dma_ops crash with virtio, so yes I think
> > > it would be good to fix that. However, even if we fixed that, the if
> > > (xen_domain()) check in vring_use_dma_api is still a problem.
> >
> > Why is it a problem? It just makes virtio use DMA API.
> > If that in turn works, problem solved.
>=20
> You are correct in the sense that it would work. However I do think it is=
 wrong
> for vring_use_dma_api to enable dma_ops/swiotlb-xen for Xen/ARM DomUs
> that don't need it. There are many different types of Xen guests, Xen x86=
 is
> drastically different from Xen ARM, it seems wrong to treat them the same
> way.
>=20
>=20
>=20
> Anyway, re-reading the last messages of the original thread [1], it looks=
 like
> Peng had a clear idea on how to fix the general issue. Peng, what happene=
d
> with that?
>=20
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Fpatchwork%2Fpatch%2F1033801%2F%231222404&amp;data=3D02
> %7C01%7Cpeng.fan%40nxp.com%7C27edb29c11da49a2249008d8192d98cc
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637287030912707
> 092&amp;sdata=3DMsF%2FLmBmJ1V%2BoOQ%2FmdhEJ3PFzH55DaSNvorRUU
> QvBvQ%3D&amp;reserved=3D0
