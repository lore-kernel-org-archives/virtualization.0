Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F03147796
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775926; cv=none; b=gNZIqDFOth/Rn3Rxejj1Tq9Cxm5Qa/+RWRRTBzrXq1shaGblkC1+sI9r6zrBWucXgY5XhFkQpbzedtzebDOSyWrKgLAx09gw3lXKr2dkzj41cqGBYF5wM3dlIPHKSMWp/9s9y2Xvj5gwX2lx+5KaxzcL0vQ1asCU2X2237dZ6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775926; c=relaxed/simple;
	bh=u+6aVQTae9UKhpweiNB0WziXXSptKc5cDjP27PTrwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwWdOH77oqNjfjm7KHyT20LmzrLQg2nQNkjMqGcYTi0n6TwVvHifJMJbAOj1c17sFhAj3dYrEwBN5F9t706eHJ5v20JLfoKxZxNxMl3OqD3ylLG+YkLrsvMkCKpg8LC1q+IGx5svBW7GFExKlHwldrffunxRYnyEPQW9QvSxJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NNl+OQgP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NNl+OQgP"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cc9b887f1so837091e87.3
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718775922; x=1719380722; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBUpXYsRWJCnSelZydra6vNcCLcuzgf3v2FxOtylRHw=;
        b=NNl+OQgPbYhvJ9aXiSHztmHAzSR5fUMShtgqnvN77mUHU71cXt4MpI/pQk2HW8ifsH
         nWNRc0f0zduyRm2tZqrvyqSkY/epyNH+QACUmmuBEDBESjs+yAPZS6/zhIPwygUxOl9d
         2gPgMnSB2f/e5GG59+Q5dFzg6W+Ygek6YyS8okfFKiCvLU4e2DHguw+JD2HgifSZU4Pp
         q6cILJUtvPnNoCC0TykNNrsr82h0efFZVlImmzb2sTjhMCSwvoJLIK7o4/UomAipRLaI
         dMQPhbd7iXsdgJhlhaxridWvPoCJOyJoLBZlJzDCbIYt+Io/bZt9JMBr2pRAndnmu0lF
         KU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775922; x=1719380722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBUpXYsRWJCnSelZydra6vNcCLcuzgf3v2FxOtylRHw=;
        b=ovIuTX2T3bCjLFF7GUOOclLsnNy9eBUVdUoQ2GEYBgFTXX7R6ozyGf87lvZKyeDrMn
         iYCcIkR1JWQ9Soep0WP+9eByAHjrhF0qoe13WkM7oUI1l9M4GMHICsM2MptZq5oi419h
         oXnMLJaomJd1ohblddkld8Ft/LdZtDAKSUHAQG1Qz8NX7kjhG6pAvYVEc+H4qzM+YImO
         KHZ3iOwkCGLxxci1Z8A3m/45MyQc1HB3nJve1j0FYb5E+a2pPHPFmTsN8Bu0zKG8+XCU
         2dY30/iIGOWXEcoUL5Y/4dkgZJcLza6aoiaRC14wqLmZs0K5kS0trM61Puiht8QOYqYj
         9fYg==
X-Forwarded-Encrypted: i=1; AJvYcCXxVY4YL6dg+O4Tn+JoQL3Mq7tHSIuG0NTXBQWw6pAmSgcBCBQas3a99u+i8zj9ILYkUqDo5ZP8ZN9cA1JS+NkeDqTD6WEEfj1tLKs/8oQ=
X-Gm-Message-State: AOJu0YwkffUr3vkSDHprqxVVUdHC6mqnKVj1ummUtphL5z16Sp6CtRBg
	RdOWCQqCtzbCWClk1C43t0EPwNif3wcNTAmI0/03518v3ohsdmWw4Qx+JgddbQg=
X-Google-Smtp-Source: AGHT+IHULcp5ds4O7fOVdQUeEh65o5RmCsUsHbk0hYjdBf9jpDqDyLmJP2czRpLMC8R+5wtj0LiM+g==
X-Received: by 2002:a05:6512:12cc:b0:52b:79d6:5c28 with SMTP id 2adb3069b0e04-52ccaa926f4mr1024149e87.52.1718775922073;
        Tue, 18 Jun 2024 22:45:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3615d7a1a0csm3582216f8f.23.2024.06.18.22.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:45:21 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:45:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnJwbKmy923yye0t@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618140326-mutt-send-email-mst@kernel.org>

Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
>This looks like a sensible way to do this.
>Yet something to improve:
>
>
>On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 

[...]


>> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
>>  {
>>  	unsigned int len;
>>  	void *ptr;
>>  
>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -		++stats->packets;
>> -
>>  		if (!is_xdp_frame(ptr)) {
>> -			struct sk_buff *skb = ptr;
>> +			struct sk_buff *skb = ptr_to_skb(ptr);
>>  
>>  			pr_debug("Sent skb %p\n", skb);
>>  
>> -			stats->bytes += skb->len;
>> +			if (is_orphan_skb(ptr)) {
>> +				stats->packets++;
>> +				stats->bytes += skb->len;
>> +			} else {
>> +				stats->napi_packets++;
>> +				stats->napi_bytes += skb->len;
>> +			}
>>  			napi_consume_skb(skb, in_napi);
>>  		} else {
>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>  
>> +			stats->packets++;
>>  			stats->bytes += xdp_get_frame_len(frame);
>>  			xdp_return_frame(frame);
>>  		}
>>  	}
>> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
>
>Are you sure it's right? You are completing larger and larger
>number of bytes and packets each time.

Not sure I get you. __free_old_xmit() is always called with stats
zeroed. So this is just sum-up of one queue completion run.
I don't see how this could become "larger and larger number" as you
describe.


>
>For example as won't this eventually trigger this inside dql_completed:
>
>        BUG_ON(count > num_queued - dql->num_completed);

Nope, I don't see how we can hit it. Do not complete anything else
in addition to what was started in xmit(). Am I missing something?


>
>?
>
>
>If I am right the perf testing has to be redone with this fixed ...
>
>
>>  }
>>  

[...]
