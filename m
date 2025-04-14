Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2025395C
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648359; cv=none; b=GWB0UMujv05sSU7i8PeRAn4eiMfuQfeZsjOrUP1cdXtWmDlzciyExdb0xn5TmqNVH7KmPQK6bUJU1yNHC+Xp99BNvEiE/01E0xYIk4HLVhhjpA36Ed3aOF7UlqDL1fj5E8XMGv8h6oWID6PekJBeq89ORvhYMKE4j9GHeL/XV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648359; c=relaxed/simple;
	bh=LxeEjXsTzyjmpn+ReNlLxMKLEF/tsQrcB3L0UMTB9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IHp3LT6We6IEKK/vkELWcNXWkPyEwmYDK/vWD6cOkszgJPbTiurgtEyXCpM9P4iW1H/EKIgluwdagf79VtYf0cxzw2KtGNpnjTHZdnbqYgo03LmIbu0Msnq+zv51LuoyCQqdktocMRw5/LkUL0AvrFekeUyF1kTGd3BAN4kGTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrppPEBy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrppPEBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744648356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psPpYVaNQlJBPoNb/90nh8sbsObK4AuLZcGNe09lj5c=;
	b=VrppPEByuDEadsvSH+p/M1HnQCMj2v5XF6AtS80foymTitPpmiIE2Wd7OklxnBTn8KptjP
	cMjxNz1BJIYJykiYD3CB73znx6OgDQqRRwARqkF/FoecqbhK0Nmhp1qdoAywk9Rs0p/YYk
	4KZxmYhS1mgx26NWN4iNlWa6vHVGH2A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-kPTAoGkyNsSvoFezB6AyAA-1; Mon, 14 Apr 2025 12:32:35 -0400
X-MC-Unique: kPTAoGkyNsSvoFezB6AyAA-1
X-Mimecast-MFC-AGG-ID: kPTAoGkyNsSvoFezB6AyAA_1744648354
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so2386611f8f.1
        for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 09:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744648354; x=1745253154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psPpYVaNQlJBPoNb/90nh8sbsObK4AuLZcGNe09lj5c=;
        b=tyPQCS6Qz07ARihg71qD9idpn1insGSdkaybCvr23y9mHBGZrGlgbtrdeaR3gG3Zc+
         zBOnPPrJfOL6w3/XIY2YgLib094YuRssIEL7wX18SiDHGvjnyVnZ17zTi6GwCjIKJXO4
         U3QUEK8hWo5kxgfpw9NNjgTu/AoDf9++HM9/j0Avvq5bXoLQua17gQhSd9fvEQLkBSDj
         ePIYy5rmDFAkJ7fR5o5ky1pH9DbOIuuIL/iX7sUVFZa1Kw4icifMGX66ABq44EDmUZTJ
         mtMG3zJXV+ZHxTsREi3l7ZNZIU022m9rOK3VsFY3YaYkv6G4nGr4Nb7lT7kAuOKT1VW1
         /pqA==
X-Gm-Message-State: AOJu0Ywvm6dMIwftN0sHOa1pq2zaYg7c2O13VrvpydnyakGRb7dOSIga
	CldBz0tnRnwlayFl0b8FWF+ccale9ALo+Raoo9dhMInssk0Zh+g89ZFXCA9vWIu5Alt9hB8fS0z
	3uafLiJ/LH0PFmYBn1OPDFjhwMz+UeBOno4yk/l7onkkp0rAcg1LP81CvMR58oq6tuQjLLJJs
X-Gm-Gg: ASbGncvkQ778pn1gVAlullJ1AAFafRGMbwUL+RE9+m6crzLma34mZMbx1ZjY2d08qzC
	j6oKULqvSzNrDi0DBiO7g5fcHFkgoRrQPJmuOmacihUltEJpzNRnDS0CxQxst+QSdnFAq+udZjS
	sbAV6dfCTBqHaCrfFB3raveVdyjK2py3M5IvOowhuHobPjA0kcKk4koTmeG8HOsynNGlInLhWD6
	GGQe5TWDdokeH/w/I0Hhu9l4vMBrhFPsrq7FFZWPSPDbEMth3/3aTIs36GgpmFhnIy1q3BptjR9
	elVIVw==
X-Received: by 2002:a05:6000:248a:b0:39e:cbca:8a72 with SMTP id ffacd0b85a97d-39edc3059aamr38198f8f.12.1744648353762;
        Mon, 14 Apr 2025 09:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErshira9b65DJz4U+YOoZ2EfEQ5MJmWz7qS8OqJT6VLSYpu4hvsslk7OCkkLLr5Vcu2G6UIQ==
X-Received: by 2002:a05:6000:248a:b0:39e:cbca:8a72 with SMTP id ffacd0b85a97d-39edc3059aamr38167f8f.12.1744648353322;
        Mon, 14 Apr 2025 09:32:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm179644545e9.10.2025.04.14.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:32:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:32:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, jasowang@redhat.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, joao.m.martins@oracle.com,
	joe.jin@oracle.com, si-wei.liu@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] vhost: add WARNING if log_num is more than limit
Message-ID: <20250414123119-mutt-send-email-mst@kernel.org>
References: <20250403063028.16045-1-dongli.zhang@oracle.com>
 <20250403063028.16045-10-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250403063028.16045-10-dongli.zhang@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjWdF7Y9aKtOHSUoHGeaxR3MGpQAwfi2v_LSvEJoupE_1744648354
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2025 at 11:29:54PM -0700, Dongli Zhang wrote:
> Since long time ago, the only user of vq->log is vhost-net. The concern is
> to add support for more devices (i.e. vhost-scsi or vsock) may reveals
> unknown issue in the vhost API. Add a WARNING.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>


Userspace can trigger this I think, this is a problem since
people run with reboot on warn.
Pls grammar issues in comments... I don't think so.

> ---
>  drivers/vhost/vhost.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 494b3da5423a..b7d51d569646 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2559,6 +2559,15 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  		if (access == VHOST_ACCESS_WO) {
>  			*in_num += ret;
>  			if (unlikely(log && ret)) {
> +				/*
> +				 * Since long time ago, the only user of
> +				 * vq->log is vhost-net. The concern is to
> +				 * add support for more devices (i.e.
> +				 * vhost-scsi or vsock) may reveals unknown
> +				 * issue in the vhost API. Add a WARNING.
> +				 */
> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> +
>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
>  				++*log_num;
> @@ -2679,6 +2688,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  			 * increment that count. */
>  			*in_num += ret;
>  			if (unlikely(log && ret)) {
> +				/*
> +				 * Since long time ago, the only user of
> +				 * vq->log is vhost-net. The concern is to
> +				 * add support for more devices (i.e.
> +				 * vhost-scsi or vsock) may reveals unknown
> +				 * issue in the vhost API. Add a WARNING.
> +				 */
> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> +
>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
>  				++*log_num;
> -- 
> 2.39.3

