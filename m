Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62421225417
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254760; cv=none; b=VDdckHZF1Q+5QJV147DFDSke5Zdpa7c3SemVlmhHzSXnew5pwSEM++oaeQqhfWqORiTlMMmpptX/I/PtesOMDZkOIIH6HLG0uP4rI/5bU/9ipW+8iJVcUeFA0oX/i1qwLxqcVUHsfRQeCZJQj7mruYMELqQMaQZP2eQxArhR6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254760; c=relaxed/simple;
	bh=J+hBl84WHm9dTvb2IVD17UN8GJ36a4ic9xIN7/1TU90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMkNZgboXxINB1zNR0zJVW4/iGo2sWWjETRTYMyS1d5/DYEOWKHfEs6ZcL+D8vNvpN9QwX/WMdadIcBUm+dSg7W8gtlGCZjmfpSltaFMGfuujd/GFQIB3xWGJtu48NCeJ6UoK50EiGFltbIujjzw2iWPlR+RP0L4zSyBe3nDY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7BfkR9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7BfkR9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+hBl84WHm9dTvb2IVD17UN8GJ36a4ic9xIN7/1TU90=;
	b=c7BfkR9UR5jyEUgJnbqUrPKK1ssEFPdyvVJyhtfbaThOm+sgkwi91KF5RUp/d6wioDTOV7
	FeXifiSckXY2JwqtJBXjkIAGgAMEC1QdyPYNnW27+6kwkHsPmgvLExjUPJwFSzxfjchScW
	2LpAjPHaZVYYqbZAfIKWSStyP/XHbMo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-6eFFsC-hPPu4ownH51EwvQ-1; Mon, 08 Dec 2025 23:32:36 -0500
X-MC-Unique: 6eFFsC-hPPu4ownH51EwvQ-1
X-Mimecast-MFC-AGG-ID: 6eFFsC-hPPu4ownH51EwvQ_1765254755
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437863d0easo8297144a91.0
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 20:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254755; x=1765859555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+hBl84WHm9dTvb2IVD17UN8GJ36a4ic9xIN7/1TU90=;
        b=Z265AuUr9U9JFUe7SF57dyD4+GwlXaiqRZ58EeOsWCdoEVxAI2Gc8t4MVap4nqGna4
         PVwjC33frllW0kprsy8LqMzrLHwWlkJc0VFJiT6/11mA9ewCZa4Cx+sjEtdRLmVcdbcv
         bV9/+F2K+/Kq+FRUYSBNqInvsvhVQNQ5jaJwgEhTEL8FyxL3Dk4xBe9gFMJJ+JmhcrB5
         EFwBP1ZOnBz7xNcKP8TuEdn+Cit40SEHLBVbRhlX0o9FFsQmGcwFHUU74XWQZYH579It
         nlbBRu00Rcte1cMLbzS/2yEBOH3lZJIGR/sK0keqzdM8h9MFkGLZibleVXR4TFznVRCS
         k7uw==
X-Forwarded-Encrypted: i=1; AJvYcCVmVVZe38V8jT5rTnXJ/572DzKJWCSFY2h2CJNv5S+NbizrEPiFkCcZTKGruWEQQT6Xkh2w+XIZTccRSJDKMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywoy5MbzWD/gmBWZn3Lj6A/BHSd7tJqBkmzi+AnhmXc74/WHL5Z
	VQz6Tbhng1DZVs1o5tDYBuVwSukVp28rqe/G9j3Q46ns4hEhYoidDnPqcd7//VGOLTxg3Il/Gz5
	TtRmbEB50IoMUJYCUO9acl/8lv0vz4owV8mxfQUblGFGNXUFBHHBC6rOnQhx3jCfRo59SAZ5THJ
	sFWNAeNY19/QEy6VileX5Ri/pONAnBXuQYp21UNIxIuow=
X-Gm-Gg: ASbGncv3aJbsPLCc7+ibDW/G0EXbf+XsMFNOYiESu6H9hSQCZgAJXBs19Jf7DK6e1C6
	WgYKu0WbFrGv/tXDSsce6sx99sBtDAwEwpzt2ebhm3gUs84ZwV+nYZnbDVo0BeYUA0THIbLl+8M
	precpO7rhTbtaPPd8yCTWe2I63oj4y9PSURO7LTBd3dG8FQ1oydlRlx8lzoQDPABc7yA==
X-Received: by 2002:a17:90b:1c04:b0:34a:47d0:9a82 with SMTP id 98e67ed59e1d1-34a47d09bcdmr1283563a91.23.1765254755292;
        Mon, 08 Dec 2025 20:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZigLd+4tNDsEqpK7j1nL3e0eAUG/9ReuDlT5kDs4M6VOh8brOzGP77EQtaU2rfZiJeLxJLmD+gjQF4ATP5OQ=
X-Received: by 2002:a17:90b:1c04:b0:34a:47d0:9a82 with SMTP id
 98e67ed59e1d1-34a47d09bcdmr1283553a91.23.1765254754860; Mon, 08 Dec 2025
 20:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251209015951.4174743-1-maobibo@loongson.cn> <20251209015951.4174743-3-maobibo@loongson.cn>
 <CACGkMEs8E9DYzmZ8k4fH7h=fxC07wMsHizyDAE3wiKmQhkW3Uw@mail.gmail.com>
In-Reply-To: <CACGkMEs8E9DYzmZ8k4fH7h=fxC07wMsHizyDAE3wiKmQhkW3Uw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:32:23 +0800
X-Gm-Features: AQt7F2rlxm1BYckxq9YbxOuPFOA7BbwOSR1nEKtVYCMLEczaDu9olC5Koe5SKPU
Message-ID: <CACGkMEviPVi+nJvS6rU55vF8xk08kAkr6ja0tYZp3BHJK=LtJQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] crypto: virtio: Remove duplicated virtqueue_kick
 in virtio_crypto_skcipher_crypt_req
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LW-Fw_yS7QOQt38he_f42r3mShtUAfdictamG7eHvgk_1765254755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:31=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Dec 9, 2025 at 10:00=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wr=
ote:
> >
> > With function virtio_crypto_skcipher_crypt_req(), there is already
> > virtqueue_kick() call with spinlock held in funtion
>
> A typo should be "function".
>
> > __virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
> > function call here.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Btw.

I think this probably deserved a stable tag as well as the
virtqueue_kick is not synchronized here?

>
> Thanks

Thanks

