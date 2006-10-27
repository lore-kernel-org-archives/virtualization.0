From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
 address space
Date: Fri, 27 Oct 2006 14:31:41 -0700
Message-ID: <45427ABD.6070407@goop.org>
References: <1161920325.17807.29.camel@localhost.localdomain>	<1161920535.17807.33.camel@localhost.localdomain> <20061027113001.GB8095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752497AbWJ0Vbl@vger.kernel.org>
In-Reply-To: <20061027113001.GB8095@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> Indentation is b0rken here.
>   

Oops.  How strange.

> And... is get_user right primitive for accessing area that may not be
> there?

I'm pretty sure there's precedent for using __get_user in this way 
(get_user is a different matter, since it cares about whether the 
address is within the user part of the address space).  Certainly in 
arch/i386 code there shouldn't be a problem.  Is there some other way to 
achieve the same effect (without manually setting up an exception/fixup 
block)?

    J
