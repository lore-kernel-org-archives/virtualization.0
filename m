Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F12AEE2
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448973; cv=none; b=DI6Cdg6Sj3a5aRqX5SgeCLK9hc0nrAav4I6bkc+VhPHnh6ATD00YrP4AcZGEvJba38CKCKgy3W4c5nWldWkcSjG1hlAm4PuKgJ1DBw+T3S4XwTUGnJqhzkBa08Q2kVT3GbOwMuJXschoDQM1Pte7pj8xDYfnMY5FRGcIsQ9ua4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448973; c=relaxed/simple;
	bh=pykQWiiCufg9UKjHIJTQCkNZCnZqG7otAUgzUYRGDng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFGPw81dvq6CC2drGh/1k2f8+wkDetyVbyDDaus5ggzJvFJcViefUplJrF3ODotJMeLFE01czctt3qUakK3mxf5Vq0o4DEivJjR7xfmV8QCFCZIte99kQE0DvLqOcxxxOHLs92ZmT1tEk3KaXDCVgxLl68JIhiPaj/SJOT6pwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=RjLHAdct; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RjLHAdct"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225a28a511eso5720655ad.1
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742448971; x=1743053771; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbGnsTCcev6pYDQx9u/sGBjWd1vcflm1xvB7Aplfx1U=;
        b=RjLHAdctdYhJRnlCHkd18SbLlb49eRx/DSXD0mM/zyiGR/yOn0FFc2s/UzjrugeyQb
         3J6rgtxVC97OYmEErqRqOqU4+pIZQCyQFy+efAIWfoPxoccWoCP5zDkXzsJ07R/9jlXW
         Svl346tjHPSnS9oKAVhZuzt26vdV8bXfKN4rDgc1yuPQhxVXMx2QqCcuWbpf5oGNnZG8
         Gv9qIHsw/zHp+bHtghOUV0WfoWu9tKkZYPnhwDQmcPmHu8D/0kEunA2j6pH6ZftiQPuE
         YjklvRPq3OPR4tW5S6yQF/t+zYtz4xBT2ODR3PEmZxUJOUqRGiN39O4iCTTfKe7USdpn
         wkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742448971; x=1743053771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbGnsTCcev6pYDQx9u/sGBjWd1vcflm1xvB7Aplfx1U=;
        b=KnUz/6ndOJw3SieJsKyltswuRxE37JnQkmjF6KmUPdr9s9VRVGnemxT+aPD8wyVNIg
         ZfMLvPthvCUAglteZxQCqw+0GoLxNTZp+FirZgn/n5LxmnlPoi4X3nOuI1RtDAkzmnCn
         qN+FjIP8uodCT8bDncM+kQ5nKzz82HyJzmafs7Zm2FxM4Q/NPYtYLIASfrP5QdT6kzsL
         Lr7jngJAqqt6Qa6isWswR6WQrDliYenTxkcNC11F9z3eMr7irPYOfXDJ5VXH8T3MbkYz
         OmrCjM0Og8103F9rn9Wa8jrcv8MIVrzfJ/h+wmPnO+ibzAoOjSNZeKDuyygvk/ZZInEk
         qASg==
X-Forwarded-Encrypted: i=1; AJvYcCXum1A7dcwUWO6cjE7GOoJE2qDBUwUugVIyX3wkb0GfxX9TwOuppgzFdqYbECcci5dQ5A7SqlIj9LoATN3PMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP6b/DdJ+9TBlLoMDZhM7OqC6AdJuum1ZJSG9Xz3JdaK0ho9W/
	tI7WH891VZ0UyiMaROW8V4neBT4vuRk50U/u0IbFcC5WAzf5UgyG7oAGyDo1H38=
X-Gm-Gg: ASbGncv2iIoZAe07jNy+NZ8OA2mqVE361LspkPe9an5vcCqOpGANq1k4xwo5q4VSrZk
	pzPwsBEH6/Aoft7CXUe8Bpulw1FnBks55/Uvbump/g4Mu6hhQmkzGmDLc29yC3vcOvSWq6ZXxgF
	pU3O7ARGFSCcN9MXrbtw9V5c93mQyKG1D+sGC4IzV1tzwomBFdRDLi4dNMrKCGTPHbqr18dz5v2
	58/rZF1Q1dJB3de7R1EBgKCTkiEBjT15io8+lmZ85348pVFOdFSlp2KQUtIGhoVdvRHWFlkt8Az
	zKp+vVt9wd5xqUdq0yD6yXtFjky8RVFm7NrzQ/cmMjGDzBd/VZFk9122Iw==
X-Google-Smtp-Source: AGHT+IErhQqYwyVfjSSFE49cyYQSwTfv6bxLT2Cv1e2uEHao33rhRGfa+oAbBrQwdclN/m7vUf+GeA==
X-Received: by 2002:a17:902:ce0d:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22649ccca04mr93156685ad.53.1742448971138;
        Wed, 19 Mar 2025 22:36:11 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm125565465ad.149.2025.03.19.22.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 22:36:10 -0700 (PDT)
Message-ID: <83a5ab7b-7b29-413e-a854-31c7893f3c4a@daynix.com>
Date: Thu, 20 Mar 2025 14:36:06 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
 <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
 <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com>
 <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/20 10:50, Jason Wang wrote:
> On Wed, Mar 19, 2025 at 12:48 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/19 10:43, Jason Wang wrote:
>>> On Tue, Mar 18, 2025 at 5:57 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> The new RSS configuration structures allow easily constructing data for
>>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
>>>> for the command.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
>>>>    1 file changed, 43 insertions(+), 74 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index d1ed544ba03a..4153a0a5f278 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -360,24 +360,7 @@ struct receive_queue {
>>>>           struct xdp_buff **xsk_buffs;
>>>>    };
>>>>
>>>> -/* This structure can contain rss message with maximum settings for indirection table and keysize
>>>> - * Note, that default structure that describes RSS configuration virtio_net_rss_config
>>>> - * contains same info but can't handle table values.
>>>> - * In any case, structure would be passed to virtio hw through sg_buf split by parts
>>>> - * because table sizes may be differ according to the device configuration.
>>>> - */
>>>>    #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>>>> -struct virtio_net_ctrl_rss {
>>>> -       __le32 hash_types;
>>>> -       __le16 indirection_table_mask;
>>>> -       __le16 unclassified_queue;
>>>> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
>>>> -       __le16 max_tx_vq;
>>>> -       u8 hash_key_length;
>>>> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>>> -
>>>> -       __le16 *indirection_table;
>>>> -};
>>>>
>>>>    /* Control VQ buffers: protected by the rtnl lock */
>>>>    struct control_buf {
>>>> @@ -421,7 +404,9 @@ struct virtnet_info {
>>>>           u16 rss_indir_table_size;
>>>>           u32 rss_hash_types_supported;
>>>>           u32 rss_hash_types_saved;
>>>> -       struct virtio_net_ctrl_rss rss;
>>>> +       struct virtio_net_rss_config_hdr *rss_hdr;
>>>> +       struct virtio_net_rss_config_trailer rss_trailer;
>>>> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>>>
>>>>           /* Has control virtqueue */
>>>>           bool has_cvq;
>>>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
>>>>           VIRTNET_XMIT_TYPE_XSK,
>>>>    };
>>>>
>>>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
>>>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
>>>>    {
>>>> -       if (!indir_table_size) {
>>>> -               rss->indirection_table = NULL;
>>>> -               return 0;
>>>> -       }
>>>> +       u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
>>>>
>>>> -       rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
>>>> -       if (!rss->indirection_table)
>>>> -               return -ENOMEM;
>>>> -
>>>> -       return 0;
>>>> +       return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
>>>>    }
>>>>
>>>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
>>>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
>>>>    {
>>>> -       kfree(rss->indirection_table);
>>>> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
>>>>    }
>>>>
>>>>    /* We use the last two bits of the pointer to distinguish the xmit type. */
>>>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
>>>>
>>>>           for (; i < vi->rss_indir_table_size; ++i) {
>>>>                   indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>>>> -               vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
>>>> +               vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
>>>>           }
>>>> -       vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
>>>> +       vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>>>>    }
>>>>
>>>>    static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>    {
>>>>           struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>>>> -       struct virtio_net_ctrl_rss old_rss;
>>>> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
>>>> +       struct virtio_net_rss_config_trailer old_rss_trailer;
>>>>           struct net_device *dev = vi->dev;
>>>>           struct scatterlist sg;
>>>>
>>>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>            * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>>>            */
>>>>           if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
>>>> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
>>>> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
>>>> -                       vi->rss.indirection_table = old_rss.indirection_table;
>>>> +               old_rss_hdr = vi->rss_hdr;
>>>> +               old_rss_trailer = vi->rss_trailer;
>>>> +               vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
>>>> +               if (!vi->rss_hdr) {
>>>> +                       vi->rss_hdr = old_rss_hdr;
>>>>                           return -ENOMEM;
>>>>                   }
>>>>
>>>> +               *vi->rss_hdr = *old_rss_hdr;
>>>>                   virtnet_rss_update_by_qpairs(vi, queue_pairs);
>>>>
>>>>                   if (!virtnet_commit_rss_command(vi)) {
>>>>                           /* restore ctrl_rss if commit_rss_command failed */
>>>> -                       rss_indirection_table_free(&vi->rss);
>>>> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
>>>> +                       kfree(vi->rss_hdr);
>>>> +                       vi->rss_hdr = old_rss_hdr;
>>>> +                       vi->rss_trailer = old_rss_trailer;
>>>>
>>>>                           dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
>>>>                                    queue_pairs);
>>>>                           return -EINVAL;
>>>>                   }
>>>> -               rss_indirection_table_free(&old_rss);
>>>> +               kfree(old_rss_hdr);
>>>>                   goto succ;
>>>>           }
>>>>
>>>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
>>>>    static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>>>>    {
>>>>           struct net_device *dev = vi->dev;
>>>> -       struct scatterlist sgs[4];
>>>> -       unsigned int sg_buf_size;
>>>> +       struct scatterlist sgs[2];
>>>>
>>>>           /* prepare sgs */
>>>> -       sg_init_table(sgs, 4);
>>>> -
>>>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
>>>> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
>>>> -
>>>> -       if (vi->has_rss) {
>>>> -               sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
>>>> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
>>>> -       } else {
>>>> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
>>>> -       }
>>>> -
>>>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
>>>> -                       - offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>>>> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
>>>> -
>>>> -       sg_buf_size = vi->rss_key_size;
>>>> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
>>>> +       sg_init_table(sgs, 2);
>>>> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
>>>> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
>>>
>>> So I still see this:
>>>
>>>           if (vi->has_rss || vi->has_rss_hash_report) {
>>>                   if (!virtnet_commit_rss_command(vi)) {
>>>
>>> Should we introduce a hash config helper instead?
>>
>> I think it's fine to use virtnet_commit_rss_command() for hash
>> reporting. struct virtio_net_hash_config and struct
>> virtio_net_rss_config are defined to have a common layout to allow
>> sharing this kind of logic.
> 
> Well, this trick won't work if the reserved field in hash_config is
> used in the future.

Right, but we can add a hash config helper when that happens. It will 
only result in a duplication of logic for now.

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
>>
> 

