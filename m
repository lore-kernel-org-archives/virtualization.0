From: Greg KH <greg@kroah.com>
Subject: Re: Patch to auto-load MSFT PV NIC driver
Date: Mon, 10 May 2010 08:49:44 -0700
Message-ID: <20100510154944.GB14703@kroah.com>
References: <4BE453510200003000084906@sinclair.provo.novell.com>
	<8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100508142716.GA32133@kroah.com> <4BE5ED79.9080008@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4BE5ED79.9080008@goop.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Ky Srinivasan <ksrinivasan@novell.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 08, 2010 at 04:02:17PM -0700, Jeremy Fitzhardinge wrote:
> On 05/08/2010 07:27 AM, Greg KH wrote:
> > How would you do that?  The symbol resolution will not allow hv_netvsc
> > to be loaded without hv_vmbus being around.
> >
> > Now I do think that just adding the same pci/dmi ids to all of the
> > modules is a bit odd, and that something else needs to be done here, but
> > at the moment, I can't think of anything better.
> >   
> 
> Could you make hv_vmbus a real bus implementation, which knows how to
> enumerate and probe devices hanging off it?

Yes, that's the correct solution here.  I originally thought this
couldn't be done, but in looking at the code some more, I think it can
happen for the network driver, and perhaps some others (but not the
block, as both devices work off of the same interface to the hypervisor,
so which one do we load?)

I'll look into that later if I get the chance.

thanks,

greg k-h
