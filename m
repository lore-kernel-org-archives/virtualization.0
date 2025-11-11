Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED834F255
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857745; cv=none; b=ayXdsNgvSEPORQk5VEEaKwqSFjSbxy4U5dIYd/yxY/cU6wdkbqJ7u3+9ARfsj/fY99HaHmB+bjfnYB1rJWqQRcoinXmueQVC0/4TmMtRFHh3vdGf7l6fw+PYe1rnbk+KOG1iRhHlbOSTzdRfpOpzbOv1WZnqNGIeMT/ziE1x9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857745; c=relaxed/simple;
	bh=a6nv63g15xZWAV7bVcMWY6pNkhiANyeoNIIE8kwHel8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6WvUTzw97n6dqBdwVc8vTQWGrWJ6ggzeZeKluN8vBBwUdbvL6a1ySvezbKl6NgB4DaLc2ibghRNQCJZshiValMOn89kiuzsU2s7dPpqRU53DtHXicoTWG4uVyuzdw3gYDratHVdXU/RIbyCUsk38X9TZTfg6vDToyHMTKQhpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Am753w4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am753w4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762857742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vL9KIlYCu7LmFDNFmygm16FGGbh7HGCYxHOoN516RqY=;
	b=Am753w4jpO5WvQT8zLT3hN14MCxtwl/i9QXTeTAyFx5Eb52M8hcC5cpTH/qysLTskMLLPZ
	EenDoj4Y5PBfBeYCPxWLyTH7PO+rO7jbkPQkva11axYRWt8zCv53TrVbG1Xhb2W3KKdTH6
	cRnPodoBKgNuGmtAGLlKySM9f2dHpW0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-P3CePT7yO0Sb9b8orXkUQA-1; Tue, 11 Nov 2025 05:42:21 -0500
X-MC-Unique: P3CePT7yO0Sb9b8orXkUQA-1
X-Mimecast-MFC-AGG-ID: P3CePT7yO0Sb9b8orXkUQA_1762857740
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso5654265e9.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 02:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857740; x=1763462540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL9KIlYCu7LmFDNFmygm16FGGbh7HGCYxHOoN516RqY=;
        b=EDRaEuP0lx7uUFwCBQ13GKk/vnC/5+LxVuNidHV+1xxeyKr2it2BMF8eKMYHPb//9o
         gRij+FZInhdhM8hsETAgk4VTKF0xmPSgJ+IhhsIyvT7cm/JsCuhaazFsdoo5XQcAITN6
         qq96SmQBw72H6sydPplXVKavNC5/Y+emiazQCh+YaUigYxRN+LgYaFWDeeRD4vTZEm/4
         hyoqE63epHs87WJJwCaaDNLTb8qh9WVKIQvd3gcSKxUZ9xZsnIaNuGjJBFZGgXP1eQoX
         1aBtFmQE6E/zFeh1qFNyPoZ1FAGr3KMHEWO5GEU7HOX2yp/NOk9YVlWTDOBXMMD8/S61
         SORQ==
X-Gm-Message-State: AOJu0Yx2Idw3+shFcj3vWDdITagghyjsvN1d4/nfgAshGqVQgeV5x2zF
	Ql3ry40U+tPSyvBBme/ry2Pf9gPkqtyWyLemuseY/kHaTY8MBpPFWEH2bzmn8eJlzY5LzLX1/qH
	Po/8bbzo3NGzSsww8d62Mp6YnE8+68IvXSxuHRelVHk40pabnoMJH1MVJg7P00FLCV8qs
X-Gm-Gg: ASbGncvlfS58WFWHITZXMqTTu45XJGCrQuTWBN77zEU8RpYKqsNYz2vaknIdXfvf3ob
	xVba1CRIzggN5vVjAfa3ClXdqbVDCsb2rkJgC8a0SmVV56v5ldfZhjRYHa30UFxHtqVy5stxIlF
	Lzdfx2tlSmx7N1h9m0tPV9Jv1diJeSNmypfN1IkIn5Hp/YQb9WiAP+2z7Gte7adH/MlTO7kh8N2
	dBeQvkm5H2NI+OlsoviwNKIYOJG/YF1TkmDEAG3gTto17IWFbktoyXdN58Dybd5/3l6g+4P2aAU
	5DEIcX1kngd3wtKSeiHNhK11NIgc5ZJs0ukS/p/N9KMPttYLoXUwrmU+rsHJ+p0YYnOfJfgr/eZ
	UFA==
X-Received: by 2002:a05:600c:3153:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47781442334mr21632375e9.17.1762857740322;
        Tue, 11 Nov 2025 02:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE39SXXrwK8KEb+Y0d1GKp77tLD2dthpm61pCGxbtS2FZaUq8fCZ+9TOrRsqQgjJjyoJrw9wQ==
X-Received: by 2002:a05:600c:3153:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47781442334mr21632115e9.17.1762857739945;
        Tue, 11 Nov 2025 02:42:19 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477632bda1asm301364145e9.3.2025.11.11.02.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:42:19 -0800 (PST)
Message-ID: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
Date: Tue, 11 Nov 2025 11:42:18 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251107041523.1928-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 33yCfMP0EnGfWBH4wOMSVHIKljDY_1EDcP-ls0vfPu4_1762857740
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;

I'm sorry for not noticing the following earlier, but it looks like that
the code could error out on ENOMEM even if the feature is not really
supported,  when `cap_id_list` allocation fails, which in turn looks a
bit bad, as the allocated chunk is not that small (32K if I read
correctly).

@Jason, @Micheal: WDYT?

/P

