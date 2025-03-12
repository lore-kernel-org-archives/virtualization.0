Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8411E230E
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759187; cv=none; b=atNL9tgvC0N8ngkRDOqlsessf2oywGkcCTuBnSfxIOKg8Yeq+v146SzYbq5O8VtwJpL8+yS8Wl2mlBlqC9O+mOHed0M/O8KcUOCnPARX0fMES60YwJ8MeM/ezrJrNabTJOth9hoqoruz9e+ZXdSs8YXVxqJB4AnGx9xcdsSJVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759187; c=relaxed/simple;
	bh=R7tuHjNoroVMo9h2O5mHayl7xY5IH0gYVy1+W3i+UMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxQRWhXuJEXoXPmvIqQ1FZp4W/AA2uAoDhuO+QNx7CjopAQTqMxRNmkigxGzJPjtE31pjuVKzPLnGDFGjeVCGFym5iDVy4lWaKKqR2SmbPnhRAxX1kMYvRG7oG/L2g/nYBZs9JmIpu4xBouG1uXGw0oFSXyELJrk0FaMdPEQ1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=IOt3K6py; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="IOt3K6py"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1A8D40482
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3U3sdRzTPLN for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 05:59:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8BD7240254
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BD7240254
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IOt3K6py
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BD7240254
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 05:59:44 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-22359001f1aso148980285ad.3
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741759184; x=1742363984; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZESZje65E8gcTEnwSqTnH4kGbDuL6yGOWt5IOmRc30=;
        b=IOt3K6py0lWWT9MlUJ2jPcUKL71K+L7s0+ONUat1bs3uiFXTkmCyPlbnpgv+WQJlau
         jeXVV3P0yD4FA59XjYg2+Pweh/74bdocfOOySI42TIi3gFSaMWzUxzZpmDDI6ZZF0Drc
         QjVsDLSxiyFo8BLWlxp6ZN2R7Hmimmr09RsTqa2qFT0qzYa/SOiLUqDqjODN5Iz1q1xa
         FwuMb+ypJnGeHbPgR7H67/87uQAE2Iq4UuKexqeO1M1U1kjyvmWZmz5FSlAEYNAgzBiN
         1wUVuwdAkVTjIP44yVUNQWPjM+3rTj88rfckBdlHrWtkewtPjb7aoXamo+0Bf71t8Yug
         ThiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741759184; x=1742363984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZESZje65E8gcTEnwSqTnH4kGbDuL6yGOWt5IOmRc30=;
        b=OrBiAQLgQREMRGkqBa/I6xT5GXPtnuoFbifwm8Q6relDi1fzs5jpK/vclLeBsLASj4
         BTYDJrc1WgKP9yuvjLRxKgAMs5TPWPyS8x2Jp1YzmmkAB/FZPmnLHDhYqBDuaMu7Z65u
         no2INDcgTD/yT/c0Tp+FU3mhixjKw4ZxTQ/6PPQb6wQ9YmUdag5iDcrJpDrMoaAb23GX
         LnuXJGF7MfQYsdjJIOlxmpXcyQe04R2J09C2aPGA0mf9gP7/6iQ3APGdJ9esJkTsnFgO
         vnMCLqfHMNAcDpknEE4sNskynaI00+ILWt1i5yCNpMSS5GHhNv80OhoVa956C+hckoRw
         O40g==
X-Forwarded-Encrypted: i=1; AJvYcCXwxb9G+KK//gaAlhMqIY27tWe3esapG4L7p/zWLIDKSaWwjNmiD/ALWNdRu8BkX8sDaggfSR1A1PO9ep2evw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyOcuIsmIVc488yQjZ2lb71PIo5x/JqRfcYv+e2kIlRuCGIczfq
	Ag6JcXM6OUKITJ4bAz95dzoW4G08H6xmkgnc6DdoQS4Da63hjCsv6vNHkxZrLCk=
X-Gm-Gg: ASbGncsKsLuNUJ052ej6Lts8CWTVwkZ7N2TF2lawEJBBKM6RupGcMAApjSH2ZIELBcS
	ctElFqSxXlmrVvlqyhQhzLoHrX3mmnlfT4PkEwjtkwrJm1xtcwZlj8rd0Id02QTizuJQTk1MYXE
	2RWoINwO14f9y8Za7H2DZNxUsIKQNZ+j6NdNHWMcI8Gi+BqMuOimEqGqcQDkMoRDu7pM7dzYJBS
	3Hi4cAgqFuNDn7QuhVLzGHXM59LzL9Z0I7aMrh/Dc3xLJQhmLWpXo1O9VNpNh09enxlEPwehQ7J
	jk5+cQDc3vq6XDQk2AF9GRBGgM9xXhQnJASWbSa+Vh5Ffm2mritar3qLew==
X-Google-Smtp-Source: AGHT+IHNxn8E8ipTo8o+6AGn7pM/bGpbwkMrzPK64AMoQJ3BPQiT3yi57XUpV2Dk7/oIOt6/kYhYhQ==
X-Received: by 2002:a17:902:f541:b0:224:c76:5e57 with SMTP id d9443c01a7336-22428ab7665mr257241305ad.39.1741759183662;
        Tue, 11 Mar 2025 22:59:43 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e848csm107914775ad.63.2025.03.11.22.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:59:43 -0700 (PDT)
Message-ID: <77c21953-b850-4962-8673-6effb593d819@daynix.com>
Date: Wed, 12 Mar 2025 14:59:36 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
 <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
 <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
 <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/12 12:36, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 2:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/11 9:42, Jason Wang wrote:
>>> On Mon, Mar 10, 2025 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/10 13:43, Jason Wang wrote:
>>>>> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>>>>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>>>>>> hash values (i.e., the hash_report member is always set to
>>>>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>>>>>> underlying socket will be reported.
>>>>>>
>>>>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>> ---
>>>>>>     drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>>>>>     1 file changed, 29 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>>>>>> --- a/drivers/vhost/net.c
>>>>>> +++ b/drivers/vhost/net.c
>>>>>> @@ -73,6 +73,7 @@ enum {
>>>>>>            VHOST_NET_FEATURES = VHOST_FEATURES |
>>>>>>                             (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>>>>>                             (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>>>>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>>>>>                             (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>>>>>                             (1ULL << VIRTIO_F_RING_RESET)
>>>>>>     };
>>>>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>>>>>                    .msg_controllen = 0,
>>>>>>                    .msg_flags = MSG_DONTWAIT,
>>>>>>            };
>>>>>> -       struct virtio_net_hdr hdr = {
>>>>>> -               .flags = 0,
>>>>>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>>>> +       struct virtio_net_hdr_v1_hash hdr = {
>>>>>> +               .hdr = {
>>>>>> +                       .flags = 0,
>>>>>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>>>> +               }
>>>>>>            };
>>>>>>            size_t total_len = 0;
>>>>>>            int err, mergeable;
>>>>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>>>>>            bool set_num_buffers;
>>>>>>            struct socket *sock;
>>>>>>            struct iov_iter fixup;
>>>>>> -       __virtio16 num_buffers;
>>>>>>            int recv_pkts = 0;
>>>>>>
>>>>>>            mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>>>>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>>>>>                            vhost_discard_vq_desc(vq, headcount);
>>>>>>                            continue;
>>>>>>                    }
>>>>>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>>>>>                    /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>>>>>                    if (unlikely(vhost_hlen)) {
>>>>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>>>>>> -                                        &fixup) != sizeof(hdr)) {
>>>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>>>> +                                        &fixup) != vhost_hlen) {
>>>>>>                                    vq_err(vq, "Unable to write vnet_hdr "
>>>>>>                                           "at addr %p\n", vq->iov->iov_base);
>>>>>>                                    goto out;
>>>>>
>>>>> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
>>>>>
>>>>> Honestly, I'm not sure if it's too late to fix this.
>>>>
>>>> There is nothing wrong with the current implementation.
>>>
>>> Note that I meant the vhost_hlen part, and the current code is tricky.
>>>
>>> The comment said:
>>>
>>> """
>>> /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>> """
>>>
>>> So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
>>> to mrg_rxbuf len.
>>>
>>> And this patch changes this behaviour.
>>
>> mrg_rxbuf only adds the num_buffers field, which is always set for
>> mrg_rxbuf.
>>
>> The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but this
>> was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers for
>> virtio 1.0")
>>
>> So there is no behavioral change for existing features with this patch.
> 
> I meant this part.
> 
>>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>>> +                                        &fixup) != vhost_hlen) {
> 
> We should copy only sizeof(hdr) instead of vhost_hlen.> > Anything I miss?

sizeof(hdr) will be greater than vhost_hlen when neither 
VIRTIO_NET_F_MRG_RXBUF or VIRTIO_F_VERSION_1 is negotiated.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks
>>>
>>>> The current
>>>> implementation fills the header with zero except num_buffers, which it
>>>> fills some real value. This functionality is working fine with
>>>> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.
>>>>
>>>> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
>>>> field, which also needs to be initialized with zero, so I'm making sure
>>>> vhost_net will also initialize it.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>> Others look fine.
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>
>>
> 

