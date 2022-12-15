Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4736CC4332F
	for <virtualization@archiver.kernel.org>; Thu, 15 Dec 2022 08:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B189C81EF0;
	Thu, 15 Dec 2022 08:30:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B189C81EF0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvQUj6Qz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9m05i15llLB; Thu, 15 Dec 2022 08:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E0EB81EE9;
	Thu, 15 Dec 2022 08:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E0EB81EE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DACE1C0032;
	Thu, 15 Dec 2022 08:30:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B2CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 08:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7169F41836
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 08:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7169F41836
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvQUj6Qz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vtwxK-x2lbdG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 08:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6431E41825
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6431E41825
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671093052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQftxKjFR81WRUC766VxI4Sfi85jP5put0rR4SH+wzs=;
 b=bvQUj6Qz8ErnJwgJOMKH+kuvMlpwRiGlb3cXN+WMeN2HSXLl+8fHJceGt7s6wdclEiFlTB
 XCtoVVgsHTAzXox3S/X3/7dMsob/yToTej+HBQF4Ga+zHsktj29zfqJucDqBCvZbsxCKHi
 AQQQBuHMsiqxINj+w8wszvqirwszpoM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-QKtVFf3DPPuqMI-PMcslkg-1; Thu, 15 Dec 2022 03:30:50 -0500
X-MC-Unique: QKtVFf3DPPuqMI-PMcslkg-1
Received: by mail-ej1-f72.google.com with SMTP id
 hr17-20020a1709073f9100b007c4fe2c7d64so1280816ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 00:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQftxKjFR81WRUC766VxI4Sfi85jP5put0rR4SH+wzs=;
 b=1A2jZJei66Ph9kUYsmeCmvMpW+rldjhzufeKcG8u4QCpKE45TMlaJG7sfQIui9/yd5
 Y7YV0i6thgacGIsafHq44SjE4rh2ndbVQi27KOMyH32IwCoCapaPc+PXe00aMH78mBTn
 WzPpBltuWQb/qSpZeh8b/u307+Gk7ZhhrHAjH3P6rOdwoUE250mMnxYts6yHz8ZbeERG
 OvU5spdoOmuzgs5WgRGpA6Df2bhlGs2uKf6Bbq6apIduPBWfC5HoR3OfYpg7VMopIzwS
 TQe8MXigJKlY/0v1fLErISQPfkeVHJ33QgRVB6wnCI8oKAXlK+BGbATg3w8in0+PI5CB
 ncFw==
X-Gm-Message-State: ANoB5pnzDNwwzeMIEqdAH8VSo0+GYgMm69RitQIhTWdYMusn5F69hEra
 GIQ2TYqB1pilr2gj6O3FXIPXNEweaGOcHj/j8z+TA4t1ovDid3969IB7jaEDmnWvuMEnRFvTax5
 hqH3iWTk2W9khLvBMMglCUGSeEYjx+YGG1rZH88h/8w==
X-Received: by 2002:a05:6402:4d6:b0:45c:835c:1ecf with SMTP id
 n22-20020a05640204d600b0045c835c1ecfmr24078762edw.29.1671093049736; 
 Thu, 15 Dec 2022 00:30:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4r/8QccpcVLtJ/LolCjiYE4eVoyO3dtVao5bKTz3iNWmsN4PhSYamWPcoMXBuegu/a2Nq8AQ==
X-Received: by 2002:a05:6402:4d6:b0:45c:835c:1ecf with SMTP id
 n22-20020a05640204d600b0045c835c1ecfmr24078753edw.29.1671093049553; 
 Thu, 15 Dec 2022 00:30:49 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 a18-20020aa7cf12000000b0046cd3ba1336sm7267337edy.78.2022.12.15.00.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Dec 2022 00:30:49 -0800 (PST)
Date: Thu, 15 Dec 2022 09:30:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221215083045.2lfplx6fhuwpau2s@sgarzare-redhat>
References: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
 <4b66f91f23a3eb91c3232bc68f45bdb799217c40.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4b66f91f23a3eb91c3232bc68f45bdb799217c40.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
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

On Wed, Dec 14, 2022 at 11:58:47AM +0100, Paolo Abeni wrote:
>On Tue, 2022-12-13 at 19:28 +0000, Bobby Eshleman wrote:
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 5703775af129..2a5994b029b2 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -51,8 +51,7 @@ struct vhost_vsock {
>>  	struct hlist_node hash;
>>
>>  	struct vhost_work send_pkt_work;
>> -	spinlock_t send_pkt_list_lock;
>> -	struct list_head send_pkt_list;	/* host->guest pending packets */
>> +	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
>>
>>  	atomic_t queued_replies;
>>
>> @@ -108,40 +107,33 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  	vhost_disable_notify(&vsock->dev, vq);
>>
>>  	do {
>> -		struct virtio_vsock_pkt *pkt;
>> +		struct virtio_vsock_hdr *hdr;
>> +		size_t iov_len, payload_len;
>>  		struct iov_iter iov_iter;
>> +		u32 flags_to_restore = 0;
>> +		struct sk_buff *skb;
>>  		unsigned out, in;
>>  		size_t nbytes;
>> -		size_t iov_len, payload_len;
>>  		int head;
>> -		u32 flags_to_restore = 0;
>>
>> -		spin_lock_bh(&vsock->send_pkt_list_lock);
>> -		if (list_empty(&vsock->send_pkt_list)) {
>> -			spin_unlock_bh(&vsock->send_pkt_list_lock);
>> +		spin_lock(&vsock->send_pkt_queue.lock);
>> +		skb = __skb_dequeue(&vsock->send_pkt_queue);
>> +		spin_unlock(&vsock->send_pkt_queue.lock);
>
>Here you use a plain spin_lock(), but every other lock has the _bh()
>variant. A few lines above this functions acquires a mutex, so this is
>process context (and not BH context): I guess you should use _bh()
>here, too.

Maybe we can use directly the new virtio_vsock_skb_dequeue().
IIRC we added it exactly to use the same kind of lock everywhere.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
