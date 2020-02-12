From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 50/62] x86/sev-es: Handle VMMCALL Events
Date: Tue, 11 Feb 2020 16:14:53 -0800
Message-ID: <DC865D59-CAD2-4D1C-919B-1C954B1EFFB1@amacapital.net>
References: <20200211135256.24617-51-joro@8bytes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-51-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Juergen Gross <JGross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org



> On Feb 11, 2020, at 5:53 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFFrom: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> Implement a handler for #VC exceptions caused by VMMCALL instructions.
> This patch is only a starting point, VMMCALL emulation under SEV-ES
> needs further hypervisor-specific changes to provide additional state.
>=20

How about we just don=E2=80=99t do VMMCALL if we=E2=80=99re a SEV-ES guest? =
 Otherwise we add thousands of cycles of extra latency for no good reason.=
