Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B7188713
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673811; cv=none; b=fCw8gxAcIuQEbQbNL/UW2VWtlwTdfpVEOt/qKfEH7+kKovJh5jx1B4FbzspEkScdEmzTXrV/0WinivbFZcJf1FKfuzCvjVCP0H8ZbileTpslyZWLK8CisOev4Fo6rkH2JJOCj/HjbYEkgu6QAsyGNk9VaJGmbEeew7B1QU3+USM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673811; c=relaxed/simple;
	bh=n19T5jlKOfkYmKd9+I3E15PSzcYf9SWePsoOQ4DAil4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iENSqUipDY6KHk0eBZBbzl4uIzhwEuSbr7pBwV81adpRva7qoeEvVQ7gd52LcBaQ82xeL8eVQGWw8g7ArXnvBk6ffwNHs1s256GQ3m24+oOyS9XbpZ9me3pVH74ISbAj9kDMEEf47hK854zGKzPIchn1APEClOXwCtjzqozLnKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4br3yx5nyRztSYS;
	Mon, 28 Jul 2025 11:35:37 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD841402C4;
	Mon, 28 Jul 2025 11:36:40 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 11:36:39 +0800
Message-ID: <08399323-6bab-44f6-bc21-21faf68cd73d@huawei.com>
Date: Mon, 28 Jul 2025 11:36:34 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: check the minimum value of gso size in
 virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <willemb@google.com>,
	<atenart@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<tobias@strongswan.org>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com>
 <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/7/28 1:15, Willem de Bruijn 写道:
> Willem de Bruijn wrote:
>> But so the real bug, an skb with 4B in the UDP layer happens before
>> that.
>>
>> An skb_dump in udp_queue_rcv_skb of the GSO skb shows
>>
>> [  174.151409] skb len=190 headroom=64 headlen=190 tailroom=66
>> [  174.151409] mac=(64,14) mac_len=14 net=(78,20) trans=98
>> [  174.151409] shinfo(txflags=0 nr_frags=0 gso(size=4 type=65538 segs=0))
>> [  174.151409] csum(0x8c start=140 offset=0 ip_summed=3 complete_sw=0 valid=1 level=0)
>> [  174.151409] hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=2 iif=8
>> [  174.151409] priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
>> [  174.151409] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
>> [  174.152101] dev name=tun0 feat=0x00002000000048c1
>>
>> And of segs[0] after segmentation
>>
>> [  103.081442] skb len=38 headroom=64 headlen=38 tailroom=218
>> [  103.081442] mac=(64,14) mac_len=14 net=(78,20) trans=98
>> [  103.081442] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>> [  103.081442] csum(0x8c start=140 offset=0 ip_summed=1 complete_sw=0 valid=1 level=0)
>> [  103.081442] hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=2 iif=8
>> [  103.081442] priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
>> [  103.081442] encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
>>
>> So here translen is already 38 - (98-64) == 38 - 34 == 4.
>>
>> So the bug happens in segmentation.
>>
>> [ongoing ..]
> Oh of course, this is udp fragmentation offload (UFO):
> VIRTIO_NET_HDR_GSO_UDP.
>
> So only the first packet has an UDP header, and that explains why the
> other packets are only 4B.
>
> They are not UDP packets, but they have already entered the UDP stack
> due to this being GSO applied in udp_queue_rcv_skb.
>
> That was never intended to be used for UFO. Only for GRO, which does
> not build such packets.
>
> Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?


Thank you for your analysis, it is totally right!

After segment in udp_queue_rcv_skb(), these segs are not UDP packets, which
leads the crash.

The packet with VIRTIO_NET_HDR_GSO_UDP type from tun device perhaps should
not enter udp_rcv_segment().

How about not do segment and pass the packet to udp_queue_rcv_one_skb()
directly, like this:

   diff --git a/include/linux/udp.h b/include/linux/udp.h
   index 4e1a672af4c5..0c27e5194657 100644
   --- a/include/linux/udp.h
   +++ b/include/linux/udp.h
   @@ -186,6 +186,9 @@ static inline bool udp_unexpected_gso(struct sock 
*sk, struct sk_buff *skb)
           if (!skb_is_gso(skb))
                   return false;

   +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
   +               return false;
   +
           if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
               !udp_test_bit(ACCEPT_L4, sk))
                   return true;

