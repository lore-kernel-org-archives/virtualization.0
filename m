From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 12:26:46 -0700
Message-ID: <44EB5A76.9060402@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org>	 <1156254965.27114.17.camel@localhost.localdomain>	 <200608221544.26989.ak@muc.de>  <44EB3BF0.3040805@vmware.com>	 <1156271386.2976.102.camel@laptopd505.fenrus.org> <1156275004.27114.34.camel@localhost.localdomain> <44EB584A.5070505@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751221AbWHVT1J@vger.kernel.org>
In-Reply-To: <44EB584A.5070505@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:

 > I've already implemented the locking and repatching bits for VMI.


Incorrectly, I might add.  The problem case for syscall patching is what 
do you do if there are in-service system calls?  The comparable problem 
here is what if you interrupt code running in the old paravirt-ops, or 
worse, a section of code that you repatch when you do the switch?

That is a really nasty problem.  You need a synchronization primitive 
which guarantees a flat stack, so you can't do it in the interrupt 
handler as I have tried to do.  I'll bang my head on it awhile.  In the 
meantime, were there ever any solutions to the syscall patching problem 
that might lend me a clue as to what to do (or not to do, or impossible?).

Thanks,

Zach
