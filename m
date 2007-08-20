From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Xen i386 xen-head.S fix sections mixup
	(updated)
Date: Mon, 20 Aug 2007 10:34:44 -0700
Message-ID: <46C9D0B4.5060300@goop.org>
References: <20070820030420.GA11070@Krystal> <46C9311D.2030702@goop.org>
	<20070820171912.GB9478@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070820171912.GB9478@Krystal>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, jeremy@xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Mathieu Desnoyers wrote:
> Xen i386 xen-head.S fix sections mixup
>
> xen-head.S does not come back to the data section, leaving the text section
> as current section. It causes problems with a slightly enhanced DEBUG_RODATA
> that supports CONFIG_HOTPLUG and bringing a CPU up after the text has been
> marked read-only: reference to early_gdt_descr causes a page fault.
>
> Update:
>
> It should be using pushsection/popsection.
>   

Looks good, with one caveat below.

Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>

> -	.section .text
> +.pushsection .text
>  	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
>  	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
>  	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
> @@ -34,5 +35,6 @@ ENTRY(hypercall_page)
>  	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "no")
>  #endif
>  	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
> +.popsection
>   

Actually, the push/popsections around the ELFNOTEs are redundant;
ELFNOTE() does its own push/popsection to put things into the
appropriate .note* section anyway.

    J
