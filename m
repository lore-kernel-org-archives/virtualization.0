From: Shreyas Bhatewara <sbhatewara@vmware.com>
Subject: RE: [PATCH 2.6.31-rc9] net: VMware virtual Ethernet NIC driver:
	vmxnet3
Date: Tue, 29 Sep 2009 09:37:59 -0700
Message-ID: <89E2752CFA8EC044846EB849981913410173CDFD23__2703.17927138439$1254242805$gmane$org@EXCH-MBX-4.vmware.com>
References: <89E2752CFA8EC044846EB849981913410173CDFAF6@EXCH-MBX-4.vmware.com>
	<20090928.170821.124026517.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090928.170821.124026517.davem@davemloft.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "greg@kroah.com" <greg@kroah.com>, "anthony@codemonkey.ws" <anthony@codemonkey.ws>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, September 28, 2009 5:08 PM
> To: Shreyas Bhatewara
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> shemminger@linux-foundation.org; jgarzik@pobox.com;
> anthony@codemonkey.ws; chrisw@sous-sol.org; greg@kroah.com; akpm@linux-
> foundation.org; virtualization@lists.linux-foundation.org; pv-
> drivers@vmware.com
> Subject: Re: [PATCH 2.6.31-rc9] net: VMware virtual Ethernet NIC
> driver: vmxnet3
> 
> From: Shreyas Bhatewara <sbhatewara@vmware.com>
> Date: Mon, 28 Sep 2009 16:56:45 -0700
> 
> > +       uint32_t rxdIdx:12;    /* Index of the RxDesc */
> 
> Don't use uint32_t et al. sized types, use "u32" and friends
> throughout.

Sure, I will fix that.

->Shreyas
