Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD81EE7B9
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674255; cv=none; b=Tk+yViUgdnXZv150r248G4xPxrFXx5lgGRVLkSaO4wwlhtuE1/ZAfJROaoK7i1aUVkIoOGwqntsAhZSvNnK2aMK/qqHWBevoEmPZagYWrgvxUZM970MFFWzkUDL0K2vue5hbWsoY3QK0qet21fLEBEsJshYWT3MPpmjyWU97zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674255; c=relaxed/simple;
	bh=DsqDEHlBUwS8fyV8/WMCNPW7k1Q8GQhlh9GKPXRNGBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm5aQTUy3kSB7V8XUbpsT9YVEAo54vZ/xb6mnoKLgjO2IjikBXHS8L0bq033ENmA0C/SPXRoV7XFsNcPRgYwimgCZY6LSJLHvy6uNitNUxciFiZoIOufhK0P4MCojaNA99dDyohbVqFLb8wjHg9Y2lg6qBcWrhuM3BqOtp6/ugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PYqbQoz0; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PYqbQoz0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27B9B40275
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLCY4HyodY6n for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 06:24:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2E452400FC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E452400FC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PYqbQoz0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E452400FC
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 06:24:12 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2239c066347so88493415ad.2
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741674252; x=1742279052; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcOWo3MpfkZwJWARJhxBJx9ftvSTMuCRJKTKMNfQ2T0=;
        b=PYqbQoz0c+MZTvgmAo4kvW6BYGG0+WsWfMwAFTOox8TxLJj0kvt7TlfI82QNc+8uaL
         7LI3GC0u4mjra9JCV3q9xXMEiNE2kIDVLURD09k/wzX3mfsnJbZVE2xGK4z53aJStNU1
         nopBeHu65jdSy15s5A9E/8jdViWEozBiZoTpY0mFagGj3JHS4Ky7ai0rLr1O2HvquPLi
         zIwJl7CHC+e50yhpJ8MRjRWHV0D5PT0TZy+mak6QsWkp6vcguj2jlWdFFwH2gb2Nojwu
         yG5ULg7/ZNxCqtUc7bjcUs0dfeWO/SZTL1iU/PrLzcon2zfxEK5gDLL6At5yBK5M4zRW
         RjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674252; x=1742279052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcOWo3MpfkZwJWARJhxBJx9ftvSTMuCRJKTKMNfQ2T0=;
        b=RS3/O5JUsSMrHR7SRl/F4tBY+//bN9O2H/JO2vCDxEfi5VK6ick/5RMtzpSfAccX4C
         9udJzn5bxl8Srb9zGrDJM6Re0lLHMloCuBCZ5oPAapS8KCtzdhR8f9CXRTn4Nr7Pk/Bn
         rhF/lAitmmnR7j+B4URUxMSCyuMJF7axbboV8zSVb1xma0WCRy4xBQTd2qXTCVMOU4lO
         csKvv3LRBn6HYs2joMPwzvLyd87DcKSMHj9Kz3Rny9HWC9qqpSrf/MokOgZr7WgBi0XB
         dOoU31G5PSVpH+EyoLOwVjtGrRBhtLYaHJoAW8HyhFYoE9yWygR8r5WmLzX+FE0T0cuM
         PaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVyzbpTpR8f98A1XREhAvajOI2hCplJK2phC9T8PIicE5LGLypL/72Tjo+6evVqMU1/WOx1BEwKtZn+FrvGRg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy148Q6S+zXgHfGa0Ew0QeqfNMWLCL9WhbBRK05yKPznArqK2+B
	lDnYE5Q3+OZD1jp2BWVbI3r50+NwUxyQP7+phNY09U48cAp6bl8WCcVGXX0rxbo=
X-Gm-Gg: ASbGncsEd8z52cH9SH67hWifYKnUgOr1zZuWiw7wXm2LJTUN77Yv3xeQEWyosE3KdRz
	dyyHQnbGHuFTyCtj7/nZactGS8Ii8T3MOUed+5WIl6E0q+/c958aDE4D4DN+saFGk0/QabMUcuQ
	Ph3f758hwD1dQJw7pexZ4GZ+fPD4CZzIkEWKsI+6pbCR1QU9RwfLwGsKGQqG8hLJmDOSpVV4rrK
	xSU2V0mDoBlwHwORYHJ4VUuft2Eo2m2fJtyNX5SXQhUcrxzvRn0gr4+wS3YyZLi51VW8kV59aLr
	ms6j2luHGbPf1/eInInMbCPOpMvZd7EMrwFZHng80Hi7GOReZgs/544eLg==
X-Google-Smtp-Source: AGHT+IGn18ZSOeDi0OtiFl4e+mdyHaJbBZUtxUxoxSL45HZJeEfhcKnA+r8VKFVTyGuyQbzX9uCMeA==
X-Received: by 2002:a05:6a00:1a92:b0:730:d5ca:aee with SMTP id d2e1a72fcca58-736aaae81e6mr21317990b3a.23.1741674252333;
        Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a336010dsm9010979b3a.59.2025.03.10.23.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
Message-ID: <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
Date: Tue, 11 Mar 2025 15:24:06 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/11 9:42, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/10 13:43, Jason Wang wrote:
>>> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>>>> hash values (i.e., the hash_report member is always set to
>>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>>>> underlying socket will be reported.
>>>>
>>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>> ---
>>>>    drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>>>    1 file changed, 29 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>>>> --- a/drivers/vhost/net.c
>>>> +++ b/drivers/vhost/net.c
>>>> @@ -73,6 +73,7 @@ enum {
>>>>           VHOST_NET_FEATURES = VHOST_FEATURES |
>>>>                            (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>>>                            (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>>>                            (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>>>                            (1ULL << VIRTIO_F_RING_RESET)
>>>>    };
>>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>>>                   .msg_controllen = 0,
>>>>                   .msg_flags = MSG_DONTWAIT,
>>>>           };
>>>> -       struct virtio_net_hdr hdr = {
>>>> -               .flags = 0,
>>>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>> +       struct virtio_net_hdr_v1_hash hdr = {
>>>> +               .hdr = {
>>>> +                       .flags = 0,
>>>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>> +               }
>>>>           };
>>>>           size_t total_len = 0;
>>>>           int err, mergeable;
>>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>>>           bool set_num_buffers;
>>>>           struct socket *sock;
>>>>           struct iov_iter fixup;
>>>> -       __virtio16 num_buffers;
>>>>           int recv_pkts = 0;
>>>>
>>>>           mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>>>                           vhost_discard_vq_desc(vq, headcount);
>>>>                           continue;
>>>>                   }
>>>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>>>                   /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>>>                   if (unlikely(vhost_hlen)) {
>>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>>>> -                                        &fixup) != sizeof(hdr)) {
>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>> +                                        &fixup) != vhost_hlen) {
>>>>                                   vq_err(vq, "Unable to write vnet_hdr "
>>>>                                          "at addr %p\n", vq->iov->iov_base);
>>>>                                   goto out;
>>>
>>> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
>>>
>>> Honestly, I'm not sure if it's too late to fix this.
>>
>> There is nothing wrong with the current implementation.
> 
> Note that I meant the vhost_hlen part, and the current code is tricky.
> 
> The comment said:
> 
> """
> /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> """
> 
> So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
> to mrg_rxbuf len.
> 
> And this patch changes this behaviour.

mrg_rxbuf only adds the num_buffers field, which is always set for 
mrg_rxbuf.

The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but this 
was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers for 
virtio 1.0")

So there is no behavioral change for existing features with this patch.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>> The current
>> implementation fills the header with zero except num_buffers, which it
>> fills some real value. This functionality is working fine with
>> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.
>>
>> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
>> field, which also needs to be initialized with zero, so I'm making sure
>> vhost_net will also initialize it.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Others look fine.
>>>
>>> Thanks
>>>
>>
> 

