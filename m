Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76C2ED84A
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878076; cv=none; b=pOQKTO6HT2y1NmsYcc/MUh9fndoovHej7pwFxzZvNAv2ISPS2m8gXqD1qk/nn3MizcFYbKG2Ozfs1gzOoLZtp9hqxhp516OgYN6ZP/NYHWcSaFD+IyFcDzxzGhL1/Xo8iHslW1Wsc9D74y51G0SYMASx9kBfwA+MZRa63bqpBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878076; c=relaxed/simple;
	bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADfiNgFXCr/LTwF1IV8ORKa44N6UppasLXjJwP0FSxo7jD0YVwfnzMFSCdy+95jWgIWOtQbMDGJxyYLnkaWTaGfwt5urq3dL8a+3q2jWpKJ9W7ScayvN/AfIoSeBY17+4vFj75YuDhXbvJWasSlE98SROark5fjXTDh8OYs27GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QBBDrQZk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QBBDrQZk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1186644a12.3
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761878067; x=1762482867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
        b=QBBDrQZkG1vHnWKUY0SjD3x3uLJ7n4fbndnRPrUX/NFker5XLKYL9WRgGAnXmSZegj
         3lsKst1Ac97BeJKW4+vZ2BcvyTTT42ILVksFQMCOIxSpohGRYAHnW1/u7ZdcBO0OyPHk
         08YNZGmYWNNgJMe4xfHoQxtADKrlwrNQwSP/hvGs8SIxP4dcdRaUb+8twS6jx2j2e4FQ
         XyE7zvcFSpzLi2pD7g/ImO2ZcmWlPRMcNJft1VxRbOXf480TPw1rW4nFekxcyCmT3rO0
         QRljPPizcaZgf+LiNoQjmF7Ox1ibN9MlU8ilpkK2zgzJVNPP2/T2KyK42KbUbZg4s2KR
         0Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878067; x=1762482867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
        b=Yt89910bnjP1kgzzyjrSHv4jRvobBTU16Ogc8sqF8whceLuHubAV0gMm66DLhPvx47
         kF3gQjnN7uiyV9Qdq8y9IFIFH/xWkq5Jv39jrXbuMffjLY9RpEO8+hluhhKrz1AY3nD9
         2p1CJeTCQH4QNBgDiSFT9/RJb90gNe+00EkcNJLXuXxbr/JfSqnxrIMNQ5PQYAYKA6I+
         2b+PM10ymbucuoN36i8bc/OixHVhfB5Bk8HUm97M5T9Numvu2Xy6WeQM/hSm6FRJLWW6
         AAKFTJOjqVmNYThEsgpti2ICY+9dvfkCvxeM92kYzSkWr1JSGah0GsC5ux8+BiwEPSNh
         ZjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWdwifWndQ/vilcBpQ0Hk/pcx5DoEYKUfVjoz+scsX68Io3qwrbuUfPeAwfVic4c92qXrWxTr2ZyqztWG/kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwDw5Ke+3C0oVaNeToT5T9F05hNi8xFgLIdND2zrP60MuAVk8p
	OdUwB9/6jeVu6EnGq5MPiJ46F9jkehLEKTMQjgiFWY3vRkiYb/a9W2O0IoLDD3mh0F5BSsJzs7A
	9AdJ9f6WXZ5mJrOE/ds62irCoCNEGOUIooqpVQAxT
X-Gm-Gg: ASbGncv3fWrryP41j3DaNxdWBgn31rocMih7py/deHIfjnEXuy2WA2+yOlOvfBr0wm0
	Q9W0btKVdtmp8rBj/8+4hauYRTamtxT1hyJPXGqTSoKqB10r6Ihv4COSOma1ohtgHHYCFSUrmTP
	c6n4i/jFN2is7F1gA8n0v0/jko4MgnWERkEwtKF/0ocPntsqZLPvneBDJMNRfoGoeqI7IvbnaDF
	fOeRDLxbEJzF4IPCfpnVySehJwnO0e7aePuVwrpGvsxSZkIkLkaLuSBAoGpR0evLbP+u5uA
X-Google-Smtp-Source: AGHT+IFem7AKTlrZNsCjCaoU1OPrjcty6AXyb5TE5ncIv0OBYEUj9H4ORU5Tw+Q3tv0Kge9QpMJknPvIgtZgno1e3rI=
X-Received: by 2002:a17:902:ea0e:b0:295:73f:90d0 with SMTP id
 d9443c01a7336-2951a526babmr24858695ad.50.1761878067240; Thu, 30 Oct 2025
 19:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-7-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-7-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:34:16 +0800
X-Gm-Features: AWmQ_bmC3YOueNDW6iNYcPJZNW_BKgIBT-LE7SSvpdq3D_IQY_Fe2LpzgVsS--g
Message-ID: <CACycT3tPTW+QChEdAKw+ChP7weZvRTFZJ7-t=HcHs6M78ESpgg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
