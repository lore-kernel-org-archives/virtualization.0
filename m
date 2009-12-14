From: Patrick McHardy <kaber@trash.net>
Subject: Re: [RFC] macvlan: add tap device backend
Date: Mon, 14 Dec 2009 13:53:14 +0100
Message-ID: <4B26353A.9020005__42656.621131073$1260795482$gmane$org@trash.net>
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259862720-28432-3-git-send-email-arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, Edge Virtual Bridging <evb@yahoogroups.com>, Stephen Hemminger <shemminger@linux-foundation.org>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> +static int macvtap_newlink(struct net *src_net,
> +			   struct net_device *dev,
> +			   struct nlattr *tb[],
> +			   struct nlattr *data[])
> +{
> +	struct device *classdev;
> +	dev_t devt;
> +	int err;
> +
> +	err = macvlan_common_newlink(src_net, dev, tb, data,
> +				     macvtap_receive, macvtap_forward);
> +	if (err)
> +		goto out;
> +
> +	devt = MKDEV(MAJOR(macvtap_major), dev->ifindex);
> +
> +	classdev = device_create(macvtap_class, &dev->dev, devt,
> +				 dev, "tap%d", dev->ifindex);
> +	if (IS_ERR(classdev)) {
> +		err = PTR_ERR(classdev);
> +		macvtap_del_queues(dev);
> +		macvlan_dellink(dev, NULL);

I think this may cause a double free since macvlan_dellink() will
free the device and rtnl_newlink() will free it again on error.

> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static void macvtap_dellink(struct net_device *dev,
> +			    struct list_head *head)
> +{
> +	device_destroy(macvtap_class,
> +		       MKDEV(MAJOR(macvtap_major), dev->ifindex));
> +
> +	macvtap_del_queues(dev);
> +	macvlan_dellink(dev, head);
> +}
> +
> +static struct rtnl_link_ops macvtap_link_ops __read_mostly = {
> +	.kind		= "macvtap",
> +	.newlink	= macvtap_newlink,
> +	.dellink	= macvtap_dellink,
> +};
