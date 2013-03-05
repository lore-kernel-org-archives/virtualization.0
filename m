From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: Define virtio-mmio registers as LE
Date: Tue, 05 Mar 2013 11:11:48 +1100
Message-ID: <87fw0ad7sr.fsf@rustcorp.com.au>
References: <87wqubkalj.fsf@rustcorp.com.au>
	<1360839247-9131-1-git-send-email-pawel.moll@arm.com>
	<513085EA.8070007@arm.com> <1362135005.3052.26.camel@hornet>
	<51308F22.7040303@arm.com> <1362141432.3052.28.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362141432.3052.28.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:
> On Fri, 2013-03-01 at 11:21 +0000, Marc Zyngier wrote:
>> > Having said that, Rusty was contemplating enforcing LE config space in
>> > the new PCI layout...
>> 
>> I wouldn't complain about that, and would like to see a similar thing on
>> MMIO.
>
> Wherever PCI goes, MMIO follows :-)

Yes, but if you switch from 'guest-endian' to 'little-endian' how will
you tell?  For PCI, we'd detect it by using the new layout.

I'd rather you specify MMIO as little endian, and we fix the kernel
config accessors to be endian aware (ie. 8, 16, 32, 64-bit accessors).
Since noone BE is using MMIO right now, it's safe...

Thanks,
Rusty.
