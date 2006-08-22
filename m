From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 20:30:04 +0100
Message-ID: <1156275004.27114.34.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751163AbWHVTJX@vger.kernel.org>
In-Reply-To: <1156271386.2976.102.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ar Maw, 2006-08-22 am 20:29 +0200, ysgrifennodd Arjan van de Ven:
> > And it doesn't work for VMI or lhype, both of which might modify 
> > paravirt_ops way later in the boot process, when loaded as a module.  
> 
> doesn't this then start to have the same issues that runtime patching
> the system call table had?

It has several I can see that are if anything worse

- Stacked hypervisors stomping each others functions
- Locking required to do updates: and remember our lock functions use
methods in the array
- If we boot patch inline code to get performance natively its almost
impossible to then revert that.
