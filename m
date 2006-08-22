From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 12:17:30 -0700
Message-ID: <44EB584A.5070505@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org>	 <1156254965.27114.17.camel@localhost.localdomain>	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>	 <1156271386.2976.102.camel@laptopd505.fenrus.org> <1156275004.27114.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751151AbWHVTRc@vger.kernel.org>
In-Reply-To: <1156275004.27114.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Alan Cox wrote:
>
> - Stacked hypervisors stomping each others functions
>   

Possibly an issue, but why would you ever want stacked paravirt-ops?  
You're only talking to the hypervisor directly above you, and there is 
only one of those.

> - Locking required to do updates: and remember our lock functions use
> methods in the array
>   

Yes, locking is an issue, but it is possible to do.  You just need to 
stop interrupts, NMIs, and faults on all processors simultaneously.  
Actually, it's not that scary - since you'll be doing it in a hypervisor.

> - If we boot patch inline code to get performance natively its almost
> impossible to then revert that.
>   

You can patch back over it.  I've already implemented the locking and 
repatching bits for VMI.

Zach
