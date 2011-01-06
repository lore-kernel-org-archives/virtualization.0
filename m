From: Stephen Hemminger <shemminger@vyatta.com>
Subject: [PATCH] hv: don't enable Scatter/Gather
Date: Thu, 6 Jan 2011 12:28:27 -0800
Message-ID: <20110106122827.733b5438__23005.6278560825$1294345761$gmane$org@nehalam>
References: <20101210180954.58441856@nehalam>
	<8AFC7968D54FB448A30D8F38F259C5622C0BD044@TK5EX14MBXC116.redmond.corp.microsoft.com>
	<1FB5E1D5CA062146B38059374562DF7292CCE678@TK5EX14MBXC121.redmond.corp.microsoft.com>
	<1FB5E1D5CA062146B38059374562DF729555F841@TK5EX14MBXC121.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1FB5E1D5CA062146B38059374562DF729555F841@TK5EX14MBXC121.redmond.corp.microsoft.com>
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
Cc: netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The HyperV network driver can do scatter/gather but does not
do checksum offload. Since the network stack requires checksum offload
to do direct transmit (sendfile), netdev_register produces a message
when driver is loaded.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

--- a/drivers/staging/hv/netvsc_drv.c	2011-01-06 12:23:48.143333212 -0800
+++ b/drivers/staging/hv/netvsc_drv.c	2011-01-06 12:24:10.447744121 -0800
@@ -390,8 +390,6 @@ static int netvsc_probe(struct device *d
 	net->netdev_ops = &device_ops;
 
 	/* TODO: Add GSO and Checksum offload */
-	net->features = NETIF_F_SG;
-
 	SET_ETHTOOL_OPS(net, &ethtool_ops);
 	SET_NETDEV_DEV(net, device);
