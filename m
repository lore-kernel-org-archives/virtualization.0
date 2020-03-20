From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Date: Fri, 20 Mar 2020 20:48:49 +0100
Message-ID: <20200320194849.GJ5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-71-joro@8bytes.org>
 <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com>
 <20200319160749.GC5122@8bytes.org>
 <CALCETrXY5M87C1Fc3QvTkc6MdbQ_3gAuOPUeWJktAzK4T60QNQ@mail.gmail.com>
 <20200319192654.GD611@suse.de>
 <CALCETrXzyUGjPYBR_NDSvTG8TqLuQP2Q+v_mwXPne4O0U-18NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXzyUGjPYBR_NDSvTG8TqLuQP2Q+v_mwXPne4O0U-18NA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 02:27:49PM -0700, Andy Lutomirski wrote:
> AIUI the shift-ist stuff is because we aren't very good about the way
> that we handle tracing right now, and that can cause a limited degree
> of recursion.  #DB uses IST for historical reasons that don't
> necessarily make sense.  Right now, we need it for only one reason:
> the MOV SS issue.  IIRC this isn't actually triggerable without
> debugging enabled -- MOV SS with no breakpoint but TF on doesn't seem
> to malfunction quite as badly.

I had a look at the shift_ist stuff today and it looks like a good
solution to the #VC nesting problem when it is turned into a #VC
handler. The devil is in the details, of course, as 3 or 4 stacks for
the #VC handler (per cpu) should only be allocated when actually running
in an SEV-ES guest. Let's see how this works out in practice.

Regards,

	Joerg
