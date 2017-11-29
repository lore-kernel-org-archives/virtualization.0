From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [virtio-dev] [RFC PATCH v2 4/5] ACPI/IORT: Support
	paravirtualized IOMMU
Date: Wed, 29 Nov 2017 15:17:55 +0000
Message-ID: <aea995d0-333b-cfec-abe7-2e59ef37c19e__21096.2790334181$1511968511$gmane$org@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
	<20171117185211.32593-5-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171117185211.32593-5-jean-philippe.brucker@arm.com>
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
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On 17/11/17 18:52, Jean-Philippe Brucker wrote:
> To describe the virtual topology in relation to a virtio-iommu device,
> ACPI-based systems use a "paravirtualized IOMMU" IORT node. Add support
> for it.
> 
> This is a RFC because the IORT specification doesn't describe the
> paravirtualized node at the moment, it is only provided as an example in
> the virtio-iommu spec. What we need to do first is confirm that x86
> kernels are able to use the IORT driver with the virtio-iommu. There isn't
> anything specific to arm64 in the driver but there might be other blockers
> we're not aware of (I know for example that x86 also requires custom DMA
> ops rather than iommu-dma ones, but it's unrelated) so this needs to be
> tested on the x86 prototype.

I tested IORT with an x86 guest, putting a virtio-iommu on the PCI bus and
it worked fine :)

x86 still requires additional code [1] for using the IOMMU DMA ops,
and I'm not comfortable enough with x86 to write the patch, but for
instantiating virtio-iommus and for enumerating endpoints/buses connected
to them, IORT should suffice.

Thanks,
Jean

[1]
http://www.linux-arm.org/git?p=linux-jpb.git;a=patch;h=e910e224b58712151dda06df595a53ff07edef63;hp=e7f9475480c24c5f973711984b30cf6746ff3ec8
