Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6D3F1AA4
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653994; cv=none; b=qVhnKERTQB2kvmE7l0TBZAweIUT9+RkwF2LsxI5dYAJXvLu9E7QFpdh7DU5QKOSEE1cX0ZoXzzqd2wso8JZ1YeK6DBb0mJ8pIR85bf6BF+ItpGWbzBxYDPcXJPK9vS13pYp1zs5+olkE5UnWqKkp4a5Hk8MqAn5BqtwjUqWOF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653994; c=relaxed/simple;
	bh=ztAnFFia61pebOka09ezVWOXBaAS2ARNognUTc57RIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=luoMyg33SxxowVNCqg0N93+p6AAHZ9ocpcZ9Rab5HsWsma3x2Iy8aM6Z7phS/RRJhMiQ+PjN6ssIl+kTqttbFAWR/UvCp362gWeFkDEzkPYTiD0ogChm5RPhcP3q2LwKV4HE4+lGdb1Iu9YSiGu8iAE5Yx2wP9Ql8YXM3OI+/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iArP3H2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iArP3H2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780653992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YWmpWJa7c5/U2sLQeNqQjOY16iYx/q2CbxO1cEf/tY=;
	b=iArP3H2QcuKi764dLDNCls9DnydlyyjZ9/v3ju3ynYYMbNlKEVxrVNlh0w75i6tOWACCf0
	LnT1vnuEz1VHvh/Vgf/ohSvHSVjrF/1il1hH9kclD19LNvIpdf8+phJAyUekw24GUafmmu
	rWdNLwjmNlb0mCl7PpECeKuialQHWn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-XOPg_WATNKCqa5FZLWZgDg-1; Fri, 05 Jun 2026 06:06:30 -0400
X-MC-Unique: XOPg_WATNKCqa5FZLWZgDg-1
X-Mimecast-MFC-AGG-ID: XOPg_WATNKCqa5FZLWZgDg_1780653990
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490addd42bbso11789575e9.3
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 03:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653989; x=1781258789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YWmpWJa7c5/U2sLQeNqQjOY16iYx/q2CbxO1cEf/tY=;
        b=eJUcmBJ01cR2Xr9XQhxgdvDcLKoTwyQ1l35A7mj81+ho/J3EcAWoJs05fnZgVjkY26
         YzMT5qyzkb+hS1tC2b3HTqn1CjWApS83S5GSUanXmVAwtakNk8edW9edDagMMMzJ3CpM
         T2B8a5NEjT5NwJ9qJMLgeyFachIZdAWO2hKQVknQlBxJnf6RbU6yveTP/PY8kraD7qpE
         JlOluwtctrIn5yoQ136L2AS3NBg6ZKy4GbBoXvJPLd3918z3hyvHiqgXqWz0OVOn0GVc
         Nzu1SY4BoR7G8eyK1qi794J0ogGXv8rzhWUPR91sYU6sWwDWaHmB5NBqZgB2nslzt/RJ
         rk0g==
X-Forwarded-Encrypted: i=1; AFNElJ/6x/hZv4goGTZnETb2Nj4YA4kaN/gp3W31oE9z4ySD+CozO2UVSDk5WF1RHyEVaeaWBgJ/rdIoAVRyC4VzLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlNKmZu+AFaw7IpvCMttXUKcJeT54W9JLOrb4BhdgG72ZLtmMx
	M2V1eYxEPfyQGx7KnRpAtzLQudYM4j7gJRxSXgS0CRrUn6yFoxKiV/GN8N9SevhdqOHrjk2Awj2
	Fvp3HG1nVAZ8DIBIRfb1HhXgvF24gSlIe3rIBY9H3C7erH74PWhNf9D4AEYTKdFrXXMn6
X-Gm-Gg: Acq92OHDrxvHrIfPAHkgMcBmT1ByFYjwvFv0BtWRLykIEUYMBl9fXlYNHvYG4Xbxjur
	wFodRS7vLpU4h3EPouKJhc8AWeU95KmVSqwGRBcvY+Eswd6BEC36u7TL9e+dwOFyZIvLpMDcmMo
	DKTRJznJuq3cbVr1fX6lEHVIlisZaIyBJspxQmXT0fVRHaL3qPTDz+BIi1EMhGp25iy5OvjCN8t
	rGIOf7zVEICx9BbzjDvhBd1Tq+UJ4Zez7G/kIOMtUaXHS/oun+voIfn9/IK0T6nefihMVMO0i5h
	z6sWEVL/l9OpW4lPRtANqo2ZKRHLlwSykbpzEjWCFgwMKBPJ5ocEOM4urHqGcnixodtYzvKzQ4C
	xmRPoDW450B9PPwDUDUsRC0gUcXCd7ofJ5NxOkYYrXTn96VT6mMfVFO8=
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490c25dd6aamr39020195e9.16.1780653989443;
        Fri, 05 Jun 2026 03:06:29 -0700 (PDT)
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490c25dd6aamr39019635e9.16.1780653988913;
        Fri, 05 Jun 2026 03:06:28 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm40480039f8f.29.2026.06.05.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:06:28 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:06:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio: check mmap return value in vringh_test
Message-ID: <20260605060404-mutt-send-email-mst@kernel.org>
References: <20260605021446.1611-1-yanlonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260605021446.1611-1-yanlonglong@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _opZ2DzHvWcH_eMpwmmab0Pln6c3tHK9faTNlx9sb9M_1780653990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2026 at 10:14:45AM +0800, longlong yan wrote:
> In parallel_test(), the return values of mmap() for both host_map and
> guest_map are not checked against MAP_FAILED. If mmap() fails, the
> subsequent code will dereference the invalid pointer, leading to a
> segmentation fault.
> 
> Add MAP_FAILED checks after both mmap() calls, using err() to report
> the error and exit, consistent with the existing error handling style
> in this file (e.g., the open() call on line 149).
> 
> Fixes: 1515c5ce26ae("tools/virtio: add vring_test.")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>  tools/virtio/vringh_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index b9591223437a..8cc5ca6c7cca 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -159,7 +159,12 @@ static int parallel_test(u64 features,
>  
>  	/* Parent and child use separate addresses, to check our mapping logic! */
>  	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (host_map == MAP_FAILED)
> +		err(1, "mmap host_map");
> +	


trailing whitespace here.

>  	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (guest_map == MAP_FAILED)
> +		err(1, "mmap guest_map");
>  
>  	pipe_ret = pipe(to_guest);
>  	assert(!pipe_ret);
> -- 
> 2.43.0

