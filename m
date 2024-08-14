Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C221AD40B
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637785; cv=none; b=qPZSdcIY0eWL6hFqmlUQquU4045AFMVunWkJMADhWt/+74QQw+i8v5zupUe6HzzuMWMY+wuhhrOUCq2ApdZDoSJfkJA7+dV7n/OYJlJpagjGnnGSlKwQKv90yoghWtx+uaWGBIsBmQihtyTvkRKuE3tzyWdC0xD1rxPW5FZNA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637785; c=relaxed/simple;
	bh=LOXtqIv4EVemkhjUSrHDTA/YAtXnYgGDmfhh2wCEyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewKfrdp/w/9OGnBu9O0NfmxTpLE1Pt12+Et6KGqG/+gV0FuyvRrn8LaOHIlpCLCWdbcTNzOyqJ886ZF9CTSNbHS6oVk+LjDnQfsSYBu6SN+RSdEeoejoWHyEy4nMgVNUfyi9Ohjy8BGOAFSnLIPX0hV54LjQxLP9JcAdIRACncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aLlZn9qz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aLlZn9qz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso14088695e9.2
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723637782; x=1724242582; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYDRTUiCJggNa2PcVthlMSA7/lNsNWAZITIINEDwZnc=;
        b=aLlZn9qziaOXI++Y1EjiRpS0B5Ra797S5BL6Sj1G2S3lqWkM9sAg05AdiqHeFWLyhz
         QudfeYOGxICUH678utF5wk9En4My1f9XCtZRzUxw/S6YDBilqYSbaz+L4mTRlf8/6+fT
         bScpLBj8NvwdohUJmRN3NZpAmxQ5d8p7O99wxMvqJRNMIpUyjU8IneAJs8kKwWf8+giH
         gMapR60bLgn0Qyjr5DRDz4nxb8DbvSnC2jaXIcWTiuOCJT2jqJdDu7lsa3lFXm36RLU5
         q2HzDFFutJ70mTBcvC9ZySZjcDDZCcHBNVPg3YY5kse0sktNObf4gH3DcuNEwn5tzFAj
         tgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637782; x=1724242582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYDRTUiCJggNa2PcVthlMSA7/lNsNWAZITIINEDwZnc=;
        b=J9Ck5jKINNHJ/1uL6CHjLzuRCw2poGn4v2NNn78yT6TlP/wO6uLF1lyTJvxPlnyRHj
         SFhvWH+JWeQqHivrEBrj5pJl5SMl5geuZ87iMLAZQLw1iYzoxU9IZEBX0izLwZ7SfsZz
         vHqmnwcfdDNJL7bSm8BOTF/ln0bM4Zaz2nuI8SE18vyT3OoZIB5BI/AACMExrksK2v7S
         LYaAEIxqrHc4r1X+cjl4REjX3TnZSv9MUHLPVzH2WcGMe33dgW/D8gtqtQuxpIJrlKhk
         0ihabpdbWyhI92eWBCDufw54jrg5GGlUeZeKyIrUkciP96K9oeORc7L6bfHEFkYBKsFo
         O7DA==
X-Forwarded-Encrypted: i=1; AJvYcCX0sRezegn0zU9T1aIhsMV4AunLMQARjgh0Dy/JWSK1ker2gMaAJBScToq/9q8SPr34TY6NBRmOM18A16lOQPqh3gnDPDKnByDoa2AWa/A=
X-Gm-Message-State: AOJu0YwnNz5AXbxIfqI5MkvgucdUT4hMnBvs31DKrt/+2hkRr7iKus2w
	ShejQt4C8iNP89voP2WTEL8aeT2YeWBeL6mNmQo0i3+dQqQxM3hcKanK35PgzN0=
X-Google-Smtp-Source: AGHT+IGnqvle1WrbIFXUtN34+72aFtlxZcxGUlbtEIG6FFewrjtBnIeHhP/1ArXBUzRbii/b6pQz7Q==
X-Received: by 2002:a05:600c:4751:b0:426:593c:9359 with SMTP id 5b1f17b1804b1-429dd267b32mr26501015e9.32.1723637781552;
        Wed, 14 Aug 2024 05:16:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded1eff2sm18360945e9.3.2024.08.14.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:16:20 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:16:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZrygE7SjwPpdWM5G@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
 <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
 <Zro8l2aPwgmMLlbW@nanopsycho.orion>
 <e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com>
 <Zrxhpa4fkVlMPf3Z@nanopsycho.orion>
 <ZrxoC_jCc00MzD-o@nanopsycho.orion>
 <20240814053637-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814053637-mutt-send-email-mst@kernel.org>

Wed, Aug 14, 2024 at 11:43:51AM CEST, mst@redhat.com wrote:
>On Wed, Aug 14, 2024 at 10:17:15AM +0200, Jiri Pirko wrote:
>> >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> >index 3f10c72743e9..c6af18948092 100644
>> >--- a/drivers/net/virtio_net.c
>> >+++ b/drivers/net/virtio_net.c
>> >@@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>> > 	if (err < 0)
>> > 		goto err_xdp_reg_mem_model;
>> > 
>> >-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>> > 	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
>> >+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>> > 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>> 
>> Hmm, I have to look at this a bit more. I think this might be accidental
>> fix. The thing is, napi can be triggered even if it is disabled:
>> 
>>        ->__local_bh_enable_ip()
>>          -> net_rx_action()
>>            -> __napi_poll()
>> 
>> Here __napi_poll() calls napi_is_scheduled() and calls virtnet_poll_tx()
>> in case napi is scheduled. napi_is_scheduled() checks NAPI_STATE_SCHED
>> bit in napi state.
>> 
>> However, this bit is set previously by netif_napi_add_weight().
>
>It's actually set in napi_disable too, isn't it?

Yes, in both.

I actually find exactly what's the issue.

After virtnet_napi_enable() is called, the following path is hit
  __napi_poll()
    -> virtnet_poll()
      -> virtnet_poll_cleantx()
        -> netif_tx_wake_queue()

That wakes the TX queue and allows skbs to be submitted and accounted by
BQL counters.

Then netdev_tx_reset_queue() is called that resets BQL counters and
eventually leads to the BUG in dql_completed().

That's why virtnet_napi_tx_enable() move helped. Will submit.


>
>> 
>> >
>> > > ...
>> >
>> >Best regards
>> >-- 
>> >Marek Szyprowski, PhD
>> >Samsung R&D Institute Poland
>> >
>> 
>> 
>> > 
>> > 	return 0;
>> >
>> >
>> >Will submit the patch in a jiff. Thanks!
>> >
>> >
>> >
>> >>
>> >>Best regards
>> >>-- 
>> >>Marek Szyprowski, PhD
>> >>Samsung R&D Institute Poland
>> >>
>
