From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 9 Feb 2007 12:50:06 +0100
Message-ID: <200702091250.06482.ak@muc.de>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171018812.2718.66.camel@localhost.localdomain> <45CC5771.1070309@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946379AbXBILuv@vger.kernel.org>
In-Reply-To: <45CC5771.1070309@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> Yes, it is a bit, umm, innovative.  If it is going to be kept, even if 
> just for devel logging, you should disable interrupts around it.  
> Changing segments is not a normal thing to do.

Actually that wouldn't be needed because interrupts are not allowed to do any 
user accesses. And contrary to the name it doesn't actually change
the segment registers, only state used by *_user.

-Andi
