Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D9283FC3
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314609; cv=none; b=CEZZTp3G1W3QDTZXqzq9/Sr/fL3DT/TeINd6djkCLCKWTsxQd6BPESRiDvcLxEZX9ZCyxLrJRpz0efwD1WwhI/IabN84stU4rorLaldg2Xa9K5IFMzBYif8nI4V3c7koRNsTFEcfMypUDaQVvpqwSQ5Vucw7aYjo8d3qkqyuIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314609; c=relaxed/simple;
	bh=lHu6MXmC881GNys4A4x9dwsGJnuct71yJhITMvkSNBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1NVNVU8wKfZtZcdD/pBuOHegAq5lEl6j9hvMKZ+LWZdCGSRMQczAPdChzfJVIkUf4xy8ME1jkX5/fL9ARnhB6ruLRVfdjIsMCHu5mXWMe9QlZ7hzbYaKV3ohZycFeOPm8cFTXinZe+9RwdtgXYG5/W30G1z95uUpw6I7+kK1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFU/dZ1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFU/dZ1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768314605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
	b=QFU/dZ1a8NlbMjuSzMe/cxMmRXci8UZAX8ttovMPSYp9vY9/AXgRhlZJGA3qI300cCHH68
	/32haXfWVOzWFrh0hJZZ6dNUjEFzvTcGXd2SjURrBqGD2/bPqsgNKARgpgmPiHm/S6IC3X
	5NO1RM6Z36Kp9nrqImlob0JiggukSGk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-S1PhMZXgPJu-rqOvX3GNFQ-1; Tue, 13 Jan 2026 09:30:04 -0500
X-MC-Unique: S1PhMZXgPJu-rqOvX3GNFQ-1
X-Mimecast-MFC-AGG-ID: S1PhMZXgPJu-rqOvX3GNFQ_1768314603
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso6218453f8f.1
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314603; x=1768919403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsGMLadexo/nCzuVTGjgLCJkB33PukmvAkeDyomNP3Y=;
        b=X2b9GJXah1d3c/u+O/HDsO+DQdqyspVmaF7gCBvJAUC9ZmAad5HC946eqTuyL9+ekg
         gkyB5bUagMvsg4GBant7Q40eojclmIsWrv8GzjEigcHahBiIUWaPPqCHYRSbaMR51o2H
         OBdei7Weqfu4ea0ww+5RaKw3g5+BAGK8pBkhdK6E1tewOnlmddZJqlCVyCquDKOrdjAD
         i5nHOqshIM2CQmWy+k3nUpRPJGLdSnDDHdyhHlQtYX8J6WmxmpQ6j5RBMsVejE01vtzi
         WqnqMIORxKAF5kISQA/qs4cyGcqn2mTss+UEcMaqyZnqKkiCTHN0kcmPCZFTVF7Tpp/a
         ATnw==
X-Forwarded-Encrypted: i=1; AJvYcCV+/yvvXZL2EcDgEVEnv31Ax2EfAsjbp0rD6FnQjHMq7t9H+0hQ+q8ng6bikSlScd3jb9iqF+zzQPnhKzkXjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6rxQmHKj/qcOA/PstuenNX/D9cA+aElYMyUP0uE0kLT82heuO
	7WeofM2ScrudwAAH2Jqu70ME+wf3OWhf2+PBHZkZ0Ibo8h/FrLduJlkZn7F+UKkfAKXoVcukdRD
	Tbuxvp97tuUHEiOauKbNKN0YN3j4wP2mHLlx1i0IiGj8+zoeoofGh2Vol/DSdRR5ntNcy
X-Gm-Gg: AY/fxX4dc47LosqOXr2O5DMfBhGuKqgRCN9TohA678R298bqE5BE+AK9f3EfqhraeO7
	uKy1tDlx2RY33G2rrVHNjQsty311xsfR2aa3MlEfA9D/pte6PCr5qYAkUO/UGLKPf6dD1SF1X5Z
	asBEgC/6MRDNusJrF3TKlF/4XYWvkLnipK6tykAiLiTAPaefkyaPXXRERC8ZbX9z7NLxX95vuvf
	qnuUnSIXITuFfRmAqRznEN37UeAuCjteEryvj9aGNzYF42O9JCo9BFsm7SYOtNdGe+T9NImHswI
	0YNFrq0GSlxaqe3vTwn9NErPQpY0uE5slZq5WnPbJBH6pfR1llnsU9gd8mtTk8mXqujYcB7/zyW
	qAwkFaY8YCd1d
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992657f8f.57.1768314603286;
        Tue, 13 Jan 2026 06:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/QAVAjAHGrbVqsroQVjucumpuberxPHjIK5D6+36lcnv98Jxe8Pu+ntURZqANmPNOZ6UFhw==
X-Received: by 2002:a05:6000:2411:b0:431:c2:c632 with SMTP id ffacd0b85a97d-432c38d22f0mr26992605f8f.57.1768314602838;
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm47097191f8f.24.2026.01.13.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 06:30:02 -0800 (PST)
Message-ID: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
Date: Tue, 13 Jan 2026 15:30:00 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jn_Q-Xki27Ic3uRdL5WUNdY-pTrmWQ4mreKCcqX6tqs_1768314603
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a result, the RSS key passed to the device is shifted by 1
> byte: the last byte is cut off, and instead a (possibly
> uninitialized) byte is added at the beginning.
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.

@Michael, @Jason: This is still apparently targeting 'net-next', but I
think it should land in the 'net' tree, right?

/P

