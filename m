Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0122D786
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524162; cv=none; b=UGgRfkilAKScCecMqGfjMSsGS9jCEhrAbVexpr8xPtFVwrMYgMEyMXUOr7h1Cg9QS16B7+aXqjNSVMsOSgytRL3zLJUW4bf0bXfzAPAE035gKfClmfrOI53Tj48V79E9++DqTNt772JRLSTCR5EDSjiRnc2ePdOKfLromUbvp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524162; c=relaxed/simple;
	bh=+YlkbjzccGRqkWwHpSFZUUSOe0RPNXe8gtXayegBMac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5qdyNB04GnTrHRApSCqyHlBemOR5hjaoTKE4hk28juTD4EsAjui7tJOlOQJwn8n5R9KaRX3X+PcreONqkkqsxkqPUdSfMkj/mPJEksbTPa5V+mn5yEm92k4y7lVi6wl7AD9VtH0rI3yRIObY7LC3AnJtaBGukAZMAURi3lA5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlKhOzkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlKhOzkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+nbout4lsz7dbdgL7U1+4YNWasydkL0pPSm+7Ne+0E=;
	b=MlKhOzkp6jO5mQ0zXEsR53Tx1NFXt5V5hmVKGVLpXe5lRGb7pF1xFTITD20Y/QjOSbGEZj
	/ty4lBIhhbyc91nuPbBI5/9+Il/3i9cs9SUX3CfUl3fdggLU44mDbsA3p/0oxPGQg9+Bzo
	LlSaVwxtyGllUAwz4UnA6+5ic3E4ng4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-2NYszBaCO2uJlY8A1X0tIg-1; Fri, 14 Feb 2025 04:09:18 -0500
X-MC-Unique: 2NYszBaCO2uJlY8A1X0tIg-1
X-Mimecast-MFC-AGG-ID: 2NYszBaCO2uJlY8A1X0tIg_1739524157
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so2820456a91.3
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 01:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524157; x=1740128957;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+nbout4lsz7dbdgL7U1+4YNWasydkL0pPSm+7Ne+0E=;
        b=je9Ziwt0D7l0S3pyyMzg6Kg5JZy7PN79e+dMB86TJWpRvMZg1xW/8q/sojJ1X4iO+q
         9hfu9x+V79aLMgEjgVJz3f15oXTNw1KA0OvsxHg0J+sUXYogYLCxBKwgezlsbE7r2RbB
         OaJEyJO9J3BEXiOW8ajXDqZIEy2i5X9p6aYRRUV+mLaHooTZ6KNpfszkxkbN8d82yAdr
         xgcKa/e4zrvBAqhj0moVbVVzVeb9Qimu5IohsX88GzpoGbO5UnNs7uoBTFi1MKb4GNkW
         ULQe+Ep6UqNw1CjKIZ4hkDwTdwfLEpqoFxIOOcq+3SI7wTt0/F/+RtnHiblfVhXk+eLd
         W1nw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWs+H55ft4U2e/i07aDZaXu31P4f3fcR9nO0CdcX7AjYICgNH9CFjdjQpDEppMl4RhMMBqrj6ionSz2pdqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ2MTlwH5g7OGwHRctHqkF3vjMr7aiHMOTBpTCrTzJx6EdQVJ/
	0K0akMzJ5OPyWsCk8YmcuQWhpvq24aoM7bNAOGyess5y3lrdxv0UowVFKVimLXQ5+7vd7p+qrTE
	V8u+2ipP8RHo7u0CvVFTUE51ybduH+eMLWv/MIiHGDr3hkr/Ksr/eQw66+BN/jFQ9CYeaEwrbNk
	DWoIAgjczuKYyTsJMPmYxIOKTiBE6eCYI+oTARLWMN5iEdAXc=
X-Gm-Gg: ASbGncs9VERVsy47Aq0w75giZjjHhNpj6n+6jrKmvloAwuXlajSEfqdVJmqiNUwKTqt
	vE9eMcWg7GCtwVN3SNjXHmYeDTXfqk+lhQNiUMTRyC7f+957K0FwOljpFXQ==
X-Received: by 2002:a17:90b:23cf:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2fbf5adefb1mr18493349a91.0.1739524156706;
        Fri, 14 Feb 2025 01:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfBgLIwyh2FsWpWhHAyE4zl/I82er44UopncdtHfHPjqZPaXeOHlFpwjXqLXDv7MngbAIpn83RTELo7JIUQoE=
X-Received: by 2002:a17:90b:23cf:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2fbf5adefb1mr18493302a91.0.1739524156373; Fri, 14 Feb 2025
 01:09:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:09:14 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com>
 <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com> <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:09:14 -0800
X-Gm-Features: AWEUYZkUHPoBM7Ip5aSx6k-wlgqT6hg27bhkTyFnhLlZU7B6wD2b2Y1SLRAiVHo
Message-ID: <CAAiTLFVZGNi-i-qCZZcoyX6Hfgtz+NMAQSq-OHE4Q0n+kvsc2A@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: js-NoNImBeU4Jed6G4Bc0TOJNu_AZMEGgeh9yeg41d8_1739524157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Verkamp <dverkamp@chromium.org> writes:

> On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wro=
te:
>>
>> Turn the 16 bit padding into a page_size field to allow the device to
>> pass its required page size with format PAGE_SIZE >> 12.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>>  include/uapi/linux/virtio_pci.h    |  2 +-
>>  2 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_=
pci_modern.c
>> index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d12=
e65d64490a855d75 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
> [...]
>> +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
>> +                       pci_read_config_word(dev, pos + offsetof(struct =
virtio_pci_cap,
>> +                                                                page_si=
ze), &res_psize);
>> +                       if (!res_psize) {
>> +                               dev_err(&dev->dev, "%s: shm cap with inv=
alid page size on "
>> +                                       "a device with VIRTIO_F_SHM_PAGE=
_SIZE feature\n",
>> +                                       __func__);
>
> Maybe this should also constrain the page size to be a power of 2?
>
> [...]
>> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio=
_pci.h
>> index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f78333=
c4d2f43540e1764b 100644
>> --- a/include/uapi/linux/virtio_pci.h
>> +++ b/include/uapi/linux/virtio_pci.h
>> @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>>         __u8 cfg_type;          /* Identifies the structure. */
>>         __u8 bar;               /* Where to find it. */
>>         __u8 id;                /* Multiple capabilities of the same typ=
e */
>> -       __u8 padding[2];        /* Pad to full dword. */
>> +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). *=
/
>
> This comment should probably clarify that the page_size field is only
> valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
> that's the case. Or should the device be expected to provide the
> page_size for all capabilities regardless of type?

Only for VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, I'll clarify that in the
comment.

> It seems like the name should also ideally make it clearer that this
> is page_size/4096 rather than the actual page size to avoid confusing
> device implementers.

I like your suggestion in the other email of turning this into
page_shift, which clarifies the field contents and also addresses the
need check the constrains you highlighted above. I'll do that in v2.

Thanks!
Sergio.

