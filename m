Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AE14A4F9
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909240; cv=none; b=HZ+TDX+6+0iDXRmxGo4ywpjdzSVxWMj89uaHN5pMYA/KnSyZQjT4hhbxBkNnf0BxwYjlRxnN+yeuYLxW2ZtSPxtHBsjA/vTg2DEwefqA9OHAF0sHC1a2jqGMjEm4/nR0I81/kaN0ifccJEeVSQDqyr7aTma8OtxEpMMpSVTjgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909240; c=relaxed/simple;
	bh=zzKo2mj/+4vtvIo5VcfAPqVBZTJajVhadduku3w/Us4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2CfD30AlvAewZDM5W++uRu76iSAQQIfqmCr6M8uoqV6UX0MyKsw5LdYi8O5XJU/l3KEzO72XYNdEeJVRbsqTZDbNBSXxcM8wSb71vaxZUAeaZn/Rwhi/FzipDxrDIp8OmsfUrErcaYoQwas7ymvyBEZ8BuiRkTKfXxhPpte8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hi8RwPRl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi8RwPRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762909237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFVrOXbCFRxnp2issGLmDi5PFJkGnCTM0Na+vvGf2k8=;
	b=hi8RwPRlPPhMgui1g6pB8rU9ZV74BNh4oK6bl/e+dicZmRlaippmRZEBwQH4yJ64BUGwqg
	UyMuF83fR6CTW6AsYxXYHws2BpBaOJ50A3dwKDHth+VB4TZnuKFjmeIor/YXy/FHCG3EwY
	1eGPp6t4a3tq1YBFOA/+fjj5Ts2SoII=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-SvJwf-aWO6GtKRmNNVEUgg-1; Tue, 11 Nov 2025 20:00:35 -0500
X-MC-Unique: SvJwf-aWO6GtKRmNNVEUgg-1
X-Mimecast-MFC-AGG-ID: SvJwf-aWO6GtKRmNNVEUgg_1762909235
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dbcb1740daso173162137.2
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 17:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762909235; x=1763514035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFVrOXbCFRxnp2issGLmDi5PFJkGnCTM0Na+vvGf2k8=;
        b=fG5r3QckIlr3VI1jNfCBt/4HEYB2VLkMmqwPpsEuvMXxgwpc0eCObswHX6qoChpN2F
         pkJ26cFy2TpBTv2PA+t3jIM28sU8W44qhLZIS/Jnam8U2AXs1mPGagTnUpihR4KZf4oW
         g2dbKOGsRPBDXvi7YNl6db9d4MfmJlL8uFyUWR11kgL7ni9/gjHjml5cRqw47NG2VIVv
         D4wZPCo2A+OtoziMKG0Gqmg3+xuo/L+8be9mEmCjq49s2J5CoEO7ReBC4KH6FjOjoEy+
         IpJn1JZSJJlA/p38SToPn8nMJ1VuN3oS/lYmVSLDK0jWDTkQyCy8tFi7ndDrBuN2Rtsp
         eRiw==
X-Forwarded-Encrypted: i=1; AJvYcCWefEhKL2elozqmL8t5aJnkX0GCCRCDyOALWom7Xzn70cgnCFB4/xqukarE2msozM2yglu82IIvIo6FsX930A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEENVsDmwAayukmDH5Kbf5EzxVnn0zvDY0ttBQaL2KESx49PBD
	ur9JxjXvMBSb5fhBQc04oCiyUTx/Q0EBMJwPKxIQenD7yw+ufLULbMzQDvpZN9je73dQ5olcPVp
	HHeUJ8CqgxgoeNMB5tahfs7QEalk+r05ZzwI7pYpse7e/coI7d2CwwahcQ5UxP0hsXt+GwEef9k
	VW8Z7QWqH3Qdi6uINgrA6yFIJSdRBdLZVFF+e29+SP05g=
X-Gm-Gg: ASbGnctSkORc6cPyMC4Wrekb5TIlEUA0R5CYqFEp9IITv81mj+i02tVOg+/gs+dv05H
	rPLsQVzgQvK3lBW+tMCHjOvsToedGfyX1JMAyELdgHcCY//gLpouPEuq85bAayVL3dAJB/lxn3J
	c5jSJGJPI8jrM8AirCXZ1qreoTJ8R7Ft059pfyFK7rqTgxvtu6pngoVHEE
X-Received: by 2002:a05:6102:c04:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-5de07d583b4mr283752137.13.1762909235016;
        Tue, 11 Nov 2025 17:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgpt/cD5eXz8XccmQv5+UwYlAdDSB6UzWuxssggO0EBznFSIg1YG1onbagrA6UIT13LrlniFagHoveoNvzrs4=
X-Received: by 2002:a05:6102:c04:b0:521:b9f2:a5ca with SMTP id
 ada2fe7eead31-5de07d583b4mr283733137.13.1762909234629; Tue, 11 Nov 2025
 17:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
In-Reply-To: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 09:00:22 +0800
X-Gm-Features: AWmQ_bkX9lyiKTIQGwwCGxeG6NPaCiYy1VfK14nH1UflcpzDspDFS3ytGYyGxbs
Message-ID: <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QjXU-5PnsxDjTfsZaoFbAXUD8ijw1l986VaJr7X_W4I_1762909235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> > @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >       }
> >       vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +     /* Initialize flow filters. Not supported is an acceptable and co=
mmon
> > +      * return code
> > +      */
> > +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> > +     if (err && err !=3D -EOPNOTSUPP) {
> > +             rtnl_unlock();
> > +             goto free_unregister_netdev;
>
> I'm sorry for not noticing the following earlier, but it looks like that
> the code could error out on ENOMEM even if the feature is not really
> supported,  when `cap_id_list` allocation fails, which in turn looks a
> bit bad, as the allocated chunk is not that small (32K if I read
> correctly).
>
> @Jason, @Micheal: WDYT?

I agree. I think virtnet_ff_init() should be only called when the
feature is negotiated.

Thanks

>
> /P
>

