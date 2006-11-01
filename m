From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Date: Wed, 1 Nov 2006 13:17:53 +0100
Message-ID: <20061101121753.GA2205@elf.ucw.cz>
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946838AbWKAMSJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061029024606.496399000@sous-sol.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: akpm@osdl.org, ak@muc.de, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat 2006-10-28 00:00:04, Chris Wright wrote:
> Allow selected bug checks to be skipped by paravirt kernels.  The two most
> important are the F00F workaround (which is either done by the hypervisor,
> or not required), and the 'hlt' instruction check, which can break under
> some hypervisors.

How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
innocent to me.

> --- linux-2.6-pv.orig/arch/i386/kernel/cpu/intel.c
> +++ linux-2.6-pv/arch/i386/kernel/cpu/intel.c
> @@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
>  	 * Note that the workaround only should be initialized once...
>  	 */
>  	c->f00f_bug = 0;
> -	if ( c->x86 == 5 ) {
> +	if (!paravirt_enabled() && c->x86 == 5) {

I'd do x86==5 check first... pentiums are not common any more.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
