From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 00/62] Linux as SEV-ES Guest Support
Date: Tue, 11 Feb 2020 19:48:12 -0800
Message-ID: <BD48E405-8E3F-4EEE-A72A-8A7EDCB6A376@amacapital.net>
References: <20200211135256.24617-1-joro@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Juergen Gross <JGross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



> On Feb 11, 2020, at 5:53 AM, Joerg Roedel <joro@8bytes.org> wrote:

>=20
>=20
>    * Putting some NMI-load on the guest will make it crash usually
>      within a minute

Suppose you do CPUID or some MMIO and get #VC. You fill in the GHCB to ask f=
or help. Some time between when you start filling it out and when you do VMG=
EXIT, you get NMI. If the NMI does
its own GHCB access [0], it will clobber the outer #VC=E2=80=99a state, resu=
lting in a failure when VMGEXIT happens. There=E2=80=99s a related failure m=
ode if the NMI is after the VMGEXIT but before the result is read.

I suspect you can fix this by saving the GHCB at the beginning of do_nmi and=
 restoring it at the end. This has the major caveat that it will not work if=
 do_nmi comes from user mode and schedules, but I don=E2=80=99t believe this=
 can happen.

[0] Due to the NMI_COMPLETE catastrophe, there is a 100% chance that this ha=
ppens.=
