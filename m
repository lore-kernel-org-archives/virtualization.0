Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE23594A
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349011; cv=none; b=h5OwTxl6ESD+8P8Kh20WY7nnbEs9i+d5v2Z6x2JS95D830JFPNADuyCIjaOKa7eCUWiT340vdsnQerU0jVsJsBf8S1gFLXOmpg+P2kQwCxajT8mLbZ99at6XwTarYO7o7Egh50pdpB9ExyLwDIYooUXLx/h0OP2MPH6rrPnDtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349011; c=relaxed/simple;
	bh=FtEPTa4Dy2lq8qJWWzsiBzS0C8SD7cKdkopMOEifno0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQM3/8ZGy8n36B8lWKuKemFZ/u0Aw2HdmjewiYDtM7oIQjU9WU5Mni3QcwEoOCT5duVY57PYhn/GE5ECZGhNl9LJHvpDeIfsYwIhPoL9U8rxpK/tSvmYVrfk1gpU4ft9fhDYJGzvsUCgpKl7k50Lt/lSECSLP3WJKLtHcIKKHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+I5JIlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+I5JIlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756349006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
	b=b+I5JIlS22yNFCVh7FMp1LKnsmdkVFzSpEmzc6jHRZugcDadXNzbli2cYTTrs3uVB9cl1f
	U6hpJceRN4gG8NKrsdn6dfW40BRXdhKMR8msQ6Sl1FQShoyE7P/nULmjKeW47LsgIz1cCw
	oCS7VjNjHAT6zEsLcuvTfSbP8NlW+QE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-DzR0tjQLO0mUjA9AMi_xiw-1; Wed, 27 Aug 2025 22:43:25 -0400
X-MC-Unique: DzR0tjQLO0mUjA9AMi_xiw-1
X-Mimecast-MFC-AGG-ID: DzR0tjQLO0mUjA9AMi_xiw_1756349004
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61c524e33d9so324262a12.1
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349004; x=1756953804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVzFqi3qYGzTZymoMc9gsg7jQyopRP+VJ4wN1OXKbW0=;
        b=lfBjDh7/YUuhhW1YB+Wrtk+sSdg/vwO9l/MRbRxyhoZ4WD/JOutu2Z/seJXlKumMMb
         46m/KuAo2WKajt9Q0qZc+YpgiiM+Y4tdB8xMPXueVbQ7AhapjLG82/JXFU1zY9fObOon
         0MdWQp8qamVbxLxV+Eo3xkq6Cm+HyzCys6zrFviT5y2D3MosiUiV8+XTla3TQpUX1TWs
         19LaLWW3p/O9L3MmRD4auQz4OzXlqcqf7ZoCyaoFSPgju53SZnPG66YGRxY1fW5/kS1p
         s0lRmH4MTAa1pU4y73ke+MitNlPWGjW0H/FQVkWbeshjTdsusjaXGJSZn2beSuVpbinG
         iwIg==
X-Forwarded-Encrypted: i=1; AJvYcCVgphP3OM8OauFtrRMrJbwLZQpwASWgT1rg+ELFRyk6oLmJQ0i+fR51+mqwilMdIMD1GlrtCk0JrP3zFTIEQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI5u9fhGUO0r90K8/A9QjUzJsaROylQXinG1L0VSU2wBP62vhF
	ONzq7bKMVyv6jfGe4wBzFj4u8u+v3BYCnTzuGoVfP9Iku88q6hii0ZeJRL3rf3vyAtt4PvG9qnm
	IVRUvhksXGoqi/HE0uy/6zU2gMatuSsc0R72ZT7Qy+1Ew/3ifCBlaDUJQCyG87DNgpGhlg66Pu0
	XHnGCBePxAdceakhDAGRPM6OOCklqvKwo8YtEcftzOTTc=
X-Gm-Gg: ASbGncum0iEkIT6EqSPsu2m+Eq/8KYmltkAQTZ3dtWqb911VOxG8HKqsCj8D3eUMUux
	hGeV7zI+uwPyB3TRoFuCjGRJfdjvu2aD8+gZPs7zsyoZlD3I1AncKlYTCccy19pYFaLFIjxnxXX
	iGDSAWbkhFiy4hUQLN8WudUg==
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id 4fb4d7f45d1cf-61c1b70a459mr17263467a12.33.1756349004189;
        Wed, 27 Aug 2025 19:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLJP7RVQ7XggHy4wLklb0+/anyb2o4/+NcZbJ0ac7BY7NdvZ8eKkWZUKb7OLDIF0YQ0f0iZv5O0U1kANohzIg=
X-Received: by 2002:a05:6402:280c:b0:618:4a41:80b2 with SMTP id
 4fb4d7f45d1cf-61c1b70a459mr17263447a12.33.1756349003785; Wed, 27 Aug 2025
 19:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:42:47 +0800
X-Gm-Features: Ac12FXxm1PYVDZmD5Ru0N_nQlupVeshkDMt_GvrRtBisXzJaavMi349lmdLEkns
Message-ID: <CAPpAL=weN2kjgz4n8JtAPytHQi+828v2xUTHJ4Tr7GdTchk24w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XoyVfcZVODr0itYEunbhnKwejQJ8leYByClcNqSl6e4_1756349004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches's v2 again with vhost-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Aug 28, 2025 at 4:11=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
>
> Sean,
>
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical=E2=80=A6
>
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>          * freeing it below.
>          */
>         wait_for_completion(&vtsk->exited);
> +       put_task_struct(vtsk->task);
>         kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
>                 return ERR_CAST(tsk);
>         }
>
> -       vtsk->task =3D tsk;
> +       vtsk->task =3D get_task_struct(tsk);
>         return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
>
> Sebastian
>

