From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH net v3] failover: allow name change on IFF_UP slave
	interfaces
Date: Fri, 29 Mar 2019 03:49:56 +0800
Message-ID: <201903290354.GYaxkjYZ%lkp__43289.6697356895$1553802639$gmane$org@intel.com>
References: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, kbuild-all@01.org, netdev@vger.kernel.org, si-wei liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Si-Wei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Si-Wei-Liu/failover-allow-name-change-on-IFF_UP-slave-interfaces/20190329-020744
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   net/core/dev.c: In function 'dev_change_name':
>> net/core/dev.c:1277:9: error: too few arguments to function 'dev_open'
      ret = dev_open(dev);
            ^~~~~~~~
   In file included from net/core/dev.c:93:0:
   include/linux/netdevice.h:2636:5: note: declared here
    int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
        ^~~~~~~~

vim +/dev_open +1277 net/core/dev.c

  1166	
  1167	/**
  1168	 *	dev_change_name - change name of a device
  1169	 *	@dev: device
  1170	 *	@newname: name (or format string) must be at least IFNAMSIZ
  1171	 *
  1172	 *	Change name of a device, can pass format strings "eth%d".
  1173	 *	for wildcarding.
  1174	 */
  1175	int dev_change_name(struct net_device *dev, const char *newname)
  1176	{
  1177		unsigned char old_assign_type;
  1178		bool reopen_needed = false;
  1179		char oldname[IFNAMSIZ];
  1180		int err = 0;
  1181		int ret;
  1182		struct net *net;
  1183	
  1184		ASSERT_RTNL();
  1185		BUG_ON(!dev_net(dev));
  1186	
  1187		net = dev_net(dev);
  1188	
  1189		/* Allow failover slave to rename even when
  1190		 * it is up and running.
  1191		 *
  1192		 * Failover slaves are special, since userspace
  1193		 * might rename the slave after the interface
  1194		 * has been brought up and running due to
  1195		 * auto-enslavement.
  1196		 *
  1197		 * Failover users don't actually care about slave
  1198		 * name change, as they are only expected to operate
  1199		 * on master interface directly.
  1200		 */
  1201		if (dev->flags & IFF_UP) {
  1202			if (likely(!(dev->priv_flags & IFF_FAILOVER_SLAVE)))
  1203				return -EBUSY;
  1204			reopen_needed = true;
  1205		}
  1206	
  1207		write_seqcount_begin(&devnet_rename_seq);
  1208	
  1209		if (strncmp(newname, dev->name, IFNAMSIZ) == 0) {
  1210			write_seqcount_end(&devnet_rename_seq);
  1211			return 0;
  1212		}
  1213	
  1214		memcpy(oldname, dev->name, IFNAMSIZ);
  1215	
  1216		err = dev_get_valid_name(net, dev, newname);
  1217		if (err < 0) {
  1218			write_seqcount_end(&devnet_rename_seq);
  1219			return err;
  1220		}
  1221	
  1222		if (reopen_needed)
  1223			dev_close(dev);
  1224	
  1225		if (oldname[0] && !strchr(oldname, '%'))
  1226			netdev_info(dev, "renamed from %s\n", oldname);
  1227	
  1228		old_assign_type = dev->name_assign_type;
  1229		dev->name_assign_type = NET_NAME_RENAMED;
  1230	
  1231	rollback:
  1232		ret = device_rename(&dev->dev, dev->name);
  1233		if (ret) {
  1234			memcpy(dev->name, oldname, IFNAMSIZ);
  1235			dev->name_assign_type = old_assign_type;
  1236			write_seqcount_end(&devnet_rename_seq);
  1237			if (err >= 0)
  1238				err = ret;
  1239			goto reopen;
  1240		}
  1241	
  1242		write_seqcount_end(&devnet_rename_seq);
  1243	
  1244		netdev_adjacent_rename_links(dev, oldname);
  1245	
  1246		write_lock_bh(&dev_base_lock);
  1247		hlist_del_rcu(&dev->name_hlist);
  1248		write_unlock_bh(&dev_base_lock);
  1249	
  1250		synchronize_rcu();
  1251	
  1252		write_lock_bh(&dev_base_lock);
  1253		hlist_add_head_rcu(&dev->name_hlist, dev_name_hash(net, dev->name));
  1254		write_unlock_bh(&dev_base_lock);
  1255	
  1256		ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
  1257		ret = notifier_to_errno(ret);
  1258	
  1259		if (ret) {
  1260			/* err >= 0 after dev_alloc_name() or stores the first errno */
  1261			if (err >= 0) {
  1262				err = ret;
  1263				write_seqcount_begin(&devnet_rename_seq);
  1264				memcpy(dev->name, oldname, IFNAMSIZ);
  1265				memcpy(oldname, newname, IFNAMSIZ);
  1266				dev->name_assign_type = old_assign_type;
  1267				old_assign_type = NET_NAME_RENAMED;
  1268				goto rollback;
  1269			} else {
  1270				pr_err("%s: name change rollback failed: %d\n",
  1271				       dev->name, ret);
  1272			}
  1273		}
  1274	
  1275	reopen:
  1276		if (reopen_needed) {
> 1277			ret = dev_open(dev);
  1278			if (ret) {
  1279				pr_err("%s: reopen device failed: %d\n",
  1280				       dev->name, ret);
  1281			}
  1282		}
  1283	
  1284		return err;
  1285	}
  1286	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
jXcAAA==

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--4Ckj6UjgE2iN1+kY--
