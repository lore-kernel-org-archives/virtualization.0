From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Tue, 8 May 2018 17:02:27 +0800
Message-ID: <201805081451.t5GJxu1F%fengguang.wu__37209.7667110667$1525770100$gmane$org@intel.com>
References: <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, kbuild-all@01.org, sridhar.samudrala@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Sridhar,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/Enable-virtio_net-to-act-as-a-standby-for-a-passthru-device/20180508-123531
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/core/net_failover.c:868:16: sparse: Using plain integer as NULL pointer
   net/core/net_failover.c:115:12: sparse: context imbalance in 'net_failover_select_queue' - wrong count at exit

vim +868 net/core/net_failover.c

   828	
   829	/**
   830	 * net_failover_register - Register a failover instance
   831	 *
   832	 * @dev: failover or standby netdev
   833	 * @ops: failover ops
   834	 *
   835	 * Paravirtual drivers supporting 3-netdev model call this routine indirectly
   836	 * via net_failover_create(). It passes failover netdev and ops will be NULL
   837	 * as the slave events are handled internally.
   838	 * Paravirtual drivers supporting 2-netdev model call this routine by passing
   839	 * standby netdev and ops that are called to handle slave register/unregister/
   840	 * link change events.
   841	 *
   842	 * Return: pointer to failover instance
   843	 */
   844	struct net_failover *net_failover_register(struct net_device *dev,
   845						   struct net_failover_ops *ops)
   846	{
   847		struct net_failover *failover;
   848	
   849		failover = kzalloc(sizeof(*failover), GFP_KERNEL);
   850		if (!failover)
   851			return ERR_PTR(-ENOMEM);
   852	
   853		rcu_assign_pointer(failover->ops, ops);
   854		dev_hold(dev);
   855		dev->priv_flags |= IFF_FAILOVER;
   856		rcu_assign_pointer(failover->failover_dev, dev);
   857	
   858		spin_lock(&net_failover_lock);
   859		list_add_tail(&failover->list, &net_failover_list);
   860		spin_unlock(&net_failover_lock);
   861	
   862		netdev_info(dev, "failover master:%s registered\n", dev->name);
   863	
   864		net_failover_existing_slave_register(dev);
   865	
   866		return failover;
   867	
 > 868		return 0;
   869	}
   870	EXPORT_SYMBOL_GPL(net_failover_register);
   871	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
