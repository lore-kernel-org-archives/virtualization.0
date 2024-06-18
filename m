Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9C13D25E
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697167; cv=none; b=uKOE4GM2WEfxuoIO79POJAQtJwkYbeytPZ+ZhsqijBwGvL02qjgLYgne6Lx4qF/bohG4LkbjgjCdds1Bc/Drexak0eQzXZIgHkJXctt9zDvc4YDu/pqUK7Q+OEX30A9LnDSJkp4O1m2Z58vdbH+nggoGGySpswILKBN1Hjx3ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697167; c=relaxed/simple;
	bh=VNEo19Tc5MJTiO5fT03+bouUbfa/076D4b1voV/qyao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwInPXK3Rr2td/lsEMdcNgZNHBG+H1JbOoLGRCd720mICYlAtHHuuyOknhvI/r8TomLOEga57kwKz2Fen6RpUV5nMbZ70yVd2I/3jtGgLdGdHTBkzj6qewiLLvyyvYcJnpQk/5C+fsqqKcBVIjNlEP6XVv3SGVkwz4tg/F/b71M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kmyGX9Hp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kmyGX9Hp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f14af40c2so4321649f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718697164; x=1719301964; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/XI6WSwtia3EjF/qcHL88JwGq0UZpvShFE/yvYgKu4g=;
        b=kmyGX9Hp4LNnKf35l4WN2k2qX+5EKjgVuH8mfYaLju56EWluAPA3IElINIpQ5LFfGh
         rHvvKJa9TO73olmsMBJRUcxm29ahkHPKuh3eLXRE6a5sx99e4h9zONTGg78Wot23y7sP
         0Ve49y5ilfDnYagqa4w9pfX/zqfNkGeCc7AuZw02YEEagTCkmynaX7FikdmAlUUmXitm
         JFcxVo37nv4+hapzyXzZXnBLOVCYCuiMKIRLq4JTrB812JdHSdNY1gQMYtEI8zIbOG61
         FVoL/A97gQ1HD4kDK4P6aliYRFasqE1cOYSGX/Qc3T15a8LahRenRSoe0N29IS8B/9Fv
         41wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697164; x=1719301964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XI6WSwtia3EjF/qcHL88JwGq0UZpvShFE/yvYgKu4g=;
        b=qAnWIjcB/IhHG/Q7v2X27JMxHkkjYRtfObMYHC7Q6ljra/SBAnyrSnmLjrXCwmMk2C
         yglFs2ToQ6QPTcG9W8qF2u0+6q3fv/ciCV2G0CifUsam6saaH3FJrKXw4WGND02Ag3kv
         X53pynmxyWrM3i9SX9QP3nrwRIpucJ5zdxqz7pgnI44K6/6D86rV+df3qqf2rA0Fhgk6
         5Q1TdIJJqhKmezq1SEv9O8zUckAqwPe2pWcgvBw/zXMshS5WUS8LYIW2xz0KVplUk8M0
         ZT8IueqoXPZQYIPc8faOOGjrlTMwFhC78DyJyZp4BOJu8Y/Ckf2JS70FrcvzXQn9EDi9
         JirA==
X-Forwarded-Encrypted: i=1; AJvYcCWgUqz1NZzRubxZcquslXIcq6scGUzGzRTRPir25k1SAx+MDjYxLOzz92kNnyFbx3UIn/LO96/PDRpAdAqRY/XVUOHhuYd+eaI5A8mahCg=
X-Gm-Message-State: AOJu0Yznudt+xCpHuPfbWtC96MlLt6vWNzLQstv5BX5ixYvtECG1Xeud
	/9Cof0f89d1xvx7M+MRID3pzY6M2z3XGr+0ZUmVcaKFBGkVvpZpWjW2Z7tubhNY=
X-Google-Smtp-Source: AGHT+IF1XsFupWj3HhfJxQ7LjsEbbKSBNrBVVdNZN9TU3kkhg3a/RnyXA8WufdFDaI/EexvRvBDwRw==
X-Received: by 2002:a5d:6903:0:b0:35f:209b:c10f with SMTP id ffacd0b85a97d-3607a782476mr8245733f8f.68.1718697164430;
        Tue, 18 Jun 2024 00:52:44 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2263sm13700598f8f.83.2024.06.18.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:52:43 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:52:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnE8yKDl5O-UkBS_@nanopsycho.orion>
References: <20240612170851.1004604-1-jiri@resnulli.us>
 <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
 <Zm__WzuGEV8OdEKR@nanopsycho.orion>
 <CACGkMEt9Vokeh6n8DKdBcqLRKVEXvNzM+-Zwad5eeMHvOdxXPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt9Vokeh6n8DKdBcqLRKVEXvNzM+-Zwad5eeMHvOdxXPw@mail.gmail.com>

Tue, Jun 18, 2024 at 02:53:42AM CEST, jasowang@redhat.com wrote:
>On Mon, Jun 17, 2024 at 5:18 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Jun 17, 2024 at 04:34:26AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 13, 2024 at 1:09 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> >> Add support for Byte Queue Limits (BQL).
>> >>
>> >> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> >> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> >> running in background. Netperf TCP_RR results:
>> >>
>> >> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> >> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> >> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> >> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> >> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> >> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>> >>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>> >>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>> >>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>> >>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>> >>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>> >>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>> >>
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >> v1->v2:
>> >> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>> >>   propagate use_napi flag to __free_old_xmit() and only call
>> >>   netdev_tx_completed_queue() in case it is true
>> >> - added forgotten call to netdev_tx_reset_queue()
>> >> - fixed stats for xdp packets
>> >> - fixed bql accounting when __free_old_xmit() is called from xdp path
>> >> - handle the !use_napi case in start_xmit() kick section
>> >> ---
>> >>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>> >>  1 file changed, 32 insertions(+), 18 deletions(-)
>> >>
>> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> >> index 61a57d134544..5863c663ccab 100644
>> >> --- a/drivers/net/virtio_net.c
>> >> +++ b/drivers/net/virtio_net.c
>> >> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>> >>
>> >>  struct virtnet_sq_free_stats {
>> >>         u64 packets;
>> >> +       u64 xdp_packets;
>> >>         u64 bytes;
>> >> +       u64 xdp_bytes;
>> >>  };
>> >>
>> >>  struct virtnet_sq_stats {
>> >> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>> >>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>> >>  }
>> >>
>> >> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> >> +                           bool in_napi, bool use_napi,
>> >>                             struct virtnet_sq_free_stats *stats)
>> >>  {
>> >>         unsigned int len;
>> >>         void *ptr;
>> >>
>> >>         while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> >> -               ++stats->packets;
>> >> -
>> >>                 if (!is_xdp_frame(ptr)) {
>> >>                         struct sk_buff *skb = ptr;
>> >>
>> >>                         pr_debug("Sent skb %p\n", skb);
>> >>
>> >> +                       stats->packets++;
>> >>                         stats->bytes += skb->len;
>> >>                         napi_consume_skb(skb, in_napi);
>> >>                 } else {
>> >>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>> >>
>> >> -                       stats->bytes += xdp_get_frame_len(frame);
>> >> +                       stats->xdp_packets++;
>> >> +                       stats->xdp_bytes += xdp_get_frame_len(frame);
>> >>                         xdp_return_frame(frame);
>> >>                 }
>> >>         }
>> >> +       if (use_napi)
>> >> +               netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
>> >> +
>> >>  }
>> >
>> >I wonder if this works correctly, for example NAPI could be enabled
>> >after queued but before sent. So __netdev_tx_sent_queue() is not
>> >called before.
>>
>> How is that possible? Napi weight can't change when link is up. Or am I
>> missing something?
>
>Something like this:
>
>1) packet were queued
>2) if down
>3) enable NAPI
>4) if up
>5) packet were sent

Gotcha, will try to fix. Thanks!


>
>?
>
>Thanks
>
>>
>> >
>> >Thanks
>> >
>>
>
