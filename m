Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC66246760
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594655; cv=none; b=ciuUW4iT9DO5qRsPPXiJNpfL+qK4e00jS/L+Mr2gKP+DXrUtly1u611xjB7gyoPWgx3niO6t86fNVK2EnufGiFXtL3oMspP4xzq6sfQ22JeBiweEBCccckog8Mgfsy64AncYnDsxkozSYSDqCbwPEc0KrFoZOy1foeOnKAspWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594655; c=relaxed/simple;
	bh=fzWQ97isS0aFc0gzpnyA+DyrdqHK5QpHgLLtTb5CyoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrVL6//Q4pNN4D43VYAZVfOZ+98ZNF/uARbpDggUTQVhr5R6LNMbacurjEuQN6PJZcVi/I7q2wpvzPdcBJR8USyd5S7Tsiyh7pWnZ05bmRIOpjju13u3Ilvo9VDXCrf+rtQBE0Sz/t1Tk36/BCSH5W7wQ7fPFc0vLHKh1fxOU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haEb8pIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haEb8pIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760594651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBDQEp6dY6z3vDFe/pLFiO7hi6/5jG11qLJqUUlD44o=;
	b=haEb8pIBleEHEsfYgeO8oF8HuRhLUUL2ux+afJqc9WXSNHadoo6KU5Xoi+WlIY4Tcfc0bF
	wj9Ik3Z6etFuZCFsp+DaTS45HOenfIZHitewpLMdAxfK4Ciz5sWueWvnfCHrrKCqQy1OWH
	u72P1kLTLSmCI1M1UuGDJm4XYNO+tSA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-KcJqOrVjOAyx5RLfOUmiqA-1; Thu, 16 Oct 2025 02:04:10 -0400
X-MC-Unique: KcJqOrVjOAyx5RLfOUmiqA-1
X-Mimecast-MFC-AGG-ID: KcJqOrVjOAyx5RLfOUmiqA_1760594649
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so283849a12.2
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 23:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760594649; x=1761199449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBDQEp6dY6z3vDFe/pLFiO7hi6/5jG11qLJqUUlD44o=;
        b=Id3OO399xSzca11AjAEtm1+9p+9V0G2buBkCiA+yROwbgCtg/v8eqzEcNQBMqAID89
         AktkLEHUsdPCxzMhEDgJwtFh2Aw9tACGl6deMe0NsE+xnIDEF2lqVDm/XDnoX+PCwNF4
         EDY7LtOJQXeigvFbGZDH3qTHu24v+ASd8QvaI2gNOYhWSNIj96KlShgXI2JeilZGcXVx
         yFAjMugC0H7sXVByPBh5IGjc9UkIea+vURHN6vMU17xTrk16i6YJVI5b8GukZCCVvaxS
         Fp9mCZ9oVop3+bw/4gYAIjLwlf595+8uGUKxLgohsqZCULUFDmlR8I2ATmc7Eq/ZOQS7
         LXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCILvPWddvY05UypabhliKoMPYruW2xKt5gGojZVHLxf5kd77MsW5B6udWlQhUzyvAFOuyv7cT+RmTw4b1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzEVpPUnkqfArVPKw3uIu8czz/47jPupybou8Vdhz1COvdaM2l
	YZ5tGX0ZL+x6R6aoznAE3QUSFg7s4Djn2map6d6aiNZAUScJExlw+12nlBtLyjToXQNMNdKw6E8
	a9UJER4kOy7u2cASxhzgKdYoMmgYqc90FLf73/3f5zTZbd3W9aIoCw5s3j252oyYMcaf+F8dzCp
	vUgi0RBg5h5oQ+dQluV4IlxwObuaCpXOtWIbZ53Rbo6fg=
X-Gm-Gg: ASbGncscasfQXoeWjV41v32VcXOsWp3V7JswQgnFWkIuSKwlN2iU0Qb018sARGQ6gfr
	30zIJJ0/gytzz2hidMAQKZv7wscfHEJcLKtOqZL9gPW9KUKZbQdrjuUaeeogzLB+h+ddtp5dVj4
	210FXonZoa9LLrpcxD0Tk/EkcyLDHE5BvqRYFtUXUil+ze4bU0ann8
X-Received: by 2002:a05:6a20:7287:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-33479cdfd6bmr8988330637.4.1760594649028;
        Wed, 15 Oct 2025 23:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY+kHqhWF11sY33iOBSuNwi2TBCw0YITrMKtg8kGnHaEECZ9BwvNrmu9v04hgAF1z9yPKYxqRrVB94L6OvOt4=
X-Received: by 2002:a05:6a20:7287:b0:334:79cd:fb13 with SMTP id
 adf61e73a8af0-33479cdfd6bmr8988300637.4.1760594648627; Wed, 15 Oct 2025
 23:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com> <20251016014328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251016014328-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Oct 2025 14:03:57 +0800
X-Gm-Features: AS18NWDuqYwgVzom1r2COmBXOe_87iF6tjmm9zly1hmhVkJ6KXe7eh1hEIR66RE
Message-ID: <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DaZiWW1NL0tC5H5I_lIpMGJmsDSYZPtRBk1E2YqtHsg_1760594649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > >
> > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > 100 messages to enable/disable promisc mode - together they
> > > > have no effect.
> >
> > Note that there's a case that multiple commands need to be sent, e.g
> > set rx mode. And assuming not all the commands are the best effort,
> > kernel VDUSE still needs to wait for the usersapce at least for a
> > while.
>
> Not wait, record. Generate 1st command, after userspace consumed it -
> generate and send second command and so on.

Right, that's what I asked in another thread, we still need a timeout
here. Then I think it would not be too much difference whether it is
VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
can only advertise NEEDS_RESET since it's a device implementation.
VDUSE can not simply break the device as it requires synchronization
which is not easy.

> But for each bit of data, at most one command has to be sent,
> we do not care if guest tweaked rx mode 3 times, we only care about
> the latest state.

Yes, but I want to know what's best when VDUSE meets userspace timeout.

Thanks

>
> --
> MST
>

