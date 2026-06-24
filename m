Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1328D8D0
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338385; cv=none; b=AbYB7cD+VLlcblpKfVuJHoHitEloC9rautM994/Vk3nbG3UPkv/wKxFvsexIcck+7YbHS1nRtFNOA6mQiiS41jS2xbne5/V333tUNbL8+4R2lWsu0KoIIRR048t3/GbmSu7YqwidQrY4bJOvxApkyomdr26djRCJ9EY88KK8ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338385; c=relaxed/simple;
	bh=1XTIFRs028W9ICgbgP9xwvBCqmmM/TabDzaJ5qzi1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O8Dns2L7SHcGcsi3plqLrhFBMI2800ifLS40qGLEjrkgfUAeHSFx80cLXVl3xUmYik1o1c0zGWJSqtSYwZvFgFfLjXyqOAZhqXUxFZChmS5rB2VjpCzWeDQ+Wjst/TSXiUcpQtmLFv3O+i+0JhfrdPr/Pee8ptZzDop7yBPBH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFh2/LLl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFh2/LLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
	b=JFh2/LLlgFoOA3YaRds0/vXw44PzwwgF5i6ykQfJFX8c0bW8+yaC4hA/Q5u1RYV38S+M2x
	nDz+twHX3q/5D8tA77HFT8FYixSrSBCT4fEdC219FtX5ZIhbWX6w82Wv8W193B5GWI/3Kl
	C2isOo+5tuo5is6Tjre5qDKbM7Xm7Aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-8-PfBErvMja3rc4h7Vtpqw-1; Wed, 24 Jun 2026 17:59:42 -0400
X-MC-Unique: 8-PfBErvMja3rc4h7Vtpqw-1
X-Mimecast-MFC-AGG-ID: 8-PfBErvMja3rc4h7Vtpqw_1782338381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924583c7baso16316535e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338381; x=1782943181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
        b=Aehzd8yAObOH+PWMrTbDCUYoxNO59GPUXDgnpQytfzN7+psziPchZ/URVhPtjiBRWy
         ViIoCMTFbjk6l6stqGBLIGUGagjTcF/w3K1HFM+lS7axoJwAVZI91g0eVupjnMRDDw/n
         GnMcGykahvO6p6w4veik1jn7KaF+t69lMb3h2ihKGti9QbY3gAz5OnoCN3PwKm41qGsh
         QRRQOvz0JXVxkaKvQ9WtbmjbpeC7AG/VzrEGTlVfQsBzsHbUPgU0T2ZurQtCZj8xq1cB
         dtUI4jfeJ8oxzLhGslGy4vhEFv/gwwPnQtQm8vFuclwoZIC2su5L89j/Sd2T/CkuUX5u
         2MsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GnmBi+9IlFuoDHaNddi8Q9izUvJ2XXFWLRvulDhWwIiHvdg8OfmFVWVf2svup62FHrVMvPiQMYRU3RDbGOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/tUo9aVABqcOvCZrahCYLqfrKXDcef62KWXxiONndRqQv3D6g
	rOHuBDf7jVnAh4FwLE++82+hXCffyqPCX2Jlymb02jnHnP9SXTdPC4Pwa/OeZRlKPePicabYlJt
	BArLs9xcvA17yWh7daDBnO6I7D+Tn8HkqfjdkgnukdRzC+LE9wlbVXw0Vl3Pw9MBA/kE1
X-Gm-Gg: AfdE7cmm/E5Rd1V3BavfbZBX2VuT6pDwDlf7OM4rsHy3M1VOEZupNQKHTCpmHmmZH+L
	ps/tkUArRcVbmZS9G+Vy3uSlNkeljyV8/dBokWHvFmyzynxl8u1DjN96/yK8ZJJZnnOB5l5KaM8
	Li6ywJMyO7hs0Zxr7OY5FF8KHFFhGrJYfrJ19rtKrqM1VqsdaBBwTrCcUctKi0QeTawofW7S0lG
	fO3p9BBjxwxXLsYBt5BpHdHxtAlGkaSiBsdlXfpMmRJLJLsdrJutJLBTuQWg7K0HTYW/OolTPw4
	XhlbZaDjz9W0GnKlqo9sI230fHYE1NVIv4XGcV7iZ6UZ/FfyyixsIxvoeawQpgola8KiVGclaHu
	4XAOTClfBhZ0UCIvaSM6Qld7PuY5y6WJ9
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420665e9.12.1782338381036;
        Wed, 24 Jun 2026 14:59:41 -0700 (PDT)
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420405e9.12.1782338380511;
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926543be74sm5120715e9.1.2026.06.24.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:59:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175855-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S2sk9Y39nhcVshtF1aoVOb95KI602i4Xdoq_faVIOhg_1782338381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 02:56:20PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

weirdly wrapped. will likely break some tools.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v3:
> - Add the Fixes tag.
> 
> Changes in v2:
> - Clarify that the overflow is on 32-bit systems.
> - Drop the unrelated memlock check change.
> 
>  drivers/vhost/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..38b28ed3d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
> 
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> -- 
> 2.54.0

