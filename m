From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 23/62] x86/idt: Move IDT to data segment
Date: Tue, 11 Feb 2020 14:41:25 -0800
Message-ID: <CALCETrXswGgGoNaZigboUn3-amTyCY2Ft_JaMMvXchLDDkhJfw@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-24-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-24-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> With SEV-ES, exception handling is needed very early, even before the
> kernel has cleared the bss segment. In order to prevent clearing the
> currently used IDT, move the IDT to the data segment.

Ugh.  At the very least this needs a comment in the code.

I had a patch to fix the kernel ELF loader to clear BSS, which would
fix this problem once and for all, but it didn't work due to the messy
way that the decompressor handles memory.  I never got around to
fixing this, sadly.
