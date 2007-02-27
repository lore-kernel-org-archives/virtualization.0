From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove HAVE_ARCH_MM_LIFETIME,
	define no-op architecture implementations
Date: Tue, 27 Feb 2007 12:53:14 -0600
Message-ID: <1172602394.3408.30.camel@mulgrave.il.steeleye.com>
References: <20070227081337.434798469@goop.org>
	 <20070227081632.356636957@goop.org>
	 <1172589358.3408.2.camel@mulgrave.il.steeleye.com>
	 <45E46889.9090801@goop.org>
	 <1172597726.3408.25.camel@mulgrave.il.steeleye.com>
	 <45E470D6.7050401@goop.org>
	 <1172599480.3408.28.camel@mulgrave.il.steeleye.com>
	 <45E47D08.5020802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752501AbXB0Syd@vger.kernel.org>
In-Reply-To: <45E47D08.5020802@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-02-27 at 10:48 -0800, Jeremy Fitzhardinge wrote:
> Well, I'm happy to create asm-generic/mm_hooks.h or something, and
> reduce all the changes to asm-*/mmu_context.h to a one-liner.

If no-one else objects, that will certainly make my life easier, thanks!

James
