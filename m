From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: Define virtio-mmio registers as LE
Date: Thu, 07 Mar 2013 17:36:13 +1100
Message-ID: <871ubryaw2.fsf@rustcorp.com.au>
References: <87wqubkalj.fsf@rustcorp.com.au>
	<1360839247-9131-1-git-send-email-pawel.moll@arm.com>
	<513085EA.8070007@arm.com> <1362135005.3052.26.camel@hornet>
	<51308F22.7040303@arm.com> <1362141432.3052.28.camel@hornet>
	<87fw0ad7sr.fsf@rustcorp.com.au> <1362582615.3105.45.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362582615.3105.45.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:
> On Tue, 2013-03-05 at 00:11 +0000, Rusty Russell wrote:
>> Pawel Moll <pawel.moll@arm.com> writes:
>> > On Fri, 2013-03-01 at 11:21 +0000, Marc Zyngier wrote:
>> >> > Having said that, Rusty was contemplating enforcing LE config space in
>> >> > the new PCI layout...
>> >> 
>> >> I wouldn't complain about that, and would like to see a similar thing on
>> >> MMIO.
>> >
>> > Wherever PCI goes, MMIO follows :-)
>> 
>> Yes, but if you switch from 'guest-endian' to 'little-endian' how will
>> you tell?  For PCI, we'd detect it by using the new layout.
>
> The version register/value. At some point of time there will be a
> new(ish) MMIO layout anyway to deal with 64-bit addresses, replacing the
> ring page number with two 32-bit hi/lo physical address registers. This
> was discussed not long after the driver got merged...

As long as you have a plan for older guests...

>> I'd rather you specify MMIO as little endian, and we fix the kernel
>> config accessors to be endian aware (ie. 8, 16, 32, 64-bit accessors).
>> Since noone BE is using MMIO right now, it's safe...
>
> That's absolutely fine with me, however I don't see anything I could do
> in the virtio_mmio driver and spec - the virtio_config_ops specifies
> get/set as void * operations and I simply do byte-by-byte copy. Have I
> missed some config/endianess/PCI related discussion?

Yes, that's exactly what I mean, they'd have to be split into
8/16/32/64 accessors.  Which would do byte-by-byte for PCI.

The spec can simply be updated.

Cheers,
Rusty.
