From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [Xen-devel] [PATCH RFC 0/3] Xen on Virtio
Date: Tue, 15 Dec 2015 08:45:32 -0800
Message-ID: <CALCETrX9g2Rsh5M+521Pv+OHO-HSUQLHTjGObU0y=qjrMdsgMQ__7284.51714753664$1450197979$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
	<566ECB65.3060509@citrix.com>
	<20151214161037-mutt-send-email-mst@redhat.com>
	<CALCETrVEfrXNJE1Wq3piF7KPExk+4ByBP+rHHq2jWhCAURjcyA@mail.gmail.com>
	<alpine.DEB.2.02.1512151201190.17516@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1512151201190.17516@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 15, 2015 at 4:13 AM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Mon, 14 Dec 2015, Andy Lutomirski wrote:
>> On Mon, Dec 14, 2015 at 6:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Dec 14, 2015 at 02:00:05PM +0000, David Vrabel wrote:
>> >> On 07/12/15 16:19, Stefano Stabellini wrote:
>> >> > Hi all,
>> >> >
>> >> > this patch series introduces support for running Linux on top of Xen
>> >> > inside a virtual machine with virtio devices (nested virt scenario).
>> >> > The problem is that Linux virtio drivers use virt_to_phys to get the
>> >> > guest pseudo-physical addresses to pass to the backend, which doesn't
>> >> > work as expected on Xen.
>> >> >
>> >> > Switching the virtio drivers to the dma APIs (dma_alloc_coherent,
>> >> > dma_map/unmap_single and dma_map/unmap_sg) would solve the problem, as
>> >> > Xen support in Linux provides an implementation of the dma API which
>> >> > takes care of the additional address conversions. However using the dma
>> >> > API would increase the complexity of the non-Xen case too. We would also
>> >> > need to keep track of the physical or virtual address in addition to the
>> >> > dma address for each vring_desc to be able to free the memory in
>> >> > detach_buf (see patch #3).
>> >> >
>> >> > Instead this series adds few obvious checks to perform address
>> >> > translations in a couple of key places, without changing non-Xen code
>> >> > paths. You are welcome to suggest improvements or alternative
>> >> > implementations.
>> >>
>> >> Andy Lutomirski also looked at this.  Andy what happened to this work?
>> >>
>> >> David
>> >
>> > The approach there was to try and convert all virtio to use DMA
>> > API unconditionally.
>> > This is reasonable if there's a way for devices to request
>> > 1:1 mappings individually.
>> > As that is currently missing, that patchset can not be merged yet.
>> >
>>
>> I still don't understand why *devices* need the ability to request
>> anything in particular.  In current kernels, devices that don't have
>> an iommu work (and there's no choice about 1:1 or otherwise) and
>> devices that have an iommu fail spectacularly.  With the patches,
>> devices that don't have an iommu continue to work as long as the DMA
>> API and/or virtio correctly knows that there's no iommu.  Devices that
>> do have an iommu work fine, albeit slower than would be ideal.  In my
>> book, slower than would be ideal is strictly better than crashing.
>>
>> The real issue is *detecting* whether there's an iommu, and the string
>> of bugs in that area (buggy QEMU for the Q35 thing and complete lack
>> of a solution for PPC and SPARC is indeed a problem).
>>
>> I think that we could apply the series ending here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=virtio_dma&id=ad9d43052da44ce18363c02ea597dde01eeee11b
>>
>> and the only regression (performance or functionality) would be that
>> the buggy Q35 iommu configuration would stop working until someone
>> fixed it in QEMU.  That should be okay -- it's explicitly
>> experimental.  (Xen works with that series applied.)   (Actually,
>> there might be a slight performance regression on PPC due to extra
>> unused mappings being created.  It would be straightforward to hack
>> around that in one of several ways.)
>>
>> Am I missing something?
>
> Your changes look plausible and if they fix Xen on virtio I am happy
> with them.  I didn't choose the DMA API approach because, although it
> looks cleaner, I acknowledge that is a bit invasive.
>
> I suggest that the virtio maintainers consider one of the two approaches
> for inclusion because they fix a real issue.
>
> If you would rather avoid the DMA API, then I would be happy to work
> with you to evolve my current series in a direction of your liking.
> Please advise on how to proceed.

I would rather use the DMA API, but we need Michael's buy-in for that.

Michael, if I further modify the driver so that even the dma
allocations don't happen if the in-driver quirk is set, and we set the
quirk on sparc and ppc but clear it on x86 and presumably all the
other architectures, would that be okay with you?

--Andy
