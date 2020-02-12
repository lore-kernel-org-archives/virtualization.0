From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 14/62] x86/boot/compressed/64: Add stage1 #VC handler
Date: Wed, 12 Feb 2020 12:38:40 +0100
Message-ID: <20200212113840.GB20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-15-joro@8bytes.org>
 <CALCETrWh58j3a2exXE0GE5E9EN+U=F8JEix74MUEFkoWY6Gf6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWh58j3a2exXE0GE5E9EN+U=F8JEix74MUEFkoWY6Gf6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:23:22PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
> > +void __init no_ghcb_vc_handler(struct pt_regs *regs)
> 
> Isn't there a second parameter: unsigned long error_code?

No, the function gets the error-code from regs->orig_ax. This particular
function only needs to check for error_code == SVM_EXIT_CPUID, as that
is the only one supported when there is no GHCB.

Regards,

	Joerg
