From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Mon, 7 May 2018 16:53:06 -0700
Message-ID: <20180507165306.541bd1f2__2423.50878329507$1525737067$gmane$org@xeon-e3>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon,  7 May 2018 15:10:44 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> +static struct net_device *net_failover_get_bymac(u8 *mac,
> +						 struct net_failover_ops **ops)
> +{
> +	struct net_device *failover_dev;
> +	struct net_failover *failover;
> +
> +	spin_lock(&net_failover_lock);
> +	list_for_each_entry(failover, &net_failover_list, list) {
> +		failover_dev = rtnl_dereference(failover->failover_dev);
> +		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
> +			*ops = rtnl_dereference(failover->ops);
> +			spin_unlock(&net_failover_lock);
> +			return failover_dev;
> +		}
> +	}
> +	spin_unlock(&net_failover_lock);
> +	return NULL;
> +}

This is broken if non-ethernet devices such as Infiniband are present.
