From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Xen i386 xen-head.S fix sections mixup
Date: Sun, 19 Aug 2007 23:13:49 -0700
Message-ID: <46C9311D.2030702@goop.org>
References: <20070820030420.GA11070@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070820030420.GA11070@Krystal>
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

Thanks.  It should be using pushsection/popsection.

    J
