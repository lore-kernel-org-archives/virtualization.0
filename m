From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 23/62] x86/idt: Move IDT to data segment
Date: Wed, 12 Feb 2020 08:23:54 -0800
Message-ID: <EEAC8672-C98F-45D0-9F2D-0802516C3908@amacapital.net>
References: <20200212115516.GE20066@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200212115516.GE20066@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Juergen Gross <JGross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



> On Feb 12, 2020, at 3:55 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFOn Tue, Feb 11, 2020 at 02:41:25PM -0800, Andy Lutomirski wrote:
>>> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>>>=20
>>> From: Joerg Roedel <jroedel@suse.de>
>>>=20
>>> With SEV-ES, exception handling is needed very early, even before the
>>> kernel has cleared the bss segment. In order to prevent clearing the
>>> currently used IDT, move the IDT to the data segment.
>>=20
>> Ugh.  At the very least this needs a comment in the code.
>=20
> Yes, right, added a comment for that.
>=20
>> I had a patch to fix the kernel ELF loader to clear BSS, which would
>> fix this problem once and for all, but it didn't work due to the messy
>> way that the decompressor handles memory.  I never got around to
>> fixing this, sadly.
>=20
> Aren't there other ways of booting (Xen-PV?) which don't use the kernel
> ELF loader?

Dunno. I would hope the any sane loader would clear BSS before executing any=
thing. This isn=E2=80=99t currently the case, though. Oh well.

>=20
> Regards,
>=20
>    Joerg
