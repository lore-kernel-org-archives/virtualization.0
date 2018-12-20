From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
	net/core/flow_dissector.c:764 __skb_flow_dissect
Date: Thu, 20 Dec 2018 08:45:40 +0100
Message-ID: <ba519cd8-ab88-2868-f6d0-be321d8df0be__42756.2450794086$1545291839$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Michael S Tsirkin <mst@redhat.com>, netdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Folks,

I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
Maybe someone has a quick idea.

[85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
[85109.572036] Modules linked in: vhost_net vhost macvtap macvlan tap vfio_ap vfio_mdev mdev vfio_iommu_type1 vfio kvm xt_CHECKSUM ipt_MASQUERADE tun bridge stp llc xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter dm_service_time rpcrdma sunrpc rdma_ucm rdma_cm configfs iw_cm ib_cm mlx4_ib ib_uverbs ib_core pkey ghash_s390 prng aes_s390 des_s390 des_generic sha512_s390 sha1_s390 zcrypt_cex4 zcrypt rng_core eadm_sch sch_fq_codel ip_tables x_tables mlx4_en mlx4_core sha256_s390 sha_common dm_multipath scsi_
 dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod autofs4
[85109.572072] CPU: 30 PID: 197360 Comm: vhost-197330 Not tainted 4.20.0-20181213.rc6.git0.407d079170c1.300.fc29.s390x #1
[85109.572074] Hardware name: IBM 2964 NC9 712 (LPAR)
[85109.572075] Krnl PSW : 0704c00180000000 000000000092e320 (__skb_flow_dissect+0x1f0/0x1318)
[85109.572078]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[85109.572080] Krnl GPRS: 000000000000002a 0000000000000000 000003e0385bfc84 0000000000d91e30
[85109.572081]            000003e0385bfc84 0000000000000000 0000000000000000 0000000000d91e30
[85109.572083]            000003e0385bfc84 000000000000000e 0000007e3eb88100 0000007ff3561e00
[85109.572084]            0000000000000806 0000000000b4f288 000003e0385bfbb8 000003e0385bfab0
[85109.572115] Krnl Code: 000000000092e312: e310b0180002	ltg	%r1,24(%r11)
                          000000000092e318: a7740271		brc	7,92e7fa
                         #000000000092e31c: a7f40001		brc	15,92e31e
                         >000000000092e320: 91407003		tm	3(%r7),64
                          000000000092e324: a7740257		brc	7,92e7d2
                          000000000092e328: 5810f0b4		l	%r1,180(%r15)
                          000000000092e32c: e54cf0c80000	mvhi	200(%r15),0
                          000000000092e332: c01b00000008	nilf	%r1,8
[85109.572129] Call Trace:
[85109.572130] ([<0000000000000000>]           (null))
[85109.572134]  [<000003ff800c81e4>] tap_sendmsg+0x384/0x430 [tap] 
[85109.572137]  [<000003ff801acdee>] vhost_tx_batch.isra.10+0x66/0xe0 [vhost_net] 
[85109.572138]  [<000003ff801ad61c>] handle_tx_copy+0x18c/0x568 [vhost_net] 
[85109.572140]  [<000003ff801adab4>] handle_tx+0xbc/0x100 [vhost_net] 
[85109.572145]  [<000003ff8019bbe8>] vhost_worker+0xc8/0x128 [vhost] 
[85109.572148]  [<00000000001690b8>] kthread+0x140/0x160 
[85109.572152]  [<0000000000a84266>] kernel_thread_starter+0x6/0x10 
[85109.572154]  [<0000000000a84260>] kernel_thread_starter+0x0/0x10 
[85109.572155] Last Breaking-Event-Address:
[85109.572156]  [<000000000092e31c>] __skb_flow_dissect+0x1ec/0x1318
[85109.572158] ---[ end trace 97c040a6691bc000 ]---
