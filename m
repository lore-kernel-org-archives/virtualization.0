From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PULL] virtio
Date: Tue, 01 Nov 2011 14:45:08 +0200
Message-ID: <1320151508.3847.27.camel@lappy>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com> <1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111101124223.GA14060@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-01 at 14:42 +0200, Michael S. Tsirkin wrote:
> On Tue, Nov 01, 2011 at 02:33:33PM +0200, Sasha Levin wrote:
> > On Tue, 2011-11-01 at 13:45 +0200, Michael S. Tsirkin wrote:
> > > On Tue, Nov 01, 2011 at 10:39:08AM +1030, Rusty Russell wrote:
> > > >  * [new tag]         rusty@rustcorp.com.au-v3.1-7196-gac5be1e -> rusty@rustcorp.com.au-v3.1-7196-gac5be1e
> > > > 
> > > > The following changes since commit 839d8810747bbf39e0a5a7f223b67bffa7945f8d:
> > > > 
> > > >   Merge branch 'i2c-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging (2011-10-30 15:54:59 -0700)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   git://github.com/rustyrussell/linux.git master
> > > > 
> > > > Alexey Kardashevskiy (1):
> > > >       virtio-pci: Use PCI MMIO instead of PIO when available
> > > 
> > > I missed this one - wasn't Cc'd neither me, kvm or virtio mailing lists.
> > > 
> > > It's well known that mmio is much slower than pio on kvm, since
> > > mmio needs to be emulated to get at the address.
> > > So I'm expecting this will cause a performance regression.
> > > IMO we should keep using PIO for VQ and interrupt status access
> > > if PIO is available.
> > > 
> > > Another consideration is that in an attempt to pack data
> > > densely in the PIO space the layout became messy.
> > > It would be better to have common config space and
> > > per-device config space in separate pages, possibly
> > > with padding between them.
> > > 
> > > So I'd like a bit more discussion on this patch,
> > > I'm concerned that if this is released in 3.2 as is we'll
> > > have to support this forever. How about a revert for now?
> > 
> > Another thing, the patch tries to map BAR 2 and use it as the
> > configuration space.
> > 
> > It's both not documented properly anywhere, and is not fully backwards
> > compatible - we currently use BAR 2 as part of our MSIX handling in the
> > kvm tool and I'm sure we're not the only ones to assume virtio-pci only
> > uses BAR 0.
> > 
> > A proper solution would be for example a configuration in the PIO config
> > space which points to the MMIO BAR to use instead.
> 
> I think it makes sense to put the configuration in PCI
> configuration space, using vendor-specific capability.
> This way we can reuse existing functionality for scanning
> capability lists.

Yup, I agree. It would also allow dropping the PIO config BAR altogether
after some period of backwards compatibility.

It was mostly to point out that the patch isn't really backwards
compatible :)

-- 

Sasha.
