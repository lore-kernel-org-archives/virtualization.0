From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 22:36:17 +0100
Message-ID: <1156282577.27114.38.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>
	 <1156271386.2976.102.camel@laptopd505.fenrus.org>
	 <1156275004.27114.34.camel@localhost.localdomain>
	 <44EB584A.5070505@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932171AbWHVVQ2@vger.kernel.org>
In-Reply-To: <44EB584A.5070505@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ar Maw, 2006-08-22 am 12:17 -0700, ysgrifennodd Zachary Amsden:
> Possibly an issue, but why would you ever want stacked paravirt-ops?  
> You're only talking to the hypervisor directly above you, and there is 
> only one of those.

Thankfully right now I can't think of a reason other than debugging when
using hardware VMX

> > - If we boot patch inline code to get performance natively its almost
> > impossible to then revert that.

> You can patch back over it.  I've already implemented the locking and 
> repatching bits for VMI.

Ok that bit seemed pretty scary because you have to halt all the
processors in a known state (which probably means in an IPI handler)
before you patch. If you have code thats great.

Alan
