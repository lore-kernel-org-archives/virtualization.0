From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 4 of 7]  lguest: Config and headers
Date: Fri, 9 Feb 2007 22:45:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702092243170.13855@d.namei>
References: <1171033146.2718.157.camel@localhost.localdomain>
 <1171033383.2718.163.camel@localhost.localdomain>
 <1171033436.2718.165.camel@localhost.localdomain>
 <1171033484.2718.167.camel@localhost.localdomain>
 <1171033741.2718.172.camel@localhost.localdomain>  <Pine.LNX.4.64.0702091304090.9927@d.namei>
 <1171064515.15356.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752975AbXBJDpo@vger.kernel.org>
In-Reply-To: <1171064515.15356.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 10 Feb 2007, Rusty Russell wrote:

> Well it was the use of get_order() which triggered Andi's alarm bells,
> so I went back to deriving it.  This code is correct, however.

+       hype_pages = alloc_pages(GFP_KERNEL|__GFP_ZERO, HYPERVISOR_MAP_ORDER);
+       if (!hype_pages)
+               return -ENOMEM;

This will try and allocate 2^16 pages.  I guess we need a 
HYPERVISOR_PAGE_ORDER ?


- James
-- 
James Morris
<jmorris@namei.org>
