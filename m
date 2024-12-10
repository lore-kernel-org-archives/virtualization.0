Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF091A76BB
	for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833460; cv=none; b=sF14vqoTxmR4pOeoGebx3acYFb8at08FhUMl2jqRUnu2Nbz+CW4Lpxryl+OAiV7VYHE/lsmEH78fG/WAsWtm8E2KVN7WHuhdcJRMnsN8xCe3stAv8Gyvo/rE+tQEFEpMI5Z/R8MysKKIKK+6g+hoadT4yW+DtxXoCDywd+zCYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833460; c=relaxed/simple;
	bh=YwG3Q0LwST/Krkoga8Nxp9uoO7p3NLysRaEVDcRad3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx+xKG2akAc78/3mNn0XxfWJUGU4vE4518VxnWZ98+6HdZwSZVWrImNuOBNpGyvy8H8h2ga6C7wZQHBQbwLzgIqZNiuSR7o+0WCr13QJ6DpqSKlpa14zD+abRMbTZZJ4yDc9niUPD2Ig5cY7re61emyaGFiDm9H6EYVtkKjCRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sfs8oyCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sfs8oyCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733833457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSecLXEIEH9VAnhyNAFzRJvrLm7yztvw8Khy2pOpSMo=;
	b=Sfs8oyCmrW7yhWNaM/d8H2372G6wYY4J4OKdM722WbQ3msHbrdGFilVmiOHSQeeCsX+foV
	3q/GT5/S56yvVb5JlFxJiF/F5psO7uXdOS6Uic5+JG6YxBSN9biQgzlrsxX9NJ6iQTDjmE
	+WqKjhhD+khcd9EyoTygDk+b0ei54Kg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-JZlo4QRRN_aLTE3XJN4hIw-1; Tue, 10 Dec 2024 07:24:16 -0500
X-MC-Unique: JZlo4QRRN_aLTE3XJN4hIw-1
X-Mimecast-MFC-AGG-ID: JZlo4QRRN_aLTE3XJN4hIw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa67855b3deso79152166b.1
        for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 04:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833455; x=1734438255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSecLXEIEH9VAnhyNAFzRJvrLm7yztvw8Khy2pOpSMo=;
        b=TOSDvHSCH6oNgJsVLJ1UGdywzaxUko7++R7c24bB+2NmdqY0cBE0ON9ZPxgp0eXO/K
         2OqzPRgWYqVElMQKnJkjiXr94pHm9zhIqL1FfBkyqnkq6pQaGDHvdhLeWPe28Loamx9E
         D4Bkm/0YrptkfWuJ7taXzGuKwEbe6bLobdB0N92StBb9TUA2l58+mgW0Fm31i+w3PiWd
         5qOxXny1fjaNZsUMrzE0K2EhKirdk5FpZ3fr3nBVFzgv+OEokYFI24eAWoSv7RkW7VbK
         gW6K+hgh9Mggep7cXWhZOhZv1OP5xVLF6zlsDif/Y5Sqfz6V1bn8FwgkpIcKIyj+f39d
         LgUA==
X-Forwarded-Encrypted: i=1; AJvYcCU8AN01Ii15ui+tuHmhFYgod42c+E5dycaNq8Cnl8Pv/4Grt536iiAXNYJWm056KLmVqX5vSFIJSGFIqxF/Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGD0K7FG+RDsHQ4AshfyL5KSs2DiaiOgQtPO828gXyDB/IFwnC
	/LWN1G2JjlEKIwwPQLe5Ej1Kq4ktyNqpiCdQSp6T6ql6Yq9Lb+OXiT23WJvFyaBA71ufBJEan/J
	1jpNHzV4SRLHQIGkJo+fuppaGZMWtbkCSs4hbeU5KvUEaKvUfXbd+ywbKeYZkrE4WxFINC7CFwH
	NZ7hVymi8eaTWREEc6MJd+KdyS9i8Au593+L/WdVw=
X-Gm-Gg: ASbGncssb5SMdL0RVhLeTQVne/27AF0gHv9ytvHY0a13E92Iku8GmN7OH+F8paODoD2
	CoSELBiYuWs33OSykSAG1t49Wcd5cpnE+bIR0BOOLlBgfWWRe2Y4WkBgRs8n60CXT/uM=
X-Received: by 2002:a17:906:18a9:b0:aa6:8a1b:8b7c with SMTP id a640c23a62f3a-aa68a1b8e98mr630993166b.2.1733833455446;
        Tue, 10 Dec 2024 04:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcgyA52HfEjey88Kb6EsuqPIgVlks8Qpk8hL6qKkV1dFhRyyCd5ELr+Iz6VA2G2PWuz4gd34tfvQzS/RzCBTs=
X-Received: by 2002:a17:906:18a9:b0:aa6:8a1b:8b7c with SMTP id
 a640c23a62f3a-aa68a1b8e98mr630989266b.2.1733833455085; Tue, 10 Dec 2024
 04:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241129122408.4167150-1-ryasuoka@redhat.com> <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
In-Reply-To: <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 10 Dec 2024 21:24:03 +0900
Message-ID: <CAHpthZrZ6DjsCQ4baQ80b2vOTdkR=vHDx=10W7DTS4ohxb6=pg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, daniel@ffwll.ch, jfalempe@redhat.com, 
	christophe.jaillet@wanadoo.fr, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2LMEEZXuCB5jv9Y-3M5EfcP2MYOiNN223HVccC7gXKI_1733833455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:30=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 11/29/24 15:24, Ryosuke Yasuoka wrote:
> ....
> > +     } else {
> > +             iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> > +     }
> > +
> > +     sb->format =3D plane->state->fb->format;
> > +     sb->height =3D plane->state->fb->height;
> > +     sb->width =3D plane->state->fb->width;
> > +     sb->pitch[0] =3D plane->state->fb->pitches[0];
> > +     return 0;
> > +}
> ...
> > +static void virtio_panic_flush(struct drm_plane *plane)
> > +{
> > +     struct virtio_gpu_object *bo;
> > +     struct drm_device *dev =3D plane->dev;
> > +     struct virtio_gpu_device *vgdev =3D dev->dev_private;
> > +     struct drm_rect rect;
> > +     void *p_vbuf =3D vgdev->panic_vbuf;
> > +     struct virtio_gpu_vbuffer *vbuf_dumb_bo =3D p_vbuf;
> > +     struct virtio_gpu_vbuffer *vbuf_resource_flush =3D p_vbuf + VBUFF=
ER_SIZE;
>
> This p_vbuf + VBUFFER_SIZE looks suspicious. The VBUFFER_SIZE macro
> isn't guarded with parentheses (), hence this vbuf_resource_flush is
> pointing at the CMD part of the vbuf_dumb_bo?

No. I intend vbuf_resource_flush to point to a different vbuf than
vbuf_dumb_bo. I allocate 2 vbufs in virtio_gpu_plane_init() so that
vbuf_dumb_bo points to the first vbuf and vbuf_resource_flush points
to the second one.

> Won't be using kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC) to
> dynamically allocate both buffers make everything cleaner?
>
> ...
> > -#define MAX_INLINE_CMD_SIZE   96
> > -#define MAX_INLINE_RESP_SIZE  24
> > -#define VBUFFER_SIZE          (sizeof(struct virtio_gpu_vbuffer) \
> > -                            + MAX_INLINE_CMD_SIZE             \
> > -                            + MAX_INLINE_RESP_SIZE)...
>

Yes, it is feasible.

Thank you for your review.
Ryosuke

> Best regards,
> Dmitry
>

