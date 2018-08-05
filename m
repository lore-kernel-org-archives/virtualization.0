From: Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [PATCH net-next 0/6] virtio_net: Add ethtool stat items
Date: Sun, 5 Aug 2018 16:15:17 +0300
Message-ID: <eacdf80a-87cd-ce8d-b56a-c49432948773@mellanox.com>
References: <20180723143609.2242-1-toshiaki.makita1@gmail.com>
	<20180725123908-mutt-send-email-mst@kernel.org>
	<20180725.125909.840615930497803596.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180725.125909.840615930497803596.davem@davemloft.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>, mst@redhat.com, toshiaki.makita1@gmail.com, makita.toshiaki@lab.ntt.co.jp
Cc: ranro@mellanox.com, netdev@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>, virtualization@lists.linux-foundation.org, Maor Gottlieb <maorg@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org



On 25/07/2018 10:59 PM, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 25 Jul 2018 12:40:12 +0300
> 
>> On Mon, Jul 23, 2018 at 11:36:03PM +0900, Toshiaki Makita wrote:
>>> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>
>>> Add some ethtool stat items useful for performance analysis.
>>>
>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>
>> Series:
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Series applied.
> 
>> Patch 1 seems appropriate for stable, even though it's minor.
> 
> Ok, I'll put patch #1 also into 'net' and queue it up for -stable.
> 
> Thanks.
> 

Hi,
Our verification team encountered the following degradation, introduced 
by this series. Please check KASAN bug report below.

We tested before and after the series, but didn't bisect within it. We 
can do if necessary.

Thanks,
Tariq


[   46.166544] BUG: KASAN: use-after-free in virtnet_poll+0xd9c/0xfd1 
[virtio_net]
[   46.166593] Read of size 8 at addr ffff8803400da608 by task ip/1013

[   46.166603] CPU: 3 PID: 1013 Comm: ip Not tainted 
4.18.0-rc6-for-upstream-dbg-2018-07-26_19-45-52-64 #1
[   46.166606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[   46.166609] Call Trace:
[   46.166613]  <IRQ>
[   46.166624]  dump_stack+0xf0/0x17b
[   46.166647]  ? show_regs_print_info+0x5/0x5
[   46.166654]  ? printk+0x9c/0xc3
[   46.166661]  ? kmsg_dump_rewind_nolock+0xf5/0xf5
[   46.166677]  ? virtnet_poll+0xd9c/0xfd1 [virtio_net]
[   46.166685]  print_address_description+0xea/0x380
[   46.166701]  ? virtnet_poll+0xd9c/0xfd1 [virtio_net]
[   46.166711]  kasan_report+0x1dd/0x460
[   46.166727]  ? virtnet_poll+0xd9c/0xfd1 [virtio_net]
[   46.166743]  virtnet_poll+0xd9c/0xfd1 [virtio_net]
[   46.166767]  ? receive_buf+0x2e30/0x2e30 [virtio_net]
[   46.166796]  ? sched_clock_cpu+0x18/0x2b0
[   46.166809]  ? print_irqtrace_events+0x280/0x280
[   46.166817]  ? print_irqtrace_events+0x280/0x280
[   46.166830]  ? rcu_process_callbacks+0xc5e/0x12d0
[   46.166838]  ? kvm_clock_read+0x1f/0x30
[   46.166857]  ? mark_held_locks+0xd5/0x170
[   46.166867]  ? net_rx_action+0x2aa/0x10e0
[   46.166882]  net_rx_action+0x4bc/0x10e0
[   46.166906]  ? napi_complete_done+0x480/0x480
[   46.166925]  ? print_irqtrace_events+0x280/0x280
[   46.166935]  ? sched_clock+0x5/0x10
[   46.166952]  ? __lock_is_held+0xcb/0x1a0
[   46.166982]  __do_softirq+0x2c4/0xdf4
[   46.167010]  do_softirq_own_stack+0x2a/0x40
[   46.167031]  </IRQ>
[   46.167038]  ? virtnet_napi_enable+0x37/0xa0 [virtio_net]
[   46.167044]  do_softirq.part.11+0x69/0x70
[   46.167065]  __local_bh_enable_ip+0x1d9/0x250
[   46.167076]  virtnet_open+0x13c/0x440 [virtio_net]
[   46.167099]  __dev_open+0x1cf/0x390
[   46.167108]  ? dev_set_rx_mode+0x30/0x30
[   46.167113]  ? __local_bh_enable_ip+0xf7/0x250
[   46.167124]  ? trace_hardirqs_on_caller+0x38d/0x6c0
[   46.167130]  ? __dev_change_flags+0x18d/0x630
[   46.167142]  __dev_change_flags+0x469/0x630
[   46.167152]  ? dev_set_allmulti+0x10/0x10
[   46.167157]  ? __lock_acquire+0x9c1/0x4b50
[   46.167166]  ? print_irqtrace_events+0x280/0x280
[   46.167174]  ? kvm_clock_read+0x1f/0x30
[   46.167191]  ? rtnetlink_put_metrics+0x530/0x530
[   46.167205]  dev_change_flags+0x8b/0x160
[   46.167236]  do_setlink+0xa17/0x39f0
[   46.167248]  ? sched_clock_cpu+0x18/0x2b0
[   46.167267]  ? rtnl_dump_ifinfo+0xd20/0xd20
[   46.167277]  ? print_irqtrace_events+0x280/0x280
[   46.167285]  ? kvm_clock_read+0x1f/0x30
[   46.167316]  ? debug_show_all_locks+0x3b0/0x3b0
[   46.167321]  ? kvm_sched_clock_read+0x5/0x10
[   46.167327]  ? sched_clock+0x5/0x10
[   46.167333]  ? sched_clock_cpu+0x18/0x2b0
[   46.167382]  ? memset+0x1f/0x40
[   46.167408]  ? nla_parse+0x8c/0x3f0
[   46.167419]  ? rtnetlink_put_metrics+0x530/0x530
[   46.167427]  ? kvm_sched_clock_read+0x5/0x10
[   46.167433]  ? sched_clock+0x5/0x10
[   46.167439]  ? sched_clock_cpu+0x18/0x2b0
[   46.167457]  rtnl_newlink+0x9dc/0x13a0
[   46.167484]  ? rtnl_link_unregister+0x2b0/0x2b0
[   46.167513]  ? kvm_clock_read+0x1f/0x30
[   46.167538]  ? print_irqtrace_events+0x280/0x280
[   46.167546]  ? kvm_clock_read+0x1f/0x30
[   46.167551]  ? kvm_sched_clock_read+0x5/0x10
[   46.167557]  ? sched_clock+0x5/0x10
[   46.167562]  ? sched_clock_cpu+0x18/0x2b0
[   46.167567]  ? kvm_clock_read+0x1f/0x30
[   46.167598]  ? __lock_acquire+0x9c1/0x4b50
[   46.167640]  ? debug_show_all_locks+0x3b0/0x3b0
[   46.167646]  ? kvm_clock_read+0x1f/0x30
[   46.167651]  ? kvm_sched_clock_read+0x5/0x10
[   46.167673]  ? debug_show_all_locks+0x3b0/0x3b0
[   46.167698]  ? is_bpf_text_address+0x87/0x130
[   46.167707]  ? print_irqtrace_events+0x280/0x280
[   46.167714]  ? kvm_clock_read+0x1f/0x30
[   46.167718]  ? kvm_sched_clock_read+0x5/0x10
[   46.167723]  ? sched_clock+0x5/0x10
[   46.167728]  ? sched_clock_cpu+0x18/0x2b0
[   46.167753]  ? get_lock_stats+0x18/0x160
[   46.167877]  ? __lock_is_held+0xcb/0x1a0
[   46.167908]  rtnetlink_rcv_msg+0x575/0xaa0
[   46.167913]  ? kvm_clock_read+0x1f/0x30
[   46.167925]  ? validate_linkmsg+0x900/0x900
[   46.167945]  ? netlink_deliver_tap+0x1cc/0xf30
[   46.167950]  ? kvm_clock_read+0x1f/0x30
[   46.167965]  netlink_rcv_skb+0x13c/0x3a0
[   46.167972]  ? validate_linkmsg+0x900/0x900
[   46.167984]  ? netlink_ack+0xcd0/0xcd0
[   46.168030]  netlink_unicast+0x45a/0x6a0
[   46.168061]  ? netlink_attachskb+0x770/0x770
[   46.168075]  ? import_iovec+0xa8/0x460
[   46.168093]  netlink_sendmsg+0x68e/0xdf0
[   46.168127]  ? netlink_unicast+0x6a0/0x6a0
[   46.168133]  ? copy_msghdr_from_user+0x216/0x350
[   46.168160]  ? netlink_unicast+0x6a0/0x6a0
[   46.168168]  sock_sendmsg+0xdb/0x160
[   46.168193]  ___sys_sendmsg+0x6b3/0xbd0
[   46.168207]  ? copy_msghdr_from_user+0x350/0x350
[   46.168221]  ? do_raw_spin_unlock+0xae/0x310
[   46.168248]  ? _raw_spin_unlock+0x2e/0x50
[   46.168257]  ? __handle_mm_fault+0xb65/0x2e90
[   46.168278]  ? handle_mm_fault+0x28f/0xa70
[   46.168284]  ? kvm_clock_read+0x1f/0x30
[   46.168289]  ? kvm_sched_clock_read+0x5/0x10
[   46.168303]  ? __do_page_fault+0x549/0xd00
[   46.168308]  ? kvm_clock_read+0x1f/0x30
[   46.168313]  ? kvm_sched_clock_read+0x5/0x10
[   46.168318]  ? sched_clock+0x5/0x10
[   46.168324]  ? sched_clock_cpu+0x18/0x2b0
[   46.168336]  ? __fget_light+0x5c/0x280
[   46.168357]  ? __sys_sendmsg+0xd2/0x170
[   46.168362]  __sys_sendmsg+0xd2/0x170
[   46.168371]  ? __ia32_sys_shutdown+0x90/0x90
[   46.168382]  ? handle_mm_fault+0x363/0xa70
[   46.168397]  ? up_read+0x1c/0x130
[   46.168403]  ? __do_page_fault+0x549/0xd00
[   46.168443]  ? do_syscall_64+0x18/0x540
[   46.168459]  do_syscall_64+0xa4/0x540
[   46.168470]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   46.168477] RIP: 0033:0x7fa59e680087
[   46.168481] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 80 00 00 
00 00 8b 05 aa 97 2c 00 48 63 d2 48 63 ff 85 c0 75 18 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 59 f3 c3 0f 1f 80 00 00 00 00 53 48 89 f3 48
[   46.168717] RSP: 002b:00007ffe83f2fef8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[   46.168726] RAX: ffffffffffffffda RBX: 00000000006744c0 RCX: 
00007fa59e680087
[   46.168731] RDX: 0000000000000000 RSI: 00007ffe83f2ff40 RDI: 
0000000000000003
[   46.168735] RBP: 000000005b5d727c R08: 0000000000000001 R09: 
fefefeff77686d74
[   46.168740] R10: 0000000000000006 R11: 0000000000000246 R12: 
00007ffe83f38000
[   46.168744] R13: 0000000000000000 R14: 00007ffe83f38728 R15: 
00007ffe83f37fd8

[   46.168778] Allocated by task 499:
[   46.168784]  kasan_kmalloc+0xa0/0xd0
[   46.168789]  __kmalloc+0x191/0x3a0
[   46.168795]  mpi_powm+0x956/0x2360
[   46.168801]  rsa_enc+0x1f0/0x3a0
[   46.168806]  pkcs1pad_verify+0x4c4/0x750
[   46.168815]  public_key_verify_signature+0x58b/0xac0
[   46.168821]  pkcs7_validate_trust+0x3bd/0x710
[   46.168830]  verify_pkcs7_signature+0xe8/0x1b0
[   46.168837]  mod_verify_sig+0x1d4/0x2a0
[   46.168842]  load_module+0x1689/0x6590
[   46.168847]  __do_sys_finit_module+0x192/0x1c0
[   46.168852]  do_syscall_64+0xa4/0x540
[   46.168857]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   46.168864] Freed by task 499:
[   46.168869]  __kasan_slab_free+0x11d/0x160
[   46.168874]  kfree+0x151/0x650
[   46.168878]  mpi_powm+0x621/0x2360
[   46.168883]  rsa_enc+0x1f0/0x3a0
[   46.168887]  pkcs1pad_verify+0x4c4/0x750
[   46.168892]  public_key_verify_signature+0x58b/0xac0
[   46.168897]  pkcs7_validate_trust+0x3bd/0x710
[   46.168902]  verify_pkcs7_signature+0xe8/0x1b0
[   46.168906]  mod_verify_sig+0x1d4/0x2a0
[   46.168911]  load_module+0x1689/0x6590
[   46.168916]  __do_sys_finit_module+0x192/0x1c0
[   46.168921]  do_syscall_64+0xa4/0x540
[   46.168925]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   46.168933] The buggy address belongs to the object at ffff8803400da588
                 which belongs to the cache kmalloc-2048 of size 2048
[   46.168938] The buggy address is located 128 bytes inside of
                 2048-byte region [ffff8803400da588, ffff8803400dad88)
[   46.168942] The buggy address belongs to the page:
[   46.168947] page:ffffea000d003600 count:1 mapcount:0 
mapping:ffff880355011540 index:0x0 compound_mapcount: 0
[   46.169272] flags: 0x2fffff80008100(slab|head)
[   46.169358] raw: 002fffff80008100 ffffea000d13a608 ffffea000d43e608 
ffff880355011540
[   46.169364] raw: 0000000000000000 00000000000d000d 00000001ffffffff 
0000000000000000
[   46.169369] page dumped because: kasan: bad access detected

[   46.169377] Memory state around the buggy address:
[   46.169383]  ffff8803400da500: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   46.169388]  ffff8803400da580: fc fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   46.169394] >ffff8803400da600: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   46.169398]                       ^
[   46.169403]  ffff8803400da680: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   46.169408]  ffff8803400da700: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   46.169427] 
==================================================================
[   46.169431] Disabling lock debugging due to kernel taint
