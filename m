Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E1351C00
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559784; cv=none; b=OgtdP1qlvxFu8XXKRPGqz16cB2YLZ/PEe7bkphnEZFsiarVCFEODK3uZ3USQs2UQtxznGix3EaBBsHLlO/9F9w6ddFSoFlBR8r0gDg307ZIQ9P5OKOd1CJeCK5bGd4Z9YB/NUXJbq0cE60zcg3Apgu5ZdboePa7C2xchkxmKN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559784; c=relaxed/simple;
	bh=dZp04g6uiiOvyjSK+U2cIgCRjRltYcNDmLHe1BhbY4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZJVH4fgN6qBcfsQhCwF1LShaXAjhGygjEI2EUlLNoLitxt+J7lSWw5mW+ugCh+aumMTT+hvt95TgBtDdMwfapw3YDd+0hk1zEplO7+4zsDPpopeLX2holDvMtINlxcnbSW6lUqfdgK+7Dbj4hfF4W46+KRDOzTkKqilaVD7ZLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmmOc0AS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmmOc0AS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772559782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXyJq2jhL63XCeCGf/kk+0S1SsVNcL/cSZ0UgVWv13U=;
	b=AmmOc0ASHu3IL8AxnBmapiwFNGgP3QdktMUR/RMHNJHpX5UOnm5zqjdPXfgBqj9ygOnnGd
	q96mk4cZrWQCvRB7jmpDrKKeJbvv1S7w9pmm5AtQarIOQ+MPCXE3Ys7sRlbENCxogqDH7E
	ay2dJ/hz7+Ulxc68QqoWIeoLoKlO3mI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-o14O49wLOqu0lq_3tI-nLA-1; Tue, 03 Mar 2026 12:43:00 -0500
X-MC-Unique: o14O49wLOqu0lq_3tI-nLA-1
X-Mimecast-MFC-AGG-ID: o14O49wLOqu0lq_3tI-nLA_1772559779
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c4c1056fso284045f8f.0
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 09:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559779; x=1773164579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXyJq2jhL63XCeCGf/kk+0S1SsVNcL/cSZ0UgVWv13U=;
        b=OO4y8/WJqk831ZoJFj6NsFja4Mhf7fWnIKc5YgYnTWe9BQcz8KIIPz7Nz8vfQogziz
         YAGH+cX3BTkDfwI305UyH7gLQKnuRKnTtC/3frqkdR8liOoX1Xte4HLGAOj/U+pchhhC
         OD7Qrv3IvM3NLdsz1c+A33h8ehIzamJ7fYYCxaUK9HDxn49UI4SU12GsrK+4vAnRcXFb
         LNXLtH4odO7rBl4AkfW5+BbZtRKaC+dc/bq7CjYH31Z6I52aafOqhrgJfgHCAX37wILa
         8QXXa0a5sAD6ngtxXm6FkGrQkU1fPn3jMvcBrNy0oG+iIBrNqVyy9AFpQyKR1AIzNKWC
         7PXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiMfLXJ/J3Ba5EDxJeX/1Qq0zf8gbW1e7xK38dLIk1/GyBJKx1d6dlfKb71Gbcz9Jci7Cq4zgrrZ7q0kc4NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaUFQWkitIitma2mHRivJcajXfZuO7icTwsfDGpg1PTwi2q79L
	O4qF489RrV3AF21Q5lVfu1RAhnrGusaNJG0+r0+LM2PPFg5XXHYAAQQUhmpcoXpLbHrYyeJSst/
	ksz2ooMpZHWtA9otBJrjgHbsTm//SoVxVwV9+7GZWGmZUbQ+4+fHRaJsAURBDVFoFvgSF
X-Gm-Gg: ATEYQzyqNcsvFuTog1V8LiI8jppCxKn5EeaE4ngcSVjtq1XJJ0ax8whFzRfVbSm0TB6
	hiL86dbyoU9tkXFK9R+8DcyFnX0q3aJBRx8tiGpNWOg7uX1l2f6AMjkl7uuUmjKvAckEpjo3SRd
	T0HxseQBgPuIZcCpcUT6u7rZ+67bV7S08dprJqh13tEPu8ZeouIe38FUHKCEizu5r6QrxKZIhp1
	26gSrj2qprV3yyvc622e1Ftr8oAgtxNsD6Yviy3rNbxFQ8Otpq8cu2wTnqQQojv2w/5dVHK5ya3
	eT5bflaHX3e6WDrXHQAlyvqOToagTDMDrf+k6FLJm0B8tYYeL0Jo+BCnG7ClCzam/9F9Fa9vM6X
	npMCHByMmgwNsTxZ+cNjlDBM+3XsYczaF29c/HKwghitLMw==
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-439b2656dd5mr17085007f8f.12.1772559779106;
        Tue, 03 Mar 2026 09:42:59 -0800 (PST)
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-439b2656dd5mr17084962f8f.12.1772559778587;
        Tue, 03 Mar 2026 09:42:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm13000276f8f.33.2026.03.03.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:42:58 -0800 (PST)
Date: Tue, 3 Mar 2026 12:42:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
Cc: david@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] Allow order zero pages in page reporting
Message-ID: <20260303124236-mutt-send-email-mst@kernel.org>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: khVq35BfRp2RuJQj9wBc3TGv3jQ2c74RIFU-h7k883g_1772559779
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 03:30:27AM -0800, Yuvraj Sakshith wrote:
> Today, page reporting sets page_reporting_order in two ways:
> 
> (1) page_reporting.page_reporting_order cmdline parameter
> (2) Driver can pass order while registering itself.
> 
> In both cases, order zero is ignored by free page reporting
> because it is used to set page_reporting_order to a default
> value, like MAX_PAGE_ORDER.
> 
> In some cases we might want page_reporting_order to be zero.
> 
> For instance, when virtio-balloon runs inside a guest with
> tiny memory (say, 16MB), it might not be able to find a order 1 page
> (or in the worst case order MAX_PAGE_ORDER page) after some uptime.
> Page reporting should be able to return order zero pages back for
> optimal memory relinquishment.
> 
> This patch changes the default fallback value from '0' to '-1' in
> all possible clients of free page reporting (hv_balloon and
> virtio-balloon) together with allowing '0' as a valid order in
> page_reporting_register().

virtio change is a technicality, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Changes in v1:
> - Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
> - Make use of new macro in drivers (hv_balloon and virtio-balloon)
>         working with page reporting.
> - Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
>         page order that can be requested.
> 
> Changes in v2:
> - Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
>         PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
>         the situation where page reporting order is not specified
>         in the commandline.
> - Minor commit message changes.
> 
> Changes in v3:
> - Setting page_reporting_order's initial value to
> 	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
> 	PATCH #5.
> 
> Changes in v4:
> - Move PAGE_REPORTING_ORDER_UNSPECIFIED's usage with
> 	page_reporting_order to patch #5.
> 
> Yuvraj Sakshith (5):
>   mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
>   virtio_balloon: set unspecified page reporting order
>   hv_balloon: set unspecified page reporting order
>   mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
>   mm/page_reporting: change page_reporting_order to
>     PAGE_REPORTING_ORDER_UNSPECIFIED
> 
>  drivers/hv/hv_balloon.c         | 2 +-
>  drivers/virtio/virtio_balloon.c | 2 ++
>  include/linux/page_reporting.h  | 1 +
>  mm/page_reporting.c             | 7 ++++---
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.34.1

