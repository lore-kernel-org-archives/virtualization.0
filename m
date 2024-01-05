Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0B3D8F
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgnIwT8R"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 470AC83F00
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 470AC83F00
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YgnIwT8R
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BkQiv2X6X-aI
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 02:47:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E5BE83ED8
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 02:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E5BE83ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704422836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj9qM4WWk3dS+keeMX239nQGN9ivC8XXFg/nyP/Nxfw=;
	b=YgnIwT8RKK5sW3BMvNXNRo8MCUpWdqXNpNzvFq6wb5TlnTkZ148l/7cTcQ5GreW4RvDMzp
	ajh51vYYZhhNn1bJdgL7Ed06NHD5atoggvWDt5GVz/quvm4CU7FNtdAb4t8TRF3OfoJwv9
	VgF9gj3cZCLjfx/pUWERg7oDaKrr7bE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-aqSt8g2LNH27y-ZiOnaxNA-1; Thu, 04 Jan 2024 21:47:09 -0500
X-MC-Unique: aqSt8g2LNH27y-ZiOnaxNA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28cb109eb73so846096a91.0
        for <virtualization@lists.linux-foundation.org>; Thu, 04 Jan 2024 18:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422828; x=1705027628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj9qM4WWk3dS+keeMX239nQGN9ivC8XXFg/nyP/Nxfw=;
        b=ltY8O2VyIbnyn/qWuwSXJKUfOhT6fC1ZotIBqQHNUEfOJ8npabKLM4gCO69mRI2sgV
         YQ0/Yo+1t8pR+EzPwis/kipJVcFSwa/qyiHSsC/5K4bg/ik5MplIrHg333GUdrG4xika
         KRKglDaQuv9xY8Qw86zUtNthGk82Q9Qv2KAPw7WJ+RFssf5OgE1jiDV1H2/s6VzBPxWR
         6bq0Qs4E4/o8hpzxg3G9Nh2T39fVaVdSEI290EYPIkhKeONdiz7qeiVKQkHGYwAZ96O0
         ggO5poK7mXdwemR+zVSULk1myupAlPwulMZ8RZbw5tSQDq33yodOez0Z9Z8aKoQV2MHm
         7qTQ==
X-Gm-Message-State: AOJu0YzP3lJ2kNZEDzvIIGYmqokvSbqwZYFIotlRpJrOiWD8B9/N0VSC
	Rsifs69RRruWs0JsvmY5DnAhTH2bummgw/up5Q2PKgns4PLmKNDgF3gDIoRzjrnkyulS+kOJNvA
	F9N7adDra1UeWiD1A5j5DSXXFNmTFSwvM4tsSb8VFE1ZXIqjuB31motLDy0fMyAO6bw==
X-Received: by 2002:a17:90a:6bc1:b0:28b:c057:4e01 with SMTP id w59-20020a17090a6bc100b0028bc0574e01mr1152179pjj.90.1704422828616;
        Thu, 04 Jan 2024 18:47:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKKMNeGhYuYDZT0lc+vAEL/Zscf9ZdFfetLkDt8t9DSjWTGQpscLo+jU5vx4cKUtpjDmi7NatT45l6e6ksc1U=
X-Received: by 2002:a17:90a:6bc1:b0:28b:c057:4e01 with SMTP id
 w59-20020a17090a6bc100b0028bc0574e01mr1152171pjj.90.1704422828347; Thu, 04
 Jan 2024 18:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-4-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Jan 2024 10:46:56 +0800
Message-ID: <CACGkMEvdqT0ct1Uc4-JeagSzhW4omVda+Rj-y3fJOnK6T0oE=Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

