From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 18:02:12 -0700
Message-ID: <4660C194.4010003@zytor.com>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <466087CF.70708@goop.org> <4660924A.2070009@zytor.com> <466093E3.4010701@goop.org> <46609636.4050208@zytor.com> <4660BBDF.1040007@goop.org> <4660BCF8.7000208@zytor.com> <4660C0CD.5060606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761762AbXFBBCb@vger.kernel.org>
In-Reply-To: <4660C0CD.5060606@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
> Just to clarify:
> 
> In my proposal is that we have bzImage structured something like (where
> "|" is concatenation, and "()" is a  blob containing stuff):
> 
>     bzImage = 16-bit setup | ELF file (decompressor, compressed kernel)
>       
> 
> With the intention that 32-bit only bootloader always loads the ELF file
> as-is and just runs it.  Aside from the fact that its an ELF file,
> there's nothing else about it which really concerns the bootloader,
> since once its loaded and running, it does all its own setup.  Its not
> clear that code32_start really means much in this case, though I guess
> it could point to the same place as the ELF file's entrypoint.
> 

It would have to, because of the way code32_start is defined to work.
We don't get control again after its use as a hook.

> Whereas you're proposing:
> 
>     bzImage = 16-bit setup | decompressor | compressed kernel (ELF file)
>       
> 
> where code32_start points to the decompressor, and some other pointer
> points to the compressed kernel data.  And your intent is that an
> external bootloader could also interpret the compressed kernel image,
> and identify what format its in and handle it appropriately from
> outside.  Right?

Correct.

> In both cases, it seems to me that we need an extra boot_param pointer
> to point to the offset of the payload blob (ELF file in my case,
> compressed kernel in yours).  Yes?

Indeed.

	-hpa
