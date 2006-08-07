From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
Date: Sun, 06 Aug 2006 22:22:10 -0700
Message-ID: <44D6CE02.4020303@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751068AbWHGFWF@vger.kernel.org>
In-Reply-To: <1154925835.21647.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> (Andrew, please sit these in the -mm tree for cooking)
>
> Create a paravirt.h header for (almost) all the critical operations
> which need to be replaced with hypervisor calls.
>
> For the moment, this simply includes no_paravirt.h, where all the
> native implementations now live.
>   

Sorry, but I have to say these are not yet ready for -mm.  While they're 
better than before (I can successfully boot), the machine locks up when 
I start X, and I wouldn't have any confidence in running with this stuff 
enabled.  I'd prefer these weren't in -mm until we somewhat confident 
one could run with CONFIG_PARAVIRT on all the time (ie, think it could 
be default on, even if it isn't).

    J
