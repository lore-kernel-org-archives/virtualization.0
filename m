Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908EE13C9D9
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041686; cv=none; b=g/N2k7JC6u9yqez+o1L8R/rN7efw0lLQEwmKsSI5ngKpAGS+qRJuvX1zB6XgtB8AMEx2tzuCLb6hkkP3Sw9SdicdOOaEmKtUd8noEzDQlw86WJAuilcXRhM38vGz1zF2PF1TKELjoQ3ZJFkxkiF9pnMR205CClqPzpxRRn2JaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041686; c=relaxed/simple;
	bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGpRywF8pcdfV8hwFmKv2WJv2+lNIpVMNIPw024YAaWTe5ZNZOgW6WEJS+NG6rlJvS9oBM+SeccVQRQ8X0AJ7B70NO6AomYbGWkke7Xqu3NRnc12zKWzUkyBSUoqfMTcIzCfA4mBs6QF+wa0jOJAco/T/Z//pJgM7jHVaz5qLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKYe1LaH; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKYe1LaH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D7B180AC8
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 08:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0Ooh7xJEfpi for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 08:01:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2294780A52
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2294780A52
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iKYe1LaH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2294780A52
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726041682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
	b=iKYe1LaH+ntw8w/lhU+wlFD3FxNXNOnQU9f+HDBAdxtIMnqmjC2RE4WGEGSDh4znzw3uRR
	vG7PYeKmKGEjuxEzGKHtE/O0n/S5YiwgnBoVdLHJag8QcJwSKuLvZj8ifF4wXH6Clo6QjU
	ExW8EcVPouleCK5pe2/p4I62cCkvhOU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-OIycmWLCMuiAlgLPHY91aw-1; Wed, 11 Sep 2024 04:01:20 -0400
X-MC-Unique: OIycmWLCMuiAlgLPHY91aw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6d7124939beso193118517b3.2
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 01:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041680; x=1726646480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7YFPOr47KnzpX+EfvhDAL9kUueFzGcx6/bEZmJEe1U=;
        b=eXB5aWXJ1o/cP72MRBsczGkRMi1o6kYSJBUZQbrPfEVZwVmWUDlHdcx5TNWqWy7+07
         SLGNk+QQ2jmY/qAyMtmp4q3F1IHnYqVVDU7TCywgYBan8zgdSkuRujwUpm49GxvFmO4o
         2O82gvmMHuoiRqzAP+LZS3xqMrvKhbWYR3e4p+EksWstCppBOqggbPzu5YFPFwxDAtZz
         GkWUKhOYH1ea9gJGu/CAyhoWr3L4B92MlqiD9cJ6OWBTp6Ea1sGox6026uDeo9VkLcPB
         cfCI7HfZ23nqqFxz04fu4opUsu6Bn4H0ZUJzVAtwcP0XTnJXY0WCfRrFOT+2HirwbH1B
         ByCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5zihY0HwR8muoNMdkBaYt1+xzHneKuSaKfUzCFHauG2cpnmqllo2i27r2waEntyOae/i1MYKyDx5RcFo/OA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxGTCAzXR85M+gCMrx60hPDv9S6HfVFIeCm6Qegfx57+24yUxx7
	mWuL/ei9AXIF5T82aNI6zgFJ7j2BOZN7y5T/vD2+FKy9lJcOpkIfglUze5+P5OOSwD6W9/dKqPf
	jFl/Ta6O9Zt3xGHxPGMyrP9c48uc7tnty7VDSUgULKqh6w8pJNOTfcX7zFaCz/IDiOt7Cyti1gt
	7HM8PyVKIxhUFvUX+vPfYvi4lC4ZMOsZnzcN2qOLQb8vuuIF8Y2P57cw==
X-Received: by 2002:a05:690c:6512:b0:64a:3e36:7fd1 with SMTP id 00721157ae682-6db44d9e360mr200120247b3.10.1726041680281;
        Wed, 11 Sep 2024 01:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGycL15wVUOnoLYy7HKMCqM5sIYCNMn+FEaCTz3f8kQpDk/ygjQU73LezZOKgf3VnEGDHaAdRqQdFmHRUiFMw=
X-Received: by 2002:a05:690c:6512:b0:64a:3e36:7fd1 with SMTP id
 00721157ae682-6db44d9e360mr200119947b3.10.1726041679985; Wed, 11 Sep 2024
 01:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <20240816090159.1967650-2-dtatulea@nvidia.com>
 <c59afb55-78b1-48b3-bafa-646b8499bf1c@nvidia.com>
In-Reply-To: <c59afb55-78b1-48b3-bafa-646b8499bf1c@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 10:00:44 +0200
Message-ID: <CAJaqyWcEt7=3j2uoToZH=no-gPvRsXwW7RLtFcbD7_-nQ0Dqyw@mail.gmail.com>
Subject: Re: [PATCH mlx5-vhost v2 01/10] net/mlx5: Support throttled commands
 from async API
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:33=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 16.08.24 11:01, Dragos Tatulea wrote:
> > Currently, commands that qualify as throttled can't be used via the
> > async API. That's due to the fact that the throttle semaphore can sleep
> > but the async API can't.
> >
> > This patch allows throttling in the async API by using the tentative
> > variant of the semaphore and upon failure (semaphore at 0) returns EBUS=
Y
> > to signal to the caller that they need to wait for the completion of
> > previously issued commands.
> >
> > Furthermore, make sure that the semaphore is released in the callback.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Same reminder as in v1: Tariq is the maintainer for mlx5 so his review
> also counts as Acked-by.
>

Not sure if it was the case when you send the mail, but this series is
already in the maintainer's branch:
* https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/
* https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=
=3Dvhost&id=3D691fd851e1bc8ec043798e1ab337305e6291cd6b

Thanks!

