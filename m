Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C11EC01B
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137765; cv=none; b=dEjF7EmMaWJx0U+54XhsF4Y58e+F+2I4n35Jq1pbgJOTGBlvu9yM1wg+M4jSd86E1PEF6F/LCW9LV0UBh8oS8kk78C/vLm61hyLwG367seAHyQOMmXMy0qAPlO9EWB4vK4jkgaUmZuSePqMiRuwSmhZtgM93T/sQrNOuQBkaI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137765; c=relaxed/simple;
	bh=Hhkb/uQKRbBMevmupgfqk1Z+Assp9GjwVgOnkjW+mvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCjkgWoAeSF4BDzScW0yppO5Wd2qN3ibHm3QNBnhCQRlFuwR2CP5MUJsUwY1HIZIVtgw3Nd4mbrRjaf2RdXJuPZsfJCtCITBTiHhsscrzwnqrYp2H65MvhuY/A5XiSITB5wVDA19FAooODQCw4LR+wRG2K/MGLi1H/ft9lfuCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7zr8a4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7zr8a4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dJimzQGQg955aU+NR/OTglx/NF3Eo4HFgMmqUmEC2k=;
	b=K7zr8a4ZMXHlUQFQLbdEIoZMw/zUgV+yO+ujMXGLgZiRggRLSLbHKeIdQbWtojZNyht3s8
	TmlvuaK9GvBG3nHOXVQrm9f537waUojX40oXjPlM0Ep4yy4Bii5gd3FkKEYNRzHPeROx3W
	8bWXfEqKW7BxCs2il/3O8AaRWYqdT90=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-jc6FUraxPI6vedTP5y0hTg-1; Wed, 26 Nov 2025 01:16:01 -0500
X-MC-Unique: jc6FUraxPI6vedTP5y0hTg-1
X-Mimecast-MFC-AGG-ID: jc6FUraxPI6vedTP5y0hTg_1764137760
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2982b47ce35so67399705ad.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137760; x=1764742560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dJimzQGQg955aU+NR/OTglx/NF3Eo4HFgMmqUmEC2k=;
        b=bDLgBcHo6xgscl4JX03tTDJM03BsbDKQFlvSbAJZdxmDViwdog/2EL4emocF74Y/SD
         X/oYqB/yEj5kscU2amzhehsSB64dUP3RUC+sPtLUH+H20Zp7nFVl7asC/WeVlIgx9PEg
         OTz9YX/hQtepqAf4nMSlYuAcjOXH8QaxhOiV8bwwvYC+wxTswrsRYokjsRTd09sUcVjz
         1RiyKm7NMbTN+eH7lCNy+eV7FUipWfowu++MwsWI488HTkpvhVy5EJzuDSwKKlJsjU0A
         gTnhYVa4w3qoBBn87/Dx+g89EnbBak28dmN6pB8mT2LNPVTO8Bu1BC21vQ6PXwDoFIdQ
         IIzw==
X-Forwarded-Encrypted: i=1; AJvYcCXSoB6wwT3HCy7cd/tT8Aj0YVgyR9uW4M2bWIhilijv1qYzfP551+Rl3ARDS26oW44BVWAHSu6vMrcYbvb37A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPqdc28YViUfdeNUr27M5PMgPrueUBE1Kc23xDaQn82G5Ju62c
	U9nMS7osF2EjN0UQH0a+byiW6fLw8Y4EpQSNPkXTffEohFHRpw67ax2m/viukN3FbMmhpoxwmqN
	MXXCsHBUid8iL9xPt4FBfdkr9t/9grPLy7rFoeWM3BNRddcgagRONzJnRxrnakqLTDa2Gg81JHB
	nzWmRNifhMXP2YOw6d/WXixCvREZS+/LRefdCnFspqpQ4=
X-Gm-Gg: ASbGncthwRr3/MNuzTxwD0q1HkccjytSlaZphoiznOFuBAslGlA+h0RG/TsD2nd4Gwf
	esH9vF/Bsuawe4gT/NAKQkJngMES7qXJ+55ugDGZ9+qV5r093JKbnRZ4YBRluBoVxUQIzBVz+WT
	EF8S9QG387bXKhaED2sL0mZq841yyPaIK5qfiyiOmeeVaos+cG2ax8XXp+Za3EtBkj51s=
X-Received: by 2002:a17:903:2c0d:b0:29b:5c65:4521 with SMTP id d9443c01a7336-29b6c6cf2f4mr185578215ad.60.1764137760465;
        Tue, 25 Nov 2025 22:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp5XvNsnFpgsWRW2tQ1zh6WcpwYde25ZVuL9wuN9oXE1mfzdcNCQGyR/EOxkG1uaOEL4o3pHnX4XP18UW3zR0=
X-Received: by 2002:a17:903:2c0d:b0:29b:5c65:4521 with SMTP id
 d9443c01a7336-29b6c6cf2f4mr185578095ad.60.1764137760068; Tue, 25 Nov 2025
 22:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125180034.1167847-1-jon@nutanix.com>
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:15:45 +0800
X-Gm-Features: AWmQ_bnZI9fzMXfYky4r-2TXzDDyUyIJGaC0lgl7E9RYBzJFA-iONio19mXg7uE
Message-ID: <CACGkMEv22mEkVoEdN0iPdgeycOEn8TaXcg-y5PGHTjw9YvTKpw@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t_uUd3hykuNT3wqmk7wGpfUzmW41uwqHqSY-ustZ8Hc_1764137760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:18=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> is called to flush done_idx and notify the guest if needed.
>
> However, signaling the guest can take non-trivial time. During this
> window, additional RX payloads may arrive on rx_ring without further
> kicks. These new payloads will sit unprocessed until another kick
> arrives, increasing latency. In high-rate UDP RX workloads, this was
> observed to occur over 20k times per second.
>
> To minimize this window and improve opportunities to process packets
> promptly, immediately call peek_head_len after signaling. If new packets
> are found, treat it as a busy poll interrupt and requeue handle_rx,
> improving fairness to TX handlers and other pending CPU work. This also
> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/vhost/net.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..04cb5f1dc6e4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost=
_net *net, struct sock *sk,
>         struct vhost_virtqueue *tvq =3D &tnvq->vq;
>         int len =3D peek_head_len(rnvq, sk);
>
> +       if (!len && rnvq->done_idx) {
> +               /* When idle, flush signal first, which can take some
> +                * time for ring management and guest notification.
> +                * Afterwards, check one last time for work, as the ring
> +                * may have received new work during the notification
> +                * window.
> +                */
> +               vhost_net_signal_used(rnvq, *count);
> +               *count =3D 0;
> +               if (peek_head_len(rnvq, sk)) {
> +                       /* More work came in during the notification
> +                        * window. To be fair to the TX handler and other
> +                        * potentially pending work items, pretend like
> +                        * this was a busy poll interruption so that
> +                        * the RX handler will be rescheduled and try
> +                        * again.
> +                        */
> +                       *busyloop_intr =3D true;
> +               }
> +       }

I'm not sure I will get here.

Once vhost_net_rx_peek_head_len() returns 0, we exit the loop to:

if (unlikely(busyloop_intr))
                vhost_poll_queue(&vq->poll);
        else if (!sock_len)
                vhost_net_enable_vq(net, vq);
out:
        vhost_net_signal_used(nvq, count);

Are you suggesting signalling before enabling vq actually?

Thanks

> +
>         if (!len && rvq->busyloop_timeout) {
>                 /* Flush batched heads first */
>                 vhost_net_signal_used(rnvq, *count);
> --
> 2.43.0
>

