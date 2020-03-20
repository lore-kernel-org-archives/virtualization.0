From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v2.1] x86/sev-es: Handle NMI State
Date: Fri, 20 Mar 2020 07:42:09 -0700
Message-ID: <7d1ee9d9-d333-4529-b21b-19758c99e029@intel.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-71-joro@8bytes.org>
 <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com>
 <20200320131707.GF5122@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200320131707.GF5122@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 3/20/20 6:17 AM, Joerg Roedel wrote:
> On Thu, Mar 19, 2020 at 08:35:59AM -0700, Andy Lutomirski wrote:
>> 1. Just put the NMI unmask in do_nmi().  The kernel *already* knows
>> how to handle running do_nmi() with NMIs unmasked.  This is much, much
>> simpler than your code.
> Okay, attached is the updated patch which implements this approach. I
> tested it in an SEV-ES guest with 'perf top' running for a little more
> than 30 minutes and all looked good. I also removed the dead code from
> the patch.

FWIW, perf plus the x86 selftests run in a big loop was my best way of
stressing the NMI path when we mucked with it for PTI.  The selftests
make sure to hit some of the more rare entry/exit paths.
