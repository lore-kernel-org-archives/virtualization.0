From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 41/70] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 19 Mar 2020 20:38:13 +0100
Message-ID: <20200319193813.GE611@suse.de>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-42-joro@8bytes.org>
 <CALCETrW9EYi5dzCKNtKkxM18CC4n5BZxTp1=qQ5qZccwstXjzg@mail.gmail.com>
 <20200319162439.GE5122@8bytes.org>
 <CALCETrW6LOwEfjJz-S7fFJvPqgr9BoCkRG2MA-Pk6K_y_rmGHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrW6LOwEfjJz-S7fFJvPqgr9BoCkRG2MA-Pk6K_y_rmGHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 11:43:20AM -0700, Andy Lutomirski wrote:
> Or future generations could have enough hardware support for debugging
> that #DB doesn't need to be intercepted or can be re-injected
> correctly with the #DB vector.

Yeah, the problem is, the GHCB spec suggests the single-step-over-iret
way to re-enable the NMI window and requires intercepting #DB for it. So
the hypervisor probably still has to intercept it, even when debug
support is added some day. I need to think more about this.

Regards,

	Joerg
