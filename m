From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio: stop using legacy struct vring in kernel
Date: Tue, 7 Apr 2020 04:54:13 +0800
Message-ID: <202004070437.soIn8LZK%lkp@intel.com>
References: <20200406161146.130741-2-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406161146.130741-2-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Michael,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200406]
[also build test ERROR on v5.6]
[cannot apply to vhost/linux-next linus/master linux/master v5.6 v5.6-rc7 v5.6-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Michael-S-Tsirkin/virtio-alignment-issues/20200407-025651
base:    b2e2a818a01717ba15c74fd355f76822b81a95f6
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/virtio.h:12,
                    from include/linux/virtio_config.h:7,
                    from include/uapi/linux/virtio_net.h:30,
                    from include/linux/virtio_net.h:6,
                    from net//packet/af_packet.c:82:
>> include/linux/vringh.h:42:15: error: field 'vring' has incomplete type
      42 |  struct vring vring;
         |               ^~~~~

vim +/vring +42 include/linux/vringh.h

f87d0fbb579818 Rusty Russell      2013-03-20  20  
f87d0fbb579818 Rusty Russell      2013-03-20  21  /* virtio_ring with information needed for host access. */
f87d0fbb579818 Rusty Russell      2013-03-20  22  struct vringh {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  23  	/* Everything is little endian */
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  24  	bool little_endian;
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  25  
f87d0fbb579818 Rusty Russell      2013-03-20  26  	/* Guest publishes used event idx (note: we always do). */
f87d0fbb579818 Rusty Russell      2013-03-20  27  	bool event_indices;
f87d0fbb579818 Rusty Russell      2013-03-20  28  
f87d0fbb579818 Rusty Russell      2013-03-20  29  	/* Can we get away with weak barriers? */
f87d0fbb579818 Rusty Russell      2013-03-20  30  	bool weak_barriers;
f87d0fbb579818 Rusty Russell      2013-03-20  31  
f87d0fbb579818 Rusty Russell      2013-03-20  32  	/* Last available index we saw (ie. where we're up to). */
f87d0fbb579818 Rusty Russell      2013-03-20  33  	u16 last_avail_idx;
f87d0fbb579818 Rusty Russell      2013-03-20  34  
f87d0fbb579818 Rusty Russell      2013-03-20  35  	/* Last index we used. */
f87d0fbb579818 Rusty Russell      2013-03-20  36  	u16 last_used_idx;
f87d0fbb579818 Rusty Russell      2013-03-20  37  
f87d0fbb579818 Rusty Russell      2013-03-20  38  	/* How many descriptors we've completed since last need_notify(). */
f87d0fbb579818 Rusty Russell      2013-03-20  39  	u32 completed;
f87d0fbb579818 Rusty Russell      2013-03-20  40  
f87d0fbb579818 Rusty Russell      2013-03-20  41  	/* The vring (note: it may contain user pointers!) */
f87d0fbb579818 Rusty Russell      2013-03-20 @42  	struct vring vring;
3beee86a4b9374 Sjur Brændeland    2013-03-20  43  
9ad9c49cfe970b Jason Wang         2020-03-26  44  	/* IOTLB for this vring */
9ad9c49cfe970b Jason Wang         2020-03-26  45  	struct vhost_iotlb *iotlb;
9ad9c49cfe970b Jason Wang         2020-03-26  46  
3beee86a4b9374 Sjur Brændeland    2013-03-20  47  	/* The function to call to notify the guest about added buffers */
3beee86a4b9374 Sjur Brændeland    2013-03-20  48  	void (*notify)(struct vringh *);
3beee86a4b9374 Sjur Brændeland    2013-03-20  49  };
3beee86a4b9374 Sjur Brændeland    2013-03-20  50  

:::::: The code at line 42 was first introduced by commit
:::::: f87d0fbb579818fed3eeb0923cc253163ab93039 vringh: host-side implementation of virtio rings.

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Q6oAAA==

--1yeeQ81UyVL57Vl7--
