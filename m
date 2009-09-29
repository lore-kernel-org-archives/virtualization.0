From: David Miller <davem@davemloft.net>
Subject: Re: [Pv-drivers] [PATCH 2.6.31-rc9] net: VMware virtual Ethernet
	NIC driver: vmxnet3
Date: Mon, 28 Sep 2009 18:17:02 -0700 (PDT)
Message-ID: <20090928.181702.41922043.davem__26065.9917643808$1254187062$gmane$org@davemloft.net>
References: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
	<20090929002207.GB31372@kroah.com>
	<1254185499.13456.40.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254185499.13456.40.camel@ank32.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: pv-drivers@vmware.com, greg@kroah.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, netdev@vger.kernel.org, akpm@linux-foundation.org, shemminger@linux-foundation.org, jgarzik@pobox.com
List-Id: virtualization@lists.linuxfoundation.org

From: Alok Kataria <akataria@vmware.com>
Date: Mon, 28 Sep 2009 17:51:39 -0700

> As a side note, were there any changes in the networking API's, that we
> should look out for in the merge cycle ?
> If not I think the rebase should be pretty trivial.

Just off the top of my head, the return type of the driver transmit
function was changed to netdev_tx_t, for one thing.

But there were likely numerous others.  You'll have to check.
