From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v8 2/4] net: Introduce generic failover module
Date: Fri, 27 Apr 2018 20:39:26 +0800
Message-ID: <201804272024.Ly8sEAMD%fengguang.wu__13283.177992753$1524832723$gmane$org@intel.com>
References: <1524700768-38627-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524700768-38627-3-git-send-email-sridhar.samudrala@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/Enable-virtio_net-to-act-as-a-standby-for-a-passthru-device/20180427-183842
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/core/net_failover.c:544:39: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct net_device *dev @@    got struct net_devicestruct net_device *dev @@
   net/core/net_failover.c:544:39:    expected struct net_device *dev
   net/core/net_failover.c:544:39:    got struct net_device [noderef] <asn:4>*standby_dev
   net/core/net_failover.c:547:39: sparse: incorrect type in argument 1 (different address spaces) @@    expected struct net_device *dev @@    got struct net_devicestruct net_device *dev @@
   net/core/net_failover.c:547:39:    expected struct net_device *dev
   net/core/net_failover.c:547:39:    got struct net_device [noderef] <asn:4>*primary_dev
>> net/core/net_failover.c:112:12: sparse: context imbalance in 'net_failover_select_queue' - wrong count at exit

vim +544 net/core/net_failover.c

   446	
   447	static int net_failover_slave_register(struct net_device *slave_dev)
   448	{
   449		struct net_failover_info *nfo_info;
   450		struct net_failover_ops *nfo_ops;
   451		struct net_device *failover_dev;
   452		bool slave_is_standby;
   453		u32 orig_mtu;
   454		int err;
   455	
   456		ASSERT_RTNL();
   457	
   458		failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
   459		if (!failover_dev)
   460			goto done;
   461	
   462		if (failover_dev->type != slave_dev->type)
   463			goto done;
   464	
   465		if (nfo_ops && nfo_ops->slave_register)
   466			return nfo_ops->slave_register(slave_dev, failover_dev);
   467	
   468		nfo_info = netdev_priv(failover_dev);
   469		slave_is_standby = (slave_dev->dev.parent == failover_dev->dev.parent);
   470		if (slave_is_standby ? rtnl_dereference(nfo_info->standby_dev) :
   471				rtnl_dereference(nfo_info->primary_dev)) {
   472			netdev_err(failover_dev, "%s attempting to register as slave dev when %s already present\n",
   473				   slave_dev->name,
   474				   slave_is_standby ? "standby" : "primary");
   475			goto done;
   476		}
   477	
   478		/* We want to allow only a direct attached VF device as a primary
   479		 * netdev. As there is no easy way to check for a VF device, restrict
   480		 * this to a pci device.
   481		 */
   482		if (!slave_is_standby && (!slave_dev->dev.parent ||
   483					  !dev_is_pci(slave_dev->dev.parent)))
   484			goto done;
   485	
   486		if (failover_dev->features & NETIF_F_VLAN_CHALLENGED &&
   487		    vlan_uses_dev(failover_dev)) {
   488			netdev_err(failover_dev, "Device %s is VLAN challenged and failover device has VLAN set up\n",
   489				   failover_dev->name);
   490			goto done;
   491		}
   492	
   493		/* Align MTU of slave with failover dev */
   494		orig_mtu = slave_dev->mtu;
   495		err = dev_set_mtu(slave_dev, failover_dev->mtu);
   496		if (err) {
   497			netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
   498				   slave_dev->name, failover_dev->mtu);
   499			goto done;
   500		}
   501	
   502		dev_hold(slave_dev);
   503	
   504		if (netif_running(failover_dev)) {
   505			err = dev_open(slave_dev);
   506			if (err && (err != -EBUSY)) {
   507				netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
   508					   slave_dev->name, err);
   509				goto err_dev_open;
   510			}
   511		}
   512	
   513		netif_addr_lock_bh(failover_dev);
   514		dev_uc_sync_multiple(slave_dev, failover_dev);
   515		dev_uc_sync_multiple(slave_dev, failover_dev);
   516		netif_addr_unlock_bh(failover_dev);
   517	
   518		err = vlan_vids_add_by_dev(slave_dev, failover_dev);
   519		if (err) {
   520			netdev_err(failover_dev, "Failed to add vlan ids to device %s err:%d\n",
   521				   slave_dev->name, err);
   522			goto err_vlan_add;
   523		}
   524	
   525		err = netdev_rx_handler_register(slave_dev, net_failover_handle_frame,
   526						 failover_dev);
   527		if (err) {
   528			netdev_err(slave_dev, "can not register failover rx handler (err = %d)\n",
   529				   err);
   530			goto err_handler_register;
   531		}
   532	
   533		err = netdev_upper_dev_link(slave_dev, failover_dev, NULL);
   534		if (err) {
   535			netdev_err(slave_dev, "can not set failover device %s (err = %d)\n",
   536				   failover_dev->name, err);
   537			goto err_upper_link;
   538		}
   539	
   540		slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
   541	
   542		if (slave_is_standby) {
   543			rcu_assign_pointer(nfo_info->standby_dev, slave_dev);
 > 544			dev_get_stats(nfo_info->standby_dev, &nfo_info->standby_stats);
   545		} else {
   546			rcu_assign_pointer(nfo_info->primary_dev, slave_dev);
   547			dev_get_stats(nfo_info->primary_dev, &nfo_info->primary_stats);
   548			failover_dev->min_mtu = slave_dev->min_mtu;
   549			failover_dev->max_mtu = slave_dev->max_mtu;
   550		}
   551	
   552		net_failover_compute_features(failover_dev);
   553	
   554		call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
   555	
   556		netdev_info(failover_dev, "failover %s slave:%s registered\n",
   557			    slave_is_standby ? "standby" : "primary", slave_dev->name);
   558	
   559		goto done;
   560	
   561	err_upper_link:
   562		netdev_rx_handler_unregister(slave_dev);
   563	err_handler_register:
   564		vlan_vids_del_by_dev(slave_dev, failover_dev);
   565	err_vlan_add:
   566		dev_uc_unsync(slave_dev, failover_dev);
   567		dev_mc_unsync(slave_dev, failover_dev);
   568		dev_close(slave_dev);
   569	err_dev_open:
   570		dev_put(slave_dev);
   571		dev_set_mtu(slave_dev, orig_mtu);
   572	done:
   573		return NOTIFY_DONE;
   574	}
   575	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
