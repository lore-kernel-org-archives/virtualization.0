From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 3/4] An Implementation of KVP functionality
Date: Wed, 8 Dec 2010 14:35:44 -0800
Message-ID: <20101208223544.GC6714@suse.de>
References: <4CFFA47602000030000918D7@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFFA47602000030000918D7@novprvoes0310.provo.novell.com>
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

How about:
	Subject: [PATCH 3/4] Staging: hv: implement key/value pair functionality

On Wed, Dec 08, 2010 at 03:29:58PM -0700, Ky Srinivasan wrote:
> >From 2843393e8f50421e81e033806cd121cfb8cc7b6a Mon Sep 17 00:00:00 2001
> From: ksrinivasan <ksrinivasan@novell.com>
> Date: Wed, 8 Dec 2010 13:46:46 -0700

Again, this doesn't belong in the patch body.  Use git send-email to
send patches out properly.

> 
>  
> This is an implementation of the key/value pair (KVP) functionality 
> for Linux guests hosted on HyperV. All guest specific data gathering for 
> KVP will be implemented in a user-level daemon. This kernel component packaged
> as part of the hv_utils driver supports communication with the HyperV 
> host. 

You have trailing spaces in your changelog comment.  Please fix your
editor to highlight stuff like this.

> 
> 
> 
> Signed-off-by: ksrinivasan <ksrinivasan@novell.com>

Again, wrong name :(
