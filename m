From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
Date: Tue, 27 Nov 2018 13:10:43 -0500
Message-ID: <20181127131031-mutt-send-email-mst__25501.9530807205$1543342139$gmane$org@kernel.org>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
	<20181122193801.50510-6-jean-philippe.brucker@arm.com>
	<20181123164716-mutt-send-email-mst@kernel.org>
	<0fed79f3-ca2e-b539-74f5-cd2a8091f65d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0fed79f3-ca2e-b539-74f5-cd2a8091f65d@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, Robin Murphy <Robin.Murphy@arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 27, 2018 at 05:58:18PM +0000, Jean-Philippe Brucker wrote:
> On 23/11/2018 21:48, Michael S. Tsirkin wrote:
> >> +struct virtio_iommu_config {
> >> +	/* Supported page sizes */
> >> +	__u64					page_size_mask;
> >> +	/* Supported IOVA range */
> >> +	struct virtio_iommu_range		input_range;
> >> +	/* Max domain ID size */
> >> +	__u8					domain_bits;
> >> +	__u8					padding[3];
> > 
> > Not enough padding here it seems. Structure is 8 byte
> > aligned on 64 bit systems.
> 
> The next field (probe_size) is 4 bytes, so the alignment ends up fine.
> That field is introduced in patch 6, maybe I should move it here?
> 
> Thanks,
> Jean

Sounds like a good idea.

-- 
MST
