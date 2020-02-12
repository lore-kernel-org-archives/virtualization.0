From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 50/62] x86/sev-es: Handle VMMCALL Events
Date: Wed, 12 Feb 2020 14:22:20 +0100
Message-ID: <20200212132220.GI20066@8bytes.org>
References: <20200211135256.24617-51-joro@8bytes.org>
 <DC865D59-CAD2-4D1C-919B-1C954B1EFFB1@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DC865D59-CAD2-4D1C-919B-1C954B1EFFB1@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Juergen Gross <JGross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 04:14:53PM -0800, Andy Lutomirski wrote:
> 
> How about we just don’t do VMMCALL if we’re a SEV-ES guest?  Otherwise
> we add thousands of cycles of extra latency for no good reason.

True, but I left that as a future optimization for now, given the size
the patch-set already has. The idea is to add an abstraction around
VMMCALL for the support code of the various hypervisors and just do a
VMGEXIT in that wrapper when in an SEV-ES guest. But again, that is a
separate patch-set.

Regards,

	Joerg
