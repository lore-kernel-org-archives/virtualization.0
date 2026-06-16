Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264673D75BF
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622197; cv=none; b=pOHPGhPraXE5yewpUUTlpHtC1qXmL6BqXoEhJpKIey8ireI3ySKN82ptpYBB3s4EFgdl/4LruQkBN6PH4FvPR6FsB1C/EbbhchJeVSanl56se3Av49gbh0ncK2JlIoSzNY8XmL/qott0lmpwZRxvs9SDbvhqn+LUn8bn90gKPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622197; c=relaxed/simple;
	bh=xC+beP4a6w3VIhynN6Bo100Xb4uAkVRIkb4MDIWhP9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZcw1OdhyOiXUQPaPxq+LkXWNkKECONMOKNv8LMuhky46GNZ3QkvLylBSWSTd3eBurtfSUEdPsmMDRl357UyMr1TGirvpGHDnDCa7ofAzJxnxkZtb2PdBSFWR0HWFHeFY9uY8VuMTAUsnyZw4ANOF9QCA2WUWluxLPftfaR3n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=MnnYmzxT; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b="MnnYmzxT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 910BA84DFB
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 15:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id USs-Z_Vhcgjz for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Jun 2026 15:03:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=155.212.184.193; helo=mail.rulkc.org; envelope-from=avkrasnov@rulkc.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 015DF84DB4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 015DF84DB4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rulkc.org header.i=@rulkc.org header.a=rsa-sha256 header.s=dkim header.b=MnnYmzxT
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 015DF84DB4
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 15:03:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B6DA1011EF;
	Tue, 16 Jun 2026 18:02:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1781622185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BOZdJldyA9xjQSPbHtynyt1B2+NL3cHwnFTKNzeJ14A=;
	b=MnnYmzxTpoDkBkxeqEEUwVjjOGeJZtB9ee9alhl8qU/pmY6E0HLibQescqHzEwLHptkCuT
	x7JqE62HoGa48mNCPwUffgUKTsUxmEMMkIBDj8Lf+VWT9G/nZmfgJ/S0aDLsSOgmshXa+m
	NlLj02J9sp2ZQ5AMBZ5d7ezMkmEcOePpE9hBTbDz/j+IGmdjvEOuVjJphr8P4mtHwEwsT8
	7jA5HnLLCcGXPCfuyw4jM4s/rlfhYv+LJufAssEDScXREQRB14fgbarezI9Qs3dyt2WWp6
	YT5aHokJXJRbMvpARcWpejDMKRNRvIISb+9TDedlroKmuj5AJVpRKn4U6MXkWQ==
Message-ID: <772885a4-c755-433c-b076-ae7ac73794aa@rulkc.org>
Date: Tue, 16 Jun 2026 18:02:43 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
 <ajFFOJSdqpNWgohB@sgarzare-redhat>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <ajFFOJSdqpNWgohB@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 16/06/2026 16:09, Stefano Garzarella wrote:
> On Sun, Jun 14, 2026 at 08:47:56PM +0300, Arseniy Krasnov wrote:
>> Logically it was based on TCP implementation, so make further support
>> easier, rewrite it in the TCP way.
>
> Hi Arseniy, and thank you so much for the patch!
>
> I’d like to ask you to expand on the message a bit, especially to explain why we’re making this change.
>
> In particular, I’d like to better understand whether this is just a cosmetic change or if we’re fixing any issues (and if so, which ones), so we can determine whether this patch should be backported to the stable branches.

This is cosmetic change. I'll update commit message in v3.

>
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>> ---
>> Changelog v1->v2:
>> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>>   already added.
>
> Ah, okay is net-next material, please use the net-next tag (ie. [PATCH net-next v2]). 

Sure!

>
>>
>> net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
>> 1 file changed, 23 insertions(+), 25 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 09475007165b..787524b8cb44 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>     if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>>         return pkt_len;
>>
>> -    if (info->msg) {
>> -        /* If zerocopy is not enabled by 'setsockopt()', we behave as
>> -         * there is no MSG_ZEROCOPY flag set.
>> +    if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>> +        /* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>> +         * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>> +         * handling from 'tcp_sendmsg_locked()'.
>>          */
>> -        if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>> -            info->msg->msg_flags &= ~MSG_ZEROCOPY;
>> +        if (info->msg->msg_ubuf) {
>> +            uarg = info->msg->msg_ubuf;
>> +            can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>> +        } else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>> +            uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>> +                            NULL, false);
>> +            if (!uarg) {
>> +                virtio_transport_put_credit(vvs, pkt_len);
>> +                return -ENOMEM;
>> +            }
>>
>> -        if (info->msg->msg_flags & MSG_ZEROCOPY)
>>             can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>>
>
> nit: we can remove this extra blank line.
>
> For the rest I can't see anything wrong, but a bit more context in the commit would help me in the review.

Ack, I'll update commit message in v3. Also need to check some reports about pre-existing issues from sashiko, triggered by this patch.

Thanks!

>
> Thanks,
> Stefano
>
