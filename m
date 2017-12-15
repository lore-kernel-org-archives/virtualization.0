From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v19 1/7] xbitmap: Introduce xbitmap
Date: Fri, 15 Dec 2017 19:05:07 +0800
Message-ID: <201712151837.MQq7hdgk%fengguang.wu__35899.5881899775$1513335977$gmane$org@intel.com>
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.15-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wei-Wang/Virtio-balloon-Enhancement/20171215-100525
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +29 lib/xbitmap.c

     5	
     6	/**
     7	 *  xb_set_bit - set a bit in the xbitmap
     8	 *  @xb: the xbitmap tree used to record the bit
     9	 *  @bit: index of the bit to set
    10	 *
    11	 * This function is used to set a bit in the xbitmap. If the bitmap that @bit
    12	 * resides in is not there, the per-cpu ida_bitmap will be taken.
    13	 *
    14	 * Returns: 0 on success. %-EAGAIN indicates that @bit was not set.
    15	 */
    16	int xb_set_bit(struct xb *xb, unsigned long bit)
    17	{
    18		int err;
    19		unsigned long index = bit / IDA_BITMAP_BITS;
    20		struct radix_tree_root *root = &xb->xbrt;
    21		struct radix_tree_node *node;
    22		void **slot;
    23		struct ida_bitmap *bitmap;
    24		unsigned long ebit;
    25	
    26		bit %= IDA_BITMAP_BITS;
    27		ebit = bit + 2;
    28	
  > 29		err = __radix_tree_create(root, index, 0, &node, &slot);
    30		if (err)
    31			return err;
    32		bitmap = rcu_dereference_raw(*slot);
    33		if (radix_tree_exception(bitmap)) {
    34			unsigned long tmp = (unsigned long)bitmap;
    35	
    36			if (ebit < BITS_PER_LONG) {
    37				tmp |= 1UL << ebit;
    38				rcu_assign_pointer(*slot, (void *)tmp);
    39				return 0;
    40			}
    41			bitmap = this_cpu_xchg(ida_bitmap, NULL);
    42			if (!bitmap)
    43				return -EAGAIN;
    44			memset(bitmap, 0, sizeof(*bitmap));
    45			bitmap->bitmap[0] = tmp >> RADIX_TREE_EXCEPTIONAL_SHIFT;
    46			rcu_assign_pointer(*slot, bitmap);
    47		}
    48	
    49		if (!bitmap) {
    50			if (ebit < BITS_PER_LONG) {
    51				bitmap = (void *)((1UL << ebit) |
    52						RADIX_TREE_EXCEPTIONAL_ENTRY);
  > 53				__radix_tree_replace(root, node, slot, bitmap, NULL);
    54				return 0;
    55			}
    56			bitmap = this_cpu_xchg(ida_bitmap, NULL);
    57			if (!bitmap)
    58				return -EAGAIN;
    59			memset(bitmap, 0, sizeof(*bitmap));
    60			__radix_tree_replace(root, node, slot, bitmap, NULL);
    61		}
    62	
    63		__set_bit(bit, bitmap->bitmap);
    64		return 0;
    65	}
    66	EXPORT_SYMBOL(xb_set_bit);
    67	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
