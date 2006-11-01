From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Date: Wed, 1 Nov 2006 17:40:19 -0500
Message-ID: <20061101224019.GA10577@redhat.com>
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org> <20061101121753.GA2205@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752529AbWKAWlj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061101121753.GA2205@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 01, 2006 at 01:17:53PM +0100, Pavel Machek wrote:

 > > +++ linux-2.6-pv/arch/i386/kernel/cpu/intel.c
 > > @@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
 > >  	 * Note that the workaround only should be initialized once...
 > >  	 */
 > >  	c->f00f_bug = 0;
 > > -	if ( c->x86 == 5 ) {
 > > +	if (!paravirt_enabled() && c->x86 == 5) {
 > 
 > I'd do x86==5 check first... pentiums are not common any more.

It's not like paravirt_enabled will be common-case either,
and is this isn't exactly a performance critical piece of code,
it doesn't really matter which way around the checks are done.

	Dave

-- 
http://www.codemonkey.org.uk
