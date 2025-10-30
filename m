Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26B32571E
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791296; cv=none; b=Cx14UUc1QSnUMuvSEoQLVmjXAAb1PIg5MjwaaXBNiicZy4Q4am7LxhK4uo5gawTv4dWhG2QK73rMSawSvOmX8YZxMKf4aGfE+LdamqXm3qCgPdG2+lgemwsbbaSCEPqE9hu7nzooH1T7Mol+ToZWSVoY9KzqSLW36PxAHYI+z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791296; c=relaxed/simple;
	bh=ueYr4fDOrACBm0KAvR6isY3b4Yz0LjNUirZu7x5KA9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufw0jpdD4gK0xNxg5sBZDjRLFeq8z57sTDUO2Bfsj4RteGK8IiY4G9oGZA9R79CL6WPr297/5+FicbNMkjIkebvHjPWC7T7mMnZfl811QxJ1jrlmUUcjbEmY7JKn5la/Ts2NnbuAxyfGwhIMPMIOhKqj8UM8qUZuB7jPzytk9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETGG4pd7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETGG4pd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761791292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEN+zeuhvan/3gHVWq0QoHaYVhmGbEh/guxFqXcIed0=;
	b=ETGG4pd7xkWjleVmw39YJ0PUfQmvuhLwogP6CcDPV1bTwoAWmXWWsp3vF4kfQw5GqRKwEf
	16d3XkDvopdX9Ak2NhN2Sw56O8vW1z4XqWBOmoMKkv3ubLq/YD+bpXLG9hblxcl7A2jiEu
	HetIAz5QC67gyIeqyEUohw2t9+6AYO4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-II_8ynV1PrCiPN2uea7iFw-1; Wed, 29 Oct 2025 22:28:10 -0400
X-MC-Unique: II_8ynV1PrCiPN2uea7iFw-1
X-Mimecast-MFC-AGG-ID: II_8ynV1PrCiPN2uea7iFw_1761791290
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33baef12edaso563969a91.0
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 19:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761791290; x=1762396090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEN+zeuhvan/3gHVWq0QoHaYVhmGbEh/guxFqXcIed0=;
        b=a2mji+JBAgv5V0QBxXvnzTjV5Zx05dTvw77W5VxiRqjO/9JLJPx7070wW0RYIqXcr1
         gO+r+DJjzoZOH3vSP1xDYVKiPOk1GPfZ5Mvc7kOUg07nG43PA3n2DWLh2JRKoyTkp3X4
         jv7dV366I8oupakfQvufyd4tVRfsONMsP83CjEkA/mKNcts3f+GdLtlDS0T+/D7pNaNj
         ry3YXHYFAg7s+pOtgM/7LqPFtTFhQ3OiaE3vgB6wPMadf14T0DqYpnCiEN3lvQNQwyug
         rInzPJeeLdWTYy4gPmkB+AOQ6aGfl1h4KSahqP9vUsnVGbm4qPGyyI2piq7yMedsN4up
         R3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaVq+hwO6mOlKRKAgRqdRK5Hqn2K/rweVkVCCWIzW6VArFm1soy6ua6gdniJd7xbpXfd7Rn9MX39B5AoD3xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDjJdrBIRGOH6OX11aNp96eClpZYulNE8ETSZdZ1o6aZGd0H0p
	wRuPN77iiyt2UNY9xS+DJKg1oAQBClnaOm77Cu84qI7xMbPpg1L2kkXJ5aUScIP07P3zTycndr2
	ehimRzzvBLM79B62chyYZ+fdPy+qJOV04JN4YRTK7XK8LGUwXubTwFzKoZuDOl5LAa1L3HTc6C0
	6P1++kB2Etow1eQtWO7jHaWq5uYJ8zmgJeSDIGu6s50BM=
X-Gm-Gg: ASbGnctlpdEhggZxMbwN7L9IKj+XMoa/RCndNdpAKhKsPt7LfW9sAdy1IApn1fVsTBO
	CDKDvH8JT2ITYCTVeCguzlTWIhzcMgPkIPCmSKEFa/b+EK8FQfaOeJ7Ue5053BbGNcZgXxfM7v5
	aZMF01rNfoYZPiJ6+5smw+ZotpskIXcOxSfzYJXFTyOM7tMDrFeoky
X-Received: by 2002:a17:90b:52c5:b0:33e:2d0f:4792 with SMTP id 98e67ed59e1d1-3403a291b3cmr6059392a91.28.1761791289748;
        Wed, 29 Oct 2025 19:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHEWi/hchP75vr8TIP5GW4NVbW1uVRS0LdgxFaSgFw7RPLbuq2PN5WoSwups/PCd+nOV9QSlX3uJ5UVD6ygrA=
X-Received: by 2002:a17:90b:52c5:b0:33e:2d0f:4792 with SMTP id
 98e67ed59e1d1-3403a291b3cmr6059377a91.28.1761791289293; Wed, 29 Oct 2025
 19:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87y0ota32b.fsf@alyssa.is>
In-Reply-To: <87y0ota32b.fsf@alyssa.is>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:27:55 +0800
X-Gm-Features: AWmQ_bmHhVnu561Asm5YRG2jN4tA7sSFzSe2trT2iThrq4EmrmxrrfR7rVVshjM
Message-ID: <CACGkMEuTnLX7EPuOLb2UhrZT2oH2AcXPQrvq-uw2ZydYV_FAgQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] virtio_net CSUM broken with Cloud Hypervisor
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, regressions@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 147WkyL3AttHnFGBkUzqKfaRru0fV3EelDtcInoOA0s_1761791290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:03=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Since 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support."),
> networking in Cloud Hypervisor is no longer working for me.
>
> I've narrowed down the problem to here:
>
> > @@ -2555,14 +2567,21 @@ static void virtnet_receive_done(struct virtnet=
_info *vi, struct receive_queue *
> >       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> >               virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> >
> > -     if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > -             skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > +     hdr->hdr.flags =3D flags;
>
> It looks like this was added because virtio_net_handle_csum_offload()
> looks at the flags from the hdr it's given, rather than having it passed
> separately, but it appears something later on relies on the previous
> value of hdr->hdr.flags.
>
> From my tracing, hdr->hdr.flags is set to either 0 or
> VIRTIO_NET_HDR_F_NEEDS_CSUM before this assignment, and flags is always
> 0, so in some cases VIRTIO_NET_HDR_F_NEEDS_CSUM now ends up being unset.

Are you using XDP, if not there should be no change.

>
> > +     if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csu=
m)) {
> > +             net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: =
%x rx_tnl_csum %d\n",
> > +                                  dev->name, hdr->hdr.flags,
> > +                                  hdr->hdr.gso_type, vi->rx_tnl_csum);
> > +             goto frame_err;
> > +     }
>
> If I change it to save the previous value of hdr->hdr.flags, and restore
> it again here, everything works again.
>
> Disabling offload_csum in Cloud Hypervisor is a usable workaround,
> because then hdr->hdr.flags is always 0 to begin with anyway.
>
> #regzbot introduced: 56a06bd40fab

Is mergeable rx buffer enabled, if not, I wonder if this can be fixed by:

https://marc.info/?l=3Dlinux-netdev&m=3D176170721926346&w=3D2

Thanks

