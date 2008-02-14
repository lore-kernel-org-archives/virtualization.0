From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Thu, 14 Feb 2008 11:34:04 +0000
Message-ID: <1202988844.26435.4.camel__20635.5933602483$1202988993$gmane$org@muff>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
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

On Wed, 2008-02-13 at 20:54 +0000, Ian Campbell wrote:
> This allows other boot loaders such as the Xen domain builder the
> opportunity to extract the ELF file.

	Right, Xen currently can't boot bzImage (it needs the ELF image) so you
still can't use the same kernel image on Xen as bare-metal.

> +Field name:	compressed_payload_offset
> +Type:		read
> +Offset/size:	0x248/4
> +Protocol:	2.08+
> +
> +  If non-zero then this field contains the offset from the end of the
> +  real-mode code to the compressed payload. The compression format
> +  should be determined using the standard magic number, currently only
> +  gzip is used.

	Should probably mention that the payload format is expected to be ELF.
 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index f88458e..9695aff 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -94,6 +94,20 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>  
>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>  
> +sed-offsets := -e 's/^00*/0/' \
> +        -e 's/^\([0-9a-fA-F]*\) . \(input_data\|input_data_end\)$$/\#define \2 0x\1/p'
> +
> +quiet_cmd_offsets = OFFSETS $@
> +      cmd_offsets = $(NM) $< | sed -n $(sed-offsets) > $@
> +
> +$(obj)/offsets.h: $(obj)/compressed/vmlinux FORCE
> +	$(call if_changed,offsets)
> +
> +targets += offsets.h
> +
> +AFLAGS_header.o += -I$(obj)
> +$(obj)/header.o: $(obj)/offsets.h

	How about this?

+sed-offsets := -e 's/^00*/0/' \
+        -e 's/^\([0-9a-fA-F]*\) . \(input_data\|input_data_end\)$$/-D\2=0x\1 /p'
+
+$(obj)/header.o: AFLAGS_header.o += $(shell $(NM) $(obj)/compressed/vmlinux | sed -n $(sed-offsets))
+$(obj)/header.o: $(obj)/compressed/vmlinux FORCE

Cheers,
Mark.
