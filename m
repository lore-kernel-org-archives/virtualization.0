Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F51CF96
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430030; cv=none; b=hSu3VOt/wjaJ2Lx+SoBL9HoMRQKQChYMQ4CeuNh5GgaoNajbPYZxNlfGHC7YzukKGlw4gwnN07eaYVQxCpNkqgxY+SmRowtM9tN7Jeh/UArsm5SetQCkT3Pc9MyPmB7hQBYmNusvlf7oHWlFmyCqtH+bLwF4Esjl6wa3npLFPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430030; c=relaxed/simple;
	bh=P2deU3JZDkvYVtH5GnOFLNknOytS8dMMUCIUQGHAeY4=;
	h=Received:DKIM-Filter:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding; b=T0eDhwUXucuArRK+dsIghs4AcqH3Zpv8bwrnUsNuB+ga+ESEMf2DEzO8QRbyEtEuspp5Y0F10rZSCoFTKQcETffLmtlkHYzxmA9JmQy6e8vCnnA1nxyM2EFhlF7Iw7d7eyvJXyhpUd5Pfo2aMOx5n0RzcAcyhKoRTOjVn2oF7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBONMbP1; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBONMbP1"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ABAE60E71
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ABAE60E71
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hBONMbP1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AUTcUH3UwER
	for <virtualization@lists.linux-foundation.org>;
	Tue, 16 Jan 2024 18:33:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D770605C9
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D770605C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705430024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0IvAnbO55I9U8lmAgynm04Aoyru/cAMqaXR93cb9pg=;
	b=hBONMbP1e0YcukW0VDYfdrJMauM5P5/taWrSoSPBqnGuM7EkUhoO9CQf4Z6ID/O5swxkfv
	sqecNokApVmtNT6EHs16PluOQH7VvIC6sukHLSOO3+p6h+9AUWdjO7soXqYW7eOftk6xSP
	bOVAAAK7khMBUrOEA+CBypmM1aGByLc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-6HlTPRXANJutBf0vAwul_w-1; Tue, 16 Jan 2024 13:33:42 -0500
X-MC-Unique: 6HlTPRXANJutBf0vAwul_w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5f53b4554b6so158892797b3.3
        for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 10:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430021; x=1706034821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0IvAnbO55I9U8lmAgynm04Aoyru/cAMqaXR93cb9pg=;
        b=Qxx4BImW6wUnftKF+uctgFvA3zLlelM4ltTyE2bcxnJ4GXvQDEvDe579/aHbRqxEwn
         NY8bTmOVuADnqmXiMx1kPA8xq9jUAEeXBnW31Rx4Uw0FCn0KiExRNF8hEbQ4JYFkEJaN
         46Baj6DYydTJn3YibTa4UKolsxSH8dbC8oD276SzSkL07CAcF7UFAbfI9y0kx/h7/T8s
         N68xYgAZWCXIsydylrrz4L7Go+J01MMXPf8WWlaTkzD9U4yMIRyvNkcG6IbEVOaqLo1D
         f9y5MU/N590m2PDW4SSW74leYtaYj+OajCxR18Ih+fGhaFVJn0pRAYlbNFoaKnMD8Xl1
         U6xA==
X-Gm-Message-State: AOJu0YxZe2c7/dHZ3eaEEPWMzDwZRuKUWmDKiV2kcYTWBzca0BfnS85w
	NKHSKXzjCpF06slV7Jy4IT968hh4bQmB4nku1bZk8HAZ87wlxShWdG7klOmzvmzX8E1+mdk/0iO
	YKjqPOFTwEW4SIwrNSiS4jKMNCpRx9S6JStpQmzrhveE+WULb8CheDUgyQtn6AhLFpQ==
X-Received: by 2002:a05:690c:38b:b0:5ff:529c:504d with SMTP id bh11-20020a05690c038b00b005ff529c504dmr1236635ywb.79.1705430021683;
        Tue, 16 Jan 2024 10:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc++qjoX9+huuWU6/NpDkmXEUsOis3ggKPAVlpqTbgz16EtjCmi6t0RwzJCBocLX9FFxZVQ5Zt/zYiyEFic64=
X-Received: by 2002:a05:690c:38b:b0:5ff:529c:504d with SMTP id
 bh11-20020a05690c038b00b005ff529c504dmr1236625ywb.79.1705430021375; Tue, 16
 Jan 2024 10:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-10-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-10-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jan 2024 19:33:05 +0100
Message-ID: <CAJaqyWdf5PiDc=WdHXQ485eDA_D00ER3v9rqw9j7XWGggz_Nrg@mail.gmail.com>
Subject: Re: [RFC V1 09/13] vdpa_sim: reset must not run
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Eli Cohen <elic@nvidia.com>, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:40=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> vdpasim_do_reset sets running to true, which is wrong, as it allows
> vdpasim_kick_vq to post work requests before the device has been
> configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
> is set.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Good catch, thanks! Please send this separately so it can be merged
independently.

Also, the Fixes tag is missing, isn't it?

Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..6304cb0b4770 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim,=
 u32 flags)
>                 }
>         }
>
> -       vdpasim->running =3D true;
> +       vdpasim->running =3D false;
>         spin_unlock(&vdpasim->iommu_lock);
>
>         vdpasim->features =3D 0;
> @@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vd=
pa, u8 status)
>
>         mutex_lock(&vdpasim->mutex);
>         vdpasim->status =3D status;
> +       vdpasim->running =3D (status & VIRTIO_CONFIG_S_FEATURES_OK) !=3D =
0;
>         mutex_unlock(&vdpasim->mutex);
>  }
>
> --
> 2.39.3
>

