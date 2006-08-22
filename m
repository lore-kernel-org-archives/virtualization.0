From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 07:59:55 -0700
Message-ID: <44EB1BEB.60202@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>	 <44DB7596.6010503@goop.org> <1156254965.27114.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932296AbWHVO77@vger.kernel.org>
In-Reply-To: <1156254965.27114.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Alan Cox wrote:
> It would be nice not to export it at all or to protect it, paravirt_ops
> is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> is properly protected, its an unpleasantly large security target if not.
>   

Do you have an example of an attack which would become significantly 
easier with pv_ops in use?  I agree it might make a juicy target, but 
surely it is just a matter of degree given that any attacker who can get 
to pv_ops can do pretty much anything else.

> It would be a lot safer if we could have the struct paravirt_ops in
> protected read-only const memory space, set it up in the core kernel
> early on in boot when we play "guess todays hypervisor" and then make
> sure it stays in read only (even to kernel) space.
>   

Yes, I'd thought about doing something like that, but as Arjan pointed 
out, nothing is actually read-only in the kernel when using a 2M 
mapping.  It's also ameliorated by the fact that some of the entrypoints 
are never used at runtime, because the code has been patched inline (but 
I don't think it would ever be desirable to patch every entrypoint, 
since some are just not worth the effort, complexity or obfuscation 
which result from patching).

    J
