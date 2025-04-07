Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557822A7FE
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015482; cv=none; b=st+bu5r8FvxDAyc72KehZ8NZexBJIjJMukAZ+IQRe8QmJKtifJbyivmwYrdQnPZ1DBAvEs6Ya3GgD2aliY6T0+gQmySFVJdsA3jaa1HAnWQVEKpYid2CfoPtKNHn92Ff/eKOUe4J9+U63utCCQofSLQ9kB06g53O9/U/IMej8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015482; c=relaxed/simple;
	bh=PtiFvCi0OCxZqEy7v1TJKjthTCLnjNTw9mDEXSxL+Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sz03zeyzagqrJyM/3Nc+s+t8Z+IYMXK8Oms4p7dDHUV6bJJo2jNZPni0XuFqOkVZNo/bkOcJiwQ7yu76dY8FBGYjf8z9XNlIQNIcLvPWHV1n4VAZHKRIk9cscWCJi8AKpK2nscNqjx32xQ5DjETt8qc4NwjKNFjSWdQCwF0Tn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/r4RuHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/r4RuHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxsyOJ1xzReb7dqRLf34SXfhgO/SwPIG7kI1XoYIq/U=;
	b=e/r4RuHlBvrasjUXGdK9hIe4bpV9+qBQpHiQc+qsHSWe6fEybDSpvnmZh4n6pGsLbR9uI4
	xFRUdELnsG0HVU/ZTsLEiBiSsp5k3JqmzxMtZTTECHS+Z1r50WkIMtiWT1aQvor2VOHuOO
	HJlQp9//ZwEYQ/yv1BiokZuDBCkUU6g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-1S8fao5INeCw7oic0iGu9g-1; Mon, 07 Apr 2025 04:44:37 -0400
X-MC-Unique: 1S8fao5INeCw7oic0iGu9g-1
X-Mimecast-MFC-AGG-ID: 1S8fao5INeCw7oic0iGu9g_1744015476
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39c1b1c0969so3367157f8f.1
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015476; x=1744620276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxsyOJ1xzReb7dqRLf34SXfhgO/SwPIG7kI1XoYIq/U=;
        b=JEUAIUAEC++8SAYd0y+iu5h9kODEKoNAdU22XEzV6I1MU3Fpi/yS9qlM07t13Op6du
         s0F5bdF/y96ukQzAOavm6rCMvMXKEEHRRArk6uvZ3xl/D66InHl7lJJNbF15t/TM6E/N
         +Kwe3haaQokmswvgq9jdXMGDGkXvS0cDvjSe4dwmGc/kyrKV9MX33Z/VSQwi/Fnf0ND6
         hmK97ozpSdXZNKoSODzuoL+nxGtDN+px4+GjOAKbKwJhjbrvlhRoTgvgN1mcED9m2dTm
         sQ1kvJ13gnq1OPsSaLM5bMvDifU1VyP8JxoR+snlIHXt0XmFWnk1eUhTQl6JgTFMU96I
         H25w==
X-Forwarded-Encrypted: i=1; AJvYcCU180AelamprsfBEbQj/wetnMdEO200WvWNeCKmS0oxoXpQh9igsSe52wVn2tVHVStpUm+NpzioSpJfrf5bvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0KqqXPNUU4RGJwD6r74MVI9iKP3eYBfAlg6yTB5hOGjFy1E5X
	8AJj0zsH3keg1B4DINE1RDdYYTzqIaAnJygpQcjfv3ZIHGtRmYZCcvN+FBoEiRNbjkWuhrxZTeK
	dIcqBnUlrq0atLM/FW4L7YvpOT30Kk0RTwlAEcRFWF8ZhNG1b2fPJD8Qn8oAz2O74
X-Gm-Gg: ASbGncuCYNYAqGCDk6o1gR7e8KaNJk7D/l2r0fb2x26/JFsehCI+EjhI8TsGrSsDS6o
	pvBIK+BrUcX5dP9MCmAQ0N0Vv/urImWnbzExhclSoCzUH01G4TMzGFxTflaXsBeJGoziNmn+Cg5
	ref2HxMrbK8AhbEzV0z74Sz4fEV2w5LX2gR9vrSmwjbu903BmOVdXxA5moP+Ap+c0tJZqsCgIZS
	mHyFXoGmASHkvpTctl7T6qXAPQndI2jrgkW7fHXRtJK5LUx3g3AES8p0FcYHicIEihX60113i4n
	uJcG7DHqMg==
X-Received: by 2002:a05:6000:2285:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39cadc85ab6mr9887022f8f.0.1744015476151;
        Mon, 07 Apr 2025 01:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RHnKh0qDdKz/5Ine63hPlJA3HH3Ym3a+73u+PAR+VrXtWlXlmPf7sT0QkaNygBVDWFb9Aw==
X-Received: by 2002:a05:6000:2285:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39cadc85ab6mr9886995f8f.0.1744015475774;
        Mon, 07 Apr 2025 01:44:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226be7sm11211086f8f.89.2025.04.07.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:44:35 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407044246-mutt-send-email-mst@kernel.org>
References: <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <39a67ca9-966b-40c1-b080-95d8e2cde376@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <39a67ca9-966b-40c1-b080-95d8e2cde376@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _iUMUHFdyuF0RAoEBmFP05t7PAvo1Xhi1BbaZ9Cuo0g_1744015476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Wow great job digging through all these hypervisors!

On Mon, Apr 07, 2025 at 10:38:59AM +0200, David Hildenbrand wrote:
> crossvm:
> https://github.com/google/crosvm/blob/main/devices/src/virtio/balloon.rs
> 
> -> Hard-codes queue numbers; does *not* offer/implement
>    VIRTIO_BALLOON_F_STATS_VQ but does offer VIRTIO_BALLOON_F_STATS_VQ
>    and VIRTIO_BALLOON_F_DEFLATE_ON_OOM.
> 
> -> Implements something that is not in the virtio-spec
> 
> const VIRTIO_BALLOON_F_WS_REPORTING: u32 = 8; // Working Set Reporting
> virtqueues
> 
> and
> 
> const WS_DATA_VQ: usize = 5;
> const WS_OP_VQ: usize = 6;
> 
> 
> IIUC, Linux inside cross-vm might actually be problematic? They would
> disagree on the virtqueue for free-page-reporting


That's why things must be tied to negotiated features, not to offered
ones.


> 
> Maybe I am missing something, it's a mess ...

Indeed. Let's fix the implementations while keeping work arounds for
existing ones.

-- 
MST

