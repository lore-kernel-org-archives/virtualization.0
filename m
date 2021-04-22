Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F7C433ED
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 11:21:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF246144A
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 11:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF246144A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B8D3401AD;
	Thu, 22 Apr 2021 11:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDhQe2xP5bXX; Thu, 22 Apr 2021 11:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C35D340112;
	Thu, 22 Apr 2021 11:21:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93F21C000E;
	Thu, 22 Apr 2021 11:21:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A32F2C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 11:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A32240173
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 11:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57e8gYTkORuv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 11:21:04 +0000 (UTC)
X-Greylist: delayed 00:07:20 by SQLgrey-1.8.0
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2FD540148
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 11:21:04 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 01D7CB7B;
 Thu, 22 Apr 2021 07:13:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 22 Apr 2021 07:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IJN37N
 EIbSrkyUHwNV2n5pU1WWCFWamQCT3x2Sx6yCY=; b=Z/3r9TawZmzelWOHTm06K/
 xAPTN7vyW5aNY3MCRiTyfQpEjH6tAVd+320DKhPlzS2r15xbqaFPJVz46m5J7zkQ
 wORjGXi9x5OWKo+HpPt87fI7cEGED2OvAjwCb1mV+nXa8ILo6q5+HKDWUq3npWnH
 gwOECj7n/oAMKC95dPaocbDlmUIFEXB6ipwIwj7eaLHW87JXs/Sarn7LV0YNHSaR
 WZ8LiRXEHEKOi0UagoY/WZgjFNK2hEce0AvSaslZ78aAp4le0O0kqz/U5ekRm0Oo
 BljZZKNV9nKiwvhiu0eRxquU5G4td4s8VGFQC7csWXgVzIdddVtUhCtiJG8FR0yg
 ==
X-ME-Sender: <xms:ZFqBYCBTZUtX8XnucRDOg5239Y_NZdTzQCjfE1jiTAgyNg6dUP-IhQ>
 <xme:ZFqBYD8cJTaSCc4mnjEVWO_Kvw9wk6FEGsgQ3NdYmtCR--zm1ayg_DHvaXOLjn19l
 sAYJm_ecv5xvMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddutddgfeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefkughoucfu
 tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
 gvrhhnpeetteekheejgeeufeekgfeggefhhffgtdehffdtffehieeluedvtedvveejgeef
 ueenucffohhmrghinhepqhgvmhhurdhorhhgnecukfhppeekgedrvddvledrudehfedrud
 ekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehi
 ughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:ZFqBYC-pv0V8JMxylDRSIGUzcfouuBiVR4ErAJ9M8YnfhVTtshkFNw>
 <xmx:ZFqBYKfGuYaCS8s8CmgJL94PHUj1wmRwuU9SFCtEi0jNgJKVAwTX6g>
 <xmx:ZFqBYLEa6aOE3vG6vOQZTD0jygOBHL7qaOQzzQBcHDvg6tkbByaO8Q>
 <xmx:ZVqBYKlwtrPVB6qNLkn0roxJS1k9ArTI8NZES1xoXKzQLAluWC3WuA>
Received: from localhost (igld-84-229-153-187.inter.net.il [84.229.153.187])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1C01D108006B;
 Thu, 22 Apr 2021 07:13:39 -0400 (EDT)
Date: Thu, 22 Apr 2021 14:13:36 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
Message-ID: <YIFaYBAryfCEBhln@shredder.lan>
References: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Apr 16, 2021 at 05:16:15PM +0800, Xuan Zhuo wrote:
> In page_to_skb(), if we have enough tailroom to save skb_shared_info, we
> can use build_skb to create skb directly. No need to alloc for
> additional space. And it can save a 'frags slot', which is very friendly
> to GRO.
> 
> Here, if the payload of the received package is too small (less than
> GOOD_COPY_LEN), we still choose to copy it directly to the space got by
> napi_alloc_skb. So we can reuse these pages.
> 
> Testing Machine:
>     The four queues of the network card are bound to the cpu1.
> 
> Test command:
>     for ((i=0;i<5;++i)); do sockperf tp --ip 192.168.122.64 -m 1000 -t 150& done
> 
> The size of the udp package is 1000, so in the case of this patch, there
> will always be enough tailroom to use build_skb. The sent udp packet
> will be discarded because there is no port to receive it. The irqsoftd
> of the machine is 100%, we observe the received quantity displayed by
> sar -n DEV 1:
> 
> no build_skb:  956864.00 rxpck/s
> build_skb:    1158465.00 rxpck/s
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>

We have VMs that use virtio_net for their management interface. After
this patch was applied we started seeing crashes when these VMs access
an NFS file system. I thought Eric's patches will fix it, but problem
persists even with his two patches:

af39c8f72301 virtio-net: fix use-after-free in page_to_skb()
f5d7872a8b8a virtio-net: restrict build_skb() use to some arches

Reverting all three patches makes the problem go away. A KASAN enabled
kernel emits the following (decoded) stack trace.

[1]
BUG: KASAN: use-after-free in skb_gro_receive (net/core/skbuff.c:4260)
Write of size 16 at addr ffff88811619fffc by task kworker/u9:0/534
CPU: 2 PID: 534 Comm: kworker/u9:0 Not tainted 5.12.0-rc7-custom-16372-gb150be05b806 #3382
Hardware name: QEMU MSN2700, BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: xprtiod xs_stream_data_receive_workfn [sunrpc]
Call Trace:
 <IRQ>
dump_stack (lib/dump_stack.c:122)
print_address_description.constprop.0 (mm/kasan/report.c:233)
kasan_report.cold (mm/kasan/report.c:400 mm/kasan/report.c:416)
skb_gro_receive (net/core/skbuff.c:4260)
tcp_gro_receive (net/ipv4/tcp_offload.c:266 (discriminator 1))
tcp4_gro_receive (net/ipv4/tcp_offload.c:316)
inet_gro_receive (net/ipv4/af_inet.c:1545 (discriminator 2))
dev_gro_receive (net/core/dev.c:6075)
napi_gro_receive (net/core/dev.c:6168 net/core/dev.c:6198)
receive_buf (drivers/net/virtio_net.c:1151) virtio_net
virtnet_poll (drivers/net/virtio_net.c:1415 drivers/net/virtio_net.c:1519) virtio_net
__napi_poll (net/core/dev.c:6964)
net_rx_action (net/core/dev.c:7033 net/core/dev.c:7118)
__do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:346)
irq_exit_rcu (kernel/softirq.c:221 kernel/softirq.c:422 kernel/softirq.c:434)
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
</IRQ>
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:623)
RIP: 0010:read_hpet (arch/x86/kernel/hpet.c:823 arch/x86/kernel/hpet.c:793)
Code: 90 48 8b 05 a5 ef 6f 02 48 89 44 24 68 48 c1 e8 20 89 c2 3b 44 24 4c 74 d1 89 d0 e9 c7 fe ff ff e8 38 90 35 00 fb 8b 44 24 6c <e9> b8 fe ff ff 8b 54 24 6
All code
========
   0:	90                   	nop
   1:	48 8b 05 a5 ef 6f 02 	mov    0x26fefa5(%rip),%rax        # 0x26fefad
   8:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
   d:	48 c1 e8 20          	shr    $0x20,%rax
  11:	89 c2                	mov    %eax,%edx
  13:	3b 44 24 4c          	cmp    0x4c(%rsp),%eax
  17:	74 d1                	je     0xffffffffffffffea
  19:	89 d0                	mov    %edx,%eax
  1b:	e9 c7 fe ff ff       	jmpq   0xfffffffffffffee7
  20:	e8 38 90 35 00       	callq  0x35905d
  25:	fb                   	sti
  26:	8b 44 24 6c          	mov    0x6c(%rsp),%eax
  2a:*	e9 b8 fe ff ff       	jmpq   0xfffffffffffffee7		<-- trapping instruction
  2f:	8b 54 24 06          	mov    0x6(%rsp),%edx

Code starting with the faulting instruction
===========================================
   0:	e9 b8 fe ff ff       	jmpq   0xfffffffffffffebd
   5:	8b 54 24 06          	mov    0x6(%rsp),%edx
c 89 d0 e9 ad fe ff ff e8 fe 8c 35 00 e9
RSP: 0018:ffffc900015a7a68 EFLAGS: 00000206
RAX: 000000004ad84e9a RBX: 1ffff920002b4f4e RCX: ffffffff888897f7
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000200 R08: 0000000000000001 R09: ffffffff8c645737
R10: fffffbfff18c8ae6 R11: 0000000000000001 R12: dffffc0000000000
R13: 00000016f23c724e R14: ffff888154e24000 R15: ffff88810c2b2c00
ktime_get (kernel/time/timekeeping.c:290 (discriminator 4) kernel/time/timekeeping.c:386 (discriminator 4) kernel/time/timekeeping.c:829 (discriminator 4))
xprt_lookup_rqst (net/sunrpc/xprt.c:1049) sunrpc
xs_read_stream.constprop.0 (net/sunrpc/xprtsock.c:595 net/sunrpc/xprtsock.c:646) sunrpc
xs_stream_data_receive_workfn (net/sunrpc/xprtsock.c:712 net/sunrpc/xprtsock.c:732) sunrpc
process_one_work (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2280)
worker_thread (./include/linux/list.h:282 kernel/workqueue.c:2422)
kthread (kernel/kthread.c:292)
ret_from_fork (arch/x86/entry/entry_64.S:300)

The buggy address belongs to the page:
page:000000000b3e5dba refcount:21 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x116198
head:000000000b3e5dba order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010000(head)
raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000015ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811619ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88811619ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881161a0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8881161a0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881161a0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
