Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813719CCEA
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362066; cv=none; b=g5OmOURhGzJehxp+OUPVboB16XzqoSrE8Q6iLsjYYn3mLyQ45x2KbfmfqXnND3ype/BSzo4bcuSpjoPJKAjCDToijHaUYqf7dNGMDxXrKJdxvoK9wKESLY5K6NIx3+ju1m3mIl3Ubjz1zZMp9GKXgBKwCybgx34yTNE5OXKQ9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362066; c=relaxed/simple;
	bh=nD32JzlTG7byCRBkwQ3uZCofLUfybht+9/Qptp6H5VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iArIFOIAuFQoqJq7ad0Xa/jUqGv4CGiC7Vz3GjDTKNQXCCO5W5aHdod9L6WJ4APRESRPxIXbmVZQpzMQ6sSznWEXjC2VVU4jgGVOeWMqg+/3/Unw5yy6xQFwL6qTcQtwgki6JZegHa1mku/K3TIq7QRigZ//5McxnFBACJ2Wyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhXCxxb7; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhXCxxb7"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 150FF8111C
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fz0g9582NW_1 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:54:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2ABB481115
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ABB481115
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZhXCxxb7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2ABB481115
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFIZpi/rBPDIT2lHx7g+LDcaJiO1Zdw8ZZRV1t7ECmM=;
	b=ZhXCxxb7Faf4KkO+d+jFB7kWc/ZcbrLzwYEyNT/TPO4b3y4KfjUl4iBPchWEtD3u3qOQN+
	QI8vJRdprGKWTTrawqqbJjRU9aR4zN4N8sVYlh9AS/vQK0F9FB7+78AhMUWCrbnzCyvKKp
	sM1bdDRD5jum1m7PdVkNtbZXoaeV3hw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-1wVDgRiRO4q53AlVk4V6JQ-1; Sun, 23 Feb 2025 20:54:21 -0500
X-MC-Unique: 1wVDgRiRO4q53AlVk4V6JQ-1
X-Mimecast-MFC-AGG-ID: 1wVDgRiRO4q53AlVk4V6JQ_1740362060
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc57652924so7849481a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362060; x=1740966860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFIZpi/rBPDIT2lHx7g+LDcaJiO1Zdw8ZZRV1t7ECmM=;
        b=SQU7FcsRjH+0gpBMerwZ0aa4IjFJ5Ktc2CLAB2IkT3niMO8xt+maXRFyrECQYRubsX
         WT6knYFCGuYuq1+1SG/DGHT4qlMpX320Qd1V1v1GjZ6UUqLnQn+hxvw2tHuUB+PeH/mk
         cgh/hl+PVTVXV7TqM3Ddk7y+laTpw+3eG/CwdQ1PmRQNOfPVBPRMbG2zYQ1TMy6qaL99
         7GgrT+mLourew92fn1pjUZaTpBbAANMbhTYKFv09AQ6XJ1ir/2fdjV27fWHMAjmuDM5A
         LygeRrGD2QCD3zQqUKc1Ew+zfd6nQ7jL9k4E2ykJ9hetgx0FNBD6qj1JT97fCswEZayP
         s1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPpnmsIDCUg31pCknVJa8BDSo+cNBm5Zg+Ypv9iSfhBfW4IA1RMxwzUyImB2gWll312VtiFhz+5LUKP+yJWw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxL87iGYByFyYDpZHDaYRB5lAXVq8cMg8THY1xIPrZN42kupfzW
	uEuyFFfCuQE2q5qzVE2iswZsZDw2HDJu/5oBwiK54vhXe5jXXEyZv8u1zLGspROINSKPIyfGr+d
	ILCdhlVKYpuNI6nQiXnb3U5yvb69FQSAonrYjUdgJRdXgnSoj6kWp7Db3cxJegJZUyOkgFirLrK
	p8f6jpUMonoYV6rgqbAayTg7ERJBZOZWjTBWS3B7gQ0Zpuk2WoMVjTyw==
X-Gm-Gg: ASbGncu04F2q7g4yEVgCj+fn3HbZBApUPPQSLNh0SR6WzxpLT1HjNkKv1OH/MxSPtac
	6sIRCP4yftqbGMWjkRrMPNsk7JMPL9xYGIGDGkpm2OYEmUOOa170YLWMf2uQIMXfigFy4w6sX2A
	==
X-Received: by 2002:a17:90b:1dc3:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2fce7b747ffmr19787116a91.15.1740362059917;
        Sun, 23 Feb 2025 17:54:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQz2cyjfoUI+8wed4h5euyDATeuNA1Cp7VYDQFAtg3WkovlFwcGthW17REqwEC0lBIE42LsNki3cYepbjKMGo=
X-Received: by 2002:a17:90b:1dc3:b0:2ea:8aac:6ac1 with SMTP id
 98e67ed59e1d1-2fce7b747ffmr19787096a91.15.1740362059520; Sun, 23 Feb 2025
 17:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:54:08 +0800
X-Gm-Features: AWEUYZkU_xjE1Be_7zMS3YfmfEN33QEv5naO52XNn_cqkUkwbYxBzK_psj0_Usc
Message-ID: <CACGkMEuocDajb0uANEOCLpXsi47Ga+d5K=oF12gDgLRfC2rJSA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LPAQjNY1GhBSJkVAA_Q86HTgD6X92l453g2pDB22Jzk_1740362060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d8c0ea118bb1..45d8f5c5bca9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, s=
truct vhost_iotlb *umem)
>         int i;
>
>         vhost_dev_cleanup(dev);
> -
> +       dev->inherit_owner =3D true;

Any reason this needs to be changed under reset_owner?

>         dev->umem =3D umem;
>         /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
>          * VQs aren't running.
> @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
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
> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
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
> +               /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */

Code explains itself, let's just drop this comment.

> +               if (inherit_owner > 1) {
> +                       r =3D -EINVAL;
> +                       goto done;
> +               }
> +
> +               d->inherit_owner =3D (bool)inherit_owner;
>
> +               goto done;
> +       }
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..8f558b433536 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost devi=
ce
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread=
 mode
> + *
> + * When inherit_owner is set to 1:
> + *   - The VHOST worker threads inherit its values/checks from
> + *     the thread that owns the VHOST device, The vhost threads will
> + *     be counted in the nproc rlimits.

Since this is uAPI, it's better to avoid mentioning too many
implementation details. So I would tweak this as.

"Vhost will create tasks similar to processes forked from the owner,
inheriting all of the owner's attributes."

> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (=
kthread)
> + *     implementation, which may be preferred by older userspace applica=
tions that
> + *     do not utilize the newer vhost_task concept.

"Vhost will create tasks as kernel thread."

> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> --
> 2.45.0
>

Thanks

