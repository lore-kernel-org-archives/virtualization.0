From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 4/4] vhost: log dirty page correctly
Date: Mon, 10 Dec 2018 20:30:03 -0500
Message-ID: <20181210202547-mutt-send-email-mst__27877.6336032481$1544491708$gmane$org@kernel.org>
References: <20181210094454.21144-5-jasowang@redhat.com>
	<201812102354.K7cjF8jc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201812102354.K7cjF8jc%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <lkp@intel.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kbuild-all@01.org, Jintack Lim <jintack@cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 10, 2018 at 11:14:41PM +0800, kbuild test robot wrote:
> Hi Jason,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on net/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/Fix-various-issue-of-vhost/20181210-223236
> config: i386-randconfig-x072-201849 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//vhost/vhost.c: In function 'log_used':
> >> drivers//vhost/vhost.c:1771:27: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      ret = translate_desc(vq, (u64)vq->used + used_offset, len, iov, 64,
>                               ^
>    drivers//vhost/vhost.c:1776:27: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       ret = log_write_hva(vq, (u64)iov[i].iov_base, iov[i].iov_len);
>                               ^
>    drivers//vhost/vhost.c: In function 'vhost_log_write':
>    drivers//vhost/vhost.c:1788:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        r = log_write_hva(vq, (u64)iov[i].iov_base,
>                              ^

It's a technicality, cast to unsigned long and the warning will go away.
Donnu why does gcc bother with these warnings. Nothing is wrong
unless size of pointer is > size of int.

>    Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
>    Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
>    Cyclomatic Complexity 1 arch/x86/include/asm/barrier.h:array_index_mask_nospec
>    Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
>    Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
>    Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:set_bit
>    Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:clear_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:test_and_set_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
>    Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
>    Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
>    Cyclomatic Complexity 1 include/linux/list.h:__list_del
>    Cyclomatic Complexity 1 include/linux/list.h:list_empty
>    Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
>    Cyclomatic Complexity 3 include/linux/string.h:memset
>    Cyclomatic Complexity 5 include/linux/string.h:memcpy
>    Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
>    Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_dec_and_test
>    Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_dec_and_test
>    Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
>    Cyclomatic Complexity 1 include/linux/thread_info.h:set_ti_thread_flag
>    Cyclomatic Complexity 1 include/linux/thread_info.h:check_object_size
>    Cyclomatic Complexity 5 include/linux/thread_info.h:check_copy_size
>    Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:preempt_count
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
>    Cyclomatic Complexity 1 include/linux/wait.h:init_waitqueue_func_entry
>    Cyclomatic Complexity 1 include/linux/llist.h:init_llist_head
>    Cyclomatic Complexity 1 include/linux/llist.h:llist_empty
>    Cyclomatic Complexity 1 include/linux/llist.h:llist_del_all
>    Cyclomatic Complexity 1 include/linux/rbtree.h:rb_link_node
>    Cyclomatic Complexity 3 include/linux/overflow.h:__ab_c_size
>    Cyclomatic Complexity 1 include/linux/page_ref.h:page_ref_dec_and_test
>    Cyclomatic Complexity 1 include/linux/sched.h:task_thread_info
>    Cyclomatic Complexity 1 include/linux/sched.h:need_resched
>    Cyclomatic Complexity 1 include/linux/mm.h:put_page_testzero
>    Cyclomatic Complexity 1 include/linux/mm.h:put_devmap_managed_page
>    Cyclomatic Complexity 1 include/uapi/linux/virtio_ring.h:vring_need_event
>    Cyclomatic Complexity 1 include/linux/virtio_byteorder.h:virtio_legacy_is_little_endian
>    Cyclomatic Complexity 2 include/linux/uio.h:copy_to_iter
>    Cyclomatic Complexity 2 include/linux/uio.h:copy_from_iter
>    Cyclomatic Complexity 2 include/linux/uio.h:copy_from_iter_full
>    Cyclomatic Complexity 1 include/linux/uio.h:iov_iter_count
>    Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_type
>    Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
>    Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
>    Cyclomatic Complexity 4 include/linux/slab.h:kmalloc
>    Cyclomatic Complexity 1 arch/x86/include/asm/smap.h:clac
>    Cyclomatic Complexity 1 arch/x86/include/asm/smap.h:stac
>    Cyclomatic Complexity 1 arch/x86/include/asm/uaccess.h:set_fs
>    Cyclomatic Complexity 1 arch/x86/include/asm/uaccess_32.h:raw_copy_to_user
>    Cyclomatic Complexity 5 arch/x86/include/asm/uaccess_32.h:raw_copy_from_user
>    Cyclomatic Complexity 1 include/linux/uaccess.h:__copy_from_user
>    Cyclomatic Complexity 1 include/linux/uaccess.h:__copy_to_user
>    Cyclomatic Complexity 2 include/linux/uaccess.h:copy_from_user
>    Cyclomatic Complexity 2 include/linux/uaccess.h:copy_to_user
>    Cyclomatic Complexity 4 include/linux/poll.h:poll_wait
>    Cyclomatic Complexity 1 include/linux/poll.h:init_poll_funcptr
>    Cyclomatic Complexity 1 include/linux/rbtree_augmented.h:rb_set_parent
>    Cyclomatic Complexity 1 include/linux/rbtree_augmented.h:rb_set_parent_color
>    Cyclomatic Complexity 3 include/linux/rbtree_augmented.h:__rb_change_child
>    Cyclomatic Complexity 11 include/linux/rbtree_augmented.h:__rb_erase_augmented
>    Cyclomatic Complexity 2 include/linux/rbtree_augmented.h:rb_erase_augmented_cached
>    Cyclomatic Complexity 1 drivers//vhost/vhost.h:vhost_has_feature
>    Cyclomatic Complexity 1 drivers//vhost/vhost.h:vhost_backend_has_feature
>    Cyclomatic Complexity 1 drivers//vhost/vhost.h:vhost_is_little_endian
>    Cyclomatic Complexity 5 drivers//vhost/vhost.c:vhost_umem_interval_tree_compute_subtree_last
>    Cyclomatic Complexity 3 drivers//vhost/vhost.c:vhost_umem_interval_tree_augment_propagate
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_umem_interval_tree_augment_copy
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_umem_interval_tree_augment_rotate
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_umem_interval_tree_remove
>    Cyclomatic Complexity 7 drivers//vhost/vhost.c:vhost_umem_interval_tree_subtree_search
>    Cyclomatic Complexity 4 drivers//vhost/vhost.c:vhost_umem_interval_tree_iter_first
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_disable_cross_endian
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_enable_cross_endian_big
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_enable_cross_endian_little
>    Cyclomatic Complexity 5 drivers//vhost/vhost.c:vhost_set_vring_endian
>    Cyclomatic Complexity 2 drivers//vhost/vhost.c:vhost_get_vring_endian
>    Cyclomatic Complexity 3 drivers//vhost/vhost.c:vhost_init_is_le
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_reset_is_le
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_work_init
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_poll_init
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_has_work
>    Cyclomatic Complexity 2 drivers//vhost/vhost.c:__vhost_vq_meta_reset
>    Cyclomatic Complexity 2 drivers//vhost/vhost.c:vhost_vq_meta_reset
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_vq_reset
>    Cyclomatic Complexity 2 drivers//vhost/vhost.c:vhost_dev_check_owner
>    Cyclomatic Complexity 1 drivers//vhost/vhost.c:vhost_dev_has_owner
> 
> vim +1771 drivers//vhost/vhost.c
> 
>   1760	
>   1761	static void log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>   1762	{
>   1763		struct iovec iov[64];
>   1764		int i, ret;
>   1765	
>   1766		if (!vq->iotlb) {
>   1767			log_write(vq->log_base, vq->log_addr + used_offset, len);
>   1768			return;
>   1769		}
>   1770	
> > 1771		ret = translate_desc(vq, (u64)vq->used + used_offset, len, iov, 64,
>   1772				     VHOST_ACCESS_WO);
>   1773		WARN_ON(ret < 0);
>   1774	
>   1775		for (i = 0; i < ret; i++) {
>   1776			ret = log_write_hva(vq, (u64)iov[i].iov_base, iov[i].iov_len);
>   1777			WARN_ON(ret);
>   1778		}
>   1779	}
>   1780	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
