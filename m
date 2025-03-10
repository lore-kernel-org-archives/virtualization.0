Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61321D5142
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590291; cv=none; b=XqaKNribVJMUhoEV2Td4O0cy9bXTi7EWPktd6unfCrnDq14b7Txh7qOrLlZT3b2D8hcMaVaF3kpRpgAIBtpMNn9bAPEBOv/yoVINTQ62QuCU2JO5AeZiZC7ljbxwo57GlfBRxE16jlJxFVFTHJvPJI+2szDwSiG1tcE0cB0ZDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590291; c=relaxed/simple;
	bh=eSw/Sz1ql/4UPcLEbJRVUH0uYPxF2xmC0A18fnAZuI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cphCv3Bp2hr3jc5G/KH6VNrkMQ/yi9TflgBCKgCnJyxyz39Cp4yvVI92Gz2AhnIOZ3yZloD/SV9EIs0PTlLYbzyDU5trWM0mNUaFLHR0UCcWTBSZbzbnixfoXoIP2Xd016BR+fQ+3JK5VJfVTlIyufoBldj4RtqRY+drdIYBtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=MaSUVpD0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MaSUVpD0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2800D40562
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 07:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8B41g2n-DYC for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 07:04:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2848640549
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2848640549
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=MaSUVpD0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2848640549
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 07:04:49 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2234e4b079cso65467405ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741590288; x=1742195088; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=MaSUVpD0VgK9AdR/KtUJaFj4XnXT4t6c6u51n4yWLMXzosiaOsZ6GcfycvHtcu2qu0
         EuGVw8mr/DYegKDQEDQSs3HZ1NFp4yazI2+PU6QrFePPk836e8k9b5kotdtsWAgG3vV8
         ljf++ZwD/bIPDEXJmpq+zGqR1Ir3ckJ2RhDcU87G5M5IB8HDkF+ZwBaxCCxNxA5kAKzI
         RXGig+mOSJhPUlobYawnhAxZK7XBIhTjlgEbFvFsqKd1P/Gwr0d4x7wSSOQBsCmkYNOb
         PwDQtsChuYCpvAdGG2krRQO2okGn/65vvW3lkD67Zae2hC+vIme+wbPsLRwftyUVGKv0
         TMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590288; x=1742195088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=Tx5fzrWKB9Yy2gx6HerDAoLWz6h//4bFMs/ESfG3V6LO9fjFSZjEOU99MKl8ygkWc4
         ZfgEi9Mfq70L4uJPYNYg8/tkJl+PoSej4+6y2CtqfGVhAACwdsy/nsx3M6vJXw9cUCcE
         EQyXIBjrJ/x/lUr4Q/6XBsj+MrIPLuFpM2wXJm7SPmHlSrhInfZspkozcIqaLIfoBKFz
         C2sCObFlT/UQqCd0N6gjA7BvdJeKuFy5prp5lr6DYmlv3BDdtF7MOQASFX+nZUzax0TU
         oXeCC4q5kDcZ/ncS4V20TAQs6HUeA2EZWdYT5cjEAcRuYOMpwx7bLeJ3KlgCc0IOVErL
         +BSA==
X-Forwarded-Encrypted: i=1; AJvYcCU6tJlGufBp+eKSeL78oAdSpPkWXtAawygOZbWDjzJhDig5b6wbuo+dCNwLay7UPBELe1MZmV21cFm2Z4exmw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwcMuoAVHAIxp/iU7aYV5aEIAfiUfabgk1bEXDYDhP0EWT423Ii
	vkFH/0mk+Iq4fPQb8M//Ll6i4vfqmw9gIUq5NX9kKzHvfrqMj3TXfXWH2DZzHNc=
X-Gm-Gg: ASbGncvotPi4dvtaZ2u9r2vwlPFv+Xi+OWU/GcmSovvnIGOWY4XMIxcgKr1U5sEfhmv
	Dw4JcfHZPS0p6UklY/ZAg4/e6XCp3UHct5GqgkAQVfSOrljTAaK4ODxQtyUwEVTakeG3YYVPg5R
	988z3yOPk79UiH2SJ0a3LvJn56MtCMREKah37vUaLvuR6Ca/PqUDx93ep+3NA3AfiC5aL6kvvFK
	B01UxfY0yfDau+Syi778sIXhcbTIJ70FjrtHYlTeKEhV9WvtR6owTUJqpnVjCXo13N4LUKrzd8B
	9T7XwB6qaHfMFokl1LdTNKCOllQ0D+o2XTR+eZ3upKEgEZaxF4AeDM5pbQ==
X-Google-Smtp-Source: AGHT+IFkDjhIOqYcqagzT94jgytjjwhSIQTT2o6zqPzPIQtmCm+lioqyAyJhjHPUINzm2ba//BDswA==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr196310675ad.2.1741590288383;
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f93esm70081685ad.142.2025.03.10.00.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Message-ID: <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
Date: Mon, 10 Mar 2025 16:04:43 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:43, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>> hash values (i.e., the hash_report member is always set to
>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>> underlying socket will be reported.
>>
>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 29 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -73,6 +73,7 @@ enum {
>>          VHOST_NET_FEATURES = VHOST_FEATURES |
>>                           (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>                           (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>                           (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>                           (1ULL << VIRTIO_F_RING_RESET)
>>   };
>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>                  .msg_controllen = 0,
>>                  .msg_flags = MSG_DONTWAIT,
>>          };
>> -       struct virtio_net_hdr hdr = {
>> -               .flags = 0,
>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +       struct virtio_net_hdr_v1_hash hdr = {
>> +               .hdr = {
>> +                       .flags = 0,
>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +               }
>>          };
>>          size_t total_len = 0;
>>          int err, mergeable;
>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>          bool set_num_buffers;
>>          struct socket *sock;
>>          struct iov_iter fixup;
>> -       __virtio16 num_buffers;
>>          int recv_pkts = 0;
>>
>>          mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>                          vhost_discard_vq_desc(vq, headcount);
>>                          continue;
>>                  }
>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>                  /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>                  if (unlikely(vhost_hlen)) {
>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>> -                                        &fixup) != sizeof(hdr)) {
>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>> +                                        &fixup) != vhost_hlen) {
>>                                  vq_err(vq, "Unable to write vnet_hdr "
>>                                         "at addr %p\n", vq->iov->iov_base);
>>                                  goto out;
> 
> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
> 
> Honestly, I'm not sure if it's too late to fix this.

There is nothing wrong with the current implementation. The current 
implementation fills the header with zero except num_buffers, which it 
fills some real value. This functionality is working fine with 
VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.

Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report 
field, which also needs to be initialized with zero, so I'm making sure 
vhost_net will also initialize it.

Regards,
Akihiko Odaki

> 
> Others look fine.
> 
> Thanks
> 

