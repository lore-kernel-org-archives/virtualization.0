Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C763955E4
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572003; cv=pass; b=Jl74xw/G3fr88kh7fP3xYsbeglj4BN64CxDJWYCwtQIiTBf7TDo8mxJoSiCbEV5eesYGj3jMiMtBCJmeyQw9e9nLz5WNQisJqzagaHf8s1Tm8BbasIkCMOSmX7pJH6U/MaqAY/iqxp7gIt+t3vZVFvENsGbk+b/tMLecs61rymk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572003; c=relaxed/simple;
	bh=rrPe0S8ehMzogdnF4nvdXJJxr8a2gOQJbjrgOpLmnyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9ZVLeeca6fuco0sqa8OqPZYdpsoAsKPKGZK6dVn77S1Gs/X4lrM+Ggx63wVAcfSSzHe4c0CIGDxXoFmzJe7BGPaKmhF5ZJfMB/tWpsTAwQ0yZ2gbXSlUovTkvRdSyIfMTTmuz5m2sf2GbAY+G32qkPpHctqoB2E6fQYEd9kkNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Cxn1+BVb; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Cxn1+BVb"
ARC-Seal: i=1; a=rsa-sha256; t=1791571992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SVbjiXRc8QpmfT6PzujOK89mibaK1eVJ6rTtPddsZsXKEOPSdBIcTZoB78g3LztSgkc0N5t8cO8LcPSSBEQ9Nvv5u19PanNsLr+yz8F1NE/Ofc0oqjFPfNQQMiQVYltuoMGEOWUPS/+ch5LiuDMJBpUnqZVknx50dm144eqbRGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791571992; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VduCiD25+U1tGSGh8M5XVocEG3tjjHxcQLHCVseounc=; 
	b=LMfCLr4BpWbvpAyen2B/UpI9sjXFFYLkGTG7VIBPydNlMUKJvwW4vRc7yYDFINV66fhuY3EVDDerF6wq4owYy8lxbMTx2rXZf3mhyRKz3dQWiq9IoQP6T0ap+EcFz9sgPI0hJM6HMtYmhh7ka8DSAdXKLmL+b1w4gw+hkJav4AY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791571992;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VduCiD25+U1tGSGh8M5XVocEG3tjjHxcQLHCVseounc=;
	b=Cxn1+BVbh00aU758SljWWJjoL0usqzDvGjur8PzVHltMDnXxMPHyZCVZ3Jnxo79D
	zBRijQCDPbg2G4+cjcudddemJxPbSCJumxN5AvswlWnCDbjzEJ8W0rx7sVqn6SQAxbR
	sPKXGheruDeFPjKCz4iiJW4bJ1eDz0Et+bcrycck=
Received: by smtp.zohomail.com with SMTPS id 1791571991301128.1329973129134;
	Fri, 9 Oct 2026 11:53:11 -0700 (PDT)
Message-ID: <dfa2f117-1094-40b9-9445-ab2bbf62ff2e@collabora.com>
Date: Fri, 9 Oct 2026 21:53:07 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Honglei Huang <honghuan@amd.com>, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

24.09.2026 12:55, Honglei Huang пишет:
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr)
> +{
> +	struct virtio_gpu_object_userptr *userptr;
> +	struct virtio_gpu_mem_entry *ents = NULL;
> +	struct sg_table *sgt;
> +	struct mm_struct *mm;
> +	unsigned long lock_limit;
> +	unsigned long start;
> +	unsigned long end;
> +	s64 new_pinned;
> +	unsigned int nents;
> +	int ret;
> +
> +	*bo_ptr = NULL;
> +
> +	if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
> +	    params->userptr != (unsigned long)params->userptr)
> +		return -EINVAL;
> +
> +	start = params->userptr;
> +	if (!IS_ALIGNED(start, PAGE_SIZE) ||
> +	    check_add_overflow(start, (unsigned long)params->size, &end))
> +		return -EINVAL;

There is new vgdev->blob_alignment defining host page size as it may
differ from guest's page. Will be good to validate both.

-- 
Best regards,
Dmitry
