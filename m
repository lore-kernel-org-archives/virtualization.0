From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Thu, 14 Feb 2008 17:01:30 +0000
Message-ID: <1203008490.30818.69.camel__24871.905524242$1203008673$gmane$org@localhost.localdomain>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
	<1202988844.26435.4.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1202988844.26435.4.camel@muff>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2008-02-14 at 11:34 +0000, Mark McLoughlin wrote:
> On Wed, 2008-02-13 at 20:54 +0000, Ian Campbell wrote:
> > This allows other boot loaders such as the Xen domain builder the
> > opportunity to extract the ELF file.
> 
> 	Right, Xen currently can't boot bzImage (it needs the ELF image) so you
> still can't use the same kernel image on Xen as bare-metal.

I have a xen domain builder patch as well. I was waiting for the Linux
side to gain some traction before putting it forward (I'd attach it now
but it's at home on a laptop which is sleeping).

> > +Field name:	compressed_payload_offset
> > +Type:		read
> > +Offset/size:	0x248/4
> > +Protocol:	2.08+
> > +
> > +  If non-zero then this field contains the offset from the end of the
> > +  real-mode code to the compressed payload. The compression format
> > +  should be determined using the standard magic number, currently only
> > +  gzip is used.
> 
> 	Should probably mention that the payload format is expected to be ELF.

Agreed. Probably the same deal as the compression format, i.e. use the
magic number but only ELF is possible today (even less likely to change
than the compression format I guess...).

> 	How about this?
> 
> +sed-offsets := -e 's/^00*/0/' \
> +        -e 's/^\([0-9a-fA-F]*\) . \(input_data\|input_data_end\)$$/-D\2=0x\1 /p'
> +
> +$(obj)/header.o: AFLAGS_header.o += $(shell $(NM) $(obj)/compressed/vmlinux | sed -n $(sed-offsets))
> +$(obj)/header.o: $(obj)/compressed/vmlinux FORCE

That's probably a neater way of doing it. Although the ".../header.o:
AFLAGS_header.o" is redundant, either 
	header.o: AFLAGS += foo
or
	AFLAGS_header.o += foo
with the second being preferred in Linux Makefiles I think.

I'll try and get an updated patch out before I head for my flight
tomorrow.

Ian.

-- 
Ian Campbell
Current Noise: Reverend Bizarre - The Festival

While money can't buy happiness, it certainly lets you choose your own
form of misery.
