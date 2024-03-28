Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFC37714
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598593; cv=none; b=NrMqMw0HmKZQoJZ80lZ3JDPVV2gRPjagEpfuiCDXqNsiieazsHl8/uKnXv4qRRq53PBerCFPwqQ1JBNGSmbmp+TKcKimlzbrVvkwf9z1LPjks5pi2IpBZbQRN085TW3ueteSLVy5Cmx8bhKi5BG3URkNLfe/xTKLJeuDmwHDwm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598593; c=relaxed/simple;
	bh=MA0vU3W1LZn4Qn1ileNbbCmxahwffPLbnt6IdvVY1DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpLbeE4ix8b3cH7tJRwCxTFRCsFGkYeCkp5xXT4KIROnZ//aBlnU0BhU/aDUVr9YkUsyp5T5mNsKDcJa4ifVJXLfZf41Zyr7R8BJQ16NyK/iDj1/9qk0BHjz/XoFmkFaZuP0BAQv1Rkctf3OuZhcw7pxvMbhQ0bvkI/3q4Vii+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7PrkXeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7PrkXeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711598590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
	b=B7PrkXeMjXYJd3sz8LJvTss3rJ3wUd+CvFohOslqWVpQJU2L1CdDtF+RS7mA8Yv8Aose1A
	36v/WfCRiqZTgAV/8HHPxKqLDhbxxNmrMkOynCML4LEWGDStfetZ1OO+FkdW3/IJ1vN8f4
	a534PWI4HyZLgzeR1RHpw6mSq1Kupks=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-AC5C9kBRNQqDLHfc3sho8w-1; Thu, 28 Mar 2024 00:03:06 -0400
X-MC-Unique: AC5C9kBRNQqDLHfc3sho8w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29de02b98caso480954a91.0
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 21:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598586; x=1712203386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
        b=lJir/X0OXBmnTO6eC9vRC2Db3+7kkRRkJiz8sXAjPImN/BlhIhaNUB9MtzUcpX7kev
         7FFClzGFICCW3UxKoNiQAOM1ne+8uQnYNEWArnZsritG9T1hzbG4T1b7WEcGwUbkHA40
         1+xCMh5tju7MkzJrHdDKVI7XKNTMb+N4DJW2DGDZl6XFveALlAaxfcHYcEJNBhiYpBwK
         nEsxRpsEp8SmFggQSXmUOit5xhge6UeDffnG23FVkr+j3dNGtilYWQIvE0WOEYJTLrKS
         V4ZcOg9RNLJhd5mXo4V5owFfH6AfSyhXoXlmBO6OzSMGeAfexnZC0IKTCfH6PZeL0AlQ
         whLA==
X-Forwarded-Encrypted: i=1; AJvYcCUlgvMR+iRFmDmn3btuZJRqEM4gu5nC5r4qKSH2Bxr3gRhJCzfQtMZvUC+yqhM+82tlHw1CXwzXZSH6dyuEaJOYyN5jORBqIUu6fR8Tp+Q=
X-Gm-Message-State: AOJu0YzoKqJ6WVSIDU1iqCPddQlBNb1EttbQnFX6tAbW8qGjr9uotZNF
	Pz3rjQ2qm42+vutgvOl/b0NWUxG5mN/ImsL/Ti7zJq6OD+k0rLbM5qx81hWCpV/OJJ611qUhRt3
	t4msf8sYdXElaU04Be96jYHoZfPs9eLgz//z13Gx7F33Mvvc2olCM15Ry5KOesZBG3SOGvNdZRc
	h1Gguf7ekf9FbLISBTKK++ZGbKv1l2Dvdy4ybrcQ4=
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id em10-20020a17090b014a00b002a07815dd25mr1735001pjb.20.1711598585821;
        Wed, 27 Mar 2024 21:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/veJ62gWCxJH+rJXD0BAZFk49zg7RYhlAQmbs4vW7XEiQGECvkaoiOerml1BopvTt9smdmlPuOr7dLI1u01k=
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id
 em10-20020a17090b014a00b002a07815dd25mr1734975pjb.20.1711598585557; Wed, 27
 Mar 2024 21:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327231826.1725488-1-andrew@daynix.com>
In-Reply-To: <20240327231826.1725488-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:02:54 +0800
Message-ID: <CACGkMEuW8jLvje0_oqCT=-ih9JEgxOrWRsvjvfwQXw=OWT_RtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:44=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
>
> Qemu options:
>   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
>
> From security point of view, wrong values on field used later
> tap's tap_get_user_xdp() and will affect skb gso and options.
> Later the header(and data in headroom) should not be used by the stack.
> Using custom socket as a backend to vhost_net can reveal some data
> in the vnet_hdr, although it would require kernel access to implement.
>
> The issue happens because the value of sock_len in virtqueue is 0.
> That value is set at vhost_net_set_features() with
> VHOST_NET_F_VIRTIO_NET_HDR, also it's set to zero at device open()
> and reset() routine.
> So, currently, to trigger the issue, we need to set up qemu with
> vhost=3Don,vnet_hdr=3Doff, or do not configure vhost in the custom progra=
m.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

It seems it has been merged by Michael.

Thanks

> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
> +       if (!sock_hlen)
> +               memset(buf, 0, pad);
> +
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> --
> 2.43.0
>

