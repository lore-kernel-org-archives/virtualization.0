From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/4] Add a connector Index to support HyperV KVP
	functionality
Date: Wed, 8 Dec 2010 14:32:59 -0800
Message-ID: <20101208223259.GA6714@suse.de>
References: <4CFFA25B02000030000918BE@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CFFA25B02000030000918BE@novprvoes0310.provo.novell.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Virtualization@lists.osdl.org, Zbr@ioremap.net, devel@linuxdriverproject.org, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

Please make your subject a bit more descriptive, for this one, it would
be:
	Subject: [PATCH 1/4] Connector: add index to support HyperV

And what is a "KVP"?

On Wed, Dec 08, 2010 at 03:20:59PM -0700, Ky Srinivasan wrote:
> >From 5b7c16baf2f310a1e7e119c3df8fd976ca0e2f57 Mon Sep 17 00:00:00 2001
> From: ksrinivasan <ksrinivasan@novell.com>

I doubt that's your full name you want as the changelog author
information :)

> Date: Wed, 8 Dec 2010 09:35:13 -0700

Why is this in the body of your message?

> 
> Added a connector index to support key value/pair (KVP) functionality
> for Linux guests hosted on a HyperV platform. All KVP related
> data gathering will be done in a user-level daemon. The kernel 
> component of KVP communicates with the data gathering daemon using this
> connector index.
> 
> 
> Signed-off-by: ksrinivasan <ksrinivasan@novell.com>

Same error here with your name :(

Third time's a charm?

greg k-h
