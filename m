From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v12 1/5] net: Introduce generic failover module
Date: Fri, 25 May 2018 15:38:43 -0700
Message-ID: <20180525153843.503ee052__21199.7697981589$1527287825$gmane$org@xeon-e3>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-2-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527180917-39737-2-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 May 2018 09:55:13 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 03ed492c4e14..0f4ba52b641d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1421,6 +1421,8 @@ struct net_device_ops {
>   *	entity (i.e. the master device for bridged veth)
>   * @IFF_MACSEC: device is a MACsec device
>   * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
> + * @IFF_FAILOVER: device is a failover master device
> + * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			= 1<<0,
> @@ -1450,6 +1452,8 @@ enum netdev_priv_flags {
>  	IFF_PHONY_HEADROOM		= 1<<24,
>  	IFF_MACSEC			= 1<<25,
>  	IFF_NO_RX_HANDLER		= 1<<26,
> +	IFF_FAILOVER			= 1<<27,
> +	IFF_FAILOVER_SLAVE		= 1<<28,
>  };

Why is FAILOVER any different than other master/slave relationships.
I don't think you need to take up precious netdev flag bits for this.
