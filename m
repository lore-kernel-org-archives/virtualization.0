Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BF2EC0A6
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098135; cv=none; b=pzauTB8gDE0nJ9gAKyF3DJBJv8YhHVkfSL7b+D2DdeJYYsygOuyud6bwdJdmtfxKrcuIqdupV+HPjqA7JpTBiZQwdAh1CYGNBWkuhG73x/ozbufEd3wOx6nQNwbvwO+xSWZojGKLblwgcKZcSfQdYtqNoPL5VxDSg2rFLurqkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098135; c=relaxed/simple;
	bh=q998US9DM6OvRET551aJFQGCAmTK69Gkhu3kFz33Lo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZa8ukn0R34EEAAV3F8LjvGm3ilnEKvRfMOJlGzfoXcu6i1muY038L7wjcAQTshcyhTUQF3YRkxJsTTZr2borGtszpUFJwj60pRIs4J4PvCOiHfAEsY9b3ymoOG/K2vZs6ACdlP7Jin3yPRO5PurXkXcY6/yujWTYAxeA8+oxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyKrOky6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyKrOky6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
	b=SyKrOky6ZtE7NoZHaDoS01epAIrDUmHu6kynQJLJ6nflAcr5x5ZCaYjFkUsLBRMFxqfoBj
	ag1VSov73aZvMCtnJ3JvZRduyGUUXiF8CCG2reJCoMWqWL6ESPGCCOSYyeTVe2JAQF24vh
	S5ENBU7tVb3Yoi39H2Gxfr9MWQu+DWY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-NHGPTEU-NPWdGkTESR_CKg-1; Wed, 17 Sep 2025 04:35:29 -0400
X-MC-Unique: NHGPTEU-NPWdGkTESR_CKg-1
X-Mimecast-MFC-AGG-ID: NHGPTEU-NPWdGkTESR_CKg_1758098129
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7341cfed3ffso44637707b3.3
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098128; x=1758702928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpJuW7ScxpFIrDm/6lY2N9UNppFzeLdJ57JW01ss3N0=;
        b=QxSp5wRhK5IP9KDAuD3zIn9+kU+B0jR1sm0stmXwVcJdRkMTHACaxGWxqiR9mmJOt/
         EtOtpEEpi8hZRFxAtLerYEu30jzpBzFPuFigZNrA9pUVdec9D/yTjJYJHCHa6NIR7dUH
         FhxMRVYtFGNulynXEKdGjcBaVIbnQkogsM0bzqWW7BD2geXBaa96kyJ5UUKbAV4xYk0O
         4RYd7tWpYvJycXHF0TU2olDOp/QPi5sEZEqHkirg7Fe6oKnJg7YxS8hHA8kTNvSFPhrL
         n3PPWUuW6tJN8fE89YEcgxSo9M8J+4nzhIDIZ7H0Jbnm5cklWVin3NJtmfYfntub1wQ2
         sYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpPDjVCSrb9Mlbwgf4dQ/nJx5SRgfBL1huV2Co7BRo7hEo4DNBblqVre9KXUv+h7l4a4rDQaJmDrXD8hHLww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhrfR9uJayU3acKaFWSXA6Uk6Hg+SUUFhNcvh8sIxuOuwXv0Qr
	8JeuBI/Mghiu8I002gMsTC5YL301rGF8XW8Iikrv3o1iIaiVdmFG+fMJS7umO5BHiINUfPPR8dB
	YNtiCEE3gEzWWgNEx3uTNty13Gg22JDX5PTcXhsmxV/JxTp/2a/OywlgxdmzkbB8W8JLvY48Egy
	K1zuo2bFnqlMnbRn/c1vTj43kUxpckFI0rF86LpG9ZePM=
X-Gm-Gg: ASbGncug70qkYk/Hc2Qgm3Kp53LxPDD8sKohY4Goytlqk2sdNKPqxj6QjNpxbHx3ESf
	WT7mcjEhIkvgsSCS/0JaWwwFK500oLhRX1EI9zwljnARVEn4ncSc2p29qCcKFriamSZ/cMYBoA6
	F5ONRizQXqIhWgb3Yuq9Ry3iONZwC/YhgldIzSGpUvQw9/gfapYiXxXIyBtuMV0i/tsca7DOh3g
	KjQM2Ky
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id 00721157ae682-7389284e5e5mr9726507b3.37.1758098128456;
        Wed, 17 Sep 2025 01:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7WOF0rEFwoWJH/Fs+cwlNlhklNtr7tfG2XSvbAwX8kIp4ppyqh9Npvtpo12WegIqko71EKOuElGMUL7KcsA=
X-Received: by 2002:a05:690c:6287:b0:734:4c38:8dd7 with SMTP id
 00721157ae682-7389284e5e5mr9726207b3.37.1758098127956; Wed, 17 Sep 2025
 01:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250917063045.2042-2-jasowang@redhat.com>
In-Reply-To: <20250917063045.2042-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 10:34:50 +0200
X-Gm-Features: AS18NWCp8aMeKQoIpGNO8gXB409fPKuCuu417M71iyj7YQxnhfTZ79uY8_vwglw
Message-ID: <CAJaqyWeWy9L322_-=MNno9JABegb+ByXEHmEyBsqXHUVTiBndg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/3] Revert "vhost/net: Defer TX queue re-enable
 until after sendmsg"
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, jon@nutanix.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vMqmRHrGgYq6eUTep9VJrsTeDP7VxuDRjd2A57db8JQ_1758098129
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:31=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This reverts commit 8c2e6b26ffe243be1e78f5a4bfb1a857d6e6f6d6. It tries
> to defer the notification enabling by moving the logic out of the loop
> after the vhost_tx_batch() when nothing new is spotted. This will
> bring side effects as the new logic would be reused for several other
> error conditions.
>
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
>
> To fix, revert the change. A follow up patch will being the performance
> back in a safe way.
>
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sen=
dmsg")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..57efd5c55f89 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>         int err;
>         int sent_pkts =3D 0;
>         bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> -       bool busyloop_intr;
>         bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>
>         do {
> -               busyloop_intr =3D false;
> +               bool busyloop_intr =3D false;
> +
>                 if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
>                         vhost_tx_batch(net, nvq, sock, &msg);
>
> @@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, s=
truct socket *sock)
>                         break;
>                 /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
>                 if (head =3D=3D vq->num) {
> -                       /* Kicks are disabled at this point, break loop a=
nd
> -                        * process any remaining batched packets. Queue w=
ill
> -                        * be re-enabled afterwards.
> -                        */
> +                       if (unlikely(busyloop_intr)) {
> +                               vhost_poll_queue(&vq->poll);
> +                       } else if (unlikely(vhost_enable_notify(&net->dev=
,
> +                                                               vq))) {
> +                               vhost_disable_notify(&net->dev, vq);
> +                               continue;
> +                       }
>                         break;
>                 }
>
> @@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, st=
ruct socket *sock)
>                 ++nvq->done_idx;
>         } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
>
> -       /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
>         vhost_tx_batch(net, nvq, sock, &msg);
> -
> -       if (unlikely(busyloop_intr))
> -               /* If interrupted while doing busy polling, requeue the
> -                * handler to be fair handle_rx as well as other tasks
> -                * waiting on cpu.
> -                */
> -               vhost_poll_queue(&vq->poll);
> -       else
> -               /* All of our work has been completed; however, before
> -                * leaving the TX handler, do one last check for work,
> -                * and requeue handler if necessary. If there is no work,
> -                * queue will be reenabled.
> -                */
> -               vhost_net_busy_poll_try_queue(net, vq);
>  }
>
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *soc=
k)
> --
> 2.34.1
>

