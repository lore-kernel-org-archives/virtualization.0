From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 6/7] iommu/virtio: Add probe request
Date: Thu, 8 Nov 2018 16:46:15 +0000
Message-ID: <52102adc-ed06-da8a-9c1b-ce8ea0d31ad9__25026.5570161448$1541695482$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-7-jean-philippe.brucker@arm.com>
	<295d30bb-5aef-2727-01c0-ec10c7a8fa8c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <295d30bb-5aef-2727-01c0-ec10c7a8fa8c@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, tnowicki@caviumnetworks.com, mst@redhat.com, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 08/11/2018 14:48, Auger Eric wrote:
>> +struct virtio_iommu_probe_property {
>> +	__le16					type;
>> +	__le16					length;
> the value[] field has disappeared but still is documented in the v0.8 spec.

Good catch. I removed value[] when reworking the
virtio_iommu_probe_resv_mem definition, because embedding a struct with
a flexible array into another violates the C99 standard, even though GCC
accepts it.

I'll remove it from the spec as well, but I probably won't publish a new
version for this change alone. The virtio spec itself has similar uses
of flexible arrays, that are given for explanation but aren't valid C
(and those wouldn't even compile).

Thanks,
Jean
