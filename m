From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Thu, 15 Mar 2007 20:03:10 -0800
Message-ID: <45FA16FE.7010805@vmware.com>
References: <45FA054F.6020107@vmware.com> <45FA0D13.6080601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45FA0D13.6080601@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   =

>> Invoke black magic to relocate the VDSO even when COMPAT_VDSO is enabled
>> by fixing up the ELF object.
>>   =

>>     =

>
> So does it actually work?  Can you boot the broken distros with this in
> place?
>   =


Well testing that is not so fun.  I installed SUSE Pro 9.0, and strings =

on ld.so contains the magic at_sysinfo assert!  But it doesn't install =

TLS libraries, so I'll have to install them by hand.

In works - in theory.  Look, a puppy!

Scratchbox is rumored to produce the fabled assertion even on modern =

distros by installing its own toolchain which includes the dreaded glibc.

> Using sections is wrong; you should be going through the phdrs, and
> looking for PT_DYNAMIC for relocation.
>   =


Will do.

> Does anyone expect the symbolic info to be correct?  It might be better
> to just stomp it so nobody gets any ideas.
>
> On the other hand, we don't want to break compatibility with anything...
>   =


I'm playing safe.  Binary identical relocation to 0xffffe000 was my goal.

>> +		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".dynamic") =3D=3D 0=
) {
>> +			Elf32_Dyn *dyn =3D (void *)hdr + sechdrs[i].sh_offset;
>> +			int tag;
>> +			while ((tag =3D (++dyn)->d_tag) !=3D DT_NULL)
>>   =

>>     =

>
> Um, no.
>   =


Walk based on size instead?

>> +		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".useless") =3D=3D 0=
) {
>> +			/* This is demonic; see vsyscall.lds.S; it puts the
>> +			 * .got in a section named .useless */
>> +			uint32_t *got =3D (void *)hdr + sechdrs[i].sh_offset;
>> +			*got +=3D VDSO_HIGH_BASE;
>> +		}
>>   =

>>     =

>
> This won't get relocated with one of the other relocations?  It's in the
> text phdr.
>   =


Hmm, I can try that.  Thanks for the suggestions / fixes.

Zach
