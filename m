From: Joe Perches <joe@perches.com>
Subject: Re: [Xen-devel] [PATCH 1/2] xen: Add
	__attribute__((format(printf... where appropriate
Date: Mon, 13 Jun 2011 09:40:31 -0700
Message-ID: <1307983231.6189.6.camel__37672.6627968766$1307983275$gmane$org@Joe-Laptop>
References: <17ffbd77627a21c05ab9e1a07b5207334291cf01.1307895293.git.joe@perches.com>
	<20110613163158.GA26322@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110613163158.GA26322@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-06-13 at 12:31 -0400, Konrad Rzeszutek Wilk wrote:
> On Sun, Jun 12, 2011 at 09:21:13AM -0700, Joe Perches wrote:
> > Use the compiler to verify printf formats and arguments.
> What compiler?

Any supported version of gcc.

>  If this is not included in 3.0 what is the fallout?

Nothing of any import.
nodename won't get printed on an unlikely error message.
I don't think it should go into 3.0.

> >  	err = xenbus_switch_state(dev, XenbusStateConnected);
> >  	if (err)
> > -		xenbus_dev_fatal(dev, err, "switching to Connected state",
> > +		xenbus_dev_fatal(dev, err, "%s: switching to Connected state",
> >  				 dev->nodename);
