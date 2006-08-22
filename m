From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 21:29:43 +0200
Message-ID: <1156274983.2976.111.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
	 <1156275004.27114.34.camel@localhost.localdomain>
	 <44EB584A.5070505@vmware.com>  <44EB5A76.9060402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750988AbWHVTaY@vger.kernel.org>
In-Reply-To: <44EB5A76.9060402@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> That is a really nasty problem.  You need a synchronization primitive 
> which guarantees a flat stack, so you can't do it in the interrupt 
> handler as I have tried to do.  I'll bang my head on it awhile.  In the 
> meantime, were there ever any solutions to the syscall patching problem 
> that might lend me a clue as to what to do (or not to do, or impossible?).

yes we just disallowed it :)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
