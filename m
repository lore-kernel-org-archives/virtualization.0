From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.31-rc9] net: VMware virtual Ethernet NIC driver:
	vmxnet3
Date: Mon, 28 Sep 2009 17:22:07 -0700
Message-ID: <20090929002207.GB31372__4699.16080260209$1254183993$gmane$org@kroah.com>
References: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shreyas Bhatewara <sbhatewara@vmware.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Stephen Hemminger <shemminger@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 28, 2009 at 04:56:45PM -0700, Shreyas Bhatewara wrote:
> 
> Please consider this for inclusion in the linux net tree. I will be
> glad to receive your review comments and answer queries in order to be
> accepted in mainline in 2.6.32 release cycle.

It's usually a bit late given that the big merge window for 2.6.32 is
now closed.

> The patch applies to 2.6.31-rc9.

2.6.32-rc1 is out, you should rebase to it as a few tens of thousands of
changes have already happened since 2.6.31-rc9 :)

thanks,

greg k-h
