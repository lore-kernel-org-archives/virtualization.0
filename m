Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E01395AD5
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737416; cv=none; b=ifq+5lXVIDeVFkZq/sQ22nJxMmOkKoVw+Tilk44Kc5k/867xdHcFm0nJFiX10m3WOAwKtFV7wLnqJB2e0i9wRv7Xjkzuv4Ivh+QXqOV1jiNMiuE87ewBIGNZogUh0LP2uKW2VVdS+uQ7JjnAsCuecLzyptA+GOQ5ZsJz5924UU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737416; c=relaxed/simple;
	bh=kGVTFjQOt0Sx2VxVQgyTluCNk7T0u6JCg8f0cfpLT/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RmxLvVZSCzFWj1MjN9a1NZzwcPwNDboqWE4JAKEoTOYGnVWu5v7Ve0WF1DkK5Nd1D1QpMLs01ntx3zMzLHllbM5JZh0A+D7MY5uvu6xAz4NHzhaKBTJAbZ0gazQ7jjHqQpgJYkQIkvk2gHoJlXco0Y13X1Yod8q5M4Zq4oPKSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaGhLpNi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaGhLpNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785737403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opESCzEHUJBRfpmQVy8tuXudchPZvHydKoko2MNrriA=;
	b=EaGhLpNiq8t1ldPD3XGygu1ouySGKmoXbxVCTI8Sogav3U/f3Xsgmz2WggWGVZRYh8RfsT
	VK0d0gOxlZlaey47wPVaaEhNQmENFO6X4V/jgRWjUSSQAJQ/yGgZoqRQzkPKLMq5yCDF+2
	8r162hGgM/figPAM3Rm/H6gzJHwxJ80=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-w_J-sg9TOyW5yjdSQwcNew-1; Mon, 03 Aug 2026 02:09:57 -0400
X-MC-Unique: w_J-sg9TOyW5yjdSQwcNew-1
X-Mimecast-MFC-AGG-ID: w_J-sg9TOyW5yjdSQwcNew_1785737396
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so3181204f8f.2
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 23:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737396; x=1786342196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opESCzEHUJBRfpmQVy8tuXudchPZvHydKoko2MNrriA=;
        b=P6sTnv+NYu3170s/epmA1rNXrKMpQCPhTL/1818uWuz4YdDf4+qDofMr2NAEkA7mL+
         /FkRJNuVdAkqwGzmCk03qn28X2Z5wJFw8dl2v9esJri2VWwUHHyjaPRnfcCDH+CI2Vr1
         yOvFzRvJQnAYbz+3WvLxgGzF0btUesglEYIs6bLttgffqxLt0xOGJG+8/JfN9rpBDP0n
         O6LpgNpgHtQeLH/J7Ct1M4AuAqHA9xzrEvGSO2bNUbyzvVcTUS8QyE8V8PLTA4DDWDN0
         gZA5/4GQEaJVPzN8wTY1sshYJBLHL8T89IZHzuEjVl53rGYiAImkag+NQu60eQcKukR5
         FK/A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8Bv5cXNEh7R1uQdxPoCqHjknsxndYdSJZO7eg2meWmlnnoqvRY4ZUZ6mWwjIdHxcSOrqHxaSPnymXp+qiKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXKGz8A8KMNCgol8JThsVt97YrskF/xJGnTQEiQEVCEW6bu9Ej
	x1w8swMuSx4zUyGSXvdISBCnVM6rspLWuT6Ck9ZVcsg4jBFIT43TJwQbg6NCITY/4dyJkcNWNLj
	mU8UVBr7pI303a5I64Ee53KfYyYmn2LWvNsKcHilMUQOB0/HzNilPNhtOHtksQJhBY/VW
X-Gm-Gg: AR+sD10itaihQqYU56zW15DSkRYcfSbyPjG1bo2THOBSa0nQh2u1drSowzNEpkD/ByK
	1PfuvZx8OiW/KvmKx1uzkYlwNhrZak9yuSLDY6+dCdyWs2T1wQncIGbz+8Cf3jFlgcLqZNoR9OK
	WRmRVdk1mM8RY6IZYqSPa7afe0g5Itg76tdh3mVOnQWk9G1QuO3UmZVdUKGw/S8+2bVKtS6g9+D
	0alpAtOPkgzcyfHbpL+K2SqTpk0ru57DychTP19XxxQ3RqMdkgd2Rlyma22Tmt/D1ERWy6jlppH
	FLo02HySKfjNMS2vBtVI+KWixt7wRyEW5KVTWIoC5nYLk5WfqSQqHfUrbDpMjqi48PqQwhIUfPp
	/W/4H5KA8FlW69sE7c9cMOw==
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr159725955e9.0.1785737396403;
        Sun, 02 Aug 2026 23:09:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:495:7538:d4ea with SMTP id 5b1f17b1804b1-4980c5fd773mr159725185e9.0.1785737395940;
        Sun, 02 Aug 2026 23:09:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dcb4sm327289125e9.13.2026.08.02.23.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:09:55 -0700 (PDT)
Date: Mon, 3 Aug 2026 02:09:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: reset the vring metadata cache on vring
 reconfiguration
Message-ID: <20260803020641-mutt-send-email-mst@kernel.org>
References: <20260803014823.68623-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803014823.68623-1-juny24602@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a5pgNYd5fYIYcDbNLP2jLfEb79JuTKuPkX7ZSXuz-bg_1785737396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 09:45:14AM +0800, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
> metadata region, and iotlb_access_ok() returns early on a cache hit,
> taking the hit as proof that the region has already been validated:
> 
> 	if (vhost_vq_meta_fetch(vq, addr, len, type))
> 		return true;
> 
> The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
> device IOTLB (re)initialisation and on vq reset, but not when
> VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
> VHOST_SET_VRING_NUM changes the region sizes.
> 
> With a device IOTLB attached both ioctls are accepted while the vq is
> live, and neither validates the addresses at ioctl time: vq_access_ok()
> and vq_log_used_access_ok() return true early because the addresses are
> GIOVAs, deferring validation to prefetch time.  Once the cache has been
> populated that deferred validation no longer runs -- vq_meta_prefetch()
> hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
> translating through the old mapping as
> 
> 	map->addr + addr - map->start
> 
> for an address the mapping no longer covers.  vhost_copy_to_user() and
> vhost_copy_from_user() consume the result with __copy_to_user() and
> __copy_from_user(), which do not check it either, so a subsequent used
> ring update or descriptor fetch accesses memory outside the region the
> IOTLB actually maps.
> 
> Reset the metadata cache whenever the vring is reconfigured, so the new
> addresses are pushed back through iotlb_access_ok()'s slow path.
> 
> Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>

And it seems AI assisted writing at least the commit log am I right?

You are supposed to use:

Assisted-by: AGENT_NAME:MODEL_VERSION 



> ---
>  drivers/vhost/vhost.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..77c96993100b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		BUG();
>  	}
>  
> +	/*
> +	 * The metadata cache holds the IOTLB mapping that backed the previous
> +	 * desc/avail/used addresses and vring size, both of which are being
> +	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
> +	 * region was validated, so the stale entries have to go.
> +	 */
> +	__vhost_vq_meta_reset(vq);
> +
>  	mutex_unlock(&vq->mutex);
>  
>  	return r;
> -- 
> 2.55.0

