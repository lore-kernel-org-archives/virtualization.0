From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 37/43] lguest: Virtio helper routines for a descriptor
	ringbuffer implementation
Date: Mon, 01 Oct 2007 22:03:22 +1000
Message-ID: <1191240202.6648.11.camel@localhost.localdomain>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063651.769960367@rustcorp.com.au>
	<46FFD6CB.9020904@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46FFD6CB.9020904@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: lguest@ozlabs.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-09-30 at 19:03 +0200, Avi Kivity wrote:
> rusty@rustcorp.com.au wrote:
> 
> > These helper routines supply most of the virtqueue_ops for hypervisors
> > which want to use a ring for virtio.  Unlike the previous lguest
> > implementation:
> >
> > 1) The rings are variable sized (2^n-1 elements).
> > 2) They have an unfortunate limit of 65535 bytes per sg element.
> > 3) The page numbers are always 64 bit (PAE anyone?)
> > 4) They no longer place used[] on a separate page, just a separate
> >    cacheline.
> > 5) We do a modulo on a variable.  We could be tricky if we cared.
> > 6) Interrupts and notifies are suppressed using flags within the rings.
> >
> > Users need only get the ring pages and provide a notify hook (KVM
> > wants the guest to allocate the rings, lguest does it sanely).
> 
> This fixes an ABI.  I don't think we have enough experience with this to 
> set an ABI for 2.6.24.  I also owe you a patch for scatter/gather 
> indirection instead of chaining.
> 
> It is okay to put this in as long as 2.6.24 drivers won't try to talk to 
> 2.6.25+ hosts (which presumably will have a stable ABI).  We could do 
> this by having "stable API" feature bit which the new drivers will 
> require, and an "2.6.24 ABI" feature bit which the current drivers will 
> require, but the whole config interface itself is too new for this in my 
> opinion.

Yes, but this is what lguest is for, to play without fixing an ABI.  I
fully expect incompatible tweaks before KVM causes the ABI to nail down.

And it's going to be far easier to manage lguest-kvm cooperation with
this in tree than outside.

Cheers,
Rusty.
