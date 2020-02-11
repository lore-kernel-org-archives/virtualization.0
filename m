From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 07/62] x86/boot/compressed/64: Disable red-zone usage
Date: Tue, 11 Feb 2020 14:13:50 -0800
Message-ID: <CALCETrVVjECt2TNVDJcuS68663ioPTiEY13-1uO_gWYjWaVwPA@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-8-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-8-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The x86-64 ABI defines a red-zone on the stack:
>
>   The 128-byte area beyond the location pointed to by %rsp is
>   considered to be reserved and shall not be modified by signal or
>   interrupt handlers. 10 Therefore, functions may use this area for
>   temporary data that is not needed across function calls. In
>   particular, leaf functions may use this area for their entire stack
>   frame, rather than adjusting the stack pointer in the prologue and
>   epilogue. This area is known as the red zone.
>
> This is not compatible with exception handling, so disable it for the
> pre-decompression boot code.

Acked-by: Andy Lutomirski <luto@kernel.org>

I admit that I thought we already supported exceptions this early.  At
least I seem to remember writing this code.  Maybe it never got
upstreamed?

--Andy
