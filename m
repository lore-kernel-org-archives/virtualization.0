Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BC225415
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921131; cv=none; b=YDqSh/a3vsmi1G4O99COm9n2qksSb2Dl6bCzYkPjC5MqmTfUWLtZjtSxMp+HpsQcyvIooCghabEtsK7uEzxP/g2erKViuJHgVJHH9I59QNA+lWa0BaC07oD9EA6awVeQy5t8WgqE/8AdwBmHwWN2UktMdtayzhZKQOVtnnZd1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921131; c=relaxed/simple;
	bh=9IE8nIXiEWSBXXZ68CaiTh5yjeL/PHvQVU9lErYD0NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlMWLWttbqaj9lU20Cj9oGFtBnWQLO+XFYqFLoFE68rmK3qMBvET5vFb9u+zMrEFG9mysAHDD4EOvNd3AgKA+FwnzU1IKNpatQzCXN/aSXB2420FaySBZggYyrGwIoDwHPSe4jX/tRefyeJwyXJYMoSDkWCbnmPCE6gSfXMgGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hD1PVKVp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD1PVKVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762921127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eivNhWwruPOyJV5JjaV0gz6hcEE2lC6++XL21K7iprA=;
	b=hD1PVKVpql1Hv1PVb/r13fEqal2+9nnXfyCTbwlffN9w3qYn7pVlUc1byODpajs0K0z/N/
	VAgMd44cnXA0uAkm1tDvWkrAUqFlQCHCoEJvPT6iw3j53GbEJum/5Fw6BkKPcomP/M2XP/
	mBe29Kqt7hJ2ViGYkZjdZAj4jDqaJm0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-TlUNy3YKPMSeoHk4AzWsWw-1; Tue, 11 Nov 2025 23:18:44 -0500
X-MC-Unique: TlUNy3YKPMSeoHk4AzWsWw-1
X-Mimecast-MFC-AGG-ID: TlUNy3YKPMSeoHk4AzWsWw_1762921123
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29846a9efa5so10543185ad.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 20:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921123; x=1763525923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eivNhWwruPOyJV5JjaV0gz6hcEE2lC6++XL21K7iprA=;
        b=En/0m/QoQKxaSXuCGlLmdYxKkKVBi6YenUQh/H/wXrsrPidyMckM1NNk6EN6TVF2JO
         OxtPr3mGJvwz8k3CAB639WbjTgoh3gXsPG05blQQhr1HB5xBEXzM7ehwh5Ku6wpjwzIB
         YPCGbjGPFIBgF6XWYsbChzvCzvdGElfTeoHSiuVgmD6m/VRy7+iutj30gDMyT8p1wNfz
         oYrmbimxqQfoeAbRPz3CZ509qyp8y/P2rg0ofILoO/D+MedI1U37rjuXooarcebrkJDs
         JHU22hoG74rUN9lrNNnLubeXAjDcGT4LGI1OB4wa29gL+mLVfITCCkg5ESOYTv/l9M1i
         WraA==
X-Forwarded-Encrypted: i=1; AJvYcCVia7extIWoqq5EGRtQTK+JMxdhDflBXrG7JdXs6C+KtyrD59m9XhG7hHais8oygvk4DjFm1rpzEvi6hhVsSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3cXGiLpYH7kq1nBYMUf8aX9B6OO8bL6HbaqSHaYjq5vk8L5JR
	+VwI/pNDADmM2BrgHrrlW2LLWa0WEWcVoTCdr+MDOseotUdQHHL2QAzV42u0rS6V2lo0L+dscIY
	LuidB34HnTiGwN8aaMl5jBhNmT+mAhNeogCwYkXOrle0dYPQtg6Hddp+2+RYaN0tdgj5+47sHjF
	kdfPnaJNHt1RIBz82QQfvspcQprj2AZxeoclk09gzjBqsctaxzjml4lA==
X-Gm-Gg: ASbGncveyEHzAYILz/KqrIHo07TeN8Sz3SxRM7ekFfMOY/f7XzYa3DlOt6OW1CdjLC2
	mAELdtljbNS5k53JXr2nB5Vfz7Kf+3+fdb7MkaXtnX35WoN0LU6Z6SoJuNkP8aqM9wYjyOarOG2
	f+U4yPDqOEdOBs6AJJ7YRWMfl0eob6KOQpfZClr/NnuCqfhhyQuEfn8Vs9
X-Received: by 2002:a17:902:da8f:b0:295:7b89:cb8f with SMTP id d9443c01a7336-2984ec7cd40mr23356115ad.0.1762921122798;
        Tue, 11 Nov 2025 20:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESILra4ewxIe3nH6ffWXaekvytV9hW/5+bzDzS8duVHEbPHdwG317ziSru+7icCcrZ0vO0wEgPXJaHoTKIbrg=
X-Received: by 2002:a17:902:da8f:b0:295:7b89:cb8f with SMTP id
 d9443c01a7336-2984ec7cd40mr23355825ad.0.1762921122401; Tue, 11 Nov 2025
 20:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com> <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
 <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
In-Reply-To: <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 12:18:30 +0800
X-Gm-Features: AWmQ_bmlbBUx93bV2lthjjocX_fnCnHJp0eUq6ipUa6aaey2HEa7eyVusHutp1E
Message-ID: <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Dan Jurgens <danielj@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7nDzv-GG7l6jBD4fr3OROyIlCBMXbESzVXDsgjoLotI_1762921123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:02=E2=80=AFAM Dan Jurgens <danielj@nvidia.com> w=
rote:
>
> On 11/11/25 7:00 PM, Jason Wang wrote:
> > On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> >>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> >>>       }
> >>>       vi->guest_offloads_capable =3D vi->guest_offloads;
> >>>
> >>> +     /* Initialize flow filters. Not supported is an acceptable and =
common
> >>> +      * return code
> >>> +      */
> >>> +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> >>> +     if (err && err !=3D -EOPNOTSUPP) {
> >>> +             rtnl_unlock();
> >>> +             goto free_unregister_netdev;
> >>
> >> I'm sorry for not noticing the following earlier, but it looks like th=
at
> >> the code could error out on ENOMEM even if the feature is not really
> >> supported,  when `cap_id_list` allocation fails, which in turn looks a
> >> bit bad, as the allocated chunk is not that small (32K if I read
> >> correctly).
> >>
> >> @Jason, @Micheal: WDYT?
> >
> > I agree. I think virtnet_ff_init() should be only called when the
> > feature is negotiated.
> >
> > Thanks
> >
>
> Are you suggesting we wait to call init until get/set_rxnfc is called? I
> don't like that idea. Probe is the right time to do feature discovery.

Nope I meant it might be better:

1) embed virtio_admin_cmd_query_cap_id_result in virtnet_info to avoid
dynamic allocation

Or

2) at least check if there's an adminq before trying to call virtnet_ff_ini=
t()?

Thanks

>
>
> >>
> >> /P
> >>
> >
>

