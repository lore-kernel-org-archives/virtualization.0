Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7086AC678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 16:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0FB5817AA;
	Mon,  6 Mar 2023 16:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0FB5817AA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f0ThT+CL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpbGGqt7y40B; Mon,  6 Mar 2023 16:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B65581758;
	Mon,  6 Mar 2023 16:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B65581758
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 067A2C0071;
	Mon,  6 Mar 2023 16:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1720C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCBF9404F9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCBF9404F9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f0ThT+CL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxUUNKD1Z4sY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97A52403F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97A52403F9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678119538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9yibYb7BiHv8VUJHHc1xSbchMTl79O8SC4SNRlYdVk=;
 b=f0ThT+CLiSKlSXzbyIflo7cEc+xkZRBW9C4HkgLeE3wibNha7JN4DO6SvzR2V3ti1gblQa
 pQXrwSgIq+2Q0vOgnQR1U3LBkUrBG4O/oT+kOQ7psnI68OsEyXnAvvFLWvZTAw7/07XRDs
 WYR7y/nYF8ulmQoaCULPzPs7f+KfXaA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-7RPTyXX6Mq2Gl4s1jZd1cg-1; Mon, 06 Mar 2023 11:18:57 -0500
X-MC-Unique: 7RPTyXX6Mq2Gl4s1jZd1cg-1
Received: by mail-qk1-f199.google.com with SMTP id
 z23-20020a05620a101700b0073b328e7d17so5635881qkj.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 08:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678119537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9yibYb7BiHv8VUJHHc1xSbchMTl79O8SC4SNRlYdVk=;
 b=uubBpo4+tJWFjpH5i5ltvkIennFbcvaAbBsVEusz+AMiuflqCAmV69zB/zpQuDefpv
 ddK9pNsyC5PADj1LBF6Lmg/oufx5H7Lz/f8y0NjMwLmp4K7zcY3S89FYSuwhcC9vdyxd
 +Om+zuX+DqeFroQw4GsaFF975A1LN06w4vsULkbTNWJbHsHjQ87S7578IR2orFnTR9wN
 bdGaNZmlVeNxD7YYP7rZS0gU0RZFxdcfrZg9MPp0cRz2vNh50WDTUIqJrwOw7DlkMhtA
 xEIxIv9b5/7MGsUkqJeODKvS3/bg+mCLI268H/VxVZGTg4GXLwBaxHernBPgI+DIHlhZ
 rkLQ==
X-Gm-Message-State: AO0yUKWR9LKFb2v1uLc744DM7NetZd4wTKxfae58AnxdF3dREsx9Lw4A
 Vxz9lMs4U77SwfCOrKargDmXyCgkJAxpMl/DNBGkXN5ugD9+FBVtOVY1RUP8n4xCCy2QB7vqEYj
 BiEUqLMmU2C1OK6syCFeogvn0jSpV3j57rL5skSX2/w==
X-Received: by 2002:ac8:57c4:0:b0:3bf:c7ac:37e4 with SMTP id
 w4-20020ac857c4000000b003bfc7ac37e4mr21646905qta.53.1678119536886; 
 Mon, 06 Mar 2023 08:18:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8J4YE/RXJjUhe6KmcGADN++XZIQZ5a1lW56p6P5SGInNCKdizbMZ77Gy1LukOOT+Xou8kNBQ==
X-Received: by 2002:ac8:57c4:0:b0:3bf:c7ac:37e4 with SMTP id
 w4-20020ac857c4000000b003bfc7ac37e4mr21646869qta.53.1678119536628; 
 Mon, 06 Mar 2023 08:18:56 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 l5-20020ac87245000000b003b9a426d626sm7744060qtp.22.2023.03.06.08.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 08:18:56 -0800 (PST)
Date: Mon, 6 Mar 2023 17:18:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: remove all data from sk_buff
Message-ID: <20230306161852.4s7qf4qm3fnwjck7@sgarzare-redhat>
References: <a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru>
 <dfadea17-a91e-105f-c213-a73f9731c8bd@sberdevices.ru>
 <20230306120857.6flftb3fftmsceyl@sgarzare-redhat>
 <b18e3b13-3386-e9ee-c817-59588e6d5fb6@sberdevices.ru>
 <20230306155121.7xwxzgxtle7qjbnc@sgarzare-redhat>
 <9b882d45-3d9d-c44d-a172-f23fff54962b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <9b882d45-3d9d-c44d-a172-f23fff54962b@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 06, 2023 at 07:00:10PM +0300, Arseniy Krasnov wrote:
>
>
>On 06.03.2023 18:51, Stefano Garzarella wrote:
>> On Mon, Mar 06, 2023 at 06:31:22PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 06.03.2023 15:08, Stefano Garzarella wrote:
>>>> On Sun, Mar 05, 2023 at 11:07:37PM +0300, Arseniy Krasnov wrote:
>>>>> In case of SOCK_SEQPACKET all sk_buffs are used once - after read some
>>>>> data from it, it will be removed, so user will never read rest of the
>>>>> data. Thus we need to update credit parameters of the socket like whole
>>>>> sk_buff is read - so call 'skb_pull()' for the whole buffer.
>>>>>
>>>>> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> net/vmw_vsock/virtio_transport_common.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Maybe we could avoid this patch if we directly use pkt_len as I
>>>> suggested in the previous patch.
>>> Hm, may be we can avoid calling 'skb_pull()' here if 'virtio_transport_dec_rx_pkt()'
>>> will use integer argument?
>>
>> Yep, exactly!
>>
>>> Just call 'virtio_transport_dec_rx_pkt(skb->len)'. skb
>>
>> It depends on how we call virtio_transport_inc_rx_pkt(). If we use
>> hdr->len there I would use the same to avoid confusion. Plus that's the
>> value the other peer sent us, so definitely the right value to increase
>> fwd_cnt with. But if skb->len always reflects it, then that's fine.
>i've checked 'virtio_transport_rx_work()', it calls 'virtio_vsock_skb_rx_put()' which
>sets 'skb->len'. Value is used from header, so seems 'skb->len' == 'hdr->len' in this
>case.

Thank you for checking it.

However, I still think it is better to use `hdr->len` (we have to assign 
it to `pkt_len` anyway, as in the proposal I sent for patch 1), 
otherwise we have to go every time to check if skb_* functions touch 
skb->len.

E.g. skb_pull() decrease skb->len, so I'm not sure we can call 
virtio_transport_dec_rx_pkt(skb->len) if we don't remove `skb_pull(skb, 
bytes_to_copy);` inside the loop.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
