From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC] virtio-iommu version 0.4
Date: Wed, 23 Aug 2017 11:01:11 +0100
Message-ID: <5be484ff-6a1a-6c9b-947c-f64ea23f58cc__31963.7798857459$1503482328$gmane$org@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
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
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, will.deacon@arm.com, eric.auger@redhat.com, robin.murphy@arm.com, eric.auger.pro@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 04/08/17 19:19, Jean-Philippe Brucker wrote:
> Other extensions are in preparation. I won't detail them here because v0.4
> already is a lot to digest, but in short, building on top of PROBE:
> 
> * First, since the IOMMU is paravirtualized, the device can expose some
>   properties of the physical topology to the guest, and let it allocate
>   resources more efficiently. For example, when the virtio-iommu manages
>   both physical and emulated endpoints, with different underlying IOMMUs,
>   we now have a way to describe multiple page and block granularities,
>   instead of forcing the guest to use the most restricted one for all
>   endpoints. This will most likely be in v0.5.

In order to extend requests with PASIDs and (later) nested mode, I intend
to rename "address_space" field to "domain", since it is a lot more
precise about what the field is referring to and the current name would
make these extensions confusing. Please find the rationale at [1].
"ioasid_bits" will be "domain_bits" and "VIRTIO_IOMMU_F_IOASID_BITS" will
be "VIRTIO_IOMMU_F_DOMAIN_BITS".

For those that had time to read this version, do you have other comments
and suggestions about v0.4? Otherwise it is the only update I have for
v0.5 (along with fine-grained address range and page size properties from
the quoted text) and I will send it soon.

In particular, please tell me now if you see the need for other
destructive changes like this one. They will be impossible to introduce
once a driver or device is upstream.

Thanks,
Jean

[1] https://www.spinics.net/lists/kvm/msg154573.html
