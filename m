From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
Date: Mon, 23 Apr 2018 02:29:13 +0800
Message-ID: <201804230031.zbqzk7Wy%fengguang.wu@intel.com>
References: <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, kbuild-all@01.org, sridhar.samudrala@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Sridhar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]
[also build test WARNING on v4.17-rc1]
[cannot apply to net-next/master next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/Enable-virtio_net-to-act-as-a-standby-for-a-passthru-device/20180422-210557
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/core/failover.c:99:36: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct net_device *dev @@    got struct net_devicestruct net_device *dev @@
   net/core/failover.c:99:36:    expected struct net_device *dev
   net/core/failover.c:99:36:    got struct net_device [noderef] <asn:4>*standby_dev
   net/core/failover.c:102:36: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct net_device *dev @@    got struct net_devicestruct net_device *dev @@
   net/core/failover.c:102:36:    expected struct net_device *dev
   net/core/failover.c:102:36:    got struct net_device [noderef] <asn:4>*primary_dev
>> net/core/failover.c:468:12: sparse: context imbalance in 'failover_select_queue' - wrong count at exit

vim +99 net/core/failover.c

    58	
    59	static int failover_slave_join(struct net_device *slave_dev,
    60				       struct net_device *failover_dev,
    61				       struct failover_ops *failover_ops)
    62	{
    63		struct failover_info *finfo;
    64		int err, orig_mtu;
    65		bool standby;
    66	
    67		if (failover_ops) {
    68			if (!failover_ops->slave_join)
    69				return -EINVAL;
    70	
    71			return failover_ops->slave_join(slave_dev, failover_dev);
    72		}
    73	
    74		if (netif_running(failover_dev)) {
    75			err = dev_open(slave_dev);
    76			if (err && (err != -EBUSY)) {
    77				netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
    78					   slave_dev->name, err);
    79				goto err_dev_open;
    80			}
    81		}
    82	
    83		/* Align MTU of slave with failover dev */
    84		orig_mtu = slave_dev->mtu;
    85		err = dev_set_mtu(slave_dev, failover_dev->mtu);
    86		if (err) {
    87			netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
    88				   slave_dev->name, failover_dev->mtu);
    89			goto err_set_mtu;
    90		}
    91	
    92		finfo = netdev_priv(failover_dev);
    93		standby = (slave_dev->dev.parent == failover_dev->dev.parent);
    94	
    95		dev_hold(slave_dev);
    96	
    97		if (standby) {
    98			rcu_assign_pointer(finfo->standby_dev, slave_dev);
  > 99			dev_get_stats(finfo->standby_dev, &finfo->standby_stats);
   100		} else {
   101			rcu_assign_pointer(finfo->primary_dev, slave_dev);
   102			dev_get_stats(finfo->primary_dev, &finfo->primary_stats);
   103			failover_dev->min_mtu = slave_dev->min_mtu;
   104			failover_dev->max_mtu = slave_dev->max_mtu;
   105		}
   106	
   107		netdev_info(failover_dev, "failover slave:%s joined\n",
   108			    slave_dev->name);
   109	
   110		return 0;
   111	
   112	err_set_mtu:
   113		dev_close(slave_dev);
   114	err_dev_open:
   115		return err;
   116	}
   117	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
