From: Gregory Haskins <ghaskins@novell.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Mon, 20 Aug 2007 10:17:46 -0400
Message-ID: <1187619466.4363.186.camel__46581.0716654689$1187619693$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<46C80C5B.7070009@qumranet.com>
	<1187617806.4363.179.camel@ghaskins-t60p.haskins.net>
	<64F9B87B6B770947A9F8391472E032160D4649E2@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E032160D4649E2@ehost011-8.exch011.intermedia.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dor Laor <dor.laor@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Avi Kivity <avik@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-08-20 at 07:03 -0700, Dor Laor wrote:
> >> >         2) We either need huge descriptors or some chaining
> >mechanism to
> >> >         handle scatter-gather.
> >> >
> >>
> >> Or, my preference, have a small sglist in the descriptor;
> >
> >
> >Define "small" ;)
> >
> >There a certainly patterns that cannot/will-not take advantage of SG
> >(for instance, your typical network rx path), and therefore the sg
> >entries are wasted in some cases.  Since they need to be (IMHO) u64,
> >they suck down at least 8 bytes a piece.  Because of this I elected to
> >use the model of one pointer per descriptor, with an external
> descriptor
> >for SG.  What are your thoughts on this?
> 
> Using Rusty's code there is no waste.
> Each descriptor has a flag (head|next). Next flag stands for pointer to
> the
> next descriptor with u32 next index. So the waste is 4 bytes.
> Sg descriptors are chained on the same descriptor ring.

Right, so he is using a chaining mechanism and I was using a
single-pointer + external-descriptor mechanism.  (Actually you can chain
with IOQ too if you want but I chose to implement the IOQNET example
with external-descriptors).  I'm not sure if either way is particularly
better than the other.  The important thing (IMO) is that either way you
avoid waste for the (not so uncommon) non-sg case.

You still owe me some code, BTW ;)
