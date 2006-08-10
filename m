From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Thu, 10 Aug 2006 11:06:14 -0700
Message-ID: <44DB7596.6010503@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422676AbWHJSGV@vger.kernel.org>
In-Reply-To: <1155202505.18420.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> +EXPORT_SYMBOL_GPL(paravirt_ops);
>   
This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
driver module will need to be GPL...

    J
