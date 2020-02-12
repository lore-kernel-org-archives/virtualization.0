From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 14/62] x86/boot/compressed/64: Add stage1 #VC handler
Date: Wed, 12 Feb 2020 08:22:14 -0800
Message-ID: <A67CC291-C07A-496C-BD67-2A795813E93F@amacapital.net>
References: <20200212113840.GB20066@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200212113840.GB20066@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Juergen Gross <JGross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



> On Feb 12, 2020, at 3:38 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFOn Tue, Feb 11, 2020 at 02:23:22PM -0800, Andy Lutomirski wrote:
>>> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>>> +void __init no_ghcb_vc_handler(struct pt_regs *regs)
>>=20
>> Isn't there a second parameter: unsigned long error_code?
>=20
> No, the function gets the error-code from regs->orig_ax. This particular
> function only needs to check for error_code =3D=3D SVM_EXIT_CPUID, as that=

> is the only one supported when there is no GHCB.
>=20

Hmm. It might be nice to use the same signature for early handlers as for no=
rmal ones.

> Regards,
>=20
>    Joerg
