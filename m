From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 20:29:45 +0200
Message-ID: <1156271386.2976.102.camel@laptopd505.fenrus.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750718AbWHVSaV@vger.kernel.org>
In-Reply-To: <44EB3BF0.3040805@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> And it doesn't work for VMI or lhype, both of which might modify 
> paravirt_ops way later in the boot process, when loaded as a module.  

doesn't this then start to have the same issues that runtime patching
the system call table had?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
