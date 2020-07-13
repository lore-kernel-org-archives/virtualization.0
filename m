From: Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
Date: Mon, 13 Jul 2020 01:53:46 +0000
Message-ID: <DB6PR0402MB2760A98A427AA48FA325635288600@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
 <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jgross@suse.com" <jgross@suse.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, dl-linux-imx <linux-imx@nxp.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
>=20
> Sorry for the late reply -- a couple of conferences kept me busy.
>=20
>=20
> On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > Would you be in favor of a more flexible check along the lines of
> > > the one proposed in the patch that started this thread:
> > >
> > >     if (xen_vring_use_dma())
> > >             return true;
> > >
> > >
> > > xen_vring_use_dma would be implemented so that it returns true when
> > > xen_swiotlb is required and false otherwise.
> >
> > Just to stress - with a patch like this virtio can *still* use DMA API
> > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > as you seem to be saying, you guys should fix it before doing
> > something like this..
>=20
> Yes, DMA API is broken with some interfaces (specifically: rpmesg and tru=
sty),
> but for them PLATFORM_ACCESS is never set. That is why the errors weren't
> reported before. Xen special case aside, there is no problem under normal
> circumstances.
>=20
>=20
> If you are OK with this patch (after a little bit of clean-up), Peng, are=
 you OK
> with sending an update or do you want me to?

If you could help, that would be great. You have more expertise in knowing
the whole picture.

Thanks,
Peng.
