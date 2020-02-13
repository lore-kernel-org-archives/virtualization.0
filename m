From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 41/62] x86/sev-es: Handle MSR events
Date: Thu, 13 Feb 2020 07:45:00 -0800
Message-ID: <b688b4ad-5a64-d2df-6dd8-e23fac75a6b9@intel.com>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-42-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-42-joro@8bytes.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 2/11/20 5:52 AM, Joerg Roedel wrote:
> Implement a handler for #VC exceptions caused by RDMSR/WRMSR
> instructions.

As a general comment on all of these event handlers: Why do we bother
having the hypercalls in the interrupt handler as opposed to just
calling them directly.  What you have is:

	wrmsr()
	-> #VC exception
	   hcall()

But we could make our rd/wrmsr() wrappers just do:

	if (running_on_sev_es())
		hcall(HCALL_MSR_WHATEVER...)
	else
		wrmsr()

and then we don't have any of the nastiness of exception handling.
