From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 1/3]: An implementation of HyperV KVP functionality
Date: Thu, 9 Dec 2010 00:44:41 +0300
Message-ID: <20101208214441.GA10099@ioremap.net>
References: <4CFE4E40020000300009170B@novprvoes0310.provo.novell.com>
	<20101207231042.GD27918@suse.de>
	<4CFF96D30200003000091878@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFF96D30200003000091878@novprvoes0310.provo.novell.com>
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
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 08, 2010 at 02:31:47PM -0700, Ky Srinivasan (ksrinivasan@novell.com) wrote:
> > Care to fix this, and address the connector issues, and then resend them
> > all?
> 
> Evgeniy  has acked the patch for adding a new connector index for implementing the KVP functionality. The concern Evgeniy had  was with regards to the code currently in the upstream tree and Hank is planning to submit a patch to fix that issue.

Connector is ok, but rest of the code looks wrong sometimes,
so please resumbit the whole series with proper descriptions
and subject lines.

Thank you.

-- 
	Evgeniy Polyakov
