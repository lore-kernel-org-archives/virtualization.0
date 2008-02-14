From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Thu, 14 Feb 2008 17:37:55 +0000
Message-ID: <1203010675.16280.15.camel__8293.4845857837$1203010851$gmane$org@muff>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
	<1202988844.26435.4.camel@muff>
	<1203008490.30818.69.camel@localhost.localdomain>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1203008490.30818.69.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-02-14 at 17:01 +0000, Ian Campbell wrote:
> On Thu, 2008-02-14 at 11:34 +0000, Mark McLoughlin wrote:
> > On Wed, 2008-02-13 at 20:54 +0000, Ian Campbell wrote:
> > > This allows other boot loaders such as the Xen domain builder the
> > > opportunity to extract the ELF file.
> > 
> > 	Right, Xen currently can't boot bzImage (it needs the ELF image) so you
> > still can't use the same kernel image on Xen as bare-metal.
> 
> I have a xen domain builder patch as well. I was waiting for the Linux
> side to gain some traction before putting it forward (I'd attach it now
> but it's at home on a laptop which is sleeping).

Yep, just want to highlight to people that your patches (or an
alternative) are needed before the same pv_ops kernel truly can be used
on bare-metal and Xen.

> > 	How about this?
> > 
> > +sed-offsets := -e 's/^00*/0/' \
> > +        -e 's/^\([0-9a-fA-F]*\) . \(input_data\|input_data_end\)$$/-D\2=0x\1 /p'
> > +
> > +$(obj)/header.o: AFLAGS_header.o += $(shell $(NM) $(obj)/compressed/vmlinux | sed -n $(sed-offsets))
> > +$(obj)/header.o: $(obj)/compressed/vmlinux FORCE
> 
> That's probably a neater way of doing it. Although the ".../header.o:
> AFLAGS_header.o" is redundant, either 
> 	header.o: AFLAGS += foo

With this, AFLAGS would apply to building when building the
prerequisites of header.o too, which you don't want

The make manual says:

  "when you define a target-specific variable that variable value is
   also in effect for all prerequisites of this target, and all their
   prerequisites"

> or
> 	AFLAGS_header.o += foo
> with the second being preferred in Linux Makefiles I think.

And with this, it would try and read vmlinux before it is built.

But, hmm, given the fact that the variable is defined when building
prerequisites, you'd think that even in my version AFLAGS would be
evaluated before building vmlinux.

Cheers,
Mark.
