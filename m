From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/62] x86/boot/compressed/64: Add IDT Infrastructure
Date: Fri, 14 Feb 2020 11:40:36 -0800
Message-ID: <87k14p5557.fsf@linux.intel.com>
References: <20200211135256.24617-1-joro@8bytes.org>
        <20200211135256.24617-9-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-9-joro@8bytes.org> (Joerg Roedel's message
        of "Tue, 11 Feb 2020 14:52:02 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Joerg Roedel <joro@8bytes.org> writes:
> +	addq    $8, %rsp
> +
> +	/*
> +	 * Make sure we return to __KERNEL_CS - the CS selector on
> +	 * the IRET frame might still be from an old BIOS GDT
> +	 */
> +	movq	$__KERNEL_CS, 8(%rsp)

This doesn't make sense. Either it's running on the correct CS
before the exception or not. Likely there's some other problem
here that you patched over with this hack.

-Andi
