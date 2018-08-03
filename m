From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [net-next, v6, 6/7] net-sysfs: Add interface for Rx queue(s) map
	per Tx queue
Date: Fri, 3 Aug 2018 22:12:53 +0300
Message-ID: <20180803221212-mutt-send-email-mst__17059.057163033$1533323458$gmane$org@kernel.org>
References: <153033282719.8297.790755582693609184.stgit@anamhost.jf.intel.com>
	<20180704072048.GA29107@outlook.office365.com>
	<4b7f5d42-1b81-f095-f313-f43e41cf8601@intel.com>
	<20180802001157.GA29171@outlook.office365.com>
	<c3fbd7f6-054b-a9a3-ea21-4169b26a0a41@intel.com>
	<20180803000725-mutt-send-email-mst@kernel.org>
	<20180803190650.GA2157@outlook.office365.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180803190650.GA2157@outlook.office365.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrei Vagin <avagin@virtuozzo.com>
Cc: alexander.h.duyck@intel.com, willemdebruijn.kernel@gmail.com, "Nambiar,
	Amritha" <amritha.nambiar@intel.com>, netdev@vger.kernel.org, tom@herbertland.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, edumazet@google.com, rostedt@goodmis.org, hannes@stressinduktion.org, sridhar.samudrala@intel.com, tom@quantonium.net, davem@davemloft.net, gaowanlong@cn.fujitsu.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 03, 2018 at 12:06:51PM -0700, Andrei Vagin wrote:
> On Fri, Aug 03, 2018 at 12:08:05AM +0300, Michael S. Tsirkin wrote:
> > On Thu, Aug 02, 2018 at 02:04:12PM -0700, Nambiar, Amritha wrote:
> > > On 8/1/2018 5:11 PM, Andrei Vagin wrote:
> > > > On Tue, Jul 10, 2018 at 07:28:49PM -0700, Nambiar, Amritha wrote:
> > > >> With this patch series, I introduced static_key for XPS maps
> > > >> (xps_needed), so static_key_slow_inc() is used to switch branches. The
> > > >> definition of static_key_slow_inc() has cpus_read_lock in place. In the
> > > >> virtio_net driver, XPS queues are initialized after setting the
> > > >> queue:cpu affinity in virtnet_set_affinity() which is already protected
> > > >> within cpus_read_lock. Hence, the warning here trying to acquire
> > > >> cpus_read_lock when it is already held.
> > > >>
> > > >> A quick fix for this would be to just extract netif_set_xps_queue() out
> > > >> of the lock by simply wrapping it with another put/get_online_cpus
> > > >> (unlock right before and hold lock right after).
> > > > 
> > > > virtnet_set_affinity() is called from virtnet_cpu_online(), which is
> > > > called under cpus_read_lock too.
> > > > 
> > > > It looks like now we can't call netif_set_xps_queue() from cpu hotplug
> > > > callbacks.
> > > > 
> > > > I can suggest a very straightforward fix for this problem. The patch is
> > > > attached.
> > > > 
> > > 
> > > Thanks for looking into this. I was thinking of fixing this in the
> > > virtio_net driver by moving the XPS initialization (and have a new
> > > get_affinity utility) in the ndo_open (so it is together with other tx
> > > preparation) instead of probe. Your patch solves this in general for
> > > setting up cpu hotplug callbacks which is under cpus_read_lock.
> > 
> > 
> > I like this too. Could you repost in a standard way
> > (inline, with your signoff etc) so we can ack this for
> > net-next?
> 
> When I was testing this patch, I got the following kasan warning. Michael,
> could you take a look at it. Maybe you will understand what was going wrong there.
> 
> https://api.travis-ci.org/v3/job/410701353/log.txt
> 
> [    7.275033] ==================================================================
> [    7.275226] BUG: KASAN: slab-out-of-bounds in virtnet_poll+0xaa1/0xd00
> [    7.275359] Read of size 8 at addr ffff8801d444a000 by task ip/370
> [    7.275488] 
> [    7.275610] CPU: 1 PID: 370 Comm: ip Not tainted 4.18.0-rc6+ #1
> [    7.275613] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [    7.275616] Call Trace:
> [    7.275621]  <IRQ>
> [    7.275630]  dump_stack+0x71/0xab
> [    7.275640]  print_address_description+0x6a/0x270
> [    7.275648]  kasan_report+0x258/0x380
> [    7.275653]  ? virtnet_poll+0xaa1/0xd00
> [    7.275661]  virtnet_poll+0xaa1/0xd00
> [    7.275680]  ? receive_buf+0x5920/0x5920
> [    7.275689]  ? do_raw_spin_unlock+0x54/0x220
> [    7.275699]  ? find_held_lock+0x32/0x1c0
> [    7.275710]  ? rcu_process_callbacks+0xa60/0xd20
> [    7.275736]  net_rx_action+0x2ee/0xad0
> [    7.275748]  ? rcu_note_context_switch+0x320/0x320
> [    7.275754]  ? napi_complete_done+0x300/0x300
> [    7.275763]  ? native_apic_msr_write+0x27/0x30
> [    7.275768]  ? lapic_next_event+0x5b/0x90
> [    7.275775]  ? clockevents_program_event+0x21d/0x2f0
> [    7.275791]  __do_softirq+0x19a/0x623
> [    7.275807]  do_softirq_own_stack+0x2a/0x40
> [    7.275811]  </IRQ>
> [    7.275818]  do_softirq.part.18+0x6a/0x80
> [    7.275825]  __local_bh_enable_ip+0x49/0x50
> [    7.275829]  virtnet_open+0x129/0x440
> [    7.275841]  __dev_open+0x189/0x2c0
> [    7.275848]  ? dev_set_rx_mode+0x30/0x30
> [    7.275857]  ? do_raw_spin_unlock+0x54/0x220
> [    7.275866]  __dev_change_flags+0x3a9/0x4f0
> [    7.275873]  ? dev_set_allmulti+0x10/0x10
> [    7.275889]  dev_change_flags+0x7a/0x150
> [    7.275900]  do_setlink+0x9fe/0x2e40
> [    7.275910]  ? deref_stack_reg+0xad/0xe0
> [    7.275917]  ? __read_once_size_nocheck.constprop.6+0x10/0x10
> [    7.275922]  ? find_held_lock+0x32/0x1c0
> [    7.275929]  ? rtnetlink_put_metrics+0x460/0x460
> [    7.275935]  ? virtqueue_add_sgs+0x9e2/0xde0
> [    7.275953]  ? virtscsi_add_cmd+0x454/0x780
> [    7.275964]  ? find_held_lock+0x32/0x1c0
> [    7.275973]  ? deref_stack_reg+0xad/0xe0
> [    7.275979]  ? __read_once_size_nocheck.constprop.6+0x10/0x10
> [    7.275985]  ? lock_downgrade+0x5e0/0x5e0
> [    7.275993]  ? memset+0x1f/0x40
> [    7.276008]  ? nla_parse+0x33/0x290
> [    7.276016]  rtnl_newlink+0x954/0x1120
> [    7.276030]  ? rtnl_link_unregister+0x250/0x250
> [    7.276044]  ? is_bpf_text_address+0x5/0x60
> [    7.276054]  ? lock_downgrade+0x5e0/0x5e0
> [    7.276057]  ? lock_acquire+0x10b/0x2a0
> [    7.276072]  ? deref_stack_reg+0xad/0xe0
> [    7.276078]  ? __read_once_size_nocheck.constprop.6+0x10/0x10
> [    7.276085]  ? __kernel_text_address+0xe/0x30
> [    7.276090]  ? unwind_get_return_address+0x5f/0xa0
> [    7.276103]  ? find_held_lock+0x32/0x1c0
> [    7.276110]  ? is_bpf_text_address+0x5/0x60
> [    7.276124]  ? deref_stack_reg+0xad/0xe0
> [    7.276131]  ? __read_once_size_nocheck.constprop.6+0x10/0x10
> [    7.276136]  ? depot_save_stack+0x2d9/0x460
> [    7.276142]  ? deref_stack_reg+0xad/0xe0
> [    7.276156]  ? find_held_lock+0x32/0x1c0
> [    7.276164]  ? is_bpf_text_address+0x5/0x60
> [    7.276170]  ? __lock_acquire.isra.29+0xe8/0x1bb0
> [    7.276212]  ? rtnetlink_rcv_msg+0x5d6/0x930
> [    7.276222]  ? lock_downgrade+0x5e0/0x5e0
> [    7.276226]  ? lock_acquire+0x10b/0x2a0
> [    7.276240]  rtnetlink_rcv_msg+0x69e/0x930
> [    7.276249]  ? rtnl_calcit.isra.31+0x2f0/0x2f0
> [    7.276255]  ? __lock_acquire.isra.29+0xe8/0x1bb0
> [    7.276265]  ? netlink_deliver_tap+0x8d/0x8e0
> [    7.276276]  netlink_rcv_skb+0x127/0x350
> [    7.276281]  ? rtnl_calcit.isra.31+0x2f0/0x2f0
> [    7.276289]  ? netlink_ack+0x970/0x970
> [    7.276299]  ? __alloc_skb+0xc2/0x520
> [    7.276311]  netlink_unicast+0x40f/0x5d0
> [    7.276320]  ? netlink_attachskb+0x580/0x580
> [    7.276325]  ? _copy_from_iter_full+0x157/0x6f0
> [    7.276331]  ? import_iovec+0x90/0x390
> [    7.276338]  ? get_page_from_freelist+0x1e89/0x3e30
> [    7.276347]  ? apparmor_socket_sock_rcv_skb+0x10/0x10
> [    7.276357]  netlink_sendmsg+0x65e/0xb00
> [    7.276367]  ? netlink_unicast+0x5d0/0x5d0
> [    7.276373]  ? copy_msghdr_from_user+0x206/0x340
> [    7.276388]  ? netlink_unicast+0x5d0/0x5d0
> [    7.276394]  sock_sendmsg+0xb3/0xf0
> [    7.276401]  ___sys_sendmsg+0x604/0x8b0
> [    7.276410]  ? copy_msghdr_from_user+0x340/0x340
> [    7.276416]  ? find_held_lock+0x32/0x1c0
> [    7.276424]  ? __handle_mm_fault+0xc85/0x3140
> [    7.276433]  ? lock_downgrade+0x5e0/0x5e0
> [    7.276439]  ? mem_cgroup_commit_charge+0xb4/0xf80
> [    7.276453]  ? _raw_spin_unlock+0x24/0x30
> [    7.276458]  ? __handle_mm_fault+0xc85/0x3140
> [    7.276467]  ? __pmd_alloc+0x430/0x430
> [    7.276473]  ? find_held_lock+0x32/0x1c0
> [    7.276485]  ? __fget_light+0x55/0x1f0
> [    7.276497]  ? __sys_sendmsg+0xd2/0x170
> [    7.276502]  __sys_sendmsg+0xd2/0x170
> [    7.276508]  ? __ia32_sys_shutdown+0x70/0x70
> [    7.276516]  ? handle_mm_fault+0x1f9/0x6a0
> [    7.276528]  ? up_read+0x1c/0x110
> [    7.276534]  ? __do_page_fault+0x4a6/0xa80
> [    7.276554]  do_syscall_64+0xa0/0x280
> [    7.276558]  ? prepare_exit_to_usermode+0x88/0x130
> [    7.276566]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    7.276572] RIP: 0033:0x7ffbe9a2f160
> [    7.276574] Code: c3 48 8b 05 2a 2d 2c 00 f7 db 64 89 18 48 83 cb ff eb dd 0f 1f 80 00 00 00 00 83 3d 1d 8f 2c 00 00 75 10 b8 2e 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 00 00 48 89 04 24 
> [    7.276728] RSP: 002b:00007ffc5a2d6108 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [    7.276735] RAX: ffffffffffffffda RBX: 00007ffc5a2da220 RCX: 00007ffbe9a2f160
> [    7.276738] RDX: 0000000000000000 RSI: 00007ffc5a2d6150 RDI: 0000000000000003
> [    7.276741] RBP: 00007ffc5a2d6150 R08: 0000000000000000 R09: 0000000000000003
> [    7.276744] R10: 00007ffc5a2d5ed0 R11: 0000000000000246 R12: 000000005b6177de
> [    7.276748] R13: 0000000000000000 R14: 00000000006473a0 R15: 00007ffc5a2da918
> [    7.276763] 
> [    7.276895] Allocated by task 1:
> [    7.277026]  kasan_kmalloc+0xa0/0xd0
> [    7.277030]  __kmalloc+0x13a/0x250
> [    7.277034]  init_vqs+0xd0/0x11c0
> [    7.277038]  virtnet_probe+0xb99/0x1ad0
> [    7.277045]  virtio_dev_probe+0x3fc/0x890
> [    7.277052]  driver_probe_device+0x6c4/0xcc0
> [    7.277056]  __driver_attach+0x232/0x2c0
> [    7.277060]  bus_for_each_dev+0x118/0x1a0
> [    7.277064]  bus_add_driver+0x390/0x6e0
> [    7.277068]  driver_register+0x18e/0x400
> [    7.277076]  virtio_net_driver_init+0x6d/0x90
> [    7.277080]  do_one_initcall+0xa8/0x348
> [    7.277085]  kernel_init_freeable+0x42d/0x4c8
> [    7.277090]  kernel_init+0xf/0x130
> [    7.277095]  ret_from_fork+0x35/0x40
> [    7.277097] 
> [    7.277223] Freed by task 0:
> [    7.277347] (stack is not available)
> [    7.277473] 
> [    7.277596] The buggy address belongs to the object at ffff8801d4449100
> [    7.277596]  which belongs to the cache kmalloc-4096 of size 4096
> [    7.277769] The buggy address is located 3840 bytes inside of
> [    7.277769]  4096-byte region [ffff8801d4449100, ffff8801d444a100)
> [    7.277932] The buggy address belongs to the page:
> [    7.278066] page:ffffea0007511200 count:1 mapcount:0 mapping:ffff8801db002600 index:0x0 compound_mapcount: 0
> [    7.278230] flags: 0x17fff8000008100(slab|head)
> [    7.278363] raw: 017fff8000008100 dead000000000100 dead000000000200 ffff8801db002600
> [    7.278516] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
> [    7.278664] page dumped because: kasan: bad access detected
> [    7.278790] 
> [    7.278904] Memory state around the buggy address:
> [    7.279031]  ffff8801d4449f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    7.279175]  ffff8801d4449f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    7.279323] >ffff8801d444a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    7.279468]                    ^
> [    7.279584]  ffff8801d444a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    7.279729]  ffff8801d444a100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [    7.279870] ==================================================================
> [    7.280011] Disabling lock debugging due to kernel taint
> [    7.632219] random: mktemp: uninitialized urandom read (6 bytes read)
> [    8.052850] random: mktemp: uninitialized urandom read (6 bytes read)
> [    8.335209] random: cloud-init: uninitialized urandom read (32 bytes read)
> [    8.796331] random: cloud-init: uninitialized urandom read (32 bytes read)
> [    9.162551] random: mktemp: uninitialized urandom read (12 bytes read)
> [    9.384504] random: ssh-keygen: uninitialized urandom read (32 bytes read)
> [    9.839586] init: failsafe main process (724) killed by TERM signal
> [   14.865443] postgres (1245): /proc/1245/oom_adj is deprecated, please use /proc/1245/oom_score_adj instead.
> [   17.213418] random: crng init done
> [   17.580892] init: plymouth-upstart-bridge main process ended, respawning

I suspect an off by one somewhere. I'm looking at the patch
and I don't see it but these things are hard to spot sometimes ...

> > 
> > > >> But this may not a
> > > >> clean solution. It'd help if I can get suggestions on what would be a
> > > >> clean option to fix this without extensively changing the code in
> > > >> virtio_net. Is it mandatory to protect the affinitization with
> > > >> read_lock? I don't see similar lock in other drivers while setting the
> > > >> affinity. I understand this warning should go away, but isn't it safe to
> > > >> have multiple readers.
> > > >>
> > > >>> On Fri, Jun 29, 2018 at 09:27:07PM -0700, Amritha Nambiar wrote:
