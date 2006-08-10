From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Thu, 10 Aug 2006 08:14:32 -0700
Message-ID: <44DB4D58.9010105@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>	<1155204603.18420.9.camel@localhost.localdomain>	<20060810103012.GA2356@muc.de> <1155207946.18420.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161324AbWHJPO0@vger.kernel.org>
In-Reply-To: <1155207946.18420.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> OK, they're all static fns except two: I changed to "native".  Since
> they're in paravirt.c it's pretty clear what they're for.  Compiled and
> booted.
>   

More will become un-static later on.  "native_" seems a little generic 
to me, but I can live with it.

    J
