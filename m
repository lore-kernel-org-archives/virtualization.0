Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21139A078
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906259; cv=none; b=QSKtAWNsLs8DzuAeOIN4MIDBIc4K45v/VD7kDDKzH2x3oNClMuZAp1hsc5qQVcd9ZWYi6g2OMzLLXZbvphokPQ4ApOXE4MrLG/eXocCFxTbQbKEdzPsMudC055zXFcXXfBX9z/KrJhHKkZffiK8j3Nhp8c8RatoOrruiRkSqDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906259; c=relaxed/simple;
	bh=T+UXdam+yWyd/W4SdmgQkDS3bLFNYSV1t2bMdvafd+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syIB75e0vKDSRb/zRKsamNTGiEVbyXrBCE68vF+LosTApGcrWWxFv5qjjuMLpSyEu1dqXLQ+0WyybkKrh6zCzgeZvJhXcAkkfttd8XQ+fLPQtk9zVLURAiD0fcDffrnivYn0jqX6kPKb8nWRyEEc290nAFryxcNDFFJarnqDLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=LWLdzALM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="LWLdzALM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BB25402D2
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 08:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81gN0hIdFhut for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jun 2026 08:10:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9314642699
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9314642699
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=LWLdzALM
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9314642699
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jun 2026 08:10:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B4CC1003A7;
	Mon,  8 Jun 2026 11:10:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780906247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rCERzOtepy/cS8kAXVGlEZomKIm0tyZTnmeEluP22/M=;
	b=LWLdzALM0luSB6Rlg2IHsrv9r/lvkL67IbQPvLIEZ/1ylcsqUVjbNLa+DBqXxrEvRWHPIn
	xERoPJixjF8VUqvsAUG2spwLVOKgRoWwnqCiKf7qUFTZiZc4K9XmYTol6z5Xukq27/lcni
	RkqPlbip2WSgPV2eT6NJtOeDnW1T2Kyzyq5RNeg6/DP2uOWoy+qvEDoYg90KtRxG79g0oF
	DuIAqXjMbDRnSpOHtH8eb/BrumcRok/3dOOs8CmKLfbakjMXAZmHkr9MCLIhLAj1IxdKyc
	vvtwFOALI4hIb9BF17zPKY00pFWH1aeMVF9jzatRd9wVCLXslGnMc/95QN4gFg==
Message-ID: <e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
Date: Mon, 8 Jun 2026 11:10:24 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
 <20260605160851.3ddbd2ed@pumpkin>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <20260605160851.3ddbd2ed@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 05/06/2026 18:08, David Laight wrote:
> On Fri,  5 Jun 2026 14:53:14 +0300
> Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
>
>> Logically it was based on TCP implementation, so to make further
>> support easier, rewrite it in the TCP way.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
>>  1 file changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 2fd9eaaf5ca6..00caeeaa5590 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>  				     struct virtio_vsock_pkt_info *info,
>>  				     size_t len,
>> -				     bool zcopy)
>> +				     bool zcopy, struct ubuf_info *uarg)
>>  {
>>  	struct msghdr *msg = info->msg;
>>  
>> +	/* We have completion - attach it to 'skb'. */
>> +	skb_zcopy_set(skb, uarg, NULL);
>> +
>>  	if (zcopy)
>>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
>>  					       &msg->msg_iter, len, NULL);
>> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>>  						  u32 src_cid,
>>  						  u32 src_port,
>>  						  u32 dst_cid,
>> -						  u32 dst_port)
>> +						  u32 dst_port,
>> +						  struct ubuf_info *uarg)
>>  {
>>  	struct vsock_sock *vsk;
>>  	struct sk_buff *skb;
>> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>>  	if (info->msg && payload_len > 0) {
>>  		int err;
>>  
>> -		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
>>  		if (err)
>>  			goto out;
>>  
>> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>>  		return pkt_len;
>>  
>> -	if (info->msg) {
>> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>> -		 * there is no MSG_ZEROCOPY flag set.
>> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>> +		 * handling from 'tcp_sendmsg_locked()'.
>>  		 */
>> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>> +		if (info->msg->msg_ubuf) {
>> +			uarg = info->msg->msg_ubuf;
>> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>> +						    NULL, false);
>> +			if (!uarg) {
>> +				virtio_transport_put_credit(vvs, pkt_len);
>> +				return -ENOMEM;
>> +			}
>>  
>> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>>  
>> +			if (!can_zcopy)
>> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>> +
>> +			have_uref = true;
>> +		}
>> +
>> +		/* 'can_zcopy' means that this transmission will be
>> +		 * in zerocopy way (e.g. using 'frags' array).
>> +		 */
> I've not looked at the tcp code, but the above doesn't look right.
> I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY set.
> That would give the outer code a callback when the last skb is freed but
> still copy the data.

Hi, 

I guess case when 'msg->msg_ubuf' is non-NULL is special case today for io_uring MSG_ZEROCOPY implementation.
It was added here https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb315a7d1396b1139fc7daea55f2d3191e8e7092
As I see implementation of its tests in tools/testing/selftests/net/io_uring_zerocopy_tx.c , it doesn't require setting SOCK_ZEROCOPY option for
socket, so for virtio vsock case I just copied same logic to maintain compatibility, because there is MSG_ZEROCOPY io_uring test for virtio/vsock.


>
> I also don't see the point of calling msg_zerocopy_realloc() to get a
> callback when the last skb is freed and then setting
> 	uarg_to_msgzc(uarg)->zerocopy = 0;
> so that the callback doesn't actually do anything.
> It isn't as though you 'find out' later on that you can't actually do
> zerocopy.


Sorry, what do You mean "last skb" ? In this code we first allocate uarg (allocate, because third arg is always NULL). Then in
loop we allocate sk_buffs, fill it with data and send. I mean first/last skb will be freed after uarg is already allocated and we
don't touch it. I think i didn't understand Your question here.


>
>>  		if (can_zcopy)
>>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> -
>> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> -		    info->op == VIRTIO_VSOCK_OP_RW) {
>> -			uarg = info->msg->msg_ubuf;
>> -
>> -			if (!uarg) {
>> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> -							    pkt_len, NULL, false);
>> -				if (!uarg) {
>> -					virtio_transport_put_credit(vvs, pkt_len);
>> -					return -ENOMEM;
>> -				}
>> -
>> -				if (!can_zcopy)
>> -					uarg_to_msgzc(uarg)->zerocopy = 0;
>> -
>> -				have_uref = true;
>> -			}
>> -		}
>>  	}
>>  
>>  	rest_len = pkt_len;
>> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  
>>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>>  						 src_cid, src_port,
>> -						 dst_cid, dst_port);
>> +						 dst_cid, dst_port, uarg);
>>  		if (!skb) {
>>  			ret = -ENOMEM;
>>  			break;
>>  		}
>>  
>> -		skb_zcopy_set(skb, uarg, NULL);
> Aren't you passing uarg through two function calls instead of doing it here.
> Doesn't even make it clearer what is going on.


Agree, to simplify patch, uarg could be set earlier (without passing it to functions) I guess.

Thanks


>
> -- David
>
>> -
>>  		virtio_transport_inc_tx_pkt(vvs, skb);
>>  
>>  		ret = t_ops->send_pkt(skb, info->net);
>> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>>  					   le64_to_cpu(hdr->dst_cid),
>>  					   le32_to_cpu(hdr->dst_port),
>>  					   le64_to_cpu(hdr->src_cid),
>> -					   le32_to_cpu(hdr->src_port));
>> +					   le32_to_cpu(hdr->src_port), NULL);
>>  	if (!reply)
>>  		return -ENOMEM;
>>  
