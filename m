From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Mon, 7 May 2018 16:59:11 -0700
Message-ID: <20180507165911.45b14c58__15569.8625174866$1525737453$gmane$org@xeon-e3>
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

> +	if (netif_running(failover_dev)) {
> +		err = dev_open(slave_dev);
> +		if (err && (err != -EBUSY)) {
> +			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
> +				   slave_dev->name, err);
> +			goto err_dev_open;
> +		}
> +	}
> +
> +	netif_addr_lock_bh(failover_dev);
> +	dev_uc_sync_multiple(slave_dev, failover_dev);
> +	dev_uc_sync_multiple(slave_dev, failover_dev);
> +	netif_addr_unlock_bh(failover_dev);
> +

The order of these is backwards, you want to sync addresses before bringing up.
Also, doing it this way does not allow udev/systemd the chance to rename VF devices.

The complexity of this whole failover mechanism does not make life easier,
more reliable, or safer for netvsc. I though that was the whole reason for having
common code.
