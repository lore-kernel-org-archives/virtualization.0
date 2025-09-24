Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358452F99
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675266; cv=none; b=ADNetIpej0pgIWKdjvJbVsEsazRQtr8eKMWQdtzBX8g8JfXy8zmwqwQ6wEQEb9xYFncOWgp/Y6rn+VMgQTKekewEzEnYlu6BMBLoaNGXSlMDWswapCsAwNievupkWcCQg8Lbcpim4wPNZpaneGKV82FH1C4PaH9ua8EEiyBM70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675266; c=relaxed/simple;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSn+d/dlYZEvVY+Rdl3NU7B5NpDQmEehwh0sFG4xlcvv1+jvGhttof+XVaU8mqT48cH/Oie6p/HCuKtg+e3nv7VmUnHYhutACfcvvhpdWqYkofq0vehI0gp5t9aDRru2VVs+nmGPF+UcBjp6mNw5rLpr9fCHzUgNq1ZvDgUG/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMdhE9w5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMdhE9w5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	b=XMdhE9w5Efjgyd1eea580BE7gvBLpgXkeEqI1bi4w7dFVDRmKNqMztlt0Ijtb98oymTpkX
	OtbaUh1Xpc02ErSA+Q0p59UYJ0GffJY0MslaW1jHRbs5HjRJZGBNUU6qIOTVTTVJhbR5Vi
	1PbtNqU8pffes56fTLnA4aa4b7w/J80=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ZcGOv1hOM8ynFLsu5gR84w-1; Tue, 23 Sep 2025 20:54:22 -0400
X-MC-Unique: ZcGOv1hOM8ynFLsu5gR84w-1
X-Mimecast-MFC-AGG-ID: ZcGOv1hOM8ynFLsu5gR84w_1758675261
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso8538485a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 17:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675261; x=1759280061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
        b=TMiK9JNr1UM+RDOmeJ7sGv9Gs1+RF2Et/N08RG2SLmWBeEBMaoUByd5+Z95rDECbnv
         FKq+mdvsdAVzAEXBoyauHQ65NsZSpUlXSabBcK9/dYXn3ZDWC6cPI46ZYxTnyOlJe2Vn
         5BF5zgr6EqDkvGXy7u1z91+kw2jYqSkJUlLcmgFpVKcwxoriDMpDSgWrq+yLgm9HgH2o
         L8ek6GglNfUrpVoov+2okQ7m4JFT2XRJJQsCDHjuLL20kdSgXBL4myykUJTu/a/OsSPf
         kLPXsfvp5LH2MHHXC4dKMnlK3Vdz4kAUI7jzLZdWrhVh1N9+a4UaPbhdyb/bUwhJGWRU
         aRaA==
X-Forwarded-Encrypted: i=1; AJvYcCULunVJ6jxjDDo6tmVqFrD6854iMHddB5j/OghUZ7wF5zFLfIg6lemK4N5w9s1ferodG5gospQkFTEx/cgQTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywKrn7r6qQ2biRxBQ37TRagY61xap/zXrL5miGx1zx1Q6dMfHe
	QdYAv3EiyyQOM8Q5L3P/nvh+17Sr+YfxS0lDKvkLpE6jE3z83IkeMbPS4TKVfrm/hTQ87A8ZgHz
	rIn9g8DXY5KGFt1H5Fhhqj8Kjw/7p0y8ZQG23BOOtkzkRr41+gpfdNHr5diIM9XhHAZ6g058OYN
	1njojwzquSACkoGvizZn1+0Rs/zbQu4WN5x5azRJb8cbE=
X-Gm-Gg: ASbGnctvCtruTkB2OpiGg/4r52yazoSiz3LR6rp4M9Ah6FIdjcFyp/X9JF03+Xe+qyJ
	OrAIrGxxS62fGRAOxTEyljmCOyCr+cw5BQTJI1PABI53ecVxuhcDgheiW6bqj+qCAhsrYTE7s3s
	XjWC5ERxnrHSVV6iME7Q==
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id 98e67ed59e1d1-332a9535640mr5034840a91.13.1758675261409;
        Tue, 23 Sep 2025 17:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEfQasazQYrAqwbi0RG98kEq9UrRRqH3IBMDr3ithyqZtr8231pYip07BOxHuYxpr8+ga/tswXckGmozrzyuk=
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id
 98e67ed59e1d1-332a9535640mr5034815a91.13.1758675260992; Tue, 23 Sep 2025
 17:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
In-Reply-To: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:54:09 +0800
X-Gm-Features: AS18NWDvb7ormS481il9vCXSYhrezOtK7Oc0syIfP-2dUJUzReMkhidld3UC0C0
Message-ID: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, zhang jiao <zhangjiao2@cmss.chinamobile.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FT3dyjPBlTj8vU6qBzD51uId6eFMvz-fGz5OZtxFccQ_1758675261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The return value of copy_to_iter can't be negative, check whether the
> copied length is equal to the requested length instead of checking for
> negative values.
>
> Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.c=
hinamobile.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

