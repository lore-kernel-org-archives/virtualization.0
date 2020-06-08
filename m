From: kernel test robot <lkp@intel.com>
Subject: [vhost:vhost 18/52] drivers/virtio/virtio_mem.c:1391:5: warning:
 Variable 'rc' is reassigned a value before the old one has been used.
Date: Mon, 8 Jun 2020 08:59:29 +0800
Message-ID: <202006080825.MWCyEzr3%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
head:   f3861bc96a7e130943e1975e571ae62c0319b064
commit: 5f1f79bbc9e26fa9412fa9522f957bb8f030c442 [18/52] virtio-mem: Paravirtualized memory hotplug
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/virtio/virtio_mem.c:1391:5: warning: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
    rc = virtio_mem_init_vq(vm);
       ^
   drivers/virtio/virtio_mem.c:1375:0: note: Variable 'rc' is reassigned a value before the old one has been used.
    int rc = -EINVAL;
   ^
   drivers/virtio/virtio_mem.c:1391:5: note: Variable 'rc' is reassigned a value before the old one has been used.
    rc = virtio_mem_init_vq(vm);
       ^
>> drivers/virtio/virtio_mem.c:801:22: warning: int result is assigned to long variable. If the variable is long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
    const uint64_t size = count * vm->subblock_size;
                        ^
   drivers/virtio/virtio_mem.c:822:22: warning: int result is assigned to long variable. If the variable is long to avoid loss of information, then you have loss of information. [truncLongCastAssignment]
    const uint64_t size = count * vm->subblock_size;
                        ^

vim +/rc +1391 drivers/virtio/virtio_mem.c

  1371	
  1372	static int virtio_mem_probe(struct virtio_device *vdev)
  1373	{
  1374		struct virtio_mem *vm;
  1375		int rc = -EINVAL;
  1376	
  1377		vdev->priv = vm = kzalloc(sizeof(*vm), GFP_KERNEL);
  1378		if (!vm)
  1379			return -ENOMEM;
  1380	
  1381		init_waitqueue_head(&vm->host_resp);
  1382		vm->vdev = vdev;
  1383		INIT_WORK(&vm->wq, virtio_mem_run_wq);
  1384		mutex_init(&vm->hotplug_mutex);
  1385		INIT_LIST_HEAD(&vm->next);
  1386		spin_lock_init(&vm->removal_lock);
  1387		hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
  1388		vm->retry_timer.function = virtio_mem_timer_expired;
  1389	
  1390		/* register the virtqueue */
> 1391		rc = virtio_mem_init_vq(vm);
  1392		if (rc)
  1393			goto out_free_vm;
  1394	
  1395		/* initialize the device by querying the config */
  1396		rc = virtio_mem_init(vm);
  1397		if (rc)
  1398			goto out_del_vq;
  1399	
  1400		/* register callbacks */
  1401		vm->memory_notifier.notifier_call = virtio_mem_memory_notifier_cb;
  1402		rc = register_memory_notifier(&vm->memory_notifier);
  1403		if (rc)
  1404			goto out_del_vq;
  1405		rc = register_virtio_mem_device(vm);
  1406		if (rc)
  1407			goto out_unreg_mem;
  1408	
  1409		virtio_device_ready(vdev);
  1410	
  1411		/* trigger a config update to start processing the requested_size */
  1412		atomic_set(&vm->config_changed, 1);
  1413		queue_work(system_freezable_wq, &vm->wq);
  1414	
  1415		return 0;
  1416	out_unreg_mem:
  1417		unregister_memory_notifier(&vm->memory_notifier);
  1418	out_del_vq:
  1419		vdev->config->del_vqs(vdev);
  1420	out_free_vm:
  1421		kfree(vm);
  1422		vdev->priv = NULL;
  1423	
  1424		return rc;
  1425	}
  1426	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
