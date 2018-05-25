From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v12 1/5] net: Introduce generic failover module
Date: Fri, 25 May 2018 15:37:44 -0700
Message-ID: <20180525153744.2b53c449__8669.98777860335$1527287767$gmane$org@xeon-e3>
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


> +	spin_lock(&failover_lock);

Since register is not in fast path, this should be a mutex?


> +int failover_slave_unregister(struct net_device *slave_dev)
> +{
> +	struct net_device *failover_dev;
> +	struct failover_ops *fops;
> +
> +	if (!netif_is_failover_slave(slave_dev))
> +		goto done;
> +
> +	ASSERT_RTNL();
> +
> +	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
> +	if (!failover_dev)
> +		goto done;

Since the slave device must have a master device set already, why not use
that instead of searching by MAC address on unregister or link change.
