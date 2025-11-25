Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B013AD05
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082474; cv=none; b=Ma0s/gTpWRtdsPFXXPcEvQ5OFp9JxxIYTBZVRz68ZWNIWE0s8efqT5waaWz7DLn7am0rl55KKs1ZjwhkBAud3tiuTIdtqPTN90OeMtgwcmj9FVqNyRXfK0y1Zgo5hP94gL/NVz3z2Ny56bjxgKzOFDmSTNbRab1OUeQOmiFMkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082474; c=relaxed/simple;
	bh=8xC7HaADQYW3D+KtCunFe74uUCqkHpl2Q0DkBJIPChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qpThokOvjawg3HaBYtifYkPSQ4ahniuRUmwN/HSUQPiA8J07l9sXQwGywsaleMYYbcZDvlxvmzTpRDKU+zVZ412pLwWmEidHT6BEiou1GU+ZTxUS16kZWnqqO+E68M1mtRoYrkRXgz5l9Fs8jza3xbngMo9+LrJZBQxxF5jAhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHioTsMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHioTsMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764082472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vUrStbCWzacPZeRn/CeAW92WYQYkVd+P3AlUH3cXvno=;
	b=PHioTsMBbNlpMlR+CPJ7BTh5VCry/K/TzhYKwdPiKJKzuGAU1Xz4N3C6pATV6E3wvHGYRa
	o9HPyPCMUPelKD+au+OPQOqpNwiVRVP9cwcb/PX56gZpVytily0KadEF5RbG3TU87SdMiO
	Ch+M12ojVPdEURkpJVxLZKcPvKeAvss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-BOV2QxpQMpGvyODLcQus9A-1; Tue, 25 Nov 2025 09:54:30 -0500
X-MC-Unique: BOV2QxpQMpGvyODLcQus9A-1
X-Mimecast-MFC-AGG-ID: BOV2QxpQMpGvyODLcQus9A_1764082470
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2e448bd9so4061573f8f.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 06:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082469; x=1764687269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUrStbCWzacPZeRn/CeAW92WYQYkVd+P3AlUH3cXvno=;
        b=hqasgzqAQbxuXl6TzIT//HvQsiato72KqcLSWJzIxU7CBHK/hbbtBgW4arclBlcJki
         uXi22CKjlORSPHYkbnFZWVrxj+iLM/rOTaWLQ1wy652m4QWm4swQC0RRjCLMpiVU2xVr
         WS6f6BRZOGSk59+cJhq13TvjMcKffFBOVpxTeDy1KhpcrUiQHtiu0AIoln7/BBr5CAFW
         BQkz6+NS2B8BMa+dc+3v1frQtLCSxT2ew4aAAdszleYr+UV42dclbEtFOn8vvSA7g7Tb
         nDBsk2cZLjPf+q35Oqg0iimA56dlWGYfBwXJWxT98Ss8sADySzjJiOFoBXH+zbcSdI/j
         Pn4g==
X-Forwarded-Encrypted: i=1; AJvYcCWekvM+esFzZ1VR6wLKoQMoZWJ/JTRXpxBRh+3uPD8uw9fOf9JU52BfyGxS4LXdenjb/NIs791r46mx9kbplA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvO8PKVtCZVPpVWZ9nSMkaWK3qyz2l0kmB0dEaqoyjbCBreEDA
	uyBjw8TdXdLzIpn/7Mgsh4w8e8k74+4zJsKn/AMTLVCb27PhulUP9yzT4w20raYKlu+bezs2NMU
	H3uB2KaNxmf76hUDTkuY8Yat3PQgNUqL/FMlE8Lv4COM8LBdSzFCYQQ1bEElyYgoR6jdI
X-Gm-Gg: ASbGncuw13ZedklYq+ajYZgmPlkXmxrX71vUOHasXdUD+FgZk8LHnrcFdLRmukcQL3J
	UPSb5LQjAAE/9MyRsxBQ4fnwdTcAAeC1lgzikAYJTdHuXS/cMpXZfz19Wfpe22cAMQHq1BNPg67
	pJKEZAi+28U/pPFyNQQjEovU91xQFnjZmXGGOHinWGKnBWE7tk96hxgED3UMg98b38G3JXY25nw
	exZsGNhpgEfLi8x+mYart6QkcPLOj6c0sn4n8KWVK5oKHL8BWSsNANZlW17bXs+C8Do/gnshPGi
	K+yMG9i1T53/qhsAsWDH1jHEg5mzTJp7dbJyrZuEWngOTisg7xteMpWI2aymgnE4z0r+E28ouEs
	CqiQlLqOxBYSc8VI=
X-Received: by 2002:a05:6000:1841:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42e0f1fc3f8mr3305597f8f.3.1764082469396;
        Tue, 25 Nov 2025 06:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7rvJRNZU8Dcdx4PHJxDxhuM/oczmqfkFeajyK44cHiOkIrlaShhTGgJMJROx6QVQcGeq/5w==
X-Received: by 2002:a05:6000:1841:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42e0f1fc3f8mr3305550f8f.3.1764082468871;
        Tue, 25 Nov 2025 06:54:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f3635bsm35190453f8f.17.2025.11.25.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:54:28 -0800 (PST)
Date: Tue, 25 Nov 2025 09:54:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 1/8] ptr_ring: add __ptr_ring_full_next() to
 predict imminent fullness
Message-ID: <20251125092904-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120152914.1127975-2-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oGjqDXJltgwozyChAcIMd-KB9MNoQmKFwOv1Bfa0E80_1764082470
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2025 at 04:29:06PM +0100, Simon Schippers wrote:
> Introduce the __ptr_ring_full_next() helper, which lets callers check
> if the ptr_ring will become full after the next insertion. This is useful
> for proactively managing capacity before the ring is actually full.
> Callers must ensure the ring is not already full before using this
> helper. This is because __ptr_ring_discard_one() may zero entries in
> reverse order, the slot after the current producer position may be
> cleared before the current one. This must be considered when using this
> check.
> 
> Note: This function is especially relevant when paired with the memory
> ordering guarantees of __ptr_ring_produce() (smp_wmb()), allowing for
> safe producer/consumer coordination.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 534531807d95..da141cc8b075 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,31 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/*
> + * Checks if the ptr_ring will become full after the next insertion.

Is this for the producer or the consumer? A better name would
reflect that.

> + *
> + * Note: Callers must ensure that the ptr_ring is not full before calling
> + * this function,

how?

> as __ptr_ring_discard_one invalidates entries in
> + * reverse order. Because the next entry (rather than the current one)
> + * may be zeroed after an insertion, failing to account for this can
> + * cause false negatives when checking whether the ring will become full
> + * on the next insertion.

this part confuses more than it clarifies.

> + */
> +static inline bool __ptr_ring_full_next(struct ptr_ring *r)
> +{
> +	int p;
> +
> +	if (unlikely(r->size <= 1))
> +		return true;
> +
> +	p = r->producer + 1;
> +
> +	if (unlikely(p >= r->size))
> +		p = 0;
> +
> +	return r->queue[p];
> +}
> +
>  /* Note: callers invoking this in a loop must use a compiler barrier,
>   * for example cpu_relax(). Callers must hold producer_lock.
>   * Callers are responsible for making sure pointer that is being queued
> -- 
> 2.43.0

