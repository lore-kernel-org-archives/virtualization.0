Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F621ABD0
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521704; cv=none; b=K6sdYcDJzeWp1boEw/q7Qn+VvMEeP8PCQ0yDUS1+dS7K0niqxVA8Jp2te3HVPIEi+KiDV/dK2tseR+9CZtJ4a9OhGT0Nnz7reyGu3MPoLf16b/3TRnV812yjX/kMxl8OOTnd2Z5huOALi5Oj/J7UoUg3zMzJYvy5dcsWpeko/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521704; c=relaxed/simple;
	bh=eFlK4O/ApEpvXiMbnGQqkL7zGwcgDaXwX/hfmY0HsC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXqTeEiLMgUurMVgo4j2Q5eQcRVpmjbxuICjjAQj2oM9OQdIV+upYcqgB5gamLbwk+iqIMuVHdoZE5+tXNKJR0uI97zFKk5dx0V7kmYEyIocIFoggfVWzCv4bE5v2A+ShfyEUNylJskv+42RpMe/cT+EITLV8+UbgWEl51Jq6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GORRnw+s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GORRnw+s"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c73f82dfso535792b3a.2
        for <virtualization@lists.linux.dev>; Thu, 29 May 2025 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748521702; x=1749126502; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbRXSySOkeoAFSH1xoRdqp69bz3wjXg4GCHZGd5gC70=;
        b=GORRnw+sFXD9GydA0w9HnLkl1uabOXvDZr8RKm58m+uAynGW/s5py73fXmivYBe3RV
         WI2rIw99jg0Kz4zkD5GHTdSJCVUIENbD6TplaVedOXeWMBzmMkkW7kmea8RyL1UdiN0W
         yRTXOZd9/k7+Xrpf/LKbs8x9ocbXVBChUoMewy8RU0RjNcUjhseCZl9QNGagoKAUkU3r
         xA1rH6SJAa4z6UYNfCOjIfiLCGH1ozVJrUJ2tEbfmq7mxeaRsXukC7G6TAGeCsu3Iwef
         eIfWxH97TmKFrMzuE4I5T7ReoVTVv/EhKJ16kmgOX53NRCkLCz7R/H2AiqV4afVonX7M
         CTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748521702; x=1749126502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbRXSySOkeoAFSH1xoRdqp69bz3wjXg4GCHZGd5gC70=;
        b=YfOKs89suo0VIE3pmeyOxRoBOfDt8duDZc4OnA+sQXhAez/HH92H4NXWz4CVNlRwoA
         C+cdrI4X+bGGf6gAuqUwXbiISrJ7AIABPVBUMTSJAVGxS5/Jt/0fSGYb1hIRNOQPDWpB
         pVow3Ru/aoMk+2WaRMPfIvtOcRHwv5IcjJKb/x4V/jlqPBjQeomg8DijQVDfQ8emyCJx
         TcbStgZn3kQmzIBDVX4FU4HSzGRbMcE8PD5UQ5R+25dlzqpcMgHwp0hZ4DSieytg2iqE
         /u7c+da+NqWBX4HbbJ7oJoCyPHmrEblyPdeamSOGHgTCbVWqRC/MPeauKDjeIyVXVv0W
         OSLw==
X-Forwarded-Encrypted: i=1; AJvYcCV0f0t2V/LX2HZtmhJUtMxK6DHYquPvwIsRej1iI3N4/qhQcmMTkdv0YNVRVaPjKZkTHHxEpLMUWVCi+6HopQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywe9JbDVvxHG48DxxDMOcWL69D5YtwbZBoZn5Tk8oeRpfHxGWox
	OoATw48JbhYBNDuWJ0Y7jpCQYTd9v3v8SLsM19/Pubn1giRbL8MJVisT
X-Gm-Gg: ASbGncukJ+D860bvZbZB6uT0ZHROG0pRLV44Zfo+mvZB5ifFtj40Zv0OkhtwnHQwHUX
	VGZwVmdNHtyrtNKVjIl0Re/y5XKXhLcIbxUZ9JXDJasm+mN8B5guKLnmmYE1YZfQCdkYhK5O87s
	CAPWwKI9FYFSJGNYOorcmSTxCX5xW7dlimxfY7yLLG5RWYngpXm9kHraNQk9GzaLOsfBzYLUk4q
	KIs5NTr67qJpazUG9yZSVKPuC29EBBmezh5kgI1e55TtDBtKqkx8hOunZWoDILR19rc87Crg4PF
	7YFv+O5xTBHr9f3Ma0ZYryb0OgIOpFu/F/OTGoKb0L4+1XjnXfbM1NU45sILq1sviO8o7SheYbe
	4K0gyTf+WqmFutSXxydZVgnBGcKikQQ==
X-Google-Smtp-Source: AGHT+IF9EI5HiLoMgWWyXHJIS/JBoJHldzFEQe2we+Bla5wTXSK4xuPJ45x9JQ5aUvtdEyKotaw9fQ==
X-Received: by 2002:a05:6a21:1089:b0:216:6060:971d with SMTP id adf61e73a8af0-2188c3b49bemr33306179637.37.1748521702136;
        Thu, 29 May 2025 05:28:22 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9? ([2001:ee0:4f0e:fb30:d434:b1b6:e451:f5d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm1216650b3a.75.2025.05.29.05.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 05:28:21 -0700 (PDT)
Message-ID: <d572e8b6-e25c-480e-9d05-8c7eeb396b12@gmail.com>
Date: Thu, 29 May 2025 19:28:13 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-2-minhquangbui99@gmail.com>
 <CACGkMEvAJziO3KW3Nk9+appXmR92ixcTeWY_XEZz4Qz1MwrhYA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvAJziO3KW3Nk9+appXmR92ixcTeWY_XEZz4Qz1MwrhYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 12:59, Jason Wang wrote:
> On Wed, May 28, 2025 at 12:19 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
>> does not support multi buffer but a single buffer only. This commit adds
>> support for multi mergeable receive buffer in the zerocopy XDP path by
>> utilizing XDP buffer with frags.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>>   1 file changed, 66 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..a9558650f205 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>>   #define VIRTIO_XDP_TX          BIT(0)
>>   #define VIRTIO_XDP_REDIR       BIT(1)
>>
>> +#define VIRTNET_MAX_ZC_SEGS    8
>> +
>>   /* RX packet size EWMA. The average packet size is used to determine the packet
>>    * buffer size when refilling RX rings. As the entire RX ring may be refilled
>>    * at once, the weight is chosen so that the EWMA will be insensitive to short-
>> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
>>          }
>>   }
>>
>> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
>> -                                  struct receive_queue *rq,
>> -                                  struct sk_buff *head_skb,
>> -                                  u32 num_buf,
>> -                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
>> -                                  struct virtnet_rq_stats *stats)
>> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
>> +                                     struct receive_queue *rq,
>> +                                     u32 num_buf,
>> +                                     struct xdp_buff *xdp,
>> +                                     struct virtnet_rq_stats *stats)
>>   {
>> -       struct sk_buff *curr_skb;
>> -       struct xdp_buff *xdp;
>> -       u32 len, truesize;
>> -       struct page *page;
>> +       unsigned int len;
>>          void *buf;
>>
>> -       curr_skb = head_skb;
>> +       if (num_buf < 2)
>> +               return 0;
>> +
>> +       while (num_buf > 1) {
>> +               struct xdp_buff *new_xdp;
>>
>> -       while (--num_buf) {
>>                  buf = virtqueue_get_buf(rq->vq, &len);
>> -               if (unlikely(!buf)) {
>> -                       pr_debug("%s: rx error: %d buffers out of %d missing\n",
>> -                                vi->dev->name, num_buf,
>> -                                virtio16_to_cpu(vi->vdev,
>> -                                                hdr->num_buffers));
>> +               if (!unlikely(buf)) {
>> +                       pr_debug("%s: rx error: %d buffers missing\n",
>> +                                vi->dev->name, num_buf);
>>                          DEV_STATS_INC(vi->dev, rx_length_errors);
>> -                       return -EINVAL;
>> -               }
>> -
>> -               u64_stats_add(&stats->bytes, len);
>> -
>> -               xdp = buf_to_xdp(vi, rq, buf, len);
>> -               if (!xdp)
>> -                       goto err;
>> -
>> -               buf = napi_alloc_frag(len);
>> -               if (!buf) {
>> -                       xsk_buff_free(xdp);
>> -                       goto err;
>> +                       return -1;
>>                  }
>>
>> -               memcpy(buf, xdp->data - vi->hdr_len, len);
>> -
>> -               xsk_buff_free(xdp);
>> +               new_xdp = buf_to_xdp(vi, rq, buf, len);
>> +               if (!new_xdp)
>> +                       goto drop_bufs;
>>
>> -               page = virt_to_page(buf);
>> +               /* In virtnet_add_recvbuf_xsk(), we ask the host to fill from
>> +                * xdp->data - vi->hdr_len with both virtio_net_hdr and data.
>> +                * However, only the first packet has the virtio_net_hdr, the
>> +                * following ones do not. So we need to adjust the following
> Typo here.

I'm sorry, could you clarify which word contains the typo?

>
>> +                * packets' data pointer to the correct place.
>> +                */
> I wonder what happens if we don't use this trick? I meant we don't
> reuse the header room for the virtio-net header. This seems to be fine
> for a mergeable buffer and can help to reduce the trick.

I don't think using the header room for virtio-net header creates this 
case handling. In my opinion, it comes from the slightly difference in 
the recvbuf between single buffer and multi-buffer. When we have n 
single-buffer packets, each buffer will have its own virtio-net header. 
But when we have 1 multi-buffer packet (which spans across n buffers), 
only the first buffer has virtio-net header, the following buffers do not.

There 2 important pointers here. The pointer we announce to the vhost 
side to fill the data, let's call it announced_addr, and xdp_buff->data 
which is expected to point the the start of Ethernet frame. Currently,

     announced_addr = xdp_buff->data - hdr_len

The host side will write the virtio-net header to announced_addr then 
the Ethernet frame's data in the first buffer. In case of multi-buffer 
packet, in the following buffers, host side writes the Ethernet frame's 
data to the announced_addr no virtio-net header. So in the virtio-net, 
we need to subtract xdp_buff->data, otherwise, we lose some Ethernet 
frame's data.

I think a slightly better solution is that we set announced_addr = 
xdp_buff->data then we only need to xdp_buff->data += hdr_len for the 
first buffer and do need to adjust xdp_buff->data of the following buffers.

>
>> +               new_xdp->data -= vi->hdr_len;
>> +               new_xdp->data_end = new_xdp->data + len;
>>
>> -               truesize = len;
>> +               if (!xsk_buff_add_frag(xdp, new_xdp))
>> +                       goto drop_bufs;
>>
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> -                                                   buf, len, truesize);
>> -               if (!curr_skb) {
>> -                       put_page(page);
>> -                       goto err;
>> -               }
>> +               num_buf--;
>>          }
>>
>>          return 0;
>>
>> -err:
>> +drop_bufs:
>>          xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
>> -       return -EINVAL;
>> +       return -1;
>>   }
>>
>>   static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
>> @@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>          num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>
>>          ret = XDP_PASS;
>> +       if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
>> +               goto drop;
>> +
>>          rcu_read_lock();
>>          prog = rcu_dereference(rq->xdp_prog);
>> -       /* TODO: support multi buffer. */
>> -       if (prog && num_buf == 1)
>> -               ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
> Without this patch it looks like we had a bug:
>
>          ret = XDP_PASS;
>          rcu_read_lock();
>          prog = rcu_dereference(rq->xdp_prog);
>          /* TODO: support multi buffer. */
>          if (prog && num_buf == 1)
>                  ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>          rcu_read_unlock();
>
> This implies if num_buf is greater than 1, we will assume XDP_PASS?

Yes, I think XDP_DROP should be returned in that case.

>
>> +       if (prog) {
>> +               /* We are in zerocopy mode so we cannot copy the multi-buffer
>> +                * xdp buff to a single linear xdp buff. If we do so, in case
>> +                * the BPF program decides to redirect to a XDP socket (XSK),
>> +                * it will trigger the zerocopy receive logic in XDP socket.
>> +                * The receive logic thinks it receives zerocopy buffer while
>> +                * in fact, it is the copy one and everything is messed up.
>> +                * So just drop the packet here if we have a multi-buffer xdp
>> +                * buff and the BPF program does not support it.
>> +                */
>> +               if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
>> +                       ret = XDP_DROP;
> Could we move the check before trying to build a multi-buffer XDP buff?

Yes, I'll fix this in next version.

>
>> +               else
>> +                       ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>> +                                                 stats);
>> +       }
>>          rcu_read_unlock();
>>
>>          switch (ret) {
>>          case XDP_PASS:
>> -               skb = xsk_construct_skb(rq, xdp);
>> +               skb = xdp_build_skb_from_zc(xdp);
> Is this better to make this change a separate patch?

Okay, I'll create a separate patch to convert the current XDP_PASS 
handler to use xdp_build_skb_from_zc helper.

>
>>                  if (!skb)
>> -                       goto drop_bufs;
>> +                       break;
>>
>> -               if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
>> -                       dev_kfree_skb(skb);
>> -                       goto drop;
>> -               }
>> +               /* Later, in virtnet_receive_done(), eth_type_trans()
>> +                * is called. However, in xdp_build_skb_from_zc(), it is called
>> +                * already. As a result, we need to reset the data to before
>> +                * the mac header so that the later call in
>> +                * virtnet_receive_done() works correctly.
>> +                */
>> +               skb_push(skb, ETH_HLEN);
>>
>>                  return skb;
>>
>> @@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>                  return NULL;
>>
>>          default:
>> -               /* drop packet */
>> -               xsk_buff_free(xdp);
>> +               break;
>>          }
>>
>> -drop_bufs:
>> -       xsk_drop_follow_bufs(dev, rq, num_buf, stats);
>> -
>>   drop:
>> +       xsk_buff_free(xdp);
>>          u64_stats_inc(&stats->drops);
>>          return NULL;
>>   }
>> @@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>                  return -ENOMEM;
>>
>>          len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>> +       /* Reserve some space for skb_shared_info */
>> +       len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>
>>          for (i = 0; i < num; ++i) {
>>                  /* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
>> @@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>          dev->netdev_ops = &virtnet_netdev;
>>          dev->stat_ops = &virtnet_stat_ops;
>>          dev->features = NETIF_F_HIGHDMA;
>> +       dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
>>
>>          dev->ethtool_ops = &virtnet_ethtool_ops;
>>          SET_NETDEV_DEV(dev, &vdev->dev);
>> --
>> 2.43.0
>>
> Thanks
>

