From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Date: Mon, 22 Oct 2018 12:27:50 +0100
Message-ID: <e5c44d21-7b43-32dd-4f5f-3136bacb07e0__46095.9452823319$1540207569$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-4-jean-philippe.brucker@arm.com>
	<20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
	<20181015065024-mutt-send-email-mst@kernel.org>
	<482d0eb9-8c4c-9d64-7b32-25d5d11a8b8f@gmail.com>
	<20181017111100-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181017111100-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jean-philippe Brucker <jphilippe.brucker@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tnowicki@caviumnetworks.com, peter.maydell@linaro.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, Bjorn Helgaas <helgaas@kernel.org>, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 17/10/2018 16:14, Michael S. Tsirkin wrote:
>>> Thinking about this comment, I would like to ask: can't the
>>> virtio device indicate the ranges in a portable way?
>>> This would minimize the dependency on dt bindings and ACPI,
>>> enabling support for systems that have neither but do
>>> have virtio e.g. through pci.
>>
>> I thought about adding a PROBE request for this in virtio-iommu, but it
>> wouldn't be usable by a Linux guest because of a bootstrapping problem.
> 
> Hmm. At some level it seems wrong to design hardware interfaces
> around how Linux happens to probe things. That can change at any time
> ...

I suspect that most other OS will also solve this class of problem using
a standard such as DT or ACPI, because they also provide dependency for
clock, interrupts, power management, etc. We can add a self-contained
PROBE method if someone makes a case for it, but it's unlikely to get
used at all, and nearly impossible to implement in Linux. The host would
still need a method to tell the guest which device to probe first, for
example with kernel parameters.

>> Early on, Linux needs a description of device dependencies, to determine
>> in which order to probe them. If the device dependency was described by
>> virtio-iommu itself, the guest could for example initialize a NIC,
>> allocate buffers and start DMA on the physical address space (which aborts
>> if the IOMMU implementation disallows DMA by default), only to find out
>> once the virtio-iommu module is loaded that it needs to cancel all DMA and
>> reconfigure the NIC. With a static description such as iommu-map in DT or
>> ACPI remapping tables, the guest can defer probing of the NIC until the
>> IOMMU is initialized.
>>
>> Thanks,
>> Jean
> 
> Could you point me at the code you refer to here?

In drivers/base/dd.c, really_probe() calls dma_configure() before the
device driver's probe(). dma_configure() ends up calling either
of_dma_configure() or acpi_dma_configure(), which return -EPROBE_DEFER
if the device's IOMMU isn't yet available. In that case the device is
added to the deferred pending list.

After another device is successfully bound to a driver, all devices on
the pending list are retried (driver_deferred_probe_trigger()), and if
the dependency has been resolved, then dma_configure() succeeds.

Another method (used by Intel and AMD IOMMU drivers) is to initialize
the IOMMU as early as possible, after discovering it in the ACPI tables
and before probing other devices. This can't work for virtio-iommu
because the driver might be a module, in which case early init isn't
possible. We have to defer probe of all dependent devices until the
virtio and virtio-iommu modules are loaded.

Thanks,
Jean
