From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 39/62] x86/sev-es: Harden runtime #VC handler for
 exceptions from user-space
Date: Tue, 11 Feb 2020 14:47:05 -0800
Message-ID: <CALCETrXnFr47OEDk8OYrHHW=1XNAQMUB=wPevhLM6ROnO6_Rog@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-40-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-40-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Send SIGBUS to the user-space process that caused the #VC exception
> instead of killing the machine. Also ratelimit the error messages so
> that user-space can't flood the kernel log.

What would cause this?  CPUID?  Something else?

--Andy
