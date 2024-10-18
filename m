Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18D2905
	for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238530; cv=none; b=l5Ab1gRCadyGqUKLTyDq6EbBdVzr5fW+WVGD924mg4Icn4fDkW9BgFM4agiJgMtkg7PuivV94yd79qIkdAAx468k/jtJsD7u3GGhVp6Nv6jQgjJaZhmFigh5dPaCKqV9qJHwMDMimAg12s5jk4O18ravcuonVd2HFxbGnUMSer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238530; c=relaxed/simple;
	bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2jc+4r9JF4bD/8p80m/cV4sjC+Fmzzw3FcAiStaCseFP2AfegV21ff3deTEc99Oz09+O5vdv7vnHlyFhm+seZjXb7GqpAJlcuXqiooaikJo4CypdeJYg/orFeHIphKIqHkuPeJM/jDrC6yQOq4TMB4li5c+oeJTaUgykZbj4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+5lIWQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+5lIWQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729238528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
	b=f+5lIWQithWuHsuJ7m3eGkpnptFVEuoo0YCoNosp4/II7WhODTHUKV/uYlgY7zHv2+UnZu
	1EEL4aqZ1aXLE+cLBeURChgnsVzHSf4JcT61Ivwv6g4DjlLJoIdRQpmlgqvDVPaGuAv4dt
	T89YytRDAW35bMYws8wEL/lGBTyK2Uc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-wpQB16SwN922JG5rlgxqAQ-1; Fri, 18 Oct 2024 04:02:06 -0400
X-MC-Unique: wpQB16SwN922JG5rlgxqAQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e3984f50c3so1710007a91.1
        for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 01:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238525; x=1729843325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
        b=UjNQISMupes2PAo4OHbfZaPR2tTcUpKek2AHoS9sZbSgfkz4w/lMBa+FqaDL7f+G9D
         q7Qt0MZwEPhQ3/qiMOn+zPAtKpw3vaTag5Ldw951zBAqpJcvfpXiFYobwCW0BjIQCOdU
         a3Y2RD1rzHJibayJnqGL7ICY2yHYAaHAKuE2Rg6zU1bfdncBxdieOPNwro0gbY5bGra5
         MIA3s0eLnxFjbX/BSglXx1qXW0WSbRPdo22VHOgk1/UN+pMLK2kmvYTwBptEv3NL6g9A
         beBa9C5dIIMQrJLkmQmHjq/PVjQ69PXzEXgmpNP5wBTWe5Y1EuOOYGXZymQQxPa3VFYM
         A2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDNMxwQW3JOwUDQZ+4Os1X/GwQj9PHUxJdDFn3UMWSVEg59kGUupG4mNluptiYwXvJ0mxtirhA/2yhhR9TbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKi1S9LhfXKvzQhe0TLnREGnQ8yVd6wmtlqAzv1nJ8d3Gv3oLd
	QN34VFelHi8zWtOwKIkIhYjqEu42MHQ3zJhMGQnJnWHsXIKTvOEk5Yt1VbD1rvcH65agjjLU1No
	k3pVe8ex+kDyiNwFi77Phe4e8uv+AFB5thuBRyBFHzSNL8k5pDwq7PnjWHO88Hke3N41QK2NCP1
	LfLVSHuKJLZVV92uJUgIpENOXTuuqp3oRougfKAmQ=
X-Received: by 2002:a17:90a:6f84:b0:2e2:bd9a:4ff4 with SMTP id 98e67ed59e1d1-2e56173c1e7mr2127776a91.24.1729238525549;
        Fri, 18 Oct 2024 01:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQg5ad50z5TJT0Vz61miNpBzAGlHXC74/vab5FUTVCqiuFjBxtHJhtJuueIWOvHHFw+GQZP77hMr7YozQ9XGI=
X-Received: by 2002:a17:90a:6f84:b0:2e2:bd9a:4ff4 with SMTP id
 98e67ed59e1d1-2e56173c1e7mr2127748a91.24.1729238525123; Fri, 18 Oct 2024
 01:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:01:54 +0800
Message-ID: <CACGkMEsa7wQdc4FqN0uKu8jSzsTAxwbL_w2MXg0ML4W-qGavHw@mail.gmail.com>
Subject: Re: [PATCH 5/5] virtio_net: rx remove premapped failover code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, the premapped mode can be enabled unconditionally.
>
> So we can remove the failover code for merge and small mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Let's be more verbose here. For example, the virtnet_rq_xxx() helper
would be only used if the mode is using pre mapping.

And it might be worth adding a check to prevent misusing of the API.

Others look good to me.

Thanks

