Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E673D16F7
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243227; cv=none; b=MBbAVneQdpeh34Uc6oKkmgCVP7AHFZbLO6P4cJxV9HA6b2ni8JvDungS21y77XZVoXT+gD7ezj9G9b7qo4VECsoyeHh7uKvrhriVM9HGYpXtmE1hVIlCY6qDxw3NRLMDNbwCUBkGIQZZEOTYrmO5uFyHCPDJc8XqBRkaqBpDAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243227; c=relaxed/simple;
	bh=iFxPo2/KA9/DzBg1C4lLzMe9igTIZsgaUHaIlq8T0WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTSXuwh0lOwPIW0+2xIoa2GY8rED3IxwglACK4utMCxnWUg3qflSCiW15CXV4FEg2nFQu1lwy0z1xC5kqgqMXMmJjb1NIQGobHyDaqdFmNfUOc+71p1YLabGPhYSzr1STs0CFE6t4OMIENgkbTDz00sIzEe0/pHS7+XN+Kg2l8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjCi3iEe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjCi3iEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776243225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CK/HgtxZssW3F9et39wTV1usBDwNBbYgfdv4oAxGVs=;
	b=EjCi3iEeo7pXqQNByNjClBbFLsVX9+b8fErUt6qde8KB1h3LjL0zaloMSG4cnjAZF/E3A1
	tVz1J/B5mkeGMiQrMb8P8/rHX+TBmudPUPQoCWsJz53D73Pmo6sZQHXZOagtkp2e8bwHiu
	9Iyvnown3R8IMh5EGdyX+vmkdmURaQw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-p07KCiHBNXyuy9jEQx9W6g-1; Wed, 15 Apr 2026 04:53:42 -0400
X-MC-Unique: p07KCiHBNXyuy9jEQx9W6g-1
X-Mimecast-MFC-AGG-ID: p07KCiHBNXyuy9jEQx9W6g_1776243222
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65019ce8b1cso13411082d50.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 01:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243222; x=1776848022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6CK/HgtxZssW3F9et39wTV1usBDwNBbYgfdv4oAxGVs=;
        b=k3H31Q0bKxbBDG0t1YlMPeFWAOsSD9Ck6ucAjR4tapuBT6BgEruD1fQCWOx4ecPTZ4
         9hyugjH+skv4gj4az8jJaa3EIQgmL7QHd9m3Q8EaqBdgiEMw98Cq7eaMBIaM6LsgP8ab
         R4IVjgwytzaFYaBMsLSyWHOsXQAcDExixTPXu3WsuVyDuIxWjT6Aopl7Ldz+W6CWX3Dk
         A3GdHyqD7xbGFBxFIgn13iuPWbhZoO/Tk7/6Y+mThGUS1AC27bvmpw3fpAVRIaDnCRyd
         7bnQGBLozQW+CHV+M8PCgsQdlHF6nVYocdhP0SC6uDUbpAuFwHK3FvZa0/014O5Wzddc
         UqFw==
X-Forwarded-Encrypted: i=1; AFNElJ/8T7wz9ihgZOnCPXgkgsx0leqVi/wVCb7Gw8qN1PD1VfuumzFjm/X1LwaIwLtLLg2oqfAR5lIIT2mSFSArow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIuuaoIYEIKsXTiYuFjB5oC7qFlSzGVzOmtpYq3k67XnCPDImt
	WMoSel1Qbt6/RAudEnUln2SQQXqhH4ZNX0GPufva16oxJQCr3hcthVfLqOOPZJyZgW9OLmFWsWe
	1g+5tt2RYArpCJVD0Pwi6WKPlgMMP5k+BiqmpoGrKKIfQTqUTI47wQmkXHTAQqu05AjC6L5aN9F
	5KnBX/XRWIWMrKue5Z3kKPoYZPtmXGdp6OtdYsec3wKG0=
X-Gm-Gg: AeBDies1Un4iQvcGc6Du/NvDEmTw/q/fOxS01e9Lnn/+5wbDwpwLkBNTeDjz8neK1Pf
	j0zhRvIkatuhF2dioFz/zZj2acwUlMJIVZ1g45xbC8G5Z+/QfKin2+bh07Uuj/e4ntr8yw6m6N8
	XVD9fBOCWutLMfxmODNHiANS1atIPZfQe6pc0ClXL1uBsp7lUs5lDP71+84JyjgSLXZBCpoiE4D
	cI=
X-Received: by 2002:a53:db50:0:b0:64e:8748:38a1 with SMTP id 956f58d0204a3-65198c0e535mr14585744d50.66.1776243221785;
        Wed, 15 Apr 2026 01:53:41 -0700 (PDT)
X-Received: by 2002:a53:db50:0:b0:64e:8748:38a1 with SMTP id
 956f58d0204a3-65198c0e535mr14585736d50.66.1776243221424; Wed, 15 Apr 2026
 01:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Apr 2026 10:53:05 +0200
X-Gm-Features: AQROBzDao4nEFGvSqBpQ7ie6Zl0p3ZdC5cwek4CpOjl2D1cpTgGe4PhgNayvA5c
Message-ID: <CAJaqyWc41U2-8KORrvCMSqqu-KRS-=xEKgai1mmCvwQBCu2idQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qbDr64GmtaQi949OKsxV_d9uTlPAlWL0jEiqav0RR4A_1776243222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 12:56=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Changes in v4:
>  - Simplify code.                                 [Jason]
>  - Add comment for rolling back.                  [Jason]
>  - Link to v3: https://lore.kernel.org/lkml/20260202072655.95143-1-zhangt=
ianci.1997@bytedance.com/
>
> Changes in v3:
>  - Add first patch.
>  - Link to v2: https://lore.kernel.org/lkml/20260202031212.26871-1-zhangt=
ianci.1997@bytedance.com/
>
> Changes in v2:
>  - Rewrite commit message.                        [Michael]
>  - Add Fixes tag and cc stable email list.        [Eugenio]
>  - Rewrite one comment.                           [Michael]
>  - Link to v1: https://lore.kernel.org/lkml/20260130081524.81271-1-zhangt=
ianci.1997@bytedance.com/
>
>
> Zhang Tianci (2):
>   vduse: Requeue failed read to send_list head
>   vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

