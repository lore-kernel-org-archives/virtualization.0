Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1053E024B
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883152; cv=none; b=HxmzNSVrLy+vwCZstQs3wAym+D/LeHKpYWFzWXTp1z7fxOEVOFyBcd94p3P6ws3onbBHIPHNxIVE6bODGznL6hPRMMzIODXvTeKTPT89oTTt8rVVpDZ/ob2i7HAfvP0NVOx/5+qPVmMUV/5V0mTfZHQu0magD8oePAoIfLluB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883152; c=relaxed/simple;
	bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MRZeAyYm8g58kzcJ/2+dZBPioLYB6Co15soV/WTPrdUbnDwfEiufBwniPatKBMr+JQfZT9S3awftxDWrwUGzX9uhJExHAqEgXNWeRkY+ymh4CFSUh33upimRs7DKGIQhZ6jm3UH3RNFEFuNWAvc62TckSNxmZXKoaDuHGNPtT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqOpV/KT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqOpV/KT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791883148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
	b=bqOpV/KT5yv9659dEiYYELjQo3V/pITRYC+tsilBTIjCL1/qQb6P6vtP8EkDuXjRShKkXH
	jlfq69P+wPSXgxbCScEzJUpOoBxtydqw44kW/Cjx3IguqEjtc7Z66MMg4fmVsri9+C7UE0
	Zv3STkxuDy94kmxzsUWjBKiNghDWUAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-h2fqygPcMsmvmTuQmGvYRw-1; Tue, 13 Oct 2026 09:19:07 +0000
X-MC-Unique: h2fqygPcMsmvmTuQmGvYRw-1
X-Mimecast-MFC-AGG-ID: h2fqygPcMsmvmTuQmGvYRw_1791883146
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso18581265e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 02:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883146; x=1792487946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ifxJXmHIdOpbrwVmaxz9CH5L1s1R8aDY8bfmqlUzMI=;
        b=2Ilqk7YuJWz0lUs2OOq/hxx/eebeTn2v6r6IdngsU0GagBbvrcwYH/dZzfw/LiNVEC
         EJtG8bcsGJifGS258YMq5ZN4uYts5f/HAZ7THBebHJqNe1PQ/jRVMezZeTSkb6IxjsPa
         ET2VASlpZXjwZSohBzPDb4V+OvUNEfyVRIpBxnFnVsxC82dE7EDAVjqbyyhKFqOb7A6t
         KTVUtNVUz39uzP8uwWMT3aVF9m9jj7VJEaSDz5vQm2La6iLGjnjHGkRl5IGvyMugq22H
         z/2BUtMEfW55xxgN3TSHoCVCHV3e81T4DK9Ij7b0NKqkC424KUDI0EwoG1bHVCsl9Mec
         v2JA==
X-Forwarded-Encrypted: i=1; AKwUvBxPXushkq7fVZmKnwJxooM+Y8y8Qa8oFuY/c3knIdrex7FPQzNvvevQockexRN6VONHRlsXdS/0hrmZgsET4w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIZ+m/J/odMVHZfBtwu4fAsDyRqBPJCoaETCFGqYVOfXwYfYqYW
	GMwv7++lcBL21KynYuxFUtRG3lHT5NOVWIH3S0vjmcLJtnVYRQiPKQ88QZFo3AF9GfSJLFHhztA
	7IKQZpzSQqbcP3qS+85rWcAzIOZ5vBaC96R9/vkGhhevu17G2TrMTEKxVWYKRdxuGWqKl
X-Gm-Gg: AYBFou1fgwEUEuotqJJPQP/C0g/k4Q3uanwSW9A9u7B3Oa3OeA1Q+S4q9DAr8k8nC75
	aMxxLxCy9MP66AZKbv+1kNTsbJMVrQY6wdgPP6C1sEdBU0QRtpwvbBGY9lJngv9QHb9hhxpmhqI
	XMzG8h1naWK+PTxXpQKy3IMpYpmKX0p5m52DM7vORPf63lRISg4Q7Hd4H60r+5dn4ZkReeJYFIK
	QksmccBxJWeks7UoHHIpX0trptncQnFldRRHN/4tfn3TR/2kf4djAVAGQq0Gxu+wberuUWx0w8H
	mSSbRwJmRs+7ggvHupQJ82QYbusP1t15JemfVz+hpl6ptPiqNAodkbeO0Pf1jTOQIChhhXXv7vj
	rQfyI3A==
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id 5b1f17b1804b1-4a18e4d2b31mr237237645e9.27.1791883146085;
        Tue, 13 Oct 2026 02:19:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id 5b1f17b1804b1-4a18e4d2b31mr237237135e9.27.1791883145585;
        Tue, 13 Oct 2026 02:19:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.127.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm508318675e9.9.2026.10.13.02.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:19:04 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:18:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <as32zxVBpgdtMUOU@sgarzare-redhat>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tv0GYJew1cze-E2jdwubVQPUMAjjHigvK_A9x0Jge_w_1791883146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
>I've been reviewing vsock via lore+lei for a while now.
>
>Finally adding myself as a formal reviewer, since vsock will continue
>being stuck with me for the foreseeable future.

Thank you so much for agreeing to help when we met at LPC xD

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> MAINTAINERS | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

