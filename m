Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F929E11B
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931899; cv=none; b=dbTRtykeVqIJP/q7Hen7C/L1XQJJmeu0ivoOCRHcu8pQK1yffwVDA5SO8ttmhtuWB/wNq9Qtg9DtLVz1FwvXNbjo1+FhDJ9TiMLYs66gLo2rwmkFV3S/4yCR74Lkf4sh/LkVbVnmTyTP0OcdOyZeFsz/wfqlHRR35mV85s4jEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931899; c=relaxed/simple;
	bh=l+NV0k7Bp/+YgOf/+PvP9J8DW53va6OQMtA4SQp1YmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rN9f61WJNIB7hKP9p8fHXwEUsVp8Slr3qXkBeyFAVqatQs7sBSeufAGZqhXL6s00rHh2HqEzaVTqQ08/3f8ckjEi95nhVmaphQGAqfcH2PaPax/nurcHiKxOodAdPORFTVYo/pJoDYfBb48neqmmFZNphNcgPY16uDV1xKquQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMVuL/zZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMVuL/zZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762931896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OQTWc8k6eLNIl1r2U6IKGTRX88Qf57rZqkALXWLQcE=;
	b=GMVuL/zZYJhzTG+dMGxiZzpm6+GOSCSuDbFzIwEnOepnihS3g3iIaoJlHtS1W+uTd2f1jK
	mUt6BDmprt/5hUgNcS30I6z7WI8DNCmu2Bq9GWrAxSDuHPnoGjSYc2lW4LfgqCu9Ji4L4J
	JRgloz7XdMvcNf1pr8EtE/5K4mBKhGA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-grbNrvl9OV-FKbJ2aWFYBA-1; Wed, 12 Nov 2025 02:18:15 -0500
X-MC-Unique: grbNrvl9OV-FKbJ2aWFYBA-1
X-Mimecast-MFC-AGG-ID: grbNrvl9OV-FKbJ2aWFYBA_1762931894
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341cd35b0f3so581845a91.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 23:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931894; x=1763536694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OQTWc8k6eLNIl1r2U6IKGTRX88Qf57rZqkALXWLQcE=;
        b=J2Dl9VKOzw89BTk4RJ+ejO9cUOkdN4y1Kys2iZyVE9ZR3APCzzutnSQc5mUEegYyd4
         ZeXHH+eQVCXgdAssbvRQTQnMa6dpCOO5dIYpIvmqUW4F11klEJndAOqWXQWoaVk+J0gT
         eF01ZXUAjW+yFwZ+70Nd9CPKQ2FehMB46KL++dyiqS9Dq5vopctQ35kNAOIh9dY5wd2Y
         FOpaiW6YRy+jqlXb0DheLwUhAyMuVyUf6M4B+ojVPF0R+j5IjtHIESYodFwwOYX5NCjy
         DWLNYbv5UyHghodMwwNreBiG0FGpF5PvCGpR2e0NvVVRXOT5FEclsw5rpUaoafIF9y5q
         M9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJoVk3wNvLrXzsn3DgyJ1+WlOAumRGfnFEQ2oOo3vYXe5HysDszInQhK6tqdzo7gpLBRTcFXjuCnnA4CujHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI1EDkln2UeQ9Xu7NKI44hr8wniNt2LNMF9Tl+Bdt/72nH7KIn
	KBX+rH7f1vZeRBJp1+FVC5Y1yWHXU2Njf+Qd9n/w2c+JD1viFuixSBfSqdr/3zTXOxzBLZAd+Xz
	Iu7QMjL3agE0hZ73C14mWlIC22RIrmc0H6z6HXkFqcpg33eNkdohPoaL9yLY+Zu8SDj7CHNP5Rs
	Cfzpppj1c2i1Z5/tISTQOgFJz3Wi3OBUH4IxQWlHaFGIQ=
X-Gm-Gg: ASbGncvFtlCAorXS3GK3Y9v5THMDvuE+RQTpNI9aTdA/db+A3o71Ip1BTfeNbU6/IoT
	7XjAe0qLcDB+wsBcYTmGkg6+di6EXIwL9j+RZYbWTS1OknyLUPjKxkK6cC9bOdvH/jP/urKGa4X
	ZeagS9i90oZZ2JDvGSpewwroowL0jxJ6zG8w/ruWPpoKBiYQtgybF+iPO7
X-Received: by 2002:a17:90a:ec8b:b0:340:e103:bfd4 with SMTP id 98e67ed59e1d1-343dddf5290mr2457735a91.2.1762931893996;
        Tue, 11 Nov 2025 23:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiyTtRY6Si4zXAKOZru7EoKpBQTUibKUV8Jrm0qaneiJMYyuUjN+SN/kgXL/nz1Zlqo7mpRrDD+OqPMOc61qU=
X-Received: by 2002:a17:90a:ec8b:b0:340:e103:bfd4 with SMTP id
 98e67ed59e1d1-343dddf5290mr2457700a91.2.1762931893477; Tue, 11 Nov 2025
 23:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251107041523.1928-1-danielj@nvidia.com> <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com> <CACGkMEt2SEWY-hUKv2=PwLZr+NNGSobr4i-XQ_qDtGk+tNw8Gw@mail.gmail.com>
 <443232ac-2e4f-4893-a956-cf9185bc3ac1@nvidia.com> <CACGkMEtMP2XfXFmuhoAkMrcgJD8JiRTc-tuq1i7xxxzA43A4mg@mail.gmail.com>
 <ada8b5c4-2a9e-45d9-a9e1-28fa50afce8d@nvidia.com>
In-Reply-To: <ada8b5c4-2a9e-45d9-a9e1-28fa50afce8d@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Nov 2025 15:18:02 +0800
X-Gm-Features: AWmQ_bnZhIKWSMpkWsQnvAN7AMqno6qxXdnPzDz-AkTZBuWbcERPcd9gvbM-Fys
Message-ID: <CACGkMEvgPyfOquwxXbugukpxenMt9NDevpJJi3QXD1s=0pgWXw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter caps
To: Dan Jurgens <danielj@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com, 
	virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com, 
	yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TFlFIponY03RztzrA0bhEg_YUNb0OQYQVtLhdAoWX5U_1762931894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:16=E2=80=AFPM Dan Jurgens <danielj@nvidia.com> wr=
ote:
>
> On 11/11/25 10:18 PM, Jason Wang wrote:
> > On Wed, Nov 12, 2025 at 11:02=E2=80=AFAM Dan Jurgens <danielj@nvidia.co=
m> wrote:
> >>
> >> On 11/11/25 7:00 PM, Jason Wang wrote:
> >>> On Tue, Nov 11, 2025 at 6:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
> >>>>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> >>>>>       }
> >>>>>       vi->guest_offloads_capable =3D vi->guest_offloads;
> >>>>>
> >>>>> +     /* Initialize flow filters. Not supported is an acceptable an=
d common
> >>>>> +      * return code
> >>>>> +      */
> >>>>> +     err =3D virtnet_ff_init(&vi->ff, vi->vdev);
> >>>>> +     if (err && err !=3D -EOPNOTSUPP) {
> >>>>> +             rtnl_unlock();
> >>>>> +             goto free_unregister_netdev;
> >>>>
> >>>> I'm sorry for not noticing the following earlier, but it looks like =
that
> >>>> the code could error out on ENOMEM even if the feature is not really
> >>>> supported,  when `cap_id_list` allocation fails, which in turn looks=
 a
> >>>> bit bad, as the allocated chunk is not that small (32K if I read
> >>>> correctly).
> >>>>
> >>>> @Jason, @Micheal: WDYT?
> >>>
> >>> I agree. I think virtnet_ff_init() should be only called when the
> >>> feature is negotiated.
> >>>
> >>> Thanks
> >>>
> >>
> >> Are you suggesting we wait to call init until get/set_rxnfc is called?=
 I
> >> don't like that idea. Probe is the right time to do feature discovery.
> >
> > Nope I meant it might be better:
> >
> > 1) embed virtio_admin_cmd_query_cap_id_result in virtnet_info to avoid
> > dynamic allocation
> >
> > Or
> >
> > 2) at least check if there's an adminq before trying to call virtnet_ff=
_init()?
>
> I could do a check like this:
>
>         if (!vdev->config->admin_cmd_exec)
>                 return -EOPNOTSUPP;
>
> Or would you prefer it added to the virtio_admin_command api?
>
> bool virtio_admin_supported(struct virtio_device *vdev);

I prefer 1) but I'm fine for 2) if everyone think it's ok.

Thanks

>
> >
> > Thanks
> >
> >>
> >>
> >>>>
> >>>> /P
> >>>>
> >>>
> >>
> >
>

