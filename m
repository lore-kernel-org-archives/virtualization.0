Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80E426D19
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877054; cv=none; b=A7CSJeWouGSzYHv4mpvWPxI7wKUUhTFqNWsMJfajISnMsVwu0kA3ZkVTp0d0W6VZawgT4wAIaNV4Rvmz+doxSyFS1S/Hkv2xgLIKcMYSTkiZ+UcdP+eMYXZfI+VHg8Bm2CFYwQJ+euBcnKonwgHhT/s3T1WPjEo/3YPPl5Mw86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877054; c=relaxed/simple;
	bh=zD5QzuEXj/aW/lyMHglMqD82NgpBFpKJeLCBCUPLunU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KkN3FuvOZpR6DC+xlG0Gn4Pwq4TK6AY76MrqML89W5xqTyErc/91GHkFV7il+15cDxbe5XWPKOccApm964sE8hv3KLo5zzlX1ydFuLQCWBmKHRqSNj0HPOZS3NN5IEVHtsWNpFtV+xN10KIhYDEnL+I2+S/Kikm5AG1c3QQWsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a53fM96N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a53fM96N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785877052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOchbGmdt6N2onSSUp9osLcjLtTlXjiremk9zMAq/2Q=;
	b=a53fM96N4YN0KiBVIQcLR5/kRtN4h445g4Z0axLdjoG4LFfGiVdByceQ/UtMpbg2WFwBfu
	j1aRgFf9WwpZpIMgGjMDg8DTz+tNiZqMbzvE2ZtGKn4r8QXFGGxFRGQrl7IfDwtwYlSjEM
	WmE6xOjg3pKbmZYrrD1FQGH9zun4WGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-I7FIU1YgO86ucnZ4GAuwdw-1; Tue, 04 Aug 2026 16:57:29 -0400
X-MC-Unique: I7FIU1YgO86ucnZ4GAuwdw-1
X-Mimecast-MFC-AGG-ID: I7FIU1YgO86ucnZ4GAuwdw_1785877048
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495569acf8dso1379805e9.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 13:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877048; x=1786481848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOchbGmdt6N2onSSUp9osLcjLtTlXjiremk9zMAq/2Q=;
        b=fPqBdFMGQR6Hb+XnNoSG6hDG7e2a3nAz68R6W/aM64NUar/lkyRSCT1Fj0D+3SSMpJ
         +MM6LgcPAhdXAa9iJMKZd2kzXlrkfoyGY1M2E1ahF0uRHMaK3o6s1RvXzN/UI9bjHOpz
         krhKe/bZvs61kJ3kgjzqC65zHEbp5yKCVLSePhSiH2xFvD0Wwtg3gik/mDFbMzrWuEFp
         oG4QJdML0Kw+uo8pONsLeVfWjbMFC2wN+cTs4MkN05tBjV+B+YySl7qjSTHndNxOsbbf
         2pucYEvAODu9+jt3JTrbCOje/8DwXiJPwfbWJRzOILMd182NyFmEyewmj6Z6H9bl6lxU
         sx5w==
X-Forwarded-Encrypted: i=1; AHgh+RqQrhMtk9LqeZ0JXXYgsfbSNrkUI9o5j3s2RwI4FqbjFIT82GWhYocFEkNDZPe/QrkIdCebWk21ayQ2QJEhSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywilm9AK8TvpSv8fBlI5VIy2wZmj/kEoXRVITdEsk1jc81RLUz7
	4cE2vRp8WPC3Iifgqt2Qc3ueOhrzI+HImXGFPfzqAD36ZvTyyqECmniShwVy0p25WGlba8bhu6g
	qn6lT0zVPlNVX/FmXETI/22aENYxzEN+XqCLHXa3AyVCa/VFxCyS5DJ415bbnNANLojYk
X-Gm-Gg: AR+sD10y2+62qsmTyo/CuUXcPzH+XPmjVDrq5AwjrZVcRn/oRF0ggtHKFmbvhThlcfG
	03dOvo1lOZlDToPTvReBGh3elxqtd7CZd3ON2sUw11agCReMRXI74pbcgTavHkqnbJn20xHi2BT
	jJhBeiyr93YTOqJMrb+Vs2Iy/DrklEmvKpjDgAqwmkea6H+9d2D3JV7P2lk19CIlsGAvNCaUvzA
	EDmSDk4SPDCw0uu8LuBPKICrUsIVUB3ABWX9sUZJGjDSgCASEVbNLK2/rViOowautBvc8mdhT4W
	0lG51mazDSl/F7NqzpjvPrr58E0Jqdc/b+hCTTkiB9D9Fc9WGf4g5XSYvE+dNDSHcdxlrCinh6i
	AmsbiElHyDXUWExf4ZHsfeg==
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-4994e7ba99emr14318635e9.10.1785877047724;
        Tue, 04 Aug 2026 13:57:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-4994e7ba99emr14318355e9.10.1785877047300;
        Tue, 04 Aug 2026 13:57:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fcb0c5sm107278235e9.4.2026.08.04.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:57:26 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:57:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roi L <roeilev321_@outlook.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: virtio_ring: prevent potential null dereference
 on per-desc state
Message-ID: <20260804165355-mutt-send-email-mst@kernel.org>
References: <SN6PR05MB5806027A02B2C001C8E600FDDDD42@SN6PR05MB5806.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <SN6PR05MB5806027A02B2C001C8E600FDDDD42@SN6PR05MB5806.namprd05.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JZUrMYiX_5sae-_y3rFG1K7iEizQxsDwyJJJx0kr3QU_1785877048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2026 at 10:21:00PM +0300, Roi L wrote:
> When accessing the per-descriptor state structure, we could overflow
> desc_state[] because id can be accessed by the host and the guest
> at the same time, as described by the packed implementation.

it is validated:

        id = vring_read_packed_desc_id(vq, last_used);
        *len = vring_read_packed_desc_len(vq, last_used);

        if (unlikely(id >= num)) {
                BAD_RING(vq, "id %u out of range\n", id);
                return NULL;        
        }



> 'commit 32fe1de5c124 ("virtio_ring: Add READ_ONCE annotations for device-writable fields")'
> 
> The commit mentions these are legitimate races, so I assume id might
> get corrupted? "id" is actually just ""last_used"" in some contexts,
> and at the path where last_used gets manipulated, KCSAN reports these races.
> 
> I'm not sure if this is the right approach though, maybe we should handle it
> differently other than just return?
> 
> Signed-off-by: Roi L <roeilev321_@outlook.com>

I don't understand what all this means.

> ---
>  drivers/virtio/virtio_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b438dc2ce1b8..1d99b75f3bd7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2025,6 +2025,8 @@ static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
>  	unsigned int i, curr;
>  
>  	state = &vq->packed.desc_state[id];
> +	if (unlikely(!state))
> +		return;


I don't see how it can be null even if id is out of range.

>  	/* Clear data ptr. */
>  	state->data = NULL;
> -- 
> 2.55.0

