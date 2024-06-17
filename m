Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C45194122
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615906; cv=none; b=Ypa5+pQps+VTTIGV8g8A52kfIKehlNhI2N/0thXfjsvoQ6ooXsZXx9w34SAlQag1fEBw8F7y9/SQ2+/jfomiup8T8MoIBEy/47gwbaLYA36uxab5iTlCnFdmUUS9RAqH7+zrTvwiHNQEwHN6xyjgBdSX3vBBn9XfOBC3w7uMKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615906; c=relaxed/simple;
	bh=60p88lXRnFxWwD0DE/HWIs9gL3qFPJpsKvKfDLWGtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isvxwxrspvh/AFnwa76n7VEMhjvZBTSOmCRp/j+mLv1cuTJHg65Nj7BREeSs1Kyfn19ig5caYFVRNfspJO4bbmyNbZAmZFFbQUaQBH/A/hxvEdgAVwA6sYdUVoMA7wrFRstRt4gHxvAJFXsMm0HB8wu2yDPKDgNl9E5ni/pcRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QvGTtwJT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QvGTtwJT"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f275c7286so3710452f8f.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718615903; x=1719220703; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POfDX3xWgrJgT8Fq+G401F4a/WRA9742U2LN9jolq6Q=;
        b=QvGTtwJTQ/SXY8qNTmPSdE+Ejo+XJceCK95TrsA1jYc8EV/9kQCGJGIGWJLu0G8nRD
         1WehiTv9pFXUGfuSI2pDm+hFP2UDIe59jgTNRcbkGQXyNwKvl6sSeA3wKlj8xGGKBvcG
         svyJlk1fTlA3lvWXk0yit3xCAoqgzL0l1fRIJcSJEJCV8qm9HamQXLjYmIZr1cR/ureH
         +e2QyV090HMIo/88xj4uESU1bwguIzIEQU9UFPcv4dg2nwX9+lhv5TEQ4NgWO2kYYhCr
         GapeF801MJd2FuDzTH3zx1r7jyjTsbDgtlVpcrUWpUOuZA/0/eL/VYcAB74iDPdMXmIF
         /0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615903; x=1719220703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POfDX3xWgrJgT8Fq+G401F4a/WRA9742U2LN9jolq6Q=;
        b=oLY+Egb0RfmSNegRFsGoK3/4nY0phfn6ZZS13m1VUsSTPtmr9QlvicjdIskXGfPQP0
         nM6HeMx2gGpRdMjb5R//lslNDgF08yMexSkJXeBmH5dD1aLmjK0zYjLjdUVSjPeXdHlP
         /QKimoSCQN0CXKILdO4jqI/SLXPa6ZcczGjJxHuzk5bEOdQKj2Zaj82awoxAE/Q0bgym
         6g4w8R1INogFrTeMhjAq/AtZANM0FgyY6wMN+Qeg4MFjRsTDeU7rzz50qeK16TXmaI66
         i4U1xgd2tkITna42yH0Lf0vsskODKuNs6Ame9/2XHWbBOf8Se9yKpIyWZRIymwAALdrD
         rXKA==
X-Forwarded-Encrypted: i=1; AJvYcCVlLoQXqx504AYGe9SSh79KElldt6q8EsJpRbJq9W8SM8lHbhJUJ+zg0VwlEfFLrEKgfwDg2p58905Gk/HtLMKxogSDiaH1dGoWiMaoUj4=
X-Gm-Message-State: AOJu0YxKxJygu9b1dN30DbujRBYyOO/M43sdJJpRehKXMNAonuRm+rsv
	sAgabwkrIOy4u61UQwTjlDJmReYZbPhipCcg/6p9gHbm4IpLEbsgLmItaljLlDo=
X-Google-Smtp-Source: AGHT+IFc3xNDHvg8DJDW+rOLA6i/+nFtomWf+/l7TwKCWXAEUYTKks7voFma+B6f2Aaqai0xRQn9jA==
X-Received: by 2002:adf:e9c9:0:b0:35f:3068:56a1 with SMTP id ffacd0b85a97d-3607a781a27mr6160588f8f.54.1718615903203;
        Mon, 17 Jun 2024 02:18:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2407sm11567394f8f.72.2024.06.17.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:18:22 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:18:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <Zm__WzuGEV8OdEKR@nanopsycho.orion>
References: <20240612170851.1004604-1-jiri@resnulli.us>
 <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>

Mon, Jun 17, 2024 at 04:34:26AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 13, 2024 at 1:09 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Add support for Byte Queue Limits (BQL).
>>
>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> running in background. Netperf TCP_RR results:
>>
>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>   propagate use_napi flag to __free_old_xmit() and only call
>>   netdev_tx_completed_queue() in case it is true
>> - added forgotten call to netdev_tx_reset_queue()
>> - fixed stats for xdp packets
>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>> - handle the !use_napi case in start_xmit() kick section
>> ---
>>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>>  1 file changed, 32 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 61a57d134544..5863c663ccab 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>
>>  struct virtnet_sq_free_stats {
>>         u64 packets;
>> +       u64 xdp_packets;
>>         u64 bytes;
>> +       u64 xdp_bytes;
>>  };
>>
>>  struct virtnet_sq_stats {
>> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>>  }
>>
>> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +                           bool in_napi, bool use_napi,
>>                             struct virtnet_sq_free_stats *stats)
>>  {
>>         unsigned int len;
>>         void *ptr;
>>
>>         while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -               ++stats->packets;
>> -
>>                 if (!is_xdp_frame(ptr)) {
>>                         struct sk_buff *skb = ptr;
>>
>>                         pr_debug("Sent skb %p\n", skb);
>>
>> +                       stats->packets++;
>>                         stats->bytes += skb->len;
>>                         napi_consume_skb(skb, in_napi);
>>                 } else {
>>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>>
>> -                       stats->bytes += xdp_get_frame_len(frame);
>> +                       stats->xdp_packets++;
>> +                       stats->xdp_bytes += xdp_get_frame_len(frame);
>>                         xdp_return_frame(frame);
>>                 }
>>         }
>> +       if (use_napi)
>> +               netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
>> +
>>  }
>
>I wonder if this works correctly, for example NAPI could be enabled
>after queued but before sent. So __netdev_tx_sent_queue() is not
>called before.

How is that possible? Napi weight can't change when link is up. Or am I
missing something?

>
>Thanks
>
