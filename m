Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F96219A81
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636428; cv=none; b=KoWXwxfUPIBNzUs0PNveG4G2Z07SJKkXMmgeiqt9Mv1Ss5kYkAhxfmOxd/1ma/CunFHCpjv89DvnStE8g7sJ4DHaWoT/FbeuLb3sfY4NDSYPW6Qc9kpc2SwZ/PXVcwcNCsAYLx8dLs0JnQGRPBmpht+/M3SMhZILFJBvktDGRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636428; c=relaxed/simple;
	bh=VR2IFo7pV2AiOqlzzWKRgxuJlWbNZFrWlMU2XkEpJfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo/XZinf/3tOs29KSBERrXCqVHL+2HP8qTslh4QCiNiQpHlqqQ8WNWPcfuZKYJsK1QNW0LGKJ/PAsdvoY6B2GMFkouLmRTj0fPzLyuuSs5jbxBSCnYc+pT2QhATsYND1Yk+MEh1F3egOR1j9vsbuzL5GcokDBsoA+ac56XpS8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Irm13/9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Irm13/9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiK6nN4v2R1ZXpnlWknDtpail7P4LWqxRZCBvtgu6/Y=;
	b=Irm13/9FN90S37Oo4c5M7DXuN4nPYiLcThcbbCRK6r4Dw7T1TKRj2Lvb5td1K34gpJ6tpf
	Rg7ghdSQw8YPN3qQqLnIgE2q18YE02Ck1UzkVigZ+/LgOm4EWBAbWfLNrdojdQu2jnfl0q
	4LYSbCyWUGYz/mvD8et6v4NAsBXg3D0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-EjTgzgxAPYuGmiNMWgrpFw-1; Wed, 24 Dec 2025 23:20:23 -0500
X-MC-Unique: EjTgzgxAPYuGmiNMWgrpFw-1
X-Mimecast-MFC-AGG-ID: EjTgzgxAPYuGmiNMWgrpFw_1766636422
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a089575ab3so86310355ad.0
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 20:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766636422; x=1767241222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uiK6nN4v2R1ZXpnlWknDtpail7P4LWqxRZCBvtgu6/Y=;
        b=PbYSffYFjeQ61YrIkkppcMiLBDP7XDMo1niHTsXMFBd3W1cAGLbVbthl0HNxEMwirx
         ysr6KEnzaJb0WfYxTVjXbGf6bLcegXrRT1OwJZxZVNxrslCkGfpCNrHUbHcpVDhQR7JR
         TAMo/EyTuVgxmWYgCYBqQVEybfdV25HfZzvu7ASkixo67xVE2chURRrGgRtm6yd/c3ho
         WOTv59P5W0OUgIGB56Nv+j0VCsMMK7dleEhQT950yfxwGoeEQ9TIxwLJaJ/vmB99MMV3
         Feq/Bru1qoRFqhLz5Hp9mX6hzByf6TrcnRLvuIJ0eCHPR3UuxvfBgOy4zY0GtoOcFhvp
         3tkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCmGnR1sXNKlNIBn50i6QQgDRjXx48nNjExSXmnFT6inRiij5gUZYsXUaJEkqeh5WUn170lY7QqNSvZQ+Yjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgfR5ozL32yIQw9Aq3MYczE2MiKULQ4TWmYdmB30d9Vs7H66/x
	Cgt0K7VgFbCU/cJcfpkzWWI7foDFZf3LO+LG0qRhTZ1AW0ealt5SryPSSaJRbRxyvn1W+Fhkikf
	FP6IAhc33MbKBM6Gg9NR/0mhC1z25qH/cm29sjU92R+yxbA4eNCzWeJrgdWl3ZnEDbBJdG15Jdr
	/3hw+zhk4rbf3+Y3r86InVXObCsCwDLXViGoO1Rg33kgg=
X-Gm-Gg: AY/fxX4DAVx+85L5c8R/0QwtmDbzv/F7KpXZN82DxNarryG1MWApiZQm7WM5eG63Ici
	udLYOKvxHO3UF7Yfc/lZz872X2r2OnR3bte/A9DGvXbwEMbgNG6EbdmCQs+iyNQyW+4mcyTSlld
	kJGlxoTm8nFTmLjedjzR8+9zrxh63+jmHoJIu8vw6nOyDjKfrAL+L9O+G4KroFkLDQuVU=
X-Received: by 2002:a05:6a20:4328:b0:35f:4e9d:d275 with SMTP id adf61e73a8af0-376a9accbafmr19146337637.55.1766636422349;
        Wed, 24 Dec 2025 20:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAUQOz1h6L04RCVSCc/sF5EfEOdVXC+sYPi1kQZuTFg7CkgfCNYkJrjcGSp71eUQgJKQU0DcxX+DjaLhKKtqI=
X-Received: by 2002:a05:6a20:4328:b0:35f:4e9d:d275 with SMTP id
 adf61e73a8af0-376a9accbafmr19146317637.55.1766636421941; Wed, 24 Dec 2025
 20:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251224003309.23432-1-jasowang@redhat.com> <20251224003309.23432-20-jasowang@redhat.com>
 <CAJaqyWdvLYgescRizWMpJy98p55HK2D10jYeLctux3BcrHDmCQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdvLYgescRizWMpJy98p55HK2D10jYeLctux3BcrHDmCQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 12:20:10 +0800
X-Gm-Features: AQt7F2pbC5yvu12ub-n17EvrygqGU1lHg1_4zn4AgTsF4PMYUK_anVvVE9J-6SU
Message-ID: <CACGkMEssZ8OSRX=9QNk7P7=A4y1uMeMANfBCvmqKTSoga0jEQg@mail.gmail.com>
Subject: Re: [PATCH V10 19/19] virtio_ring: add in order support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0iu48fXnv4zHy-hGNTZa_YbG2JYbl-3w90yt7lzZ1Zs_1766636422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 4:06=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 24, 2025 at 1:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Performance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  4.51Mpps     | 5.30Mpps    | +17%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > fix
>
> Extra "fix" here?

My bad, let me fix that.

>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!

[...]

> > +
> > +       if (unlikely(last_used >=3D num)) {
> > +               BAD_RING(vq, "id %u out of range\n", last_used);
> > +               return NULL;
> > +       }
>
> This check cannot be true, but it does not harm so it is totally ok to
> fix on top later.

Will fix this in V11.

Thanks

