From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove HAVE_ARCH_MM_LIFETIME,
	define no-op architecture implementations
Date: Tue, 27 Feb 2007 11:35:26 -0600
Message-ID: <1172597726.3408.25.camel@mulgrave.il.steeleye.com>
References: <20070227081337.434798469@goop.org>
	 <20070227081632.356636957@goop.org>
	 <1172589358.3408.2.camel@mulgrave.il.steeleye.com>
	 <45E46889.9090801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751219AbXB0Rft@vger.kernel.org>
In-Reply-To: <45E46889.9090801@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-02-27 at 09:21 -0800, Jeremy Fitzhardinge wrote:
> You mean add the two stubs to asm-generic/mmu_context.h, and then
> include that in all these files?  That would be cleaner, but it
> wouldn't
> remove the need to touch all these files, would it?

it would if you added asm-generic/mmu_context_paravirt.h

and only included that in the main kernel files that need the three
operations (that's just fork.c and mmap.c, isn't it)?

James
