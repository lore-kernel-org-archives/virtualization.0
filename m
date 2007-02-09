From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 1/10] lguest: Don't rely on last-linked fallthru when no paravirt handler
Date: Fri, 9 Feb 2007 10:31:20 +0100
Message-ID: <200702091031.20249.ak@muc.de>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171012458.2718.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946293AbXBIKJq@vger.kernel.org>
In-Reply-To: <1171012458.2718.30.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 February 2007 10:14, Rusty Russell wrote:

> +unhandled_paravirt:
> +	/* Nothing wanted us: try to die with dignity (impossible trap). */ 
> +	movl	$0x1F, %edx
> +	pushl	$0
> +	jmp	early_fault

Please print a real message with early_printk


-Andi
