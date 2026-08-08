Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16D36896D
	for <virtualization@lists.linux.dev>; Sat,  8 Aug 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185559; cv=none; b=j9N6zJjjvbJ5TRpEq162ARyZ2NBurU/N3sEhZHiDbmClGKcCNghc4XBOGR0672VPbTxvKCtlQrU6mvbwUm6q7KxpiYFhSQslV41jvvc4j3qpMxn9QnH7UP3g8FWknYN2VEWmwtj8eMsttMNhu3AqQC/WQ35l5y/OuU/OZOHVzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185559; c=relaxed/simple;
	bh=IsWbm760O9I15mA7fvW+rKkxvqhQsLCH30zSXYJ8nsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i7M5Ts04UqK6KAunMBPnNQOH2Yo1fDeNXZeTekD9k6X3bISvB+YcuNOebIpCi3aMHlCpNP/UcVMIUKWJ5Pnng/Jk7d5R2E1SOSOFuDyQMU+JIKmHB9YxOPilfm6CAAVaq7UexEGGxpp3r4ejMEtJSanOGqnoPd9obioubcpCnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlHWG023; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlHWG023"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786185557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8pmDKziJnJ1aHFZKG0c6hFog+fOESVRfbMD1dM6B7Y=;
	b=AlHWG023Y6wheF1uZyVNlIC01f/iI3Oai3AsERKclppoa5pbQN4mViGFgwXGwejtBCppmj
	3K11gNpI3eFIeMYYdo6B6ISXAfBlHhqlLx7gGp/pxRUmJ7/MUejxKcRpqke00Nn7N7Kra8
	ahmgdHhA9oqENVU1TmC5pcjMozjejjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UfBZuduGMuuaYnrctXoldQ-1; Sat, 08 Aug 2026 06:39:15 -0400
X-MC-Unique: UfBZuduGMuuaYnrctXoldQ-1
X-Mimecast-MFC-AGG-ID: UfBZuduGMuuaYnrctXoldQ_1786185554
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994aebe932so4453525e9.3
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 03:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786185554; x=1786790354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8pmDKziJnJ1aHFZKG0c6hFog+fOESVRfbMD1dM6B7Y=;
        b=DdCiKkv8nypX17RQVzesXtGRrpRQimxQcLmcLCHkWN2IAQK5DCHsMtdfpaue6+3mkH
         zSqASjg52p0F9QIMb1hDaPw9t62nkNNattfXtEj1GCrjYdnQr13jJlxE6hfxvLmKFloQ
         3V3MMQPVUReHJeIOjPr9Xf74Mvu/sqYFgVMVsglIzWykdM76/plAcJwe09O1bWgd/MjZ
         sCtjTG0fksrNGYaHfIfDtGNx4mAUIAwurYaUzDa9ErCcWFyVvBOcgSO3Hx/Fb94vCOeU
         RV//84Y7qyiATPHawyyFJcdQLbTPIB5fW9FgTIuUjFei+lDXRn8L4RINh4I5lDeYcNNl
         X8nA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2JeZfrn/VAGrelb93SYrpNj1SdHWFESMIW7ha3gtibjoDTP7oJ5Ve8SyJN/Uu5kugO1JdcRgjJ7sRVPeYEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5WsQa+V3S1iltQqaIAxYwcyZlYUpwGMKYHZWPwEHgp0S1Tx7S
	4J9Nd1dkGjoE0oua3B+KQklpSLTaQQe5WexQZ3S6Ubtf7c1m5DBfizuWaIqoVDwPR+4OKvz1qUc
	s+m+lUP0BgC4XmZHR9AgWY1sjLOvqmzMkF3AvN7oTLXeGN5e+z/mmlNuynHV/ccU1DIz8
X-Gm-Gg: AR+sD11RVdC9byj5tvm8YIhNx4CXfEl4I3Nf5QxSoURAPpoUYaBMpJhwg4e2Rm//Wc3
	Nbcgu3MxRk3wW2yIx+i/lpIHXxyBThQi4ohXcnmFqGc/NDHIOuV9/SUpxdI0bB8bedNIb/36zmj
	WT0qrVUWL8IYMWAR730G5uIptYxJ1VondTxJsZkmIFr/VPWeIgFzSNY3RIpbLH4UeYI/8YYGRMX
	N6PprBHpM0qCA84N4qNE3BP/imP32vV520nU2K698+08/ppfAF+B4fWZN4t7AM9iLb0qs+4W+F/
	bugQVZ+YNRWU6zH6gfq/UPbAMCpht2tIroubr2JgRCQMaPy8MWcUR2ft1mUvPY68dXySKmKbp1d
	WKMqkhMzKqVU8yWhS3mCuNPrT1Rz/yMg=
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4994e71c87bmr305222635e9.7.1786185554367;
        Sat, 08 Aug 2026 03:39:14 -0700 (PDT)
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4994e71c87bmr305222285e9.7.1786185553786;
        Sat, 08 Aug 2026 03:39:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2898sm99603235e9.4.2026.08.08.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:39:12 -0700 (PDT)
Date: Sat, 8 Aug 2026 06:39:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Message-ID: <20260808063901-mutt-send-email-mst@kernel.org>
References: <20260808103415.101261-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260808103415.101261-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k04H70_OE8bbxaP_pVnHnO4bl9ijfpZqBa00kgHRCYI_1786185554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 08, 2026 at 06:34:15PM +0800, Jia Jia wrote:
> vhost_vring_set_num() only requires a non-zero power-of-two that fits
> in 16 bits. vhost-vdpa then hands that value to the backend through
> set_vq_num() without comparing it to get_vq_num_max().
> 
> A local process with access to /dev/vhost-vdpa-* can therefore set a
> queue size larger than the device advertises. On the vdpa_sim backend,
> the worker then walks descriptors beyond the mapped descriptor ring.
> KASAN reports a 16-byte out-of-bounds read, corresponding to one
> vring_desc, in the vringh IOTLB path:
> 
>   BUG: KASAN: out-of-bounds in _copy_from_iter
>   Read of size 16
>   copy_from_iotlb
>   copydesc_iotlb
>   vringh_getdesc_iotlb
>   vdpasim_net_work
> 
> Check the requested size against get_vq_num_max() in
> vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
> -EINVAL when the request is too large.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")

sign off missing

> ---
>  drivers/vhost/vdpa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0..b2083e1ef150 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				vhost_vdpa_unsetup_vq_irq(v, idx);
>  		}
>  		break;
> +	case VHOST_SET_VRING_NUM:
> +		/* Reject sizes above the max reported by the device. */
> +		if (copy_from_user(&s, argp, sizeof(s)))
> +			return -EFAULT;
> +		if (s.num > ops->get_vq_num_max(vdpa))
> +			return -EINVAL;
> +		break;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> -- 
> 2.34.1

