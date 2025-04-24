Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24822AE7F
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495341; cv=none; b=sN/Qe6NE4qpdAQlovOfsixsV34e9Uv4o4GJWkwWVkr8l/pkqw3193kK9tbIn/I9BXgR2/8euADR3I4k/dv80cmSju1+Lqev9JNVIUpurOquho/bQYUgJlFTahswjY27Zx000gQxOhCv6xrUG3QCamlTqsHdt2V+Og3uuH0RWjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495341; c=relaxed/simple;
	bh=8b1jn4QM3miujpAVj4Ao/BPpGT15pdXb8SsrQOErUjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GjHYvfhzTp3jtuVy8AGI8X9k+yJ1WbxoyTpJJ43TO+CsVkBHjVK1P1BHxwsdHG46+TzYVEc5lUgcKR7cdvM2FoIYo+wZy3b5QTDr9DsVpMHjMnv5CGzh3HDanMkYKRRuzH0/r80GTo+nvxfB3MEzCF2lViLi7eWV/rL+iduzOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4R8/Eio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4R8/Eio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745495337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4htAbypt1PAw8cs1ZfgYILn5gui78YIttCMWVT2xuTY=;
	b=O4R8/Eiok191WaaTSPcTwnYfCYubI79ttAT3v1HpZFwY0JdowR4AU9xiggbDSardkivgdR
	VdnLcQ3iJYNQGhQXo0l9vOpKN/0rplIE0ISD3ULmdGH+G3AGlF02rCSiQ2lKvGJACkUNr6
	fnl9hPGlxTqW1/Lixc+8It0m69Kp+84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Wnd6xePXMKCoOLFOkPeEVw-1; Thu, 24 Apr 2025 07:48:56 -0400
X-MC-Unique: Wnd6xePXMKCoOLFOkPeEVw-1
X-Mimecast-MFC-AGG-ID: Wnd6xePXMKCoOLFOkPeEVw_1745495335
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-440667e7f92so4578365e9.3
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495335; x=1746100135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4htAbypt1PAw8cs1ZfgYILn5gui78YIttCMWVT2xuTY=;
        b=D/z52fdzA2DWd0eGvk6nIXZQA2o7fM7NSS3gbWrUbVhRSyjm8dz4qakDCR0skKxTjC
         7Bm5qbKHgPOm5ObV+pUCb/c1EbwnAt4a5DBiAipNj8lrDTj2DXHGzRw4AjSpe4/B6Nx+
         1BxCHHw56hlGYL9ziRuYnMJwoJwoHqwPcYvHh45Pvkfzs7yefZjKpPt49wIUAX/gfmdH
         oyFVfOuIpSCnaA+m/2ICbi3v1U06MV2zw/7KQXj1am0mD9ruMn2UAqE4MGzdJvRrpbnt
         VfPTrXzxEzY14cnTjeifcFQaSUG7w1SrMpSs6gEF77vgs1Hmr1LECnaNrmzDj13nX4Rc
         DtAA==
X-Forwarded-Encrypted: i=1; AJvYcCVnIyirrZHH+RiDBT471Oa7E6yeX2TSkiDeMIow/ua1XmEeikgbhxZN+vGjdzeo7UmnlVGnbKu0k5VsEWxh6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjPX3tBMQOWV8M9W76T4aKJSlomI842ZtNwoolQkTFXAwL5ZPQ
	V6HUUbParGGLMvUdS+54Htk/90ayIBGLWjCndlsYWesQP/+U1YteZhQJOg5hg3/5FgmegUJo3Jg
	9c+uQpO3TM8LruqETuaY4EKso8OpL0Rm02V1BTS41YppluhVeJQ3BFUE2Cwe4zzEQ
X-Gm-Gg: ASbGncv+jwtL0i87orJo+UVrP80OXu0RGXtY9UFm9v8ekFe91XWD0Qa2TNwepuMIiFn
	Idsq5nLfB7k5Acf5ORtDnJ43Bj0c3FiY4LLepKXomeJdjOnv2VGXt9xnwp8n5tcoY1YhfDh/F2Q
	IC3IYd0EOfjGeWcjBaEGMfYZS3eVx18qJUT4Y0Ig9MWF00laRQkOK9vuLzK5vM7e5qZsrkXWBqm
	y+tWwBsZrJqeSmN7i7258eyJvRJ9anWiQ5JqAwKN4c5VTxhBnX5T5LcshZxMfnVP4yPB4rKj6gu
	YRFZooGF9hOUJTKGk9hojsCGcIloNk7oOwhHS0U=
X-Received: by 2002:a05:600c:1d02:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-4409bdae980mr22059505e9.27.1745495335342;
        Thu, 24 Apr 2025 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZLkMc35rnp4BTi5uk6IdrLmESnS6O2NJ+BKK5UJ777FxcQysn8JyDJpuHccKf//6qU8xMA==
X-Received: by 2002:a05:600c:1d02:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-4409bdae980mr22059295e9.27.1745495334986;
        Thu, 24 Apr 2025 04:48:54 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29b990sm19004865e9.4.2025.04.24.04.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:48:54 -0700 (PDT)
Message-ID: <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
Date: Thu, 24 Apr 2025 13:48:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250420010518.2842335-1-jon@nutanix.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6WG3ImaTUTi-Vt36-cfBAWLDVtBrwoqWlPCZHl10AUM_1745495335
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 3:05 AM, Jon Kohler wrote:
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..9b04025eea66 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> +			/* If interrupted while doing busy polling, requeue
> +			 * the handler to be fair handle_rx as well as other
> +			 * tasks waiting on cpu
> +			 */
>  			if (unlikely(busyloop_intr)) {
>  				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
>  			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}

It's not clear to me why the zerocopy path does not need a similar change.

> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	/* All of our work has been completed; however, before leaving the
> +	 * TX handler, do one last check for work, and requeue handler if
> +	 * necessary. If there is no work, queue will be reenabled.
> +	 */
> +	vhost_net_busy_poll_try_queue(net, vq);

This will call vhost_poll_queue() regardless of the 'busyloop_intr' flag
value, while AFAICS prior to this patch vhost_poll_queue() is only
performed with busyloop_intr == true. Why don't we need to take care of
such flag here?

@Michael: I assume you prefer that this patch will go through the
net-next tree, right?

Thanks,

Paolo

