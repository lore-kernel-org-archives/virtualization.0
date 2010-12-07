From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/3]: An implementation of HyperV KVP functionality
Date: Tue, 7 Dec 2010 15:10:42 -0800
Message-ID: <20101207231042.GD27918@suse.de>
References: <4CFE4E40020000300009170B@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFE4E40020000300009170B@novprvoes0310.provo.novell.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Virtualization@lists.osdl.org, Zbr@ioremap.net, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 07, 2010 at 03:09:52PM -0700, Ky Srinivasan wrote:
> This patch is re-based on the latest linux-next tree.
> 
> From: K. Y. Srinivasan <ksrinivasan@novell.com>
> Subject: Reserve a connector index for implementing HyperV Key Value Pair
> (KVP) functionality.

A hint, this is not how you submit a patch.  Please put the Subject line
up above in the real Subject for the email.

Also provide a bit of a description in the body of the email that
explains what is going on.

> 
> Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>
> 
> Index: linux.trees.git/include/linux/connector.h
> ===================================================================

What are these lines from?  Surely you aren't using cvs these days, are
you?

I should be able to take the email and directly feed it to 'git am' to
apply it, without editing it at all.

Care to fix this, and address the connector issues, and then resend them
all?

thanks,

greg k-h
