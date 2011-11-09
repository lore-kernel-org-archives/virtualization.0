From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 9 Nov 2011 12:18:15 +0200
Message-ID: <20111109101814.GC20612@redhat.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<1320832502.31056.22.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1320832502.31056.22.camel@lappy>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 09, 2011 at 11:55:02AM +0200, Sasha Levin wrote:
> On Tue, 2011-11-08 at 23:40 +0200, Michael S. Tsirkin wrote:
> > Here's a spec change documenting what my C patch does
> > (almost - I tweaked the layout a bit, but the idea is the same).
> > Some more cleanups are needed but I thought I'd send it
> > for early flames/comments.
> > 
> > The idea is simple: we split functionally unrelated
> > register groups to independent structures, and let
> > the device place is anywhere using a capability
> > in PCI configuration space.
> 
> I'm also wondering it it's ok to move virtio configuration out of virtio
> space and into PCI space for archs that don't have PCI (such as ARM).

A bit of confusion here: no register is moved from memory into
configuration space. Configuration space only gains a list of
pointers into memory/pio space.

> Would it mean they get stuck with legacy configuration (and no new
> features)? Or is there an alternative for them?

The change only affects the layout of virtio PCI. Arches that don't
have PCI don't use virtio PCI, presumably?

BTW, the spec only covers x86 ATM, this needs to be fixed.

> 
> -- 
> 
> Sasha.
