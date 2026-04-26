Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420030CDB6
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777242571; cv=pass; b=I512JZmcQkNzM0eWug7RyWIte8Pvj0i4XKFat2BhPcXooRtC0Eo+8/29uxSlCOtOjBts8HhuQAnPiJm51eJAW42TMvQ5TtlrjnIRCLvscbfBzYVAKnd9ga3+Sc2lYMPWghRpTEryiEr8VDJOMh0BtWhx0HGqhHlXr3LoX1N0SKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777242571; c=relaxed/simple;
	bh=A7r7XRJY+hhC5kiZrc8ENFje4+Sa0UR8cNn+QOFiEBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e50Q/0s6fvUp0Npe3k2bTJtcsixO9UQ8dxtfSc8iZoEeSr0wJX3tveKTMssss9xaCD0X3lPWosxijBMh/5stMbAp8bS/p5LOPtKwScgbQbnEO5s5u9R6BbOav/B9WCBg7LxMlQhMXmzB2Z0gypIfVWxdL0jXAvA9WNeVKobzB3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd/sxM2E; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd/sxM2E"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso6522926b3a.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 15:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777242569; cv=none;
        d=google.com; s=arc-20240605;
        b=fwlztGwSHmgTCY8FDp1l51y4Ty6apnOz+dUYveglN/bBISTMTsAoBPcxzWrMxbNI3z
         w6qHIPDz3Cj/P7RXt+yNYbntvYBCSJLNV/cjt+JoqJF7cB/ExhVcHKRIDlZKxz0VDos2
         sHN27r6Ab4CRGGarS6brnk2EEeyLjVMcwPfgHh/sLkDrJ7/1L3KQr33/ovkNmeebroke
         9fYEEB9pt0bI/mY6PSe+uR+YlyqtiJEGCyiJnXQ3XYzZJxE+/i4WucukMcJsvY235zX3
         T/qMIsT+UAHDv7JxikH2uA+ORJPYc1tCzF28+cdOyYsSJ4SpuztTXEBfQ/U3QTwiO8tQ
         NpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VftedRKkqiPB89NVqMIEMAMEI2iGphAK7wusBOKZlaQ=;
        fh=7egY9EdLNIzipPRzZng0hnlmSGrUe5xSVVmVlT2ihUA=;
        b=Z5kG7AdLAns/It8jk3bDOIlmNH1t3/hGTMTRh/IjxpMYepSVKIV4s701na6TtCW0z2
         hIyazZtlBgTkBvMifCm5tRQJJJmlN5Yn+4MJJFZMtkbj84cyk750UqXrO8fPNDPz1Ni2
         uUwVTzgblEt38F8cHYsbFoHpZuXYEaLtkkJKJF0n3I589owrB5z3bOKTQIUaChBoRYHc
         yMOZ92N71OszR41EtQykUjy+17yfgtYsGU2aioLh95C/1RTPIZ88f/HJ96Q5zBMFaS0a
         Cmg5Q+lhGOfKPC2KxvqbgBEw4ety/sPLuxVpHALoZt9Cu3hvnzYIt91UddfWa9Sb0NGJ
         2q/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777242569; x=1777847369; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VftedRKkqiPB89NVqMIEMAMEI2iGphAK7wusBOKZlaQ=;
        b=jd/sxM2EWTRnxdauEUgi1mg1a0P60WUp5rjL2gOmoV+9Bn45ZLeGuFf8lC8hAi3mXs
         iJivnhiFmslWXjyjm2URwVzwHjVSu5cVdLgNZ/zuctyr6aA83pZMYpw1bJp4cAhvAlet
         DDjhdInhtPywdZqIT2Kc2T22GnXf5iotleoND3UgrzYR6RIXNhxNKBxo8kQnSaKKRxrq
         sCZuqTyT+NXBA9p/HeYpOwY6TRu8wh8zAESrAdY9x363anqDzcS7UJDdy+xNirMhocyW
         iyjhV6g4UyfOKk03C1gRhwSr+pPYsriHTO73dPHeqtbenSRBp+tWFX6+K4gWho58We3t
         SUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777242569; x=1777847369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VftedRKkqiPB89NVqMIEMAMEI2iGphAK7wusBOKZlaQ=;
        b=LCAgi5o5lHXOBywu0qoKAKmBnNOoZnAfnhuSHLldFp4k0bNW4gEhdcDgHyAcCwQhRE
         GiX/k1t/JrOYz/nFUySu898WGQ+qEBt26e4zADyr0QnGb72fTtejh3l6hv433A5MUsiv
         xopxwqRlAmC9mFY3k2I5SzHOqf8cbju1l8PmPss/bqj0+ZyYY8wik298etc1ood3aWik
         a6mBoi7QmuRjOzbfiFmimqvVHFq0s7Xqi/DOmGfhyP5EuetyhDBmlq5dW3C1kmo6viA2
         jYSz5VAtAqPMJJdSM+rb90juapO32zcvN39KugAdkaoU+ASL3azfOyJrtStcJwtm4uxa
         9f6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/eWc5aWejdSpP/iCdTV2MdM+rKWyZrnlKNX6vytCpbRmXmZyx7oOArme+TJIfYuhKlPbCdGhyUvEe1fqCrtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKvfUowDZmslMHBLYyt4+h7C6UwGPNnUvXPK+C3sJ91Ct5XsRf
	d1bYnpoL2RuqnN0ghL3E06dFj2sF2Xqco7UMX/X/LztrV+9uFz9wBEOt17+mN3AuCjdH1gk31lL
	Y9dqSbBZUsZnML0XgkRCGvYJLgjfSs0s=
X-Gm-Gg: AeBDieuUVLLXQ33CV23rXVRqUiHLiDAJadHhMOIetwF9X6CSoP7ldEMvYhR7Rscfgpq
	VC6b1IyDV0ZylbXa63lwDxgLsO76MFY8o9jbiPNQ4dD2/pBGRTlIlEoHCDcpzGQq9kPmndLV4oa
	kReKF2K8RFchMEYeKucIXlpauC1DH4NEfcRa67Oyh/IyvIsm6F52Na1kUWSi8zVk/4bA9KtCeDn
	ps3z768xCOZMoBCkAtTMNhsX9jfmxPgV1Og5FjnVwvlG6vveocTucYCf6jRlud+k9B7g3vptSI5
	oQsoY81FzW8vynlZHtK3qr0Jb2mdPyc0kK+tbTUHa6AF/P5BTMk9jkY721cjcA==
X-Received: by 2002:a05:6a00:2d01:b0:82f:91f:bf35 with SMTP id
 d2e1a72fcca58-82f8c7db32fmr41754967b3a.3.1777242569017; Sun, 26 Apr 2026
 15:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312105139.60811-1-kenner.linuxdev@gmail.com> <20260319112552-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260319112552-mutt-send-email-mst@kernel.org>
From: kenner azevedi <kenner.linuxdev@gmail.com>
Date: Sun, 26 Apr 2026 18:29:17 -0400
X-Gm-Features: AQROBzAnt0jYyeVT4PYshEQN0YBRGdKGLfoqOPBYKVwmVQqMl2UjlfGVL61aQes
Message-ID: <CAFHy_wYa1FyxEShWWE0E3sifYF+pFqoqZLkrfue1DOb02NB3Rg@mail.gmail.com>
Subject: Re: [PATCH] virtio: fix kernel-doc warnings for virtio_device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team, good evening.

Is there any update regarding this patch?

Thank you very much.

On Thu, Mar 19, 2026 at 11:26=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Mar 12, 2026 at 06:51:39AM -0400, Kenner de Azevedo dos Santos Mi=
randa wrote:
> > The following warnings were reported when running 'make htmldocs':
> >
> >   WARNING: ./include/linux/virtio.h:188 struct member 'map'
> >   not described in 'virtio_device'
> >
> >   WARNING: ./include/linux/virtio.h:188 struct member
> >   'VIRTIO_DECLARE_FEATURES(features' not described in
> >   'virtio_device'
> >
> >   WARNING: ./include/linux/virtio.h:188 struct member 'vmap'
> >   not described in 'virtio_device'
> >
> > Document the map and vmap fields in struct virtio_device.
> >
> > Also avoid kernel-doc confusion caused by the VIRTIO_DECLARE_FEATURES()
> > macro by documenting the logical @features field.
> >
> > After these changes, running 'make htmldocs' no longer reports warnings
> > for map, vmap, or VIRTIO_DECLARE_FEATURES().
> >
> > Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gm=
ail.com>
>
>
> I will queue this. Thanks!
>
> > ---
> >  include/linux/virtio.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 3bbc4cb6a672..074d36453177 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -157,11 +157,13 @@ struct virtio_admin_cmd {
> >   * @id: the device type identification (used to match it with a driver=
).
> >   * @config: the configuration ops for this device.
> >   * @vringh_config: configuration ops for host vrings.
> > + * @map: virtio specific mapping operations used by the device or tran=
sport.
> >   * @vqs: the list of virtqueues for this device.
> >   * @features: the 64 lower features supported by both driver and devic=
e.
> >   * @features_array: the full features space supported by both driver a=
nd
> > - *               device.
> > + *                device.
> >   * @priv: private pointer for the driver's use.
> > + * @vmap: mapping token passed to virtio mapping helpers and transport=
 ops.
> >   * @debugfs_dir: debugfs directory entry.
> >   * @debugfs_filter_features: features to be filtered set by debugfs.
> >   */
> > @@ -179,6 +181,7 @@ struct virtio_device {
> >       const struct vringh_config_ops *vringh_config;
> >       const struct virtio_map_ops *map;
> >       struct list_head vqs;
> > +       /* See @features */
> >       VIRTIO_DECLARE_FEATURES(features);
> >       void *priv;
> >       union virtio_map vmap;
> > --
> > 2.43.0
>
