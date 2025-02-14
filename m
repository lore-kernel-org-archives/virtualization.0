Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CC22D790
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524421; cv=none; b=O6V+bbrFBgoCjwh6q7IzCMl/ZmlbJHnuM5kQiI9svyxbWNv37yBCXRCstJ3WPHKdU/Dfz8ukrnx4qzSzVyC3ZzUfsSC9qRPYEpQ2l5Gy/t8x0J8Tq93BdI8ItYBFbqW/lc4+NHCWY94T+LmuWJtNXSkTq3fMH7UazWd7jLLqKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524421; c=relaxed/simple;
	bh=c2bKQPYo9tYpcciFCfCYFVVyaMXybQgfoIFS3LMZaek=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoWBBlE6Wn+gadxnJW/PWjidBgaZ93e5OdamKtTWKSa0FTE8dbG7+k7Uu9kKldygph3T2V/fBXVOpIwq13GG8yk2Lknc6kADr/ezHL71aljnsbMhPBYHJxFAClSQ0PxI5wXsyxnvjBIx3cN7h4ZlpPz0w/iNqXdkBc/sfiOoPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL6xd6/F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL6xd6/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhQbOMy8+GzTi4lxjceqncwBz0c2/iKXPxAWUqDq8Jg=;
	b=OL6xd6/FMuuisDcLeqc9RGGEnKaU9mQVDeiVhuj7bqVjiZSw68XD3WDfXRX9OvpYo+GLji
	5laFNY+vX1cnYCq6L8POXrgg0qgnqomG3BNWoqOarIU/D1LwNM4p1VQfKKOwPBD9Hioomw
	VrMcjEjuIjCkmi64Nwy8pl5oFQe1lrU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-63HMorAgN3GMsuk7D3YW0Q-1; Fri, 14 Feb 2025 04:13:37 -0500
X-MC-Unique: 63HMorAgN3GMsuk7D3YW0Q-1
X-Mimecast-MFC-AGG-ID: 63HMorAgN3GMsuk7D3YW0Q
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso4315940a91.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 01:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524416; x=1740129216;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhQbOMy8+GzTi4lxjceqncwBz0c2/iKXPxAWUqDq8Jg=;
        b=bu7L9C2Ql+kBFAHsLbj30VAwKuiPLtVZvfAwy9M1lYLh8M5j/CaLQaUmWAFir/U95b
         b9Ik+Sf1pVBXq+m4gN3FUT4JFo+z+A5qnUtbvGXBipv06srzSShZPoLxbKVp7gSxOJMn
         UOko6uysZXcpTJaObIn8519opdISjAoxcoqo1XwuY5WaeNwlTt/mxMMG73YPA50kDxKm
         0ASMjYOEKsS758djtgCF9H5QC8sRYl5M4+j/dC5G6pZfFOBIfcSW0/bkcO04PykPzpXL
         VLn7Mthw7U+FHLM2w8qpX36j4UT/Mn6n8r70gk1iTazRmlziGfSGiK7MK7zkFtvwUAnW
         5y+g==
X-Forwarded-Encrypted: i=1; AJvYcCVRVRe/kxBmrbu1hBrrC+pMBnfp61olt4zvjW3FSuK5JpDotxivkkfYgi1TqSgNUHihmcuF6b/oF/wHHZtduA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6MzvPerLJNh+qKrlVW6a3bXA4Zfi+51sTB2QLiMe9RO6ctTNz
	b9w+othuR2yOe0hFEG2ANO/CH53hFSVQnoRPVX5efB1f9/ePuctNpERX/wK0TxrffjFgxaAjNe4
	qXGDG3Oz1pEwQwdPzgMLCLnxxHmBYR8EOtiXllYt87/kJIM1RjluRbVfbG8CJsN0NkPCOI1BSAy
	LNvFbOgYxBHhR3F3JHn2Ns2PK2vMheJDZJ0FAVPEU=
X-Gm-Gg: ASbGncvOzXXDvItS4KMy3+0QJQdmDj7y0hd+UaATk02phqdwTP6Fvp5XhrfX5XEuEXV
	EJ3nVqzIgS0GeF5ABK8GsJmjDMFMvGmvxYt5YeUJYU4DqsrXxGdpMBCMqyQ==
X-Received: by 2002:a17:90b:5108:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2fc0decea17mr9715209a91.5.1739524416365;
        Fri, 14 Feb 2025 01:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPjo8jgtMHBDLzBP7QJE/fw8dRdYz3BXgwyJ4HUWTCvNtTSRgFZS9D1zgj8trFg+27pY2Nw3L5Um8vBjoQvM8=
X-Received: by 2002:a17:90b:5108:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2fc0decea17mr9715176a91.5.1739524416083; Fri, 14 Feb 2025
 01:13:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:13:35 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
 <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com> <CABVzXAkFPr-GiALnk2v53CzX0b5Y0yG=KoRoOFR7fy98Xeyb3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:13:35 -0800
X-Gm-Features: AWEUYZlFdNHXiXC67hDCe7uvDGJZv05mhOU5Gr2Fjb2yYXvv8J_67e4Yb22V8Nc
Message-ID: <CAAiTLFX6kNtuqWCk5qCVqCLUgNxB8yTKis0gBPKHiyNVr3a_GA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ijwNvFYHyELPUyTjgI2qXgSm5B3vbYMm9xRSXH3-Bak_1739524416
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Verkamp <dverkamp@chromium.org> writes:

> On Thu, Feb 13, 2025 at 11:22=E2=80=AFAM Daniel Verkamp <dverkamp@chromiu=
m.org> wrote:
>>
>> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wr=
ote:
>> >
>> > Turn the 16 bit padding into a page_size field to allow the device to
>> > pass its required page size with format PAGE_SIZE >> 12.
>> >
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > ---
>> >  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>> >  include/uapi/linux/virtio_pci.h    |  2 +-
>> >  2 files changed, 26 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virti=
o_pci_modern.c
>> > index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d=
12e65d64490a855d75 100644
>> > --- a/drivers/virtio/virtio_pci_modern.c
>> > +++ b/drivers/virtio/virtio_pci_modern.c
>> [...]
>> > +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
>> > +                       pci_read_config_word(dev, pos + offsetof(struc=
t virtio_pci_cap,
>> > +                                                                page_=
size), &res_psize);
>> > +                       if (!res_psize) {
>> > +                               dev_err(&dev->dev, "%s: shm cap with i=
nvalid page size on "
>> > +                                       "a device with VIRTIO_F_SHM_PA=
GE_SIZE feature\n",
>> > +                                       __func__);
>>
>> Maybe this should also constrain the page size to be a power of 2?
>>
>> [...]
>> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virt=
io_pci.h
>> > index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f783=
33c4d2f43540e1764b 100644
>> > --- a/include/uapi/linux/virtio_pci.h
>> > +++ b/include/uapi/linux/virtio_pci.h
>> > @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>> >         __u8 cfg_type;          /* Identifies the structure. */
>> >         __u8 bar;               /* Where to find it. */
>> >         __u8 id;                /* Multiple capabilities of the same t=
ype */
>> > -       __u8 padding[2];        /* Pad to full dword. */
>> > +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12).=
 */
>>
>> This comment should probably clarify that the page_size field is only
>> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
>> that's the case. Or should the device be expected to provide the
>> page_size for all capabilities regardless of type?
>>
>> It seems like the name should also ideally make it clearer that this
>> is page_size/4096 rather than the actual page size to avoid confusing
>> device implementers.
>
> Alternatively, this could be represented as a single u8 page_shift,
> where page_size =3D 1 << (page_shift + 12), and then existing devices
> would "just work" (assuming they filled the padding with 0). It is
> probably still a good idea to guard it with a feature bit, though, so
> it doesn't really make that much difference.

I actually considered not using a feature bit and just behave like this,
but then I've noticed that, for the mmio transport, it would mean
reading from a new register. Some VMMs may overreact to the unexpected
read and crash or, even if they don't, it's not guaranteed they aren't
going to return garbage in response. So I think it's better being a bit
conservative and protect the behavior behind a feature bit.

Thanks,
Sergio.

