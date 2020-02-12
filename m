From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 30/62] x86/head/64: Move early exception dispatch to C
 code
Date: Wed, 12 Feb 2020 13:39:02 +0100
Message-ID: <20200212123902.GG20066@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-31-joro@8bytes.org>
 <CALCETrVLhTkZ2MMUD+WMWXnhmSvwVhinUtMJey2M6sx_iUREcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVLhTkZ2MMUD+WMWXnhmSvwVhinUtMJey2M6sx_iUREcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:44:45PM -0800, Andy Lutomirski wrote:
> How about int (or bool) handled;  Or just if (!early_make_pgtable)
> return;  This would also be nicer if you inverted the return value so
> that true means "I handled it".

Okay, makes sense. Changed the return value of early_make_pgtable() to bool and
this function to:

	void __init early_exception(struct pt_regs *regs, int trapnr)
	{
		if (trapnr == X86_TRAP_PF &&
		    early_make_pgtable(native_read_cr2()))
				return;

		early_fixup_exception(regs, trapnr);
	}

Regards,

	Joerg
