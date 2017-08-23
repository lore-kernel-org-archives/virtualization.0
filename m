From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC 2/3] virtio-iommu: device probing and operations
Date: Wed, 23 Aug 2017 02:23:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D7E8D9__49854.1681132794$1503455044$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-3-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190CADECE@SHSMSX101.ccr.corp.intel.com>
	<34166633-f4d5-21d5-20db-9091243ccd84@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190CB262D@SHSMSX101.ccr.corp.intel.com>
	<a4df3472-449f-297f-2a18-b3a21affadee@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D7BAB1@SHSMSX101.ccr.corp.intel.com>
	<454095c4-cae5-ad52-a459-5c9e2cce4047@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D7CF52@SHSMSX101.ccr.corp.intel.com>
	<03eabc9f-5db1-0eb9-b91a-c47da9d1a29b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <03eabc9f-5db1-0eb9-b91a-c47da9d1a29b@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, Auger Eric <eric.auger@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Tuesday, August 22, 2017 10:19 PM
> 
> On 22/08/17 07:24, Tian, Kevin wrote:
> >>> (sorry to pick up this old thread, as the .tex one is not good for review
> >>> and this thread provides necessary background for IOASID).
> >>>
> >>> Hi, Jean,
> >>>
> >>> I'd like to hear more clarification regarding the relationship between
> >>> IOASID and PASID. When reading back above explanation, it looks
> >>> confusing to me now (though I might get the meaning months ago :/).
> >>> At least Intel VT-d only understands PASID (or you can think IOASID
> >>> =PASID). There is no such layered address space concept. Then for
> >>> map/unmap type request, do you intend to steal some PASIDs for
> >>> that purpose on such architecture (since IOASID is a mandatory field
> >>> in map/unmap request)?
> >>
> >> IOASID is a logical ID, it isn't used by hardware. The address space
> >> concept in virtio-iommu allows to group endpoints together, so that they
> >> have the same address space. I thought it was pretty much the same as
> >> "domains" in VT-d? In any case, it is the same as domains in Linux. An
> >> IOASID provides a handle for communication between virtio-iommu
> device
> >> and
> >> driver, but unlike PASID, the IOASID number doesn't mean anything
> outside
> >> of virtio-iommu.
> >
> > Thanks. It's clear to me then.
> >
> > btw does it make more sense to use "domain id" instead of "IO address
> > space id"? For one, when talking about layered address spaces
> > usually parent address space is a superset of all child address spaces
> > which doesn't apply to this case, since either anonymous address
> > space or PASID-tagged address spaces are completely isolated. Instead>
> 'domain' is a more inclusive terminology to embrace multiple address
> > spaces. For two, 'domain' is better aligned to software terminology (e.g.
> > iommu_domain) is easier for people to catch up. :-)
> 
> I do agree that the naming isn't great. I didn't use "domain" for various
> reasons (it also has a different meanings in ARM) but I keep regretting
> it. As there is no virtio-iommu code upstream yet, it is still possible to
> change this one.
> 
> I find that "address space" was a good fit for the baseline device, but
> the name doesn't scale. When introducing PASIDs, the address space
> moves
> one level down in the programming model. It is contexts, anonymous or
> PASID-tagged, that should be called address spaces. I was considering
> replacing it with "domain", "container", "partition"...
> 
> Even though I don't want to use too much Linux terminology (virtio isn't
> just Linux), "domain" is better fitted, somewhat neutral, and gets the
> point across. A domain has one or more input address spaces and a single
> output address space.
> 
> When introducing nested translation to virtio-iommu (for the guest to have
> virtual machines itself), there will be one or more intermediate address
> spaces. Domains will be nested, with the terminology "parent domain" and
> "child domain". I only briefly looked at a programming model for this but
> I think we can nest virtio-iommus without much hassle.
> 
> If there is no objection the next version will use "domain" in place of
> "address_space". The change is quite invasive at this point, but I believe
> that it will makes things more clear down the road.
> 

Sounds good to me. Thanks.
