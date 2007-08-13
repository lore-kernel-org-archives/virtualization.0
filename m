From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] [545/2many] MAINTAINERS - XEN HYPERVISOR
	INTERFACE
Date: Mon, 13 Aug 2007 11:55:36 -0700
Message-ID: <20070813185536.GH3672@sequoia.sous-sol.org>
References: <46bffcb5.o/KKCq3EZH4S47k3%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <46bffcb5.o/KKCq3EZH4S47k3%joe@perches.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: joe@perches.com
Cc: xen-devel@lists.xensource.com, jeremy@xensource.com, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* joe@perches.com (joe@perches.com) wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4e1cc3..8395aba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5153,6 +5153,11 @@ M:	chrisw@sous-sol.org
>  L:	virtualization@lists.osdl.org
>  L:	xen-devel@lists.xensource.com
>  S:	Supported
> +F:	arch/i386/xen/
> +F:	drivers/*/xen-*front.c
> +F:	drivers/xen/
> +F:	include/asm-i386/xen/
> +F:	include/xen/

I think this data will easily become stale.  What is the point again?
