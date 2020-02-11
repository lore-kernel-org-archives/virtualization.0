From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 00/62] Linux as SEV-ES Guest Support
Date: Tue, 11 Feb 2020 14:12:04 -0800
Message-ID: <CALCETrUtvd0OuLoo=ZBRmaJRFxgFWV9hSZyHBwmWCs2+b4J-sg@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211145008.GT14914@hirez.programming.kicks-ass.net>
 <20200211154321.GB22063@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211154321.GB22063@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 7:43 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Feb 11, 2020 at 03:50:08PM +0100, Peter Zijlstra wrote:
>
> > Oh gawd; so instead of improving the whole NMI situation, AMD went and
> > made it worse still ?!?
>
> Well, depends on how you want to see it. Under SEV-ES an IRET will not
> re-open the NMI window, but the guest has to tell the hypervisor
> explicitly when it is ready to receive new NMIs via the NMI_COMPLETE
> message.  NMIs stay blocked even when an exception happens in the
> handler, so this could also be seen as a (slight) improvement.
>

I don't get it.  VT-x has a VMCS bit "Interruptibility
state"."Blocking by NMI" that tracks the NMI masking state.  Would it
have killed AMD to solve the problem they same way to retain
architectural behavior inside a SEV-ES VM?

--Andy
