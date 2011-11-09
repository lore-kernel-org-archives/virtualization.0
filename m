From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 09 Nov 2011 14:28:03 +0200
Message-ID: <1320841683.31056.41.camel@lappy>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com> <1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com> <8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com> <20111108214021.GA4538@redhat.com>
	<1320828366.31056.16.camel@lappy> <20111109101318.GB20612@redhat.com>
	<alpine.LFD.2.02.1111091421570.4936@tux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1111091421570.4936@tux.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, penberg@cs.helsinki.fi, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-09 at 14:25 +0200, Pekka Enberg wrote:
> On Wed, 9 Nov 2011, Michael S. Tsirkin wrote:
> >> KVM tool actually has support for 64bit features, we can probably remove
> >> that when Pekka isn't looking :)
> >
> > It's not yet released so maybe it's not an issue yet.
> > If it's too late I can re-add them to legacy too.
> >
> > Pekka, 64 features aren't yet used and we are discussing
> > changing the layout for that field. Mind taking it out
> > of kvm tool for now?
> 
> Sasha, why did we add 64-bit features to the KVM tool? Wasn't it part of 
> the virtio spec? Does QEMU not use them? How badly will older versions of 
> the KVM tool break if you drop 64-bit features?

We added 64-bit features to the tool because it just got into the spec
when we rewrote our virtio-pci handling - so we just implemented the
updated spec.

QEMU doesn't use them since while it did get into the spec, it was
intended to future-proof the limited feature bits, so no one really
needed them yet.

They don't exist in kernel code either, for same reason as above.

Nothing will break if we remove it since no one really used it, we were
probably the first and only implementation of the spec which considered
them :)

-- 

Sasha.
