From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 09 Nov 2011 11:06:33 +0000
Message-ID: <1320836793.3259.151.camel__26012.878624215$1321323142$gmane$org@hornet.cambridge.arm.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com> <1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com> <8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com> <20111108214021.GA4538@redhat.com>
	<1320832502.31056.22.camel@lappy> <20111109101814.GC20612@redhat.com>
	<1320834017.31056.26.camel@lappy>
	<1320835653.3259.138.camel@hornet.cambridge.arm.com>
	<1320836144.31056.35.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320836144.31056.35.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Wang Sheng-Hui <shhuiw@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "avi@redhat.com" <avi@redhat.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-09 at 10:55 +0000, Sasha Levin wrote:
> On Wed, 2011-11-09 at 10:47 +0000, Pawel Moll wrote:
> > Yep, it's actually already in 3.2-rc1 (drivers/virtio/virtio_mmio.c) and
> > in the spec (see Appendix X). And actually the control registers layout
> > I used was originally based on the PCI "legacy" headers (slightly
> > simplified), but evolved a bit since. My understanding is that the
> > changes Michael is proposing affect the PCI device interface only so
> > they shouldn't affect "my" interface.
> 
> I didn't know it's in already, might be interesting adding support to it
> to x86 userspace tools.

Do you mean the qemu or the (non-qemu) KVM tools I know nothing
about? ;-)

If qemu, Peter got it already running with virtio_mmio on ARM models
(not upstream yet as far as I know), but I presume the code would we
mostly non-ARM specific.

Cheers!

Pawel
