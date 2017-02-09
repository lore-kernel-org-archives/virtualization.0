From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Thu, 9 Feb 2017 18:54:32 +0000
Message-ID: <CAKv+Gu_j1FaByygYkQwYrQpCztnWwot6gUGW3suGjUhdaVopeg__16015.4134537608$1486667665$gmane$org@mail.gmail.com>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
	<20170201195732-mutt-send-email-mst@kernel.org>
	<20170201182659.GM8177@arm.com>
	<20170201210648-mutt-send-email-mst@kernel.org>
	<20170202112614.GB30577@arm.com>
	<bb041fbe-3fde-0dc1-ae28-cca5acfe9dc5@arm.com>
	<20170202182224-mutt-send-email-mst@kernel.org>
	<20170202164049.GI13839@arm.com>
	<20170209201341-mutt-send-email-mst@kernel.org>
	<20170209183118.GI19397@arm.com>
	<20170209203752-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170209203752-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 9 February 2017 at 18:49, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Feb 09, 2017 at 06:31:18PM +0000, Will Deacon wrote:
>> On Thu, Feb 09, 2017 at 08:17:16PM +0200, Michael S. Tsirkin wrote:
>> > On Thu, Feb 02, 2017 at 04:40:49PM +0000, Will Deacon wrote:
>> > > On Thu, Feb 02, 2017 at 06:30:28PM +0200, Michael S. Tsirkin wrote:
>> > > > I am inclined to say, for 4.10 let's revert
>> > > > c7070619f3408d9a0dffbed9149e6f00479cf43b since what it fixes is not a
>> > > > regression in 4.10.
>> > >
>> > > No complaints there, as long as we can keep working to fix this for 4.11
>> > > and onwards. You'll also need to cc stable on the revert.
>> > >
>> > > > So I think we can defer the fix to 4.11.
>> > > > I think we still want f7f6634d23830ff74335734fbdb28ea109c1f349
>> > > > for hosts with virtio 1 support.
>> > > >
>> > > > All this will hopefully push hosts to just implement virtio 1.
>> > > > For mmio the changes are very small: several new registers,
>> > > > that's all. You want this for proper 64 bit dma mask anyway.
>> > >
>> > > As I've said, virtio 1 will have exactly the same issue unless we start
>> > > requiring firmware to advertise dma-coherent/_CCA for virtio-mmio
>> > > devices correctly.
>> > >
>> >
>> > OK I read up on _CCA in ACPI spec. It says:
>> > The _CCA object returns whether or not a bus-master device supports
>> > hardware managed cache coherency. Expected values are 0 to indicate it
>> > is not supported, and 1 to indicate that it is supported.
>> >
>> > So if host is cache coherent, and guest thinks it isn't, we incur
>> > unnecessary overhead by wasting coherent memory.
>> > I get that but you said it actually breaks - why does it?
>>
>> It breaks because QEMU doesn't set _CCA for virtio-mmio devices, and that
>> only becomes a problem when we use the DMA API, because that results in the
>> guest taking out a non-cacheable mapping. On ARM (and other archs such as
>> Power), having a mismatch between a cacheable and a non-cacheable mapping
>> can result in a loss of coherency between the two (for example, if the
>> non-cacheable gues accesses bypass the cache, but the cacheable host
>> accesses allocate in the cache).
>>
>> Will
>
> I see. And I guess using a cacheable mapping is significantly faster.
> I would say we want to typically use cacheable for virtio then,
> whether we bypass the IOMMU or not. I guess this is why we always set
> _CCA/DT correctly, right?
>

The point is that you don't get to choose: if the hardware is DMA
coherent, the CPU should use cacheable mappings, or you may lose data.
If the hardware is non-coherent, the CPU should use non-cacheable
mappings for the same reason.
