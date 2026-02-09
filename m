Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486B26F2A7
	for <virtualization@lists.linux.dev>; Mon,  9 Feb 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601631; cv=none; b=jcvNTIq8m9HCuTbvieOGnTUZ6LU7RLFy7bSQJe03+vDkkrXrTwToVhjVTLpPye5O6fd7uSks0/ljn+y2RyaauAv+QXXXCQA+gbW6LGtIVjYCUu3VcLw4X/DYQkw670FFQ6I8+I7hnn69voPshnCMu0D2WPmMHJbkU5VZVMM2O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601631; c=relaxed/simple;
	bh=A1rH8Kup5JYGSVFNThtF+pJpdOaDs/TC/8Q/WXtpf3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2fPnC1dE6K5ugreiqlYXtQqlFAIpUN1LgciyIV0d9A+i0OCbc1c8+Tp+gSMU7AS5wg8DrvEZDtJa5VPBiW3AAbLdMxibulJb9rjSSJicDh94Ae9G0SjEMrn3Jiyb1Ns+mMshkrf14OU5cRngoeZsOuMIy//qMzAtf0QG6v99so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeHdeQCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeHdeQCM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770601630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
	b=IeHdeQCMMyO1y2Y22ws2wFqQpL+FJuADFj5/SF34+0PdjB1ifiMvUkU2WhViD+jbGaFYbE
	rGf3eK6AO8sX9m9gBGNhB+aGtILF/d7ZQjphEaQKGS52CuFbXMwd6nxdc2zsWqn8N9eTef
	NKm5E1RfDD6Vzejq56osEBx9LQcnoDI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-fd2Zs1OJPIaqXSJpYPsOMA-1; Sun, 08 Feb 2026 20:47:08 -0500
X-MC-Unique: fd2Zs1OJPIaqXSJpYPsOMA-1
X-Mimecast-MFC-AGG-ID: fd2Zs1OJPIaqXSJpYPsOMA_1770601628
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so2729360a12.3
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 17:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770601628; x=1771206428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VxKFt0XoIdgZui4JIVRnYlH952Cq7jQJGTItF6gwkQ=;
        b=cwxNGitmMjvUahvApDineKKbkjMKb2bq91Xtz9jqCao3zoMmaX3vS5Ne8oW+Vb9AeN
         Y/k6TLZblBKi7/5nn9aHUnDG865ZaRz/6lrTqK2A6HVssJ2f2sLoyG5bp0srJzxJnR+2
         Jiev2jbgW8U6ckSWOzjmmBJfiikH/Ra68h2iPjbhC+EMauJ6z7RfWz1vNr/d3nBUeh1Y
         8IeWSK4BDG3T7TuYkU22TfZIXU5OemgFmH3WNVew26TLCqU5qMmYd1gjxWBJRBQSnjhP
         vH2z8Bo30CwmN0nezlU3ct1YoZjcfOXhWbz8nirwyP267bANKhfrmiG1DFy8Om4jBNPF
         nuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8FKdmPD+KweMBFwhHkjDfsCJDPRnezpD3t08QqtaLgR2IWtleS3LqB8GOZyL5vMVUSBUtyce7GVaWp527w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/YtXxBw66Ql0xiHGFMDoT77X6hFd53yX3+G5/9IyhiS9FaE2g
	t9qr4QfRocVs5CGUPIJEsHfP8kiwUWaY9Uim3eYoVJ/5i0QwxwN2vJi7/GNuk3nr1gOzwVszBWI
	Wv7hlvhrJlB3niFYJN40wSKetcX0LFt+NxBIaclel8jgQFI+27rXrLaNqKzg/P+hMGDOy/FywcF
	WykGHpIS9WzC0G4+pso73PZAMSz7+ZEHegNJxFqTnR7Gg=
X-Gm-Gg: AZuq6aIdmvjwHOol47RBpYdg5SLAx5AxYMo5OReJwXPJc8+3L7QSTAO3OO68dGXuafX
	Lr69++6VyESBjw8PqZsn6FP6x80LhtSMPOXPticPUKonkX2wLgbJX79oXfyltjCvmmI7Q6eagkB
	VrVxxlypukc0uIjOHdcyWZRiqNm+Wuh81smmvoZT0UukMDHWbD5Sk5Rj/wFDzpgWW2bR8=
X-Received: by 2002:a05:6a21:4c81:b0:38e:54b8:60a1 with SMTP id adf61e73a8af0-393acf88668mr8796247637.4.1770601627823;
        Sun, 08 Feb 2026 17:47:07 -0800 (PST)
X-Received: by 2002:a05:6a21:4c81:b0:38e:54b8:60a1 with SMTP id
 adf61e73a8af0-393acf88668mr8796229637.4.1770601627369; Sun, 08 Feb 2026
 17:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260208143441.2177372-1-lulu@redhat.com>
In-Reply-To: <20260208143441.2177372-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Feb 2026 09:46:56 +0800
X-Gm-Features: AZwV_Qi0i5ksGpVC-CJBln-eBH2tT-cjvtJdZLINPKQb7OLTsikREB_yl6vrqE0
Message-ID: <CACGkMEu+gE_K=Tdx8c8GSY4snGpSuU3MgevTq_Mh2wShmaH+2g@mail.gmail.com>
Subject: Re: [RFC 0/3] vhost-net: netfilter support for RX path
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WKk-RNS6ZlGCYB9AN55WpLl9Y-vTElidfOTcswKAOBs_1770601628
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This series adds a minimal vhost-net filter support for RX.
> It introduces a UAPI for VHOST_NET_SET_FILTER and a simple
> SOCK_SEQPACKET message header. The kernel side keeps a filter
> socket reference and routes RX packets to userspace when
> it was enabled.

I wonder if a packet socket is sufficient or is this for macvtap as well?

Thanks

>
> Tested
> - vhost=3Don  and vhost=3Doff
>
> Cindy Lu (3):
>   uapi: vhost: add vhost-net netfilter offload API
>   vhost/net: add netfilter socket support
>   vhost/net: add RX netfilter offload path
>
>  drivers/vhost/net.c        | 338 +++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vhost.h |  20 +++
>  2 files changed, 358 insertions(+)
>
> --
> 2.52.0
>

