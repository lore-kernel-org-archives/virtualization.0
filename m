Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEAEC433FE
	for <virtualization@archiver.kernel.org>; Sat, 23 Apr 2022 14:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A0B7400F8;
	Sat, 23 Apr 2022 14:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYNm5jrH6gE0; Sat, 23 Apr 2022 14:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EA14403F7;
	Sat, 23 Apr 2022 14:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D90C0032;
	Sat, 23 Apr 2022 14:17:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B5BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 14:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 681C583E2C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 14:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=blackwall-org.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E89S05mp04x3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 14:16:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06C4D83E28
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 14:16:57 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id z99so13597567ede.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XFwz0bpLCbt68VLrSr6cPenoRJF2gOgFSRXGYxsauwA=;
 b=C8GM69g+tTZB6Z1zsr+0znsHA2GogrVOPHsPzgJm7lsgAPgDQhIgXGxQgE5+Afqr8V
 9cUx6I9d1hp5R8HQ++laguu0fdE8aR+ItTSZxLREd7jVOU4QWa4lz7iSJrwiVwqkVfm4
 Tsc1SfQdNJdlfFJ+SEm/TNiSrCOjH44Xtff11gtfxkk9QlSvhQmFCEbxjbnWOPkNWToF
 pBiVT8RaSeB/0aWZGTYBRhskRr805w7OGEjz7wHoCiVVtlJRF3LBw9nQ6XnyLLvAlGwE
 4ZCg6f0yqCv+6oKU7lyMeVhr+HfUwvHEGkbjTO1BXMjZdKKWLmIQ0mM/rZVolupjL2TK
 EdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XFwz0bpLCbt68VLrSr6cPenoRJF2gOgFSRXGYxsauwA=;
 b=WrItWMo7jqpilZgRyUdT/dswMtYQAqU+WrE1KvcPDRzVo7ZwzGErggqESRH7GlcIhN
 cdwhRPalDIZi2T0JNkaOG3aOaYToojIx9VQyIv0JCEjCQ5tCFnV/5DoaIFBLlivuhCsP
 G+ewwxrVPHMVpG+0YBD3ZOzjDTAwSEzWCDIrrXeQbwh7mNbFHzN1n10INsIjvRDJzgif
 kDecQChZMezneIaDsBLwWAquc1JHSXaiW5IQyJMm/PwI7VitwC9OMMqVsBF3DfH86/Qv
 I2sXXB7Rr3Y4syj9q3RbBcfq8n4MXlVv2hR93VZcDXlsuQx8mgzb59uuHZ4e4MHozAxH
 WQpA==
X-Gm-Message-State: AOAM531flVs6TtnUBhzFhbvIkS7ZOLbHDM75AJMQ7PD92Hjg6yFgnYmH
 TOAafHv9OutGCQK8HpB7i1I8SQ==
X-Google-Smtp-Source: ABdhPJwC9pn3UuKK+CI2ZlnEgnKDVBdo9bOUtR/+173PHO6pTROu5adMOAnK1nRn/iIjYHVs5CuoHw==
X-Received: by 2002:a05:6402:2995:b0:425:d3a1:28aa with SMTP id
 eq21-20020a056402299500b00425d3a128aamr3259068edb.247.1650723415895; 
 Sat, 23 Apr 2022 07:16:55 -0700 (PDT)
Received: from [192.168.0.111] (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170906297100b006e49a9535f3sm1717235ejd.114.2022.04.23.07.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Apr 2022 07:16:55 -0700 (PDT)
Message-ID: <8d511a16-8d69-82b1-48a1-24de3a592aef@blackwall.org>
Date: Sat, 23 Apr 2022 17:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH net] virtio_net: fix wrong buf address calculation when
 using xdp
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220423112612.2292774-1-razor@blackwall.org>
 <1650720683.8168066-1-xuanzhuo@linux.alibaba.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1650720683.8168066-1-xuanzhuo@linux.alibaba.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, davem@davemloft.net
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

On 23/04/2022 16:31, Xuan Zhuo wrote:
> On Sat, 23 Apr 2022 14:26:12 +0300, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> We received a report[1] of kernel crashes when Cilium is used in XDP
>> mode with virtio_net after updating to newer kernels. After
>> investigating the reason it turned out that when using mergeable bufs
>> with an XDP program which adjusts xdp.data or xdp.data_meta page_to_buf()
>> calculates the build_skb address wrong because the offset can become less
>> than the headroom so it gets the address of the previous page (-X bytes
>> depending on how lower offset is):
>>  page_to_skb: page addr ffff9eb2923e2000 buf ffff9eb2923e1ffc offset 252 headroom 256
>>
>> This is a pr_err() I added in the beginning of page_to_skb which clearly
>> shows offset that is less than headroom by adding 4 bytes of metadata
>> via an xdp prog. The calculations done are:
>>  receive_mergeable():
>>  headroom = VIRTIO_XDP_HEADROOM; // VIRTIO_XDP_HEADROOM == 256 bytes
>>  offset = xdp.data - page_address(xdp_page) -
>>           vi->hdr_len - metasize;
>>
>>  page_to_skb():
>>  p = page_address(page) + offset;
>>  ...
>>  buf = p - headroom;
>>
>> Now buf goes -4 bytes from the page's starting address as can be seen
>> above which is set as skb->head and skb->data by build_skb later. Depending
>> on what's done with the skb (when it's freed most often) we get all kinds
>> of corruptions and BUG_ON() triggers in mm[2]. The story of the faulty
>> commit is interesting because the patch was sent and applied twice (it
>> seems the first one got lost during merge back in 5.13 window). The
>> first version of the patch that was applied as:
>>  commit 7bf64460e3b2 ("virtio-net: get build_skb() buf by data ptr")
>> was actually correct because it calculated the page starting address
>> without relying on offset or headroom, but then the second version that
>> was applied as:
>>  commit 8fb7da9e9907 ("virtio_net: get build_skb() buf by data ptr")
>> was wrong and added the above calculation.
>> An example xdp prog[3] is below.
>>
>> [1] https://github.com/cilium/cilium/issues/19453
>>
>> [2] Two of the many traces:
>>  [   40.437400] BUG: Bad page state in process swapper/0  pfn:14940
>>  [   40.916726] BUG: Bad page state in process systemd-resolve  pfn:053b7
>>  [   41.300891] kernel BUG at include/linux/mm.h:720!
>>  [   41.301801] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>  [   41.302784] CPU: 1 PID: 1181 Comm: kubelet Kdump: loaded Tainted: G    B   W         5.18.0-rc1+ #37
>>  [   41.304458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
>>  [   41.306018] RIP: 0010:page_frag_free+0x79/0xe0
>>  [   41.306836] Code: 00 00 75 ea 48 8b 07 a9 00 00 01 00 74 e0 48 8b 47 48 48 8d 50 ff a8 01 48 0f 45 fa eb d0 48 c7 c6 18 b8 30 a6 e8 d7 f8 fc ff <0f> 0b 48 8d 78 ff eb bc 48 8b 07 a9 00 00 01 00 74 3a 66 90 0f b6
>>  [   41.310235] RSP: 0018:ffffac05c2a6bc78 EFLAGS: 00010292
>>  [   41.311201] RAX: 000000000000003e RBX: 0000000000000000 RCX: 0000000000000000
>>  [   41.312502] RDX: 0000000000000001 RSI: ffffffffa6423004 RDI: 00000000ffffffff
>>  [   41.313794] RBP: ffff993c98823600 R08: 0000000000000000 R09: 00000000ffffdfff
>>  [   41.315089] R10: ffffac05c2a6ba68 R11: ffffffffa698ca28 R12: ffff993c98823600
>>  [   41.316398] R13: ffff993c86311ebc R14: 0000000000000000 R15: 000000000000005c
>>  [   41.317700] FS:  00007fe13fc56740(0000) GS:ffff993cdd900000(0000) knlGS:0000000000000000
>>  [   41.319150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  [   41.320152] CR2: 000000c00008a000 CR3: 0000000014908000 CR4: 0000000000350ee0
>>  [   41.321387] Call Trace:
>>  [   41.321819]  <TASK>
>>  [   41.322193]  skb_release_data+0x13f/0x1c0
>>  [   41.322902]  __kfree_skb+0x20/0x30
>>  [   41.343870]  tcp_recvmsg_locked+0x671/0x880
>>  [   41.363764]  tcp_recvmsg+0x5e/0x1c0
>>  [   41.384102]  inet_recvmsg+0x42/0x100
>>  [   41.406783]  ? sock_recvmsg+0x1d/0x70
>>  [   41.428201]  sock_read_iter+0x84/0xd0
>>  [   41.445592]  ? 0xffffffffa3000000
>>  [   41.462442]  new_sync_read+0x148/0x160
>>  [   41.479314]  ? 0xffffffffa3000000
>>  [   41.496937]  vfs_read+0x138/0x190
>>  [   41.517198]  ksys_read+0x87/0xc0
>>  [   41.535336]  do_syscall_64+0x3b/0x90
>>  [   41.551637]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>  [   41.568050] RIP: 0033:0x48765b
>>  [   41.583955] Code: e8 4a 35 fe ff eb 88 cc cc cc cc cc cc cc cc e8 fb 7a fe ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
>>  [   41.632818] RSP: 002b:000000c000a2f5b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000000
>>  [   41.664588] RAX: ffffffffffffffda RBX: 000000c000062000 RCX: 000000000048765b
>>  [   41.681205] RDX: 0000000000005e54 RSI: 000000c000e66000 RDI: 0000000000000016
>>  [   41.697164] RBP: 000000c000a2f608 R08: 0000000000000001 R09: 00000000000001b4
>>  [   41.713034] R10: 00000000000000b6 R11: 0000000000000212 R12: 00000000000000e9
>>  [   41.728755] R13: 0000000000000001 R14: 000000c000a92000 R15: ffffffffffffffff
>>  [   41.744254]  </TASK>
>>  [   41.758585] Modules linked in: br_netfilter bridge veth netconsole virtio_net
>>
>>  and
>>
>>  [   33.524802] BUG: Bad page state in process systemd-network  pfn:11e60
>>  [   33.528617] page ffffe05dc0147b00 ffffe05dc04e7a00 ffff8ae9851ec000 (1) len 82 offset 252 metasize 4 hroom 0 hdr_len 12 data ffff8ae9851ec10c data_meta ffff8ae9851ec108 data_end ffff8ae9851ec14e
>>  [   33.529764] page:000000003792b5ba refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x11e60
>>  [   33.532463] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
>>  [   33.532468] raw: 000fffffc0000000 0000000000000000 dead000000000122 0000000000000000
>>  [   33.532470] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
>>  [   33.532471] page dumped because: nonzero mapcount
>>  [   33.532472] Modules linked in: br_netfilter bridge veth netconsole virtio_net
>>  [   33.532479] CPU: 0 PID: 791 Comm: systemd-network Kdump: loaded Not tainted 5.18.0-rc1+ #37
>>  [   33.532482] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
>>  [   33.532484] Call Trace:
>>  [   33.532496]  <TASK>
>>  [   33.532500]  dump_stack_lvl+0x45/0x5a
>>  [   33.532506]  bad_page.cold+0x63/0x94
>>  [   33.532510]  free_pcp_prepare+0x290/0x420
>>  [   33.532515]  free_unref_page+0x1b/0x100
>>  [   33.532518]  skb_release_data+0x13f/0x1c0
>>  [   33.532524]  kfree_skb_reason+0x3e/0xc0
>>  [   33.532527]  ip6_mc_input+0x23c/0x2b0
>>  [   33.532531]  ip6_sublist_rcv_finish+0x83/0x90
>>  [   33.532534]  ip6_sublist_rcv+0x22b/0x2b0
>>
>> [3] XDP program to reproduce(xdp_pass.c):
>>  #include <linux/bpf.h>
>>  #include <bpf/bpf_helpers.h>
>>
>>  SEC("xdp_pass")
>>  int xdp_pkt_pass(struct xdp_md *ctx)
>>  {
>>           bpf_xdp_adjust_head(ctx, -(int)32);
>>           return XDP_PASS;
>>  }
>>
>>  char _license[] SEC("license") = "GPL";
>>
>>  compile: clang -O2 -g -Wall -target bpf -c xdp_pass.c -o xdp_pass.o
>>  load on virtio_net: ip link set enp1s0 xdpdrv obj xdp_pass.o sec xdp_pass
>>
>> CC: stable@vger.kernel.org
>> CC: Jason Wang <jasowang@redhat.com>
>> CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> CC: Daniel Borkmann <daniel@iogearbox.net>
>> CC: "Michael S. Tsirkin" <mst@redhat.com>
>> CC: virtualization@lists.linux-foundation.org
>> Fixes: 8fb7da9e9907 ("virtio_net: get build_skb() buf by data ptr")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  drivers/net/virtio_net.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 87838cbe38cf..0687dd88e97f 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -434,9 +434,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>  	 * Buffers with headroom use PAGE_SIZE as alloc size, see
>>  	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
>>  	 */
>> -	truesize = headroom ? PAGE_SIZE : truesize;
>> +	if (headroom) {
>> +		truesize = PAGE_SIZE;
>> +		buf = (char *)((unsigned long)p & PAGE_MASK);
> 
> The reason for not doing this is that buf and p may not be on the same page, and
> buf is probably not page-aligned.
> 
> The implementation of virtio-net merge is add_recvbuf_mergeable(), which
> allocates a large block of memory at one time, and allocates from it each time.
> Although in xdp mode, each allocation is page_size, it does not guarantee that
> each allocation is page-aligned .
> 
> The problem here is that the value of headroom is wrong, the package is
> structured like this:
> 
> from device    | headroom          | virtio-net hdr | data |
> after xdp      | headroom  |  virtio-net hdr | meta | data |

You're free to push data back (not necessarily through meta).
You don't have virtio-net hdr for the xdp case (hdr_valid is false there).

> 
> The page_address(page) + offset we pass to page_to_skb() points to the
> virtio-net hdr.
> 
> So I think it might be better to change it this way.
> 
> Thanks.
> 
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 87838cbe38cf..086ae835ec86 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1012,7 +1012,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                 head_skb = page_to_skb(vi, rq, xdp_page, offset,
>                                                        len, PAGE_SIZE, false,
>                                                        metasize,
> -                                                      VIRTIO_XDP_HEADROOM);
> +                                                      VIRTIO_XDP_HEADROOM - metazie);
>                                 return head_skb;
>                         }
>                         break;

That patch doesn't fix it, as I said with xdp you can move both data and data_meta.
So just doing that would take care of the meta, but won't take care of moving data.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
