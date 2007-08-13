From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] [365/2many] MAINTAINERS - PARAVIRT_OPS INTERFACE
Date: Mon, 13 Aug 2007 11:53:23 -0700
Message-ID: <20070813185323.GG3672@sequoia.sous-sol.org>
References: <46bffb3b.jTNczaQ2ECqVDjzn%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46bffb3b.jTNczaQ2ECqVDjzn%joe@perches.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* joe@perches.com (joe@perches.com) wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2166416..44768ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3519,6 +3519,9 @@ M:	rusty@rustcorp.com.au
>  L:	virtualization@lists.osdl.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> +F:	arch/i386/kernel/paravirt.c
> +F:	include/asm-i386/paravirt.h
> +F:	include/asm-um/paravirt.h

Not asm-um.  And it's much more spread out than that, touching many
non-paravirt specific files (as in include/asm-i386/ and search for
CONFIG_PARAVIRT).  I'm failing to see the value of this churn.

thanks,
-chris
