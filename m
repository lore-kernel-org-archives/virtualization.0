Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81F257435
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415129; cv=none; b=eS83IHbuY9cE1Q1UwrWnoPAi+SpNTe6BkZKW4+VgFYYAjcGHKcPj4vsVnnh1SV7hIE2RDGHpfsepjTdG7sTA4GI6j4e5ZznT3XaXuIoiXmBrlYA6BL/geofGLiKqIOTG+fBnDE2mV+cT7PCAIMitMfBUteNji+9qSMT87rAvVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415129; c=relaxed/simple;
	bh=FhMRkeDHmpx7UOf0s82NhMDUTYAcPcf84qt3b/CzGrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i20CqbC+PqLnwTsTudydSCS7F9UHhyVmkx+iho+Lkq/cJA4jUJS14ZC+CI4d5S8N7Fvk+0Lo+xDlHX2gbzv8aNy/byfsvIOJYNTzZCW4guFQ2dyDBaGZ1AfGCKBjHjABG7QlC8yBkF3zJl04x6BK5fqm2enwnjeylE8Wo0GUJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eg8tCdHU; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg8tCdHU"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A378613EE
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8KHQ054ZxZZR for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 07:45:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 161D7613ED
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 161D7613ED
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eg8tCdHU
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 161D7613ED
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiaOGRzrooFT8bXw1lOEtDdsYPzEgg3vg8aNgC4OOFc=;
	b=Eg8tCdHUhTNLsgP+cZKDrAJHkbvuXAlJFna6UHLhC0QYiOsJQ08SwTKc1jtC4pCKFemJZL
	wqDK9ghlFNtrh3jToNpwt4G5BoLVTgPYQYQF6qmbLl4mKWvKpQGNpiSNNtbncM+NW+wMjo
	4WnnLjJJiVbsIkGb5uscxyR+M1IvZ04=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-MIBRIf7zMUq6QKp431BMrQ-1; Thu, 06 Nov 2025 02:45:23 -0500
X-MC-Unique: MIBRIf7zMUq6QKp431BMrQ-1
X-Mimecast-MFC-AGG-ID: MIBRIf7zMUq6QKp431BMrQ_1762415123
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-559966a5b32so21595e0c.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 23:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415122; x=1763019922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiaOGRzrooFT8bXw1lOEtDdsYPzEgg3vg8aNgC4OOFc=;
        b=UXYwSPCb3/YDPLDdoRiYBjoK4Hl2z4QXTJgN6eLgXWzRdl7E8gl3TWhY3Mtz+UhVy3
         g+3MTNAT1Vvqbncl16vMUzpomLEplGyC/v0PbJtZD+miQJz3yRmwp4rCaXP+NhQcbphP
         z4hltC+4zZLDJw2iN1k1TA3yWcSXr2GILHbgs/gzW1UIrfxKaripP8AYFjdv3lKdJCIh
         Mv9d9aW8vtadhUIw/0Br3/8TtVdHhAcH9MAeYdvrUN82Qkub7RHdtEpWhjeu3+5yMCZm
         Ay5dh8qNxHZ/AbqBAvxVs4bxat6f7cuWwdioNYjoAFbYsLGJq8tRkjax64PTOb24V4IY
         8CLg==
X-Forwarded-Encrypted: i=1; AJvYcCWRzTc3BMFfEAZ3nzEQI7gC157F7nehXu/3oYBlZRr3Az3a6+OThLuN/pVsCdBephMCsyOF3tm9+Lg5bp5Urw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy/gknQfamc3idMMl8Y+3lpyHBjj29qAO2Huz4mc12Y96l9kxD1
	gjZ0vv7Q2Y1jRia5KXP9bXsY2+c263gBPbbQmHfiXR7q64hl/gpH/Th/Z0J2eL9eKhAnsOuJOXF
	Lg+JIhJq2Hq4S/L880ZqnPYo9DHySQCWvLfWkNq3B/u199pTkI/VQn0F+IU/ouMFsraTajBLNa+
	tb7aLeYD20N39j9BT7bwBBuLQmnhi5O6WWJXXoeIFgD9tnVJ2MC8E6hcwiiw==
X-Gm-Gg: ASbGncs7FGU8TqNit2p2W5sa6O3loAhjipIzmEWLR7A359HJPeW3zhYPU7W8RZppdn0
	/tvNpwz5eLrGy/4jycNeMLRpVMwHEMyYWQ1780wtZKDyu3YNZC3NEnEi4+lByejIw0FnFKcfU55
	NtCaI/G6cRO6EK/EY3i3/wMSEHC5V6n8y64GIb7LNK5ZhYvM/8PzKJ7BuE
X-Received: by 2002:a05:6102:292c:b0:4e5:8d09:7b12 with SMTP id ada2fe7eead31-5dd9fd2cd60mr811429137.7.1762415122676;
        Wed, 05 Nov 2025 23:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoxQxGcPfXwcbcmbtlPOZH7F8/LcPCM0wVxj1FiXZSVIZFK4pL2HzFx5j4VbHCoOUFIxQ+8vbnywLMUKBcuK0=
X-Received: by 2002:a05:6102:292c:b0:4e5:8d09:7b12 with SMTP id
 ada2fe7eead31-5dd9fd2cd60mr811418137.7.1762415122317; Wed, 05 Nov 2025
 23:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
In-Reply-To: <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:44:39 +0800
X-Gm-Features: AWmQ_bmGkLtddYZ3bfFGmUC5MtU_iZvCszsK1uxQmJBuiKqg1ei92qfwpzApvMs
Message-ID: <CACLfguXcgMgczeRG1w4Af=FnaR8_0MhtMd+bO8E3Vm-y6RTRXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zoRps0mc5bMZkywtCU26xE4_DDVM400tMs7NCYqd0mM_1762415123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 there

On Thu, Nov 6, 2025 at 12:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 82034efb74fc..e38aa3a335fc 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_d=
ev *v_mdev, struct vdpa_device *
> >         ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >         mdev =3D mvdev->mdev;
> >         config =3D &ndev->config;
> > +       if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +               ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC)=
;
> > +       } else {
> > +               mlx5_vdpa_warn(mvdev, "device running, skip updating MA=
C\n");
> > +               return err;
> > +       }
>
> I don't get the logic here, mgmt risk themselve for such races or what
> would happen if we don't do this?
>
> Thanks
>
sure I can move this to the reslock.
I added the VIRTIO_NET_F_MAC bit because when the device is created
without a MAC address, this bit is missing in dev_add. Since we now
configure the MAC address, we need to also add this bit. I now coding
in QEMU to use this bit to identify if the mac address provided by
host.
there is no vdpa_config_ops for device to change the device_features,
So I add it here
Thanks
cindy
> >
> >         down_write(&ndev->reslock);
> >         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > --
> > 2.45.0
> >
>

