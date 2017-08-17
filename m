From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [virtio-dev] [RFC] virtio-iommu version 0.4
Date: Thu, 17 Aug 2017 11:27:01 +0000
Message-ID: <AM5PR0401MB2545F70A3ABF2DBFFFC4A6B09A830__38957.9352959574$1502969239$gmane$org@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
	<20170816040853.GA10652@shay3t003839711.china.huawei.com>
	<a2e573f3-bdfb-b5e5-7835-a7597abd48f5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a2e573f3-bdfb-b5e5-7835-a7597abd48f5@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Adam Tao <taozhe1@huawei.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Thursday, August 17, 2017 3:42 PM
> To: Adam Tao <taozhe1@huawei.com>
> Cc: iommu@lists.linux-foundation.org; kvm@vger.kernel.org;
> virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.org;
> will.deacon@arm.com; robin.murphy@arm.com; lorenzo.pieralisi@arm.com;
> mst@redhat.com; jasowang@redhat.com; marc.zyngier@arm.com;
> eric.auger@redhat.com; eric.auger.pro@gmail.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>; peterx@redhat.com; kevin.tian@intel.com
> Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
> 
> Hi Adam,
> 
> On 16/08/17 05:08, Adam Tao wrote:
> >> * There is a working Qemu prototype [3], thanks to Eric Auger and Bharat
> >>   Bhushan.
> > Hi, Brucker
> > I read the related spec for virtio IOMMU, I am wondering if we support
> > both the virtual and physical devices in the guest to use the virtio
> > IOMMU, how can we config the related address translation for the
> > different type of devices.
> > e.g.
> > 1. for Virtio devs(e.g. virtio-net), we can change the memmap table
> > used by the vhost device.
> > 2. for physical devices we can directly config the IOMMU/SMMU on the
> > host.
> >
> > So do you know are there any RFCs for the back-end implementation for
> > the virtio-IOMMU thanks Adam
> 
> Eric's series [3] adds support for virtual devices (I'v only had time to test
> virtio-net so far, but as vhost-iotlb seems to be supported by Qemu, it should
> work with vhost-net as well). Bharat is working on the VFIO backend for
> physical devices. As far as I'm aware, his latest version is:
> 
> [7] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04094.html

I am working on newer version which will be based on Eric-v3.
Actually I wanted to include the fix for the issue reported by Eric, it fails if we assign more than one interface.
I reproduced the issues on my side and know the root cause. I am working on fixing this.

Thanks
-Bharat

> 
> Thanks,
> Jean
> 
> 
> >> [1] http://www.spinics.net/lists/kvm/msg147990.html
> >> [2] git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
> >>     http://www.linux-arm.org/git?p=virtio-
> iommu.git;a=blob;f=dist/v0.4/virtio-iommu-v0.4.pdf
> >>     I reiterate the disclaimers: don't use this document as a reference,
> >>     it's a draft. It's also not an OASIS document yet. It may be riddled
> >>     with mistakes. As this is a working draft, it is unstable and I do not
> >>     guarantee backward compatibility of future versions.
> >> [3] https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00004.html
> >> [4] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.4
> >>     Warning: UAPI headers have changed! They didn't follow the spec,
> >>     please update. (Use branch v0.1, that has the old headers, for the
> >>     Qemu prototype [3])
> >> [5] git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.4
> >>     Warning: command-line has changed! Use --viommu vfio[,opts] and
> >>     --viommu virtio[,opts] to instantiate a device.
> >> [6]
> >> http://www.linux-arm.org/git?p=virtio-iommu.git;a=tree;f=dist/diffs
