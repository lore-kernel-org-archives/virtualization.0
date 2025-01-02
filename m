Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB01CFBC
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735789037; cv=none; b=g6qgNLiGRVZdrXzXTdSxqtQcRapAVOal6h0FiAP1mbz/e6RCVS28ZdXcV/EuS+1zEqk/v1yAOpIFWSoAr5mYEQ7UOOfqiBYynUOITvebWIQo8xVxiQ7K84oqiOMIhYoGkW3gpw76vCeUYr8f0ez/SK/81VTKVMbVvAFxg2gKtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735789037; c=relaxed/simple;
	bh=dmWVtMJmFlRHZQQDk24frBVte6bV31kYMB9RRd/bh3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZGL9JG/NpWJnQWPWujDKfVUnHiKMIl/ZJANt6BApSylK0GWgfK/85H9D5mf6uPtfngbvetWJ8nUPwS5ebGKlQN6ugzu/kre6084s88wJkU4JJ6jUhrS9y0uVGyHKx+sLH52ongZpmlqGMlbQ4OH/biO7v6eXyt6xMrmW3ZOp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZkwquN6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZkwquN6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A680C808A7
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_xrxN4Z2sBh for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jan 2025 03:37:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D7F6180422
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7F6180422
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cZkwquN6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7F6180422
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735789032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffpyplUxGLhUi/V0eUe73+tbKbjnY3d2j011VHNHs5o=;
	b=cZkwquN6R4ns9mAo46fPprka6+SoKJtZkN8fELUzkDtlsywyYxJSVb/y31GZtNeY57rpiS
	of5blKgrBwy4CTlPiJSnAY6XZx8s8PDBkM6bRmAfrq3SlDyMZ5fA290kTUMqQo+sadwclo
	jlhCmzKFGyhV9n4DDGswEij+/omcjFQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-PlN0slLKNICb9eXdnZ9WSg-1; Wed, 01 Jan 2025 22:37:11 -0500
X-MC-Unique: PlN0slLKNICb9eXdnZ9WSg-1
X-Mimecast-MFC-AGG-ID: PlN0slLKNICb9eXdnZ9WSg
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2164861e1feso149026125ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Jan 2025 19:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735789030; x=1736393830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffpyplUxGLhUi/V0eUe73+tbKbjnY3d2j011VHNHs5o=;
        b=C8yA7hnJBldwRDmpTW//lPPg5tXZEfvWyEftOtHXd7/F3LOCkQRBwqL5XWBtQN3/pq
         lFZMBjg3JLghOinfGtOcGmppRtXTwiKozJ6vUsS7Y3H/ipJoU4TxXOFYR3nInmsz/CEk
         YGy1TRP0VCB5izIDBmi3LqplGT0k/pOLtVQB1adXuIlv/HQyxlhSd148EDPpBQiYXT/c
         vZ1Bu/qwD5Gnca4eng/z5espYaCWWWfc4H6bLcILpesmrXh55UgSs5LFUeXXh8pHeTP4
         DSD3rylfSMkjkDtJZR207OgDT5hhZQxykX0yD61TPbuBonLZ9Jq5LQCuP/5fTa/OwePD
         iFSA==
X-Forwarded-Encrypted: i=1; AJvYcCXNB5LF8szcQ+GZ14QvGBYKvEDCGJ0S+krFOcaNvKHt7MiR9kppmkKO3hS5vQmjbVyFFZ+S2lkXXq+Y2myaxg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yys2tDCQXMteHp+cwp/bmhHS97nqEIsWQpJm+JsbIoAFJUgDLqW
	0wKUn0c1PNmuqiMwNSs/GnWM3RaGi6KEtiaFlhxJ7+hypk/5PRoRPOzPqCnymnCHE18j6Gt/coO
	uR4819UGKSckYIxelyU7Z/zAWh52mElm3DJ9VfQLCpTVpnn26zq29gNMyjx0zrAdFZuHd/7WFbs
	nL32EHE8wp/WLmNP/1UgY4CfWDdSB2ER8yzspu6VX9Bw7RzKQksjRIgg==
X-Gm-Gg: ASbGnctR76ivCdd1Az0ckScotk20VaBGLCS2ZzeE4uRCsLb/shUuhaHl7obYqr3gQfR
	+2vBetTjgbYnisGTQVs9W9SY1TlwpR3tAbOgLxGc=
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id adf61e73a8af0-1e5e084b681mr79856346637.46.1735789030341;
        Wed, 01 Jan 2025 19:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv9voIrD/iC8Rr0zAukNWK0gKJsHiZ7mn9bKIKsQscGCQLf6WtrHGHwnd4n4LmogxuLWDEsoR/KjeMR/J8sTU=
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id
 adf61e73a8af0-1e5e084b681mr79856318637.46.1735789029927; Wed, 01 Jan 2025
 19:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-6-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:36:58 +0800
Message-ID: <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LlJdtS_He_6thcWl8kQ2y1ZHuCH8kJPcHmJthCCq0Jw_1735789030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ff17c42e2d1a..47c1329360ac 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       u8 inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +       if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> +               /*inherit_owner can only be modified before owner is set*=
/
> +               if (vhost_dev_has_owner(d)) {
> +                       r =3D -EBUSY;
> +                       goto done;
> +               }
> +               if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +                       r =3D -EFAULT;
> +                       goto done;
> +               }

Not a native speaker but I wonder if "VHOST_FORK_FROM_OWNER" is better or n=
ot.

> +               /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> +               if (inherit_owner > 1) {
> +                       r =3D -EINVAL;
> +                       goto done;
> +               }
> +
> +               d->inherit_owner =3D (bool)inherit_owner;

So this allows userspace to reset the owner and toggle the value. This
seems to be fine, but I wonder if we need to some cleanup in
vhost_dev_reset_owner() or not. Let's explain this somewhere (probably
in the commit log).

>
> +               goto done;
> +       }
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..f5fcf0b25736 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,23 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vho=
st device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread=
 mode
> + *
> + * When inherit_owner is set to 1 (default behavior):
> + *   - The VHOST worker threads inherit their values/checks from
> + *     the thread that owns the VHOST device. The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (=
kthread)
> + *     implementation, which may be preferred by older userspace applica=
tions that
> + *     do not utilize the newer vhost_task concept.
> + */
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> --
> 2.45.0

Thanks

