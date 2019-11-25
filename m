From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Date: Mon, 25 Nov 2019 19:02:47 +0100
Message-ID: <20191125180247.GD945122__46909.8631919891$1574704988$gmane$org@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122160102.00004489@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191122160102.00004489@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, mst@redhat.com, eric.auger@redhat.com, guohanjun@huawei.com, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:
> > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD and
> > IORT for Arm). From my point of view IORT is easier to extend, since
> > we just need to introduce a new node type. There are no dependencies
> > to Arm in the Linux IORT driver, so it works well with CONFIG_X86.
> > 
> From my limited understanding, IORT and VIOT is to solve device topology
> enumeration only? I am not sure how it can be expanded to cover
> information beyond device topology. e.g. DMAR has NUMA information and
> root port ATS, I guess they are not used today in the guest but might
> be additions in the future.

The PCI root-complex node of IORT has an ATS attribute, which we can
already use. However its scope is the root complex, not individual root
ports like with DMAR.

I'm not very familiar with NUMA, but it looks like we just need to specify
a proximity domain in relation to the SRAT table, for each viommu? The
SMMUv3 node in IORT has a 4-bytes "proximity domain" field for this. We
can add the same to the VIOT virtio-iommu nodes later, since the
structures are extensible.

But it might be better to keep the bare minimum information in the FW
descriptor, and put the rest in the virtio-iommu. So yes topology
enumeration is something the device cannot do itself (not fully that is,
see (2)) but for the rest, virtio-iommu's PROBE request can provide
details about each endpoint in relation to their physical IOMMU.

We could for example add a bit in a PROBE property saying that the whole
path between the IOMMU and the endpoint supports ATS. For NUMA it might
also be more interesting to have a finer granularity, since one viommu
could be managing endpoints that are behind different physical IOMMUs. If
in the future we want to allocate page tables close to the physical IOMMU
for example, we might need to describe multiple NUMA nodes per viommu,
using the PROBE request.

Thanks,
Jean
