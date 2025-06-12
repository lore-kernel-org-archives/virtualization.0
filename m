Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF6212FB7
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713136; cv=none; b=A935eVQhLgF1+IVZPlnGDGLKPTrnx/Q5I8T2v8Kv69eV6NThKHM/5IeoO0clwGpiEifo6pFDNWFM9iRB6+Syyz9Z6eb+eGbWrpU9Pw3PuA3DiHLGPIMPjbSMiGvv8owwEmlwJURgkhhkHXus23N0WxxiubXBNh4VtE4jFhJofi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713136; c=relaxed/simple;
	bh=ur9blTN+fSDyxSNvmsKgVelNyCknt1MsnEQUweyXk10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ1/4FYl3vDTGO53ZjgYKrYgXrRM4axvMnXm7gSlLwu8mX9z5cF0Xf1ioxPpMcIxQFy1w3HaCziIuKprT7+E+H5WSiMvX/yRrVxfla4bKtZAjn8CUKoxwWRIfOkhmQo1ZnRuU6UeXhFAWCrnGDrd9klYc0WoO3ECEVLn7HnXluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxVlust5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxVlust5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749713133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIFNGdl55UNkNcCSJnLvJTDzJi2fG6iDBcZL44c6Epc=;
	b=LxVlust5XAOgG1iIvqLkQOOONDikt8XJE7ZlQTdmgYlw0jFM6l+R7JVmFZdCCM79x1sudu
	lrncj2F5lRobn3vEY/WX51bsMwosK/BG8m3BoATtiHxso9kV0hVrDKS4TPDbqgBpt9HNj4
	Z7OSDw68eiSuYvV81Mq66PSYCTYat6s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-M3J-hby_PNCnxIHDNy7i_A-1; Thu, 12 Jun 2025 03:25:31 -0400
X-MC-Unique: M3J-hby_PNCnxIHDNy7i_A-1
X-Mimecast-MFC-AGG-ID: M3J-hby_PNCnxIHDNy7i_A_1749713131
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso701202a91.0
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 00:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713131; x=1750317931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIFNGdl55UNkNcCSJnLvJTDzJi2fG6iDBcZL44c6Epc=;
        b=YSMjn3x6O4Wqqv4lr4xVPygzgQEh9AITVdx/EDohKKNnJHI7iEChD4ofFb7rZ25t7S
         PyKEAiE1HjrkfBM7CH38C77dnPNI8B3wyhnMtM7oFRa/40mdLwtNi6J6Zjif2KtYAao2
         oans8rToOBJf0D/4GvHmrpDDKNyCw7Kixz+F65/NChV28LhY0pfTljrWajj3vjU+Pcf2
         vj0SmBzUWQdRfr1eBEROUEe9zxJfl7zhTf9MGotD619TT0UpmwKOWdUU0Pvj6OX3Ur6m
         gJ26FDq3dSushYHPDClDaKZr05+YztHG4gwo0snxbQu5WCBPljxn/RTdySzFF97rHXMs
         QWTA==
X-Forwarded-Encrypted: i=1; AJvYcCX2CObFc1pXrtuqfYoc107rWlFEQo87u3jaMjokoA8PFf99g0Y2UZuCPghgjwo3pbQD+Mbd6NE0aq+UnG3uTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK+wqfOCIcIFPbkoWEN12LxIgZcLrg6JAxqfYQ839IHjQoDkDo
	IA3K6b0riyZxVf8H2BGdNaOhuoYLPqvZIl73sI0f8f2GRqHAFfKTHwozwBtJN/1hO2IWg/ir5tR
	VWZ1XgJhpXSJsp3NbvQEROPCAiApp0FAP+eTpGO8flulfnjsFeDs+hC705DeWbmg4ZyEooDWoW2
	+iovrT4s3O12jVVq49pvp9VA6JYszH5/818m/I6X/lfPs=
X-Gm-Gg: ASbGncuz/+9e4G1htaj/F8xB7UBBfErwAfN1F67OlAZyXyDRN4BKfeWxq+71CA6B0u/
	L9snJ9iMuxSQQxswXyBrflAx0Gq5NskSPF8Wg19d2De2f15ZDw5d+mXdw9Kq/ZvRF36QFI8QZPq
	+ycw==
X-Received: by 2002:a17:90b:3a86:b0:312:e9d:4002 with SMTP id 98e67ed59e1d1-313c08d2a7amr2927541a91.28.1749713130832;
        Thu, 12 Jun 2025 00:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsn9cQekYcoWU3hmfR9nZcFgm5yG2fmnWGf0A0tOWhrHNUnC4LDJH9grLMX433snr/rMDLwZSQaKfwa5hMM/g=
X-Received: by 2002:a17:90b:3a86:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-313c08d2a7amr2927511a91.28.1749713130441; Thu, 12 Jun 2025
 00:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-6-eperezma@redhat.com>
 <CACGkMEsoC9g5j+GDaQGaRdGZXaCorfgP7mdhsk3cOg4BFnCcpA@mail.gmail.com>
In-Reply-To: <CACGkMEsoC9g5j+GDaQGaRdGZXaCorfgP7mdhsk3cOg4BFnCcpA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Jun 2025 09:24:54 +0200
X-Gm-Features: AX0GCFvci-W3cksqXjkQxoSVAR1GDsfAe_M9pONGx-R3lnQEy3g31a2aAJARTwk
Message-ID: <CAJaqyWe_R_59mm1i3UE=MmrVfYCQsqP5=EvHC6Ax234zibFZew@mail.gmail.com>
Subject: Re: [RFC 5/6] vduse: reset group asid in reset
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3CKz0qzEAgdYMcI2lXSek2HeVUjXADixzwOpBvNu-sc_1749713131
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Is the expected behavior with vdpa_sim and mlx.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> Should we squash this into patch 3?
>

I agree, I'll do it for the next series. Thanks!

