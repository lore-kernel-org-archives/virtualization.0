Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F9245AFC
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474596; cv=none; b=nmFdRY6Eh8W0QwOkq6OXxc+Ez3Qn1d+cHQtli0JUOerRizUi92OuTvRSgM6ndrdcqcI2Bx81iWxzszWObjDWFmGUjpFJlHPpWSfUNe9MDNubDAetmElkO5A+q336cFzxKCO/MjCnfG7dk7Xok94LJOoqGBasykwWxEXThpVOEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474596; c=relaxed/simple;
	bh=M3Xtj7RQJ68uhGe29VzgQq5XlLmgymGY4bXdENOCD3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwviu1cpleF574a8bxyxRS1eaV3/YODIZqet552/SlCSYaWZfg9mw0ZEZYff8ORNXdCdPe2PjPJNyWvvPu+2AKOdbCkltwPvDkH9Lyt973zm5oDyBdXcIdiQ019b2ptVLwO6PJwa0pIV4fUMpgEa9lFirih2eROLGfeY/G85M78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kp4pkjdK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kp4pkjdK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c895af63so3065825ad.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 11:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739474594; x=1740079394; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC+znPA2H1vB7HU6VZGH/VUzzp6EPafRFN/wfL/kwkY=;
        b=kp4pkjdKXEw537q0h8WAr/w4cQR1rP4jeSYx3OpqU4T3jc3RVNODYmlH5GuQKwopF1
         g+ZrEF2qCDSyFE2b8Aw9/yL99A2ijKDc331hMvyRDj3BzVpn8KVyTNU3K16S4X325+v0
         cMYvqlI+XTtM1kHOeZ3pWEmhS2q/Ojt43V314=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474594; x=1740079394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC+znPA2H1vB7HU6VZGH/VUzzp6EPafRFN/wfL/kwkY=;
        b=pppTrWGRFUESx9zxlgRHXUI7C1kJXB3h5lyyAlqTRYcMHi7rTrFzo3frMxIjGeSbu4
         KkKl7hieJK5598VUA9LXSCtz/cpxJvJfkfG7TSgCFRkbxYp4BfgVFocyCTS4241xlVBb
         epbBviygh6achiGBAQXHs691TLkmeemLYPMLzrFNFyqQYuAERjnyQaTNbZ4CNoJkz5iy
         hqLSGV1TRAqmnb3u7LP1xKi4P7gxOne3wr6eOQlMkINKP4DorVp7WkOn9dqt1aCK4C/W
         UF4SGK17qs7JxTYIw7pyigTfNCEyNIZFzbrrx314kpI8qdx/DG++ddxS5w7oVvfkj1yG
         RGpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrFOrsEMfWtiSfyn06Fc/lvRUu7MkG1naD1iqRurlnUmWq3+jusPnzRY3nfrKFHcV6b5yKGgwwODk1zzyPVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwEebtnmmZwLAMCAfadK8mBjHkQoYfHWloOqpjoM4WJ6PrdjYK
	Se30vceJEcro3p5blPy+bOx0ZnLYP93prr/AF1t97ZvD/wT+MFRxvEFJ7uE/4EGV6+TpGim2WgJ
	oqA==
X-Gm-Gg: ASbGncvDwVsrktJwLc6C7rbwUASH7R1OYI15icYGEktx4v2EnyRavly38OV86J1hkTY
	T1/EhjCkOJF/kxATDYeyWESUntO7/O7pBbiPxQYdqlYZsKAS4PVLq591+oevlfltlZAdYjrV96J
	BAItWp/EGSMiLoFML/6GDDdJo3rm6stvh9mrRS69r2LUUvBw1xXqQTx+J4ZbW3tTkQc+/8Umtss
	2fDXW86ZVjHXOu4WbFuyAAWqip6HDKG18npHTKxWBOHRO00htkDJbeXHZPQBcSJIAtDVuptUVfd
	mHkVPd/PnXS5faiREm3zeVx7dw/7z3sIMUAgeyUHCBuUZM3IWhtph7I=
X-Google-Smtp-Source: AGHT+IFLyxDEKe+yXvK/o2aj0nYEPuX7yJjfYp1sUPC8dQaERAv3a2opSnfUqaHStq634FdxXwYNuA==
X-Received: by 2002:a05:6a00:1944:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-7324f570edamr57240b3a.2.1739474594391;
        Thu, 13 Feb 2025 11:23:14 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e715sm1663244b3a.93.2025.02.13.11.23.12
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:23:13 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so2346488a91.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 11:23:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAhrTHxtbV+WcLcVuVa6STEX+2aV9gUu3gITFxPE5v1BGIEJuJSWBet7msu+v6JstLchuteNU8hCA8ocRFDQ==@lists.linux.dev
X-Received: by 2002:a17:90b:274e:b0:2fa:17d2:166 with SMTP id
 98e67ed59e1d1-2fbf5c6f900mr11663838a91.31.1739474591586; Thu, 13 Feb 2025
 11:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com> <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
In-Reply-To: <20250213-virtio-shm-page-size-v1-3-5ee1f9984350@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 13 Feb 2025 11:22:45 -0800
X-Gmail-Original-Message-ID: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
X-Gm-Features: AWEUYZnbyEFvCjOaJipQpOfb1MF9Gi7XhI32b8q-z-30QmKnx8ZNHSfRGuJzTvI
Message-ID: <CABVzXA=r=X+GYnSxgeyktKzfKCW2DW+v++c4v_+BHBDHZ_Bzyw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] virtio-pci: extend virtio_pci_cap to hold page_size
To: Sergio Lopez <slp@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:54=E2=80=AFAM Sergio Lopez <slp@redhat.com> wrote=
:
>
> Turn the 16 bit padding into a page_size field to allow the device to
> pass its required page size with format PAGE_SIZE >> 12.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 29 +++++++++++++++++++++++++----
>  include/uapi/linux/virtio_pci.h    |  2 +-
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 79616ce5057bf3b2b88cae7e8fb7729efa9dd632..26e9cd5148c0f10209c34d12e=
65d64490a855d75 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
[...]
> +               if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE)) {
> +                       pci_read_config_word(dev, pos + offsetof(struct v=
irtio_pci_cap,
> +                                                                page_siz=
e), &res_psize);
> +                       if (!res_psize) {
> +                               dev_err(&dev->dev, "%s: shm cap with inva=
lid page size on "
> +                                       "a device with VIRTIO_F_SHM_PAGE_=
SIZE feature\n",
> +                                       __func__);

Maybe this should also constrain the page size to be a power of 2?

[...]
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
> index 8549d4571257142ac6c9dad5c01369923791a85a..fb0ccb7a125d8178c1f78333c=
4d2f43540e1764b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -127,7 +127,7 @@ struct virtio_pci_cap {
>         __u8 cfg_type;          /* Identifies the structure. */
>         __u8 bar;               /* Where to find it. */
>         __u8 id;                /* Multiple capabilities of the same type=
 */
> -       __u8 padding[2];        /* Pad to full dword. */
> +       __u16 page_size;        /* Device page size (PAGE_SIZE >> 12). */

This comment should probably clarify that the page_size field is only
valid when cfg_type is VIRTIO_PCI_CAP_SHARED_MEMORY_CFG, assuming
that's the case. Or should the device be expected to provide the
page_size for all capabilities regardless of type?

It seems like the name should also ideally make it clearer that this
is page_size/4096 rather than the actual page size to avoid confusing
device implementers.

>         __le32 offset;          /* Offset within bar. */
>         __le32 length;          /* Length of the structure, in bytes. */
>  };
