Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE051E3DED
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433227; cv=none; b=Y+xGbkdsLEbSZmcNQoP8Y5iiMiRC2EHaOqcnp4dRcH/XX/KDekU2ooYZ5lGnsdjTW62hcsVr4pl8Ev0nrBPnRTJHN8dId/qj4ayjxi6efxq5fdLvnaKZU1km3UA/By50IuxRpuwM2CTDMjbjoyKrM3j3kU078znXogMrVPwJHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433227; c=relaxed/simple;
	bh=2v0Bp0WbvCD9vKAk3vczjx5MXMK8Ev3edpRr+RV7MTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KN670SuY92Ldiz2+b6MZgy7HLRw9hNvmPWLIytdNenH81X+DBEpDzx5lExsznkUvgEAFYCqjUmiQN8xdit928OMwn8bNxzrN47moV61U1fQvzUwzoAqEgcmC4WXAMVaDyRkYwwLveVEgGGT73xa90Fk+lEZeV16XAFfOIQf/OD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLZLrrHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLZLrrHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2XgyDPMJ1MFnAPP7MytLHmnMXp+I2XmGE5K1J0UB80=;
	b=LLZLrrHPyVTyeRiYSH18rep8CmYq7aJBjAavZLLULqbLX57jF17QWdHMT4Loxc/IAgyJKE
	U3yTJECoN4VoA5mCOCwO8MOVIts+rqdGxu6U5uMANNfCxIM2lvlOOQZxj4JQr6qDy8x+Yj
	/f8uSzNNdnGf29sypTThtk+msj/ySKI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-oS-aGdaTNryfDxRjchCVXg-1; Tue, 14 Oct 2025 05:13:43 -0400
X-MC-Unique: oS-aGdaTNryfDxRjchCVXg-1
X-Mimecast-MFC-AGG-ID: oS-aGdaTNryfDxRjchCVXg_1760433222
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46fb328a60eso16181995e9.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433222; x=1761038022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2XgyDPMJ1MFnAPP7MytLHmnMXp+I2XmGE5K1J0UB80=;
        b=xTmQFqJJeu7OoB57MKlI3zCUiXIZ26eRFV8xj1gL6I6bq/Yr8jZOp92WGQ5qsb9rT1
         xsEjsQXAZsSRaeM5ZmXbyxSOEOe3TI+ptTOHoNdTzpny37ayXJCFK2NQt9WBU693VNNg
         JGmG4Cbz5z8b5DMQB5BVQhxWzbVpUIhfUkJW0aWS4xzdSrLH+ThDSXynojNbRNrHifLE
         OxHAQ7RoxcYMiB0Ak+ts5TQWtA7Ki0Srchjxgv5CqvZHwjDA+c+HGw4cFX89P3dUhLqY
         uwmngKeTbAnFAH+UyYsOIhFDWcqnGYjUaG4EFoKQ3L3pUMZOF271tKF4/VUhQiXIf6Vw
         x1FA==
X-Forwarded-Encrypted: i=1; AJvYcCXYbyGff8wIo0vUZ6FVeC8mJuv9aWrtUpA9vFirSNA6NGLNpRnImZ1GiVTjv45Hb3C02yJfTgIaC4e8pqeVbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp0C3k77rWAbxMLH80IR1haiPu+SFveqI2vZxdOwjooeloSxS6
	PmcUR5WyFwi8acTmBMUmiomOIQNwQsRCIqEl8jE+dgckPl/J86wfdroilauwWf1w3zIMVXkzKOt
	ALRQ188aXTuMiJ52/aPOzOwE48rBxcCp6oB+rlmU3AmfsytgBxcX7bLusGyGDPcd004q1
X-Gm-Gg: ASbGncsOblAXdpnV7ygJM/WTertNNspzz7CqqPLsFWhN9WR4SMelwb+8zZBKulGpuHC
	FF74yhEX6iQY8Wp4iOijwU4j1DYeVryqjaEYRZPQqESIaeLOuah59T7g/NWJsLvpIvOTrdcUOxr
	sCKdaxtOb9AbvMQptGYYARFBhO7fi9j4KS9q4uP9TFIJ6u4VdU6ijzyUS+TEH4a8PDHQTjpYzkD
	A3iKdcjlOu1+dE8SOjBcyzxnZrq5d+R5OWdFbqox3FG4WODKA6ctHl9DeV2qmWeoQVA0fn9zt4x
	wD1aazdgKlDANDAJt26VJjoF2pRYK8UqMA==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr195064695e9.19.1760433221839;
        Tue, 14 Oct 2025 02:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr/6lo3aUFMkwfFsJSFWwzr/cwg1mRhEAlsy8hUJhHzcQrMQ9yYQk5I4elgRIAJAufqX/zbQ==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-46fa9af8595mr195064485e9.19.1760433221322;
        Tue, 14 Oct 2025 02:13:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583316sm22569145f8f.20.2025.10.14.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:13:40 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
Message-ID: <20251014050901-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250925103708.44589-20-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dg3vDcP_Hgp3mV4u2v4401o9clohb-NOdt6Juw47BAE_1760433222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> @@ -683,7 +707,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	vq->vq.num_free -= descs_used;
>  
>  	/* Update free pointer */
> -	if (indirect)
> +	if (virtqueue_is_in_order(vq)) {
> +		vq->free_head += descs_used;
> +		if (vq->free_head >= vq->split.vring.num)
> +			vq->free_head -= vq->split.vring.num;
> +		vq->split.desc_state[head].total_len = total_len;;
> +	} else if (indirect)
>  		vq->free_head = vq->split.desc_extra[head].next;
>  	else
>  		vq->free_head = i;

So in order is clearly doing something funky with the free_head.
It's no longer a head of a linked list of free descriptors, is it?
what is it doing and why?  Please add code comments to explain
both where free_list is defined and where it's used.
For example, virtqueue_vring_attach_packed only inits free_list
if not in order. So who will init it for in order? And so on.

-- 
MST

