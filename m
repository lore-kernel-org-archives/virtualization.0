Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD831064A
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534407; cv=none; b=b9rvVUdKubCiCfHh9duhbrFnTxMP8qRyjTvh3ETWSl2mnpdIQ5O+Z7COtE4Kge09dUmbVC24TZFpB0venyVnC67JbmuNuu2/Dl4bF1uWwWhS4r/XhbnX8BvUpk73yFQqG4hf0EhaLpLNiO3R+RS0RauicaviKcrKheP8YzXaho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534407; c=relaxed/simple;
	bh=S0bW8FEPYvxlNlsBKwHlG1/2rcNkECm3MSq3Fk1VY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gmOkWi3QUkwk0cBMcMVkBEI96dth6V4e2JlDMtHWO2I4M8Wv9sV0TYVGHsiL7bd72o8oIjQQQkHPLXx2cen0tru/IhqLzuw5n9TbeO2XXFnYy/kfninaXaJF6s7B4Blo5Tb3e/0n0Das/aVBS706MHFZEFnYbd2RwfCV9fzhkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzo3SarO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzo3SarO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763534404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKnjgl0kQ3X28J8QCPC2uba5bbT39T896MHGKvSIyu4=;
	b=Yzo3SarOmFCHadyUbeItL8HkaEGobBbudW2J15DBMV09Y5CuVCjKzO45ESulRbJEUgplZC
	Fny+cEkfEf3x4gQpQAOeF7gecQ/lcHbv6ZVAEaaj8/E3V2+E/5EWy7POxkSOXSOE3ZGI14
	IM/Sw0B6Wlk6yhcFupnHYHQ1aorDdu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-HWqDnzAvMLaKD8gDHUrufw-1; Wed, 19 Nov 2025 01:40:02 -0500
X-MC-Unique: HWqDnzAvMLaKD8gDHUrufw-1
X-Mimecast-MFC-AGG-ID: HWqDnzAvMLaKD8gDHUrufw_1763534401
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477632ef599so2151915e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534401; x=1764139201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKnjgl0kQ3X28J8QCPC2uba5bbT39T896MHGKvSIyu4=;
        b=bNUgAdYWPXrpjsr20LiofhRV+xdRdGi5QIavJwvJsgyIPIzvUZ86KChHuWc+wZ9UTw
         1tBW1MBHrMslVdbzbZSfckRFex1vMyiM9oHUR7mDarkEGUmKuwipkUO2V7l3MfEJ7M7o
         78WrKrVtKOqi99tmb4NxZAkJtNqaJS5QLXnfrfa09L0FFTQfQ8ZI2PKwakAmGbJ9f2BB
         KJfHPFfcMfttKMg8KGxnJAWoYwhXeaysXocDUnGsr11K0N1X5ymSHTU+GrrbqE859S2r
         WGy1HfDWj3Hh3d5rpaMk1ZjQOgIMoQ8aQEVJsUBVRhN32QInnJN2gpEsv0a9Um6fvaZ+
         XriA==
X-Forwarded-Encrypted: i=1; AJvYcCUyfB4+3rHkuSCEJJbxRq5qcM+oMkBRNKc/8NlSXLpp57iFSjOcwD1F5qBk/Rt0XGn3P9PJdfseCFc9OeSdMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFPu4wdDMyd0+fB7uekDOvQuFfZmZ0KFXUtWEJFFPCxK09GYmt
	J2yz0LNag53iym6x64Sjr6WM15moiKG2r8kg20xheosnSPHpInGLuvgm9f8+bv9z/VuSL4PCWee
	5xszLoUNxaQGH8QugOpkHLK6uGpiA/63qjB7ijEv5kficuPRqG92Nxq3TqQW1LyydkvIe
X-Gm-Gg: ASbGncv2qGCAOYFNt6V8f/N2BbkRqNhKw0nmAWrqDA12A6HLiK3bX3JKcYsYDF/fZFM
	2ScmFIgwo4z9TJiOQQlkSneOkGgTo7Ym1bganMt4BJmMOXyCGwMNjE3fouYfPYiEHwAAvjquf+I
	D0Gvwlsah8BHmHX/tYS9oHUXxXbueW0YAQEj1W7/PJULDDV1ugZJ+mQfptJnWjF6aqMt4UnXkBu
	kZrJJUu31vYxppK8jP3Ut2GKiqz/RS6iJWcSSdJJXqduVmTgHdudgFCanUqGwh5pdZDjd5Vbq6Z
	Y8RxfZGtrRrqsFzMo1ucLOvQ86d4USH0QDg0B7gyaP/v8OAMmwDRgizDWFDsbKh5TrrGQyajKks
	D7HHfGqrcoQpEzcfdaSOc9ujcNoFQTg==
X-Received: by 2002:a05:600c:8b68:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477b183de88mr10279655e9.16.1763534401420;
        Tue, 18 Nov 2025 22:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6cgNTBzLQsKkNSEyu3gdScRsnvnotpgfJecg1XHhy1j5bwsjTM6/EQU5MJrcP/FLL4rGe1w==
X-Received: by 2002:a05:600c:8b68:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477b183de88mr10279415e9.16.1763534400983;
        Tue, 18 Nov 2025 22:40:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10173a3sm29151075e9.5.2025.11.18.22.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:40:00 -0800 (PST)
Date: Wed, 19 Nov 2025 01:39:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
Message-ID: <20251119013550-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
 <20251118171338-mutt-send-email-mst@kernel.org>
 <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e5641fe1-e1a7-4f3f-b4d0-1dde55e47c83@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VaIYEse36vCfRlD_pU6r02fjpt91CXokFLoNOvE0rkM_1763534401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 09:29:05PM -0600, Dan Jurgens wrote:
> On 11/18/25 4:14 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:
> 
> >> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> >> +			     u16 obj_type,
> >> +			     u32 obj_id,
> >> +			     u16 group_type,
> >> +			     u64 group_member_id)
> > 
> > what's the point of making it int when none of the callers
> > check the return type?
> > 
> 
> It's an API, and return codes are available. I don't have a use for them
> in this series but perhaps a future user will.

For starters let's address the existing use which wants it to never fail.
I would say do something with an error inside the function.
Maybe just WARN_ON_ONCE.



-- 
MST

