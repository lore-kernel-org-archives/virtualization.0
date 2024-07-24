Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051B2D030
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828875; cv=none; b=PpHcCSDR9UUQMLY+lbd1yxvF7z4nJf/vOOQnRrtztS27UwYAC7UZs1Rz9hGxCFwylTholDsOoEwfYcvwqFuXb4WxbmhN8HmYgisawQt/hafEIXeQEwB776Vs9vUJKAm5m1HXE6nPaI1j3LPUDb7t9R8oqyPsMIhH31wa2te3RY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828875; c=relaxed/simple;
	bh=z78rSg+htcBGWCSdebP2st2w/67sDJrjGiu6NCz2MHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw5zh2EjROSbIcymI6KVn/gdC8ZHdpHh5iyWMXi1foP33S5R4GePfoiIfHarZtjCLVWRS4s0riBDP+7RACVOtQ8MF5gHX+qf8NOC7Q/D+9ELU6L8qR2Xoo8MV0Za8QvrZ7jyn3O3mW00J4Wfwd/bTj30CDJ9BmaPE/vp2UwlWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ANvZKyXH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ANvZKyXH"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01993090so5033429e87.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721828871; x=1722433671; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=woGjJUalBG5RmmZBOtkde/fWyxqIWN1lZPYfjOI7zrw=;
        b=ANvZKyXHwcSoa++FSOQapgjk8CyYRErz8MDxN+24wu4XRRyCmQ0S6SsVrb5YosJhtS
         NFjOKPYh5aOMiP9VkYPhTYnPC4ejd6DEYGxU8/61/m1AphNIZFuZVrYtTAdI06sGj59r
         CLzEOs1gZwIsJpDsqLmkwby4qoOHtGQs6xAOesKWwxYNmryCOIFtDcOuc3VtIuJGaLVq
         zOageOZms0SWMUEm6CDkoe/ba8yUgu7A2F0m44mw6t8Ubg4sV/XFKEUjvdBqSbl+DjZh
         OcHGOQSMcaaTr/ZzvoQVxthmCOYbUVB81Se2rApu3z7iz1zFkTM1weqvkzyztMG8GQR+
         j+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828871; x=1722433671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woGjJUalBG5RmmZBOtkde/fWyxqIWN1lZPYfjOI7zrw=;
        b=ExUf8rtpVcLPTE3LoLSNNqpCsq+mAZDShNNYxKhtY8ZiM85OrZBrt6M2STU+WFfK17
         eTrMhyhpknAVgesACIj0FKMBePOz22eknAwZhKNnFFoBqXUagtvqxL7/uSwDKigrM945
         23LpmKUaqCj9SnxnjyZPcO1ehoZV+awbmjc268k4ariiyd1rPNl0DXYkbiUD3P125NLg
         FXouDUFPFIMVIQiRwkdnlabnQwC/s/r3mb/oNrSDBiRp98TzP8iaT/woOEk778Zj8X/S
         lxVOe4l6gut/6cPTKrDufQ5QdDba3B5ugoSFJi4yACoem5HA2PP8xyZ68fod2Emp3t/D
         XTjg==
X-Forwarded-Encrypted: i=1; AJvYcCU+QusbuA1XBtQU0xYXtVH+lEfXDNAi98PMwTqQ5ftGuKgRdXpV7ZxU/SRsnJWEII1N4y6gAUwIIPG91M0TK8d82y4s0S0k0YJDeI5dB8k=
X-Gm-Message-State: AOJu0YyUyvHurmTTEHIX11JpNGeZk+UTBIQOi/uahi4sNqvjZjlQCq9I
	e/acAOavjxXmoT/ih0c/Dhp2xxTMT5XiOESb5LH/GTuwflle7jnfY4mxSHG6vVs=
X-Google-Smtp-Source: AGHT+IEm6r8MW3jAPa7enMwFdgbk5R91xq+SdGgS0mNQ6bgCnTIaUWtpBNZV5D+vrvTPvOV+lAaDYg==
X-Received: by 2002:a05:6512:39cd:b0:52d:582e:8093 with SMTP id 2adb3069b0e04-52fcda2626emr2018789e87.23.1721828867923;
        Wed, 24 Jul 2024 06:47:47 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aabd8cae5sm91255666b.146.2024.07.24.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:47:47 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:47:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqEGAh6R7yoR5L1n@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org>
 <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqED4bEIJGGHxsHY@infradead.org>

On Wed 24-07-24 06:38:41, Christoph Hellwig wrote:
> On Wed, Jul 24, 2024 at 03:33:19PM +0200, Vlastimil Babka wrote:
> > > I do not see this a problem. There is no real reason to have a NOWAIT
> > > allocation down the stack that has a different fallback strategy.
> > > I am not saying that this is the current practice because I do not know
> > > that but I am saying that this is not impossible to imagine and it makes
> > > scoped NOFAIL context subtle and error prone.
> > 
> > I don't think Christoph proposed scoped NOFAIL, just use scoped NOFS/NOIO
> > together with GFP_KERNEL_NOFAIL intead of introducing GFP_NOFS_NOFAIL.
> 
> Yes, exactly.
> 
> And I didn't think Michal thought I meant something different, maybe
> that's why it felt really confusing.

OK, now it makes more sense ;) I have absolutely no objections to
prefering scoped NO{FS,IO} interfaces of course. And that would indeed
eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.

Thanks for the clarification.
-- 
Michal Hocko
SUSE Labs
