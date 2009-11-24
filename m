From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 4/4] macvlan: export macvlan mode through netlink
Date: Tue, 24 Nov 2009 11:53:34 +0100
Message-ID: <4B0BBB2E.8020502__31159.5076149844$1259060341$gmane$org@trash.net>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<1259024166-28158-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259024166-28158-5-git-send-email-arnd@arndb.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> @@ -600,6 +594,18 @@ static int macvlan_validate(struct nlattr *tb[], struct nlattr *data[])
>  		if (!is_valid_ether_addr(nla_data(tb[IFLA_ADDRESS])))
>  			return -EADDRNOTAVAIL;
>  	}
> +
> +	if (data && data[IFLA_MACVLAN_MODE]) {
> +		u32 mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
> +		switch (mode) {
> +		case MACVLAN_MODE_PRIVATE:
> +		case MACVLAN_MODE_VEPA:
> +		case MACVLAN_MODE_BRIDGE:
> +			break;
> +		default:
> +			return -EINVAL;

EINVAL is quite unspecific. In this case I think EOPNOTSUPP would
be fine and provide more information.

> +		}
> +	}
>  	return 0;
>  }
> @@ -664,6 +670,13 @@ static int macvlan_newlink(struct net *src_net, struct net_device *dev,
>  	vlan->dev      = dev;
>  	vlan->port     = port;
>  
> +	vlan->mode     = MACVLAN_MODE_VEPA;
> +	if (data && data[IFLA_MACVLAN_MODE]) {
> +		u32 mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
> +
> +		vlan->mode     = mode;

This looks a bit strange, like cut-and-paste without reformatting :)
I'd suggest to simply use "vlan->mode = nla_get_u32(...)".

> +	}
> +
>  	err = register_netdevice(dev);
>  	if (err < 0)
>  		return err;
> @@ -685,6 +698,39 @@ static void macvlan_dellink(struct net_device *dev, struct list_head *head)
>  		macvlan_port_destroy(port->dev);
>  }
>  
> +static int macvlan_changelink(struct net_device *dev,
> +		struct nlattr *tb[], struct nlattr *data[])
> +{
> +	struct macvlan_dev *vlan = netdev_priv(dev);
> +	if (data && data[IFLA_MACVLAN_MODE]) {
> +		u32 mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
> +		vlan->mode     = mode;

Same here.

> +	}
> +
> +	return 0;
> +}
