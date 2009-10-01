From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2.6.32-rc1] net: VMware virtual Ethernet NIC driver:
	vmxnet3
Date: Wed, 30 Sep 2009 19:51:23 -0700 (PDT)
Message-ID: <20090930.195123.33813752.davem__48398.2085869231$1254365615$gmane$org@davemloft.net>
References: <alpine.LRH.2.00.0909301432410.8073@localhost.localdomain>
	<20090930173923.4520716a@s6510>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090930173923.4520716a@s6510>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: shemminger@vyatta.com
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, greg@kroah.com, anthony@codemonkey.ws, jgarzik@pobox.com, akpm@linux-foundation.org, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Wed, 30 Sep 2009 17:39:23 -0700

> Why not use NETIF_F_LRO and ethtool to control LRO support?

In fact, you must, in order to handle bridging and routing
correctly.

Bridging and routing is illegal with LRO enabled, so the kernel
automatically issues the necessary ethtool commands to disable
LRO in the relevant devices.

Therefore you must support the ethtool LRO operation in order to
support LRO at all.
