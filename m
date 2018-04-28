From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next v8 2/4] net: Introduce generic failover module
Date: Sat, 28 Apr 2018 11:23:34 +0300
Message-ID: <20180428082333.tjsutcqoioqv7aad__22122.6479080089$1524903733$gmane$org@mwanda>
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
To: kbuild@01.org
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, kbuild-all@01.org, sridhar.samudrala@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Sridhar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/Enable-virtio_net-to-act-as-a-standby-for-a-passthru-device/20180427-183842

smatch warnings:
net/core/net_failover.c:229 net_failover_change_mtu() error: we previously assumed 'primary_dev' could be null (see line 219)
net/core/net_failover.c:279 net_failover_vlan_rx_add_vid() error: we previously assumed 'primary_dev' could be null (see line 269)

# https://github.com/0day-ci/linux/commit/5a5f2e3efcb699867db79543dfebe764927b9c93
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 5a5f2e3efcb699867db79543dfebe764927b9c93
vim +/primary_dev +229 net/core/net_failover.c

5a5f2e3e Sridhar Samudrala 2018-04-25  211  
5a5f2e3e Sridhar Samudrala 2018-04-25  212  static int net_failover_change_mtu(struct net_device *dev, int new_mtu)
5a5f2e3e Sridhar Samudrala 2018-04-25  213  {
5a5f2e3e Sridhar Samudrala 2018-04-25  214  	struct net_failover_info *nfo_info = netdev_priv(dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  215  	struct net_device *primary_dev, *standby_dev;
5a5f2e3e Sridhar Samudrala 2018-04-25  216  	int ret = 0;
5a5f2e3e Sridhar Samudrala 2018-04-25  217  
5a5f2e3e Sridhar Samudrala 2018-04-25  218  	primary_dev = rcu_dereference(nfo_info->primary_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25 @219  	if (primary_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  220  		ret = dev_set_mtu(primary_dev, new_mtu);
5a5f2e3e Sridhar Samudrala 2018-04-25  221  		if (ret)
5a5f2e3e Sridhar Samudrala 2018-04-25  222  			return ret;
5a5f2e3e Sridhar Samudrala 2018-04-25  223  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  224  
5a5f2e3e Sridhar Samudrala 2018-04-25  225  	standby_dev = rcu_dereference(nfo_info->standby_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  226  	if (standby_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  227  		ret = dev_set_mtu(standby_dev, new_mtu);
5a5f2e3e Sridhar Samudrala 2018-04-25  228  		if (ret) {
5a5f2e3e Sridhar Samudrala 2018-04-25 @229  			dev_set_mtu(primary_dev, dev->mtu);
5a5f2e3e Sridhar Samudrala 2018-04-25  230  			return ret;
5a5f2e3e Sridhar Samudrala 2018-04-25  231  		}
5a5f2e3e Sridhar Samudrala 2018-04-25  232  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  233  
5a5f2e3e Sridhar Samudrala 2018-04-25  234  	dev->mtu = new_mtu;
5a5f2e3e Sridhar Samudrala 2018-04-25  235  
5a5f2e3e Sridhar Samudrala 2018-04-25  236  	return 0;
5a5f2e3e Sridhar Samudrala 2018-04-25  237  }
5a5f2e3e Sridhar Samudrala 2018-04-25  238  
5a5f2e3e Sridhar Samudrala 2018-04-25  239  static void net_failover_set_rx_mode(struct net_device *dev)
5a5f2e3e Sridhar Samudrala 2018-04-25  240  {
5a5f2e3e Sridhar Samudrala 2018-04-25  241  	struct net_failover_info *nfo_info = netdev_priv(dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  242  	struct net_device *slave_dev;
5a5f2e3e Sridhar Samudrala 2018-04-25  243  
5a5f2e3e Sridhar Samudrala 2018-04-25  244  	rcu_read_lock();
5a5f2e3e Sridhar Samudrala 2018-04-25  245  
5a5f2e3e Sridhar Samudrala 2018-04-25  246  	slave_dev = rcu_dereference(nfo_info->primary_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  247  	if (slave_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  248  		dev_uc_sync_multiple(slave_dev, dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  249  		dev_mc_sync_multiple(slave_dev, dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  250  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  251  
5a5f2e3e Sridhar Samudrala 2018-04-25  252  	slave_dev = rcu_dereference(nfo_info->standby_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  253  	if (slave_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  254  		dev_uc_sync_multiple(slave_dev, dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  255  		dev_mc_sync_multiple(slave_dev, dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  256  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  257  
5a5f2e3e Sridhar Samudrala 2018-04-25  258  	rcu_read_unlock();
5a5f2e3e Sridhar Samudrala 2018-04-25  259  }
5a5f2e3e Sridhar Samudrala 2018-04-25  260  
5a5f2e3e Sridhar Samudrala 2018-04-25  261  static int net_failover_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
5a5f2e3e Sridhar Samudrala 2018-04-25  262  					u16 vid)
5a5f2e3e Sridhar Samudrala 2018-04-25  263  {
5a5f2e3e Sridhar Samudrala 2018-04-25  264  	struct net_failover_info *nfo_info = netdev_priv(dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  265  	struct net_device *primary_dev, *standby_dev;
5a5f2e3e Sridhar Samudrala 2018-04-25  266  	int ret = 0;
5a5f2e3e Sridhar Samudrala 2018-04-25  267  
5a5f2e3e Sridhar Samudrala 2018-04-25  268  	primary_dev = rcu_dereference(nfo_info->primary_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25 @269  	if (primary_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  270  		ret = vlan_vid_add(primary_dev, proto, vid);
5a5f2e3e Sridhar Samudrala 2018-04-25  271  		if (ret)
5a5f2e3e Sridhar Samudrala 2018-04-25  272  			return ret;
5a5f2e3e Sridhar Samudrala 2018-04-25  273  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  274  
5a5f2e3e Sridhar Samudrala 2018-04-25  275  	standby_dev = rcu_dereference(nfo_info->standby_dev);
5a5f2e3e Sridhar Samudrala 2018-04-25  276  	if (standby_dev) {
5a5f2e3e Sridhar Samudrala 2018-04-25  277  		ret = vlan_vid_add(standby_dev, proto, vid);
5a5f2e3e Sridhar Samudrala 2018-04-25  278  		if (ret)
5a5f2e3e Sridhar Samudrala 2018-04-25 @279  			vlan_vid_del(primary_dev, proto, vid);
5a5f2e3e Sridhar Samudrala 2018-04-25  280  	}
5a5f2e3e Sridhar Samudrala 2018-04-25  281  
5a5f2e3e Sridhar Samudrala 2018-04-25  282  	return ret;
5a5f2e3e Sridhar Samudrala 2018-04-25  283  }
5a5f2e3e Sridhar Samudrala 2018-04-25  284  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
