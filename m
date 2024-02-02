Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2C7C6EF;
	Fri,  2 Feb 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869148; cv=none; b=GkvuIfS3yDXAIFKZNyNtPLcBCIJxTJNgUwLLsWAr6qNtzm8+jniO0Xxisw1lB2FYwB1CBC31bgz2XswhlSHRNybWDwJ60FQectIbMvuyMsCNb8Qqs5SUBOUx6SxXQB9rNYMkwtUKg1/pUDaQKFSpbR8qzIy/wJCb0qWZ0IdDHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869148; c=relaxed/simple;
	bh=O0dlvz0rsuZkkrXwFE4VhXogz4lXzTTIUA+KqRGGRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFKCiK09XdLfZDefbC0E73FE5tNp5z9ei9kVeJ/F5FHi+MKTgmR0XwrPa4snwAAjpDycUt14mxIIB6kkIShzi4eG1g4hnjimMURCt3VGQe0Oyoiu5QIopI9WSbCKrMLQZAdI2rsyu5RLrNiXmItBNFUATO1SrxaVvK5Ml7yUQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4Oph+s+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4Oph+s+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706869147; x=1738405147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0dlvz0rsuZkkrXwFE4VhXogz4lXzTTIUA+KqRGGRos=;
  b=b4Oph+s+101+9rzSS5tLFailKgrxQN7bNLrNaxSsQ3354BoVcqnyonzE
   tBkEHtn3sFFzDpqc7e3Cys+kmoW4tDGPs3W6LRh+WAiViO8zpsFyUM9H4
   JdoXYRZ5+EEAXhvs9jiBpYjlrPDunaLDekvU8KztoAca1Samr4Lreotab
   dwjKbBzhdCfSk+dIHchLEUMyveguNoXhCL2xpmdcCqt8+HMMtBSFkip5r
   y99IwBonEZM+/X0mT4+g43/GSx+CkODbFGt02GKP2Vxs4LxCkBt5fNGo8
   HQdAvYgrmn05955ajrpv6+durRoGkppMdtt5F7sHUBZv5cC+Z7iD7L68e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4028813"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4028813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="932436108"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="932436108"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2024 02:18:58 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVqdH-0003lw-1Y;
	Fri, 02 Feb 2024 10:18:53 +0000
Date: Fri, 2 Feb 2024 18:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org
Subject: Re: [PATCH vhost 07/17] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <202402021724.AisZOf9F-lkp@intel.com>
References: <20240130114224.86536-8-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130114224.86536-8-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7]
[also build test ERROR on next-20240202]
[cannot apply to remoteproc/rproc-next uml/next s390/features linus/master uml/fixes v6.8-rc2 v6.8-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-vring_need_unmap_buffer/20240130-195202
base:   v6.7
patch link:    https://lore.kernel.org/r/20240130114224.86536-8-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 07/17] virtio: find_vqs: pass struct instead of multi parameters
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240202/202402021724.AisZOf9F-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240202/202402021724.AisZOf9F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402021724.AisZOf9F-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_vdpa.c: In function 'virtio_vdpa_setup_vq':
>> drivers/virtio/virtio_vdpa.c:212:59: error: 'cfg' undeclared (first use in this function)
     212 |         vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
         |                                                           ^~~
   drivers/virtio/virtio_vdpa.c:212:59: note: each undeclared identifier is reported only once for each function it appears in
   drivers/virtio/virtio_vdpa.c: In function 'virtio_vdpa_find_vqs':
>> drivers/virtio/virtio_vdpa.c:389:66: error: passing argument 3 of 'virtio_vdpa_setup_vq' from incompatible pointer type [-Werror=incompatible-pointer-types]
     389 |                 vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, cfg);
         |                                                                  ^~~
         |                                                                  |
         |                                                                  struct virtio_vq_config *
   drivers/virtio/virtio_vdpa.c:145:29: note: expected 'void (*)(struct virtqueue *)' but argument is of type 'struct virtio_vq_config *'
     145 |                      void (*callback)(struct virtqueue *vq),
         |                      ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/virtio/virtio_vdpa.c:389:26: error: too few arguments to function 'virtio_vdpa_setup_vq'
     389 |                 vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, cfg);
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_vdpa.c:144:1: note: declared here
     144 | virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_vdpa.c: At top level:
>> drivers/virtio/virtio_vdpa.c:473:27: error: initialization of 'int (*)(struct virtio_device *, struct virtio_vq_config *)' from incompatible pointer type 'int (*)(struct virtio_device *, struct virtio_vq_config *, struct irq_affinity *)' [-Werror=incompatible-pointer-types]
     473 |         .find_vqs       = virtio_vdpa_find_vqs,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_vdpa.c:473:27: note: (near initialization for 'virtio_vdpa_config_ops.find_vqs')
   cc1: some warnings being treated as errors


vim +/cfg +212 drivers/virtio/virtio_vdpa.c

   142	
   143	static struct virtqueue *
   144	virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
   145			     void (*callback)(struct virtqueue *vq),
   146			     const char *name, bool ctx)
   147	{
   148		struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
   149		struct vdpa_device *vdpa = vd_get_vdpa(vdev);
   150		struct transport_vq_config tp_cfg = {};
   151		const struct vdpa_config_ops *ops = vdpa->config;
   152		struct virtio_vdpa_vq_info *info;
   153		bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
   154		struct vdpa_callback cb;
   155		struct virtqueue *vq;
   156		u64 desc_addr, driver_addr, device_addr;
   157		/* Assume split virtqueue, switch to packed if necessary */
   158		struct vdpa_vq_state state = {0};
   159		unsigned long flags;
   160		u32 align, max_num, min_num = 1;
   161		bool may_reduce_num = true;
   162		int err;
   163	
   164		if (!name)
   165			return NULL;
   166	
   167		if (index >= vdpa->nvqs)
   168			return ERR_PTR(-ENOENT);
   169	
   170		/* We cannot accept VIRTIO_F_NOTIFICATION_DATA without kick_vq_with_data */
   171		if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
   172			if (ops->kick_vq_with_data)
   173				notify = virtio_vdpa_notify_with_data;
   174			else
   175				__virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);
   176		}
   177	
   178		/* Queue shouldn't already be set up. */
   179		if (ops->get_vq_ready(vdpa, index))
   180			return ERR_PTR(-ENOENT);
   181	
   182		/* Allocate and fill out our active queue description */
   183		info = kmalloc(sizeof(*info), GFP_KERNEL);
   184		if (!info)
   185			return ERR_PTR(-ENOMEM);
   186	
   187		max_num = ops->get_vq_num_max(vdpa);
   188		if (max_num == 0) {
   189			err = -ENOENT;
   190			goto error_new_virtqueue;
   191		}
   192	
   193		if (ops->get_vq_num_min)
   194			min_num = ops->get_vq_num_min(vdpa);
   195	
   196		may_reduce_num = (max_num == min_num) ? false : true;
   197	
   198		/* Create the vring */
   199		align = ops->get_vq_align(vdpa);
   200	
   201		if (ops->get_vq_dma_dev)
   202			tp_cfg.dma_dev = ops->get_vq_dma_dev(vdpa, index);
   203		else
   204			tp_cfg.dma_dev = vdpa_get_dma_dev(vdpa);
   205	
   206		tp_cfg.num = max_num;
   207		tp_cfg.vring_align = align;
   208		tp_cfg.weak_barriers = true;
   209		tp_cfg.may_reduce_num = may_reduce_num;
   210		tp_cfg.notify = notify;
   211	
 > 212		vq = vring_create_virtqueue(vdev, index, &tp_cfg, cfg);
   213		if (!vq) {
   214			err = -ENOMEM;
   215			goto error_new_virtqueue;
   216		}
   217	
   218		vq->num_max = max_num;
   219	
   220		/* Setup virtqueue callback */
   221		cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
   222		cb.private = info;
   223		cb.trigger = NULL;
   224		ops->set_vq_cb(vdpa, index, &cb);
   225		ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
   226	
   227		desc_addr = virtqueue_get_desc_addr(vq);
   228		driver_addr = virtqueue_get_avail_addr(vq);
   229		device_addr = virtqueue_get_used_addr(vq);
   230	
   231		if (ops->set_vq_address(vdpa, index,
   232					desc_addr, driver_addr,
   233					device_addr)) {
   234			err = -EINVAL;
   235			goto err_vq;
   236		}
   237	
   238		/* reset virtqueue state index */
   239		if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
   240			struct vdpa_vq_state_packed *s = &state.packed;
   241	
   242			s->last_avail_counter = 1;
   243			s->last_avail_idx = 0;
   244			s->last_used_counter = 1;
   245			s->last_used_idx = 0;
   246		}
   247		err = ops->set_vq_state(vdpa, index, &state);
   248		if (err)
   249			goto err_vq;
   250	
   251		ops->set_vq_ready(vdpa, index, 1);
   252	
   253		vq->priv = info;
   254		info->vq = vq;
   255	
   256		spin_lock_irqsave(&vd_dev->lock, flags);
   257		list_add(&info->node, &vd_dev->virtqueues);
   258		spin_unlock_irqrestore(&vd_dev->lock, flags);
   259	
   260		return vq;
   261	
   262	err_vq:
   263		vring_del_virtqueue(vq);
   264	error_new_virtqueue:
   265		ops->set_vq_ready(vdpa, index, 0);
   266		/* VDPA driver should make sure vq is stopeed here */
   267		WARN_ON(ops->get_vq_ready(vdpa, index));
   268		kfree(info);
   269		return ERR_PTR(err);
   270	}
   271	
   272	static void virtio_vdpa_del_vq(struct virtqueue *vq)
   273	{
   274		struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
   275		struct vdpa_device *vdpa = vd_dev->vdpa;
   276		const struct vdpa_config_ops *ops = vdpa->config;
   277		struct virtio_vdpa_vq_info *info = vq->priv;
   278		unsigned int index = vq->index;
   279		unsigned long flags;
   280	
   281		spin_lock_irqsave(&vd_dev->lock, flags);
   282		list_del(&info->node);
   283		spin_unlock_irqrestore(&vd_dev->lock, flags);
   284	
   285		/* Select and deactivate the queue (best effort) */
   286		ops->set_vq_ready(vdpa, index, 0);
   287	
   288		vring_del_virtqueue(vq);
   289	
   290		kfree(info);
   291	}
   292	
   293	static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
   294	{
   295		struct virtqueue *vq, *n;
   296	
   297		list_for_each_entry_safe(vq, n, &vdev->vqs, list)
   298			virtio_vdpa_del_vq(vq);
   299	}
   300	
   301	static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
   302	{
   303		affd->nr_sets = 1;
   304		affd->set_size[0] = affvecs;
   305	}
   306	
   307	static struct cpumask *
   308	create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
   309	{
   310		unsigned int affvecs = 0, curvec, usedvecs, i;
   311		struct cpumask *masks = NULL;
   312	
   313		if (nvecs > affd->pre_vectors + affd->post_vectors)
   314			affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
   315	
   316		if (!affd->calc_sets)
   317			affd->calc_sets = default_calc_sets;
   318	
   319		affd->calc_sets(affd, affvecs);
   320	
   321		if (!affvecs)
   322			return NULL;
   323	
   324		masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
   325		if (!masks)
   326			return NULL;
   327	
   328		/* Fill out vectors at the beginning that don't need affinity */
   329		for (curvec = 0; curvec < affd->pre_vectors; curvec++)
   330			cpumask_setall(&masks[curvec]);
   331	
   332		for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
   333			unsigned int this_vecs = affd->set_size[i];
   334			int j;
   335			struct cpumask *result = group_cpus_evenly(this_vecs);
   336	
   337			if (!result) {
   338				kfree(masks);
   339				return NULL;
   340			}
   341	
   342			for (j = 0; j < this_vecs; j++)
   343				cpumask_copy(&masks[curvec + j], &result[j]);
   344			kfree(result);
   345	
   346			curvec += this_vecs;
   347			usedvecs += this_vecs;
   348		}
   349	
   350		/* Fill out vectors at the end that don't need affinity */
   351		if (usedvecs >= affvecs)
   352			curvec = affd->pre_vectors + affvecs;
   353		else
   354			curvec = affd->pre_vectors + usedvecs;
   355		for (; curvec < nvecs; curvec++)
   356			cpumask_setall(&masks[curvec]);
   357	
   358		return masks;
   359	}
   360	
   361	static int virtio_vdpa_find_vqs(struct virtio_device *vdev,
   362					struct virtio_vq_config *cfg,
   363					struct irq_affinity *desc)
   364	{
   365		struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
   366		struct vdpa_device *vdpa = vd_get_vdpa(vdev);
   367		const struct vdpa_config_ops *ops = vdpa->config;
   368		struct irq_affinity default_affd = { 0 };
   369		struct cpumask *masks;
   370		struct vdpa_callback cb;
   371		bool has_affinity = desc && ops->set_vq_affinity;
   372		struct virtqueue **vqs = cfg->vqs;
   373		unsigned int nvqs = cfg->nvqs;
   374		int i, err, queue_idx = 0;
   375	
   376		if (has_affinity) {
   377			masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
   378			if (!masks)
   379				return -ENOMEM;
   380		}
   381	
   382		for (i = 0; i < nvqs; ++i) {
   383			if (!cfg->names[i]) {
   384				vqs[i] = NULL;
   385				continue;
   386			}
   387	
   388			cfg->cfg_idx = i;
 > 389			vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, cfg);
   390			if (IS_ERR(vqs[i])) {
   391				err = PTR_ERR(vqs[i]);
   392				goto err_setup_vq;
   393			}
   394	
   395			if (has_affinity)
   396				ops->set_vq_affinity(vdpa, i, &masks[i]);
   397		}
   398	
   399		cb.callback = virtio_vdpa_config_cb;
   400		cb.private = vd_dev;
   401		ops->set_config_cb(vdpa, &cb);
   402		if (has_affinity)
   403			kfree(masks);
   404	
   405		return 0;
   406	
   407	err_setup_vq:
   408		virtio_vdpa_del_vqs(vdev);
   409		if (has_affinity)
   410			kfree(masks);
   411		return err;
   412	}
   413	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
