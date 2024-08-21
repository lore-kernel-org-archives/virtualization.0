Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C21547E5
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208521; cv=none; b=PKE16r3YjcD/lyDzydUvORje6vVNOzOslpcYs1XJz1PSrv6GX/xw8iDNwyHyjmI4SR0dRbMSguemX+ATZoBfaZf0jLcac5E8nyiIunrgY0uapJKEIS8a2OMoSE7UH2aK/OFAVunSk84OHSpgbGgA8swSQVK+40MiN9SLfGIBDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208521; c=relaxed/simple;
	bh=3NT4ahnmFddHIRmFwjcHIuJmDlTvjANzEmVMo6qJ1Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJq4oL+Zrx/JC3YDvuCP2nDTUfpVPiz7LQ06YRD9/mvLBhlVCHTPEsM8fUPRA+rGI9r/cZrgaEQBv5gPRBfKpInvzAWmyVnKXRXN/7dIoR5SEQhKHwm99V82/3nRzuH/yfEs/dvsP3J0FqZu1bX+8z09XX/gaHdepMLI83s6qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cmDn/65s; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cmDn/65s"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5da440d059eso4059699eaf.2
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 19:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724208518; x=1724813318; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3aEXOpJkCyNHt+4mZOgRQw75y4G0b8DBrW8S6IF4dU=;
        b=cmDn/65ss0Ho65a3ndsLNBnk0XTN94RKEco1+qNj1SXny6xrmBm6osdqDBNzy6Irr/
         lxujfcwy07zQLcEy1e3ZF0iEHX5+miBbPtMmymuwVLCeXT6fbBXKmmzEdEhK+QQrs6ip
         mKUI/Zr4IEQkZMNIAwVYi9k9ds5Cub8XffmZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724208518; x=1724813318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3aEXOpJkCyNHt+4mZOgRQw75y4G0b8DBrW8S6IF4dU=;
        b=HINYQlqy9iGaDbWAKcGC6snU9qsSas4dvB0h6NR+bzItSTG+eRpKSsHhrJQrC3/3ST
         J0EAhLYAHxpbcqquUUlENNbGwFDVhAnsoNjmnrCamSPkOjqRJUM721eIv2v9YMT3CtzT
         TezgwLQoHH5M7XbMG+esPY/KFuCZTxvKWG/MhW75vyPsfXKtoTFKBCRrA5J+X/e1TiZu
         kkTIFIAJKk8+GrAVKWCzhrt7P21EM50sVrNFxrQvR1WQ9ziNwjGBDOWFE+Gfc+6Fx20s
         DJRnMZf035/btfzUUD7tb5X05kAX8KSPv4Ufec8+1DK2wnrj+KILEo7OuSg7m9BkLfAl
         r54g==
X-Forwarded-Encrypted: i=1; AJvYcCVUscu8+2wh+wwjkJm3gY4NmxOsEkXLp7cuq49lJBQcPgy4Qe7SkT32iiIfB5S6wY1BNUmvgV9GqBeJSxmaIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsbnguVjdVeeMrensAMoXqwqsCsGXnOoM3FNu6Wn+SwPv88cBc
	62YzC/ha4OGjTWbhd9DqL8Z79y9tf4PY3yP82p0W84KtEAY/SzvoYx6U7xoxtuFj8/oEb/BotCu
	80+3pa8BZSa7pnDAIk+ak8QIVPMG9bxs8zs5m
X-Google-Smtp-Source: AGHT+IGw9BqTX5VOuQLmS/qKfOQP/sjqjFhw2dnBRfUPMUh9JrsC1327k3YS4AeZHPC9FiuuPKxEewNQSfw++XcuCcs=
X-Received: by 2002:a05:6358:57a3:b0:1ad:10eb:cd39 with SMTP id
 e5c5f4694b2df-1b59fc5cfc2mr159679855d.26.1724208517967; Tue, 20 Aug 2024
 19:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820172256.903251-1-philipchen@chromium.org> <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com>
In-Reply-To: <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com>
From: Philip Chen <philipchen@chromium.org>
Date: Tue, 20 Aug 2024 19:48:27 -0700
Message-ID: <CA+cxXhnrg8vipY37siXRudRiwLKFuyJXizH9EUczFFnB6iwQAg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: Check device status before requesting flush
To: Dave Jiang <dave.jiang@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 8/20/24 10:22 AM, Philip Chen wrote:
> > If a pmem device is in a bad status, the driver side could wait for
> > host ack forever in virtio_pmem_flush(), causing the system to hang.
> >
> > So add a status check in the beginning of virtio_pmem_flush() to return
> > early if the device is not activated.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> > v2:
> > - Remove change id from the patch description
> > - Add more details to the patch description
> >
> >  drivers/nvdimm/nd_virtio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 35c8fbbba10e..97addba06539 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_re=
gion)
> >       unsigned long flags;
> >       int err, err1;
> >
> > +     /*
> > +      * Don't bother to submit the request to the device if the device=
 is
> > +      * not acticated.
>
> s/acticated/activated/

Thanks for the review.
I'll fix this typo in v3.

In addition to this typo, does anyone have any other concerns?

>
> > +      */
> > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET)=
 {
> > +             dev_info(&vdev->dev, "virtio pmem device needs a reset\n"=
);
> > +             return -EIO;
> > +     }
> > +
> >       might_sleep();
> >       req_data =3D kmalloc(sizeof(*req_data), GFP_KERNEL);
> >       if (!req_data)
