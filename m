From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 09:56:28 +0200
Message-ID: <1156319788.2829.12.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
	 <1156275004.27114.34.camel@localhost.localdomain>
	 <44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com>
	 <p73y7tg7cg7.fsf@verdi.suse.de>  <44EB7F0C.60402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751456AbWHWH4p@vger.kernel.org>
In-Reply-To: <44EB7F0C.60402@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> Since this code is so rather, um, custom, I was going to reimplement 
> stop_machine in the module.

that sounds like a big mistake. I assume you want your VMI module to be
part of mainline for one.

And this is the sort of thing that if we want to support it, we better
support it inside the main kernel, eg provide an api to modules to use
it, rather than having each module hack their own....



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
