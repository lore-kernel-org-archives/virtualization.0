From: Alok Kataria <akataria@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 2.6.31-rc9] net: VMware virtual Ethernet
	NIC driver: vmxnet3
Date: Mon, 28 Sep 2009 17:47:08 -0700
Message-ID: <1254185228.13456.34.camel__17906.1020179235$1254185384$gmane$org@ank32.eng.vmware.com>
References: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
	<20090929002056.GA31372@kroah.com>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090929002056.GA31372@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <anthony@codemonkey.ws>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi Greg,

On Mon, 2009-09-28 at 17:20 -0700, Greg KH wrote:
> On Mon, Sep 28, 2009 at 04:56:45PM -0700, Shreyas Bhatewara wrote:
> > Ethernet NIC driver for VMware's vmxnet3
> > 
> > From: Shreyas Bhatewara <sbhatewara@vmware.com>
> > 
> > This patch adds driver support for VMware's virtual Ethernet NIC : vmxnet3
> > Guests running on VMware hypervisors supporting vmxnet3 device will thus
> > have access to improved network functionalities and performance.
> > 
> > Signed-off-by: Shreyas Bhatewara <sbhatewara@vmware.com>
> 
> I thought this was going to be submitted for the drivers/staging/ tree.
> What happened?

We managed to do most of the cleanup's inhouse over the weekend and
think this shouldn't need any major cleanup now. That's why thought
better to submit directly. 

Thanks,
Alok

> 
> thanks,
> 
> greg k-h
> _______________________________________________
> Pv-drivers mailing list
> Pv-drivers@vmware.com
> http://mailman2.vmware.com/mailman/listinfo/pv-drivers
