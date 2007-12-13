From: "Tom Spink" <tspink@gmail.com>
Subject: Re: [PATCH] avoid ifdefs in desc.h,
	getting rid of pack_ldt and pack_tss
Date: Thu, 13 Dec 2007 21:37:02 +0000
Message-ID: <7b9198260712131337j6249c980q55306b676b361776__35482.3642214344$1197583271$gmane$org@mail.gmail.com>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu> <20071213205838.GA9649@elte.hu>
	<20071213212221.GA16747@elte.hu> <4761A385.1080301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4761A385.1080301@zytor.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: ak@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ehabkost@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Dec 13, 2007 9:26 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Ingo Molnar wrote:
> >
> >> could we _please_ use basic tools as vmlinux size comparison and
> >> objcompare when unifying, to make sure it's a 100% identity
> >> conversion?
> >
> > case in point, the patch claims:
> >
> >>> No functional change is made.
> >
> > but vmlinux before/after size comparison shows:
> >
> >     text    data     bss     dec     hex filename
> >  8802894 1224910 3526656 13554460         ced31c vmlinux.before
> >  8803042 1224910 3526656 13554608         ced3b0 vmlinux.after
> >
>
> Well, "no functional changes" is not quite the same thing as "no object
> code changes".
>
>         -hpa
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I'm by far no expert on the subject, but after a quick eyes-debug,
have you got the size and type parameters reversed here:

+       set_tssldt_descriptor(&tss, (unsigned long)addr,
               IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1,
               DESC_TSS);

Should DESC_TSS be the parameter before that big size equation?

-- 
Regards,
Tom Spink
University of Edinburgh
