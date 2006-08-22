From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 05:56:03 -0700
Message-ID: <44EAFEE3.8080700@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de> <44E67B6E.10706@goop.org> <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751294AbWHVM4G@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Geert Uytterhoeven wrote:
>> relicensing them.
>>     
>
> That's a pretty strong statement...
>   

Well, I'm not making any kind of legal statement.  I'm just pointing out 
that from a technical perspective, there's a large visible functional 
change from before if we use EXPORT_SYMBOL_GPL(paravirt_ops) vs 
EXPORT_SYMBOL(paravirt_ops).  Given that the whole point of paravirt_ops 
is to minimize visible changes, this seems counterproductive.

    J
