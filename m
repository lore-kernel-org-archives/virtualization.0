Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6315E5CC
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062774; cv=none; b=YN9316laN8KHoLQ7v0TtXHs3G6mg708G0++RuJJr5A004J4VQzHUWazL99kzc22VCOEA742RVJDl34dg4f6HtvGKhUjVXVV36+rb4ReyARMrVhofnzX053XyPoepLiehv6fc+H6d0QPurotbwX83oUHjDXakv5VJQNtISepERQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062774; c=relaxed/simple;
	bh=RsD1v7efKDZiy3TlBFtkAVnuHfZ6a+Qf1UTSTq/7RVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxvU1nkV2PS31bUofNEyL0XezXvjnR7mAMihTEgxgMCvMIkhmWzyHrQR5Yra1TFW+MTU0PNsXNGZPQkoeRnAeAchkyyLduFR6r/9RQ3qI0J6tXYZvyDGwMyasXSPE1Z6XhZ9zJvW9hQSAzZXMWX9vwjEP3sDeQcML7WgMaaQG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QSrfH9Tm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QSrfH9Tm"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1703875a12.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724062771; x=1724667571; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7lwGUclAeYM+SMf6Ibfa53cgyLFYxXXf6hcAfETl04=;
        b=QSrfH9TmzYZ8EQz4rmVkYSSxVUt8BgKo4gnysVo+FLjuXeaGfAgvyUwB1ekSChlOLI
         VeEjZBLjZL5LbMRFRcMLV4wCwR7qrR67MqfoDKH2cppKw5kjrXH2OFdDjUl9Et/4bIQO
         q0FyhWjxPxZJ+TLQ8+UhQFG76VDB7/1u5g1fbKEDrIaiLaRm5Bi+K0XJlCGLUEBnbEXS
         4CajprKMLlq5iODNDEm4XBUZZ2JvOUpiUD/XBt4pKi1gVJkr83OkurYCqcumLNptxq6v
         1yP1a048HkF1IrSuLab39p6YeEjIkDghL/C7LysfAgVxW0t1dR/KeSgW/2fewMx/7xbJ
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062771; x=1724667571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7lwGUclAeYM+SMf6Ibfa53cgyLFYxXXf6hcAfETl04=;
        b=bM2+1q0YBGHfr+zv40Zz6s/Y6TCZQXLBiI2PlkS60+hqJ0xnuh7rYOB3busryElC1K
         VIzU/WkLXffTa7Uw0hvV8KSjRxWTmQxKTF5oL9SN6fp2/H7gyLs1gFksBNhy4YAsM2lx
         RQPc13v8uRWEiEm0Vu5sKvSPERnZ92L/pBgKBSq5CfrELkMyTyK95pv0rLhKrv4jywRW
         f4lkxY3Q8cqGev5UIvMFt2Ch3XN0f8jMQheoRPAUXqHRPvg6nC5E8Q7/H9p6QGRWnjgp
         0GyKTeWClp0Ws/78H+3euVweG268arBZRo9SYA4Dso8Fi+CqDHgWDQEMcqr1xLYg42UD
         5mlA==
X-Forwarded-Encrypted: i=1; AJvYcCVn4F5Jr2R//smuYTyoLkpAepWq9aM1zA8e1tHP04Hcpecqt5IZyDIR3/AvYljNPftqAPWyxJxofmg6kFZIGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFNV0CfG6i2NYxN7VJAE3UyXnfym1yry7H3aXMok0IvVZR4CZO
	fyfFgQtJ8DF8T54BR7EXB2tTGS+MhXRi/v0zWDxERv65mVq84sGj8BpFlglmZ2I=
X-Google-Smtp-Source: AGHT+IFHSKh1G/mGQRRhdgWLhQ7Ocsw2zYpayRSryvqrUiTsIUWGZrIFGODxW/EV60pIRBByYsnj2w==
X-Received: by 2002:a05:6402:280a:b0:5a1:4f76:1a25 with SMTP id 4fb4d7f45d1cf-5beb3c255fcmr13212519a12.17.1724062771147;
        Mon, 19 Aug 2024 03:19:31 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc0812a3sm5401160a12.82.2024.08.19.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:19:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:19:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
Message-ID: <ZsMcMognA6DiOLW3@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <c27716a2-3e9c-4b16-9c4b-7b7d1bee9ce9@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27716a2-3e9c-4b16-9c4b-7b7d1bee9ce9@redhat.com>

On Mon 19-08-24 11:44:39, David Hildenbrand wrote:
[...]
> >   	if (gfp_mask & __GFP_NOFAIL) {
> >   		/*
> > -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> > -		 * of any new users that actually require GFP_NOWAIT
> > +		 * All existing users of the __GFP_NOFAIL are blockable
> > +		 * otherwise we introduce a busy loop with inside the page
> > +		 * allocator from non-sleepable contexts
> >   		 */
> > -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > -			goto fail;
> > +		BUG_ON(!can_direct_reclaim);
> 
> No new BUG_ON(), WARN_ON_ONCE() is good enough for something that should be
> found during ordinary testing.

Do you mean 
	if (WARN_ON_ONCE_GFP(...))
		goto retry?

Barry has mentioned that option in the changelog. 
-- 
Michal Hocko
SUSE Labs
