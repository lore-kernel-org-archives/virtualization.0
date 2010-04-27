From: Greg KH <greg@kroah.com>
Subject: Re: A clocksource driver for HyperV
Date: Tue, 27 Apr 2010 14:49:36 -0700
Message-ID: <20100427214936.GA16895@kroah.com>
References: <4BBC67980200003000082A15@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
	<4BBCDF93.9010305@goop.org>
	<4BC71D050200003000083226@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BC71D050200003000083226@sinclair.provo.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, haiyangz@microsoft.com, gregkh@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 15, 2010 at 02:04:53PM -0600, Ky Srinivasan wrote:
> Jeremy,
> 
> As suggested by you, I am enclosing a patch that integrates HyperV detection with the  current hypervisor detection mechanism in the kernel. Also attached is a HyperV clocksource patch that uses this new functionality.
> 
> Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>

What's the status of this patch?  I think it's needed for the
clocksource HV patch, right?  Who's tree is it going to go through?

I'll be glad to take it in the staging tree if I can get some ACKs.

thanks,

greg k-h
