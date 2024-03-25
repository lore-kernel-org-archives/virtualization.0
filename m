Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949E14D6E6
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346277; cv=none; b=I6+Ai1J0/mPUGowUsY4FNu392ssooxi8FIbsxbVuGEJnRCMSRrvCeORHmc3lAnC6md/FZxriMnzWN0XUrwr7pE5CTyXaF9Kcsl3FcK0zQtTgC09454Pr2y+NMobhTcytZVvo6vuOh6zTq3xbXX0zzelwm64u6+FBRTPekcokzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346277; c=relaxed/simple;
	bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYFGEX+KmaDRYAkj1gk8rgxOXhRIk0VZscAI+yNXRV1Pdfh+GRHuIU514oC6b2XWnKpUUt8ZgG6Gc+l62VQelGzXYc0Vjt6rK449R9WyErLf420JzB6TgurDOFTZzZO0KnxL58A122vOpfTQaK7UpbbJX+6TsbO/szvvR15Yn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btKoXo8x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btKoXo8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711346274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
	b=btKoXo8xnDrr/oqLmxHMKZ660Jd5zbHgD54wBx2Jqm4b2wp0RIpGkpNbZBjPLJ5owwA/x9
	rbEoPHsFNnHAUYB0ZoOdaFByUYlodLUDWM9zXtGbX3/x3MP8gHthAMy34JMlrhSE99mRkW
	GsdgL4/2ohUHdIrfdoXlzW2nwTzewYU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-gmSC-dWQMnu7CKpyFZElcQ-1; Mon, 25 Mar 2024 01:57:53 -0400
X-MC-Unique: gmSC-dWQMnu7CKpyFZElcQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29f820081easo3604828a91.3
        for <virtualization@lists.linux.dev>; Sun, 24 Mar 2024 22:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711346272; x=1711951072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk2CPraBaf6pstVDw2coT42i+tAhrE7QlfbtGyeM5BA=;
        b=OGgzcodN4M7rR3qydEUDSYUZw3P5r24KrmozR71YAATNfbt+g1QWLfp17jrn4lLsHq
         OtqtsMzRlctAgwdKOdvv24bF1ZEiQYgIdNAea5nPccHydXd9nkB0BcEysv9u0UAAZm0a
         KAL6FuXaLfh55vrxxb3uWlF4szyTRlxjedt32a1lE8iOuWTJfdyGk7zuO7YwG85DZry/
         4BbZUHMWxAV4/2r0XJ3L4TLFhDQoduvE+NjotR5uOibUlFcX4+FfPPQHsV5dM60vlz0J
         C7MqEmsbMYUYr/5vSQvu9X23b/2/4ltNlH/BDJsOpO5BmNLh/kAUmtHdKMw4GsQyS2RW
         guGw==
X-Forwarded-Encrypted: i=1; AJvYcCWqWe9xqS9QYrijz7mVtUggnjsfVQk03N+rr7PiwmnMXh6Mj3Dwaq7nIw8+Y5MaLedcfwN+3miJO4pU5NmnJc4cDR6rEKptyGmyTV+LPq8=
X-Gm-Message-State: AOJu0YytgBiJVzJUHB+UZkFh9E5xhVGGXapM8KAFZQ44WB2+0q6MNNl/
	iuccNOLxtghy2eeU/Pz1ePj0Ztrk0kzuDDN8dLkOyJlTkADfnFoQo5NX8u8dQmTOgGcoDyPIeoZ
	n7n0U4cg8I3omP2CPmUAN5uCZasTApZ1aXnyjbOwYefNn1NKCkgot/mLkGXIHJcem1ITPZTtJK1
	DpX2C7Nyp70jNI/fH/jhapsVtKXa6V2qVhjBO6OT0=
X-Received: by 2002:a17:902:e546:b0:1e0:9da6:1765 with SMTP id n6-20020a170902e54600b001e09da61765mr7474488plf.46.1711346272032;
        Sun, 24 Mar 2024 22:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbSBGmoujt2DqEgZCTFU091ZGyX5Kg/qyLAwmd74LsdjhC87PQ1Ts+fJEtISdMr7oDOf0/oUhVkkcDUH39+GE=
X-Received: by 2002:a17:902:e546:b0:1e0:9da6:1765 with SMTP id
 n6-20020a170902e54600b001e09da61765mr7474477plf.46.1711346271773; Sun, 24 Mar
 2024 22:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com> <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
In-Reply-To: <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 13:57:40 +0800
Message-ID: <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=E9=81=93=
:
> > On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> Currently, ctrlq processes commands in a synchronous manner,
> >> which increases the delay of dim commands when configuring
> >> multi-queue VMs, which in turn causes the CPU utilization to
> >> increase and interferes with the performance of dim.
> >>
> >> Therefore we asynchronously process ctlq's dim commands.
> >>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > I may miss some previous discussions.
> >
> > But at least the changelog needs to explain why you don't use interrupt=
.
>
> Will add, but reply here first.
>
> When upgrading the driver's ctrlq to use interrupt, problems may occur
> with some existing devices.
> For example, when existing devices are replaced with new drivers, they
> may not work.
> Or, if the guest OS supported by the new device is replaced by an old
> downstream OS product, it will not be usable.
>
> Although, ctrlq has the same capabilities as IOq in the virtio spec,
> this does have historical baggage.

I don't think the upstream Linux drivers need to workaround buggy
devices. Or it is a good excuse to block configure interrupts.

And I remember you told us your device doesn't have such an issue.

Thanks

>
> Thanks,
> Heng
>
> >
> > Thanks
>

