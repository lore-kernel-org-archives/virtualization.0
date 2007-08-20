From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 09:24:46 +1000
Message-ID: <1187652286.19435.137.camel__32181.4733361409$1187652435$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<46C80C5B.7070009@qumranet.com>
	<1187617806.4363.179.camel@ghaskins-t60p.haskins.net>
	<64F9B87B6B770947A9F8391472E032160D4649E2@ehost011-8.exch011.intermedia.net>
	<46C9A150.60101@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C9A150.60101@qumranet.com>
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
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-08-20 at 17:12 +0300, Avi Kivity wrote:
> Dor Laor wrote:
> > Using Rusty's code there is no waste.
> > Each descriptor has a flag (head|next). Next flag stands for pointer to
> > the
> > next descriptor with u32 next index. So the waste is 4 bytes.
> > Sg descriptors are chained on the same descriptor ring.
> >   
> 
> Block I/O can easily require 256 sglist entries, eating up your ring.

Absolutely; I think we'd want this variable sized, rather than a single
page as the current implementation does for no really sound reason.

That said, I don't have a problem with Avi's out-of-band mechanism.  A
"DMA" hypercall can follow that almost as easily, and it does give that
nice "fixed number of slots" effect.

Cheers,
Rusty.
