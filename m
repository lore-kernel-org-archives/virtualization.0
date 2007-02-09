From: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 4 of 7]  lguest: Config and headers
Date: Fri, 9 Feb 2007 13:15:28 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702091304090.9927@d.namei>
References: <1171033146.2718.157.camel@localhost.localdomain>
 <1171033383.2718.163.camel@localhost.localdomain>
 <1171033436.2718.165.camel@localhost.localdomain>
 <1171033484.2718.167.camel@localhost.localdomain>
 <1171033741.2718.172.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992439AbXBISPc@vger.kernel.org>
In-Reply-To: <1171033741.2718.172.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 10 Feb 2007, Rusty Russell wrote:

> +/* 64k ought to be enough for anybody! */
> +#define HYPERVISOR_MAP_ORDER 16
> +#define HYPERVISOR_PAGES ((1 << HYPERVISOR_MAP_ORDER)/PAGE_SIZE)

I think it'd be better to go back to defining HYPERVISOR_SIZE then derive 
the map order from that via get_order(), as it should be 4 instead of 16; 
and this code is now both implying PAGE_SIZE while also using it for 
calculations. 


- James
-- 
James Morris
<jmorris@namei.org>
