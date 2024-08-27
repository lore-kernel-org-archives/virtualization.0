Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17310372
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726140; cv=none; b=qmvCF42WLzhEulkNiFwCDixxHTTU/VAnK7VRVth3b1DegLRP8QRW/Iz2RLYTgIEVDiisrR9k/Xwnvv/3554GuVdJsbQZhMEwajiMen7bmByN8Qottw+FVvXCL1Bg2i/xcc6jOBdlM32Xn2NSTCNBG4mWJ0kvI7q70QyTWPC6rC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726140; c=relaxed/simple;
	bh=/x5LgCamELn3wH1QzCM/D9Nwp6D3CNGdJwAUbt0zpQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM+k9bx4XzRywrpbHOD/T070Zhf6XVEKwbvPOvUj2NvVuk8OCsBNs98OEnRmKKXZRvNz33zEhwdyRVgNtn11uaBFlXn1qOkJLDHCp+kLpe91ieM0EI/mqHRdSuPxpWNbd1BUGXtdw6Gjfc84DX3faYiM3FBhPyE1efiR87FVlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awFXO/HX; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awFXO/HX"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E2580ED8
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7laDqL-AYjj for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:35:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D4A4380ECB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4A4380ECB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=awFXO/HX
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4A4380ECB
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xdglMwBLWZ4kP9lr3xnFQZHeIzFDS9NqTN0/hvLSHM=;
	b=awFXO/HXlKEAtGw+nvMHd6E1TMac+Qoun+8A+UoE4INzKY4bGf5CzZXttdhA9LRgrOU3+R
	uFk6mNZhqVK0nLkMyc389w6CYKU9F40KPWFenHgcsvAVM3L8Fgyatfy89Yy/qwzZ5/4Fwi
	P4iKEjVEeV7qTgp4kp9TnU04gHNTIS0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Pim5PhF9Orumwh_B8bGymw-1; Mon, 26 Aug 2024 22:35:34 -0400
X-MC-Unique: Pim5PhF9Orumwh_B8bGymw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb5847ff53so6145326a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726133; x=1725330933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xdglMwBLWZ4kP9lr3xnFQZHeIzFDS9NqTN0/hvLSHM=;
        b=tqmCjxcrAh7BpEmfOZbG9VspewGnnG8GBxQ66VWFxsMk1ocztEFf4b1psqSAox3znI
         fDohewCdwah4RDJfxaBkOv0HAxnemKBuDZhAn0HBd3h3CwroaCbfgWmrLM6d62MsXX/p
         kfiZjBHNafoYxe0tDyg3HLygwjENQ73/hD+x/aOyN4jD7ZhS6Vu0QInJA1sx/EP6dyDv
         zoqKdOFkb6mDiHrYJN/26QLLHSVi/HpYNdh9IwLhLK6q8o8p9EBI0aBwkIkaw4zmsEjM
         uH+w+bfEJ7QQybxql+js/cjZWyZnIrXh5UAU7vO4CsVi52RBZ0FKLFfTkTaL/z2/ELAC
         HOZA==
X-Forwarded-Encrypted: i=1; AJvYcCWXaNr2aUQbiSgfxnvENmOg4XCliNOpaXsEDY6MBjz6SW4GJLPLicPcXNVuVClbK28G/I7YVo10RCqWvrlB2Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx+u68tGDzEj9++2pbF7H/4oC66uQ7Dp+4lohEl+QtrhpQNLUo/
	3PAP7I3BFz7lpWiKZ2SkC1QD4dsLrIJeVbXm4rMVLAkZJ83TpZ524lvjjZmH5CiazVlS1vaCcSx
	xt8I+cKNvyXvCULofHRvj2RCc/hdQ9Ke58y5pd7NqR4/6Gl/rX93K70Dhl2Sa/LPVt5IGpQPsqF
	rexkJh4IZ83gEHJ51ZCZidGN3Pr7PF0/gJyxPMlxT+R3j6G53z7gZIrQ==
X-Received: by 2002:a17:90a:db8a:b0:2cd:40ef:4764 with SMTP id 98e67ed59e1d1-2d8257f96d4mr1672254a91.17.1724726133158;
        Mon, 26 Aug 2024 19:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYF9StMo/SkY4g3hWHvXkzikeqB0QT1VCqIcA5eVMx6EG9JTEMeXtqvLAGtsuoCae1C6CIOLDyfGiu+eqWHeA=
X-Received: by 2002:a17:90a:db8a:b0:2cd:40ef:4764 with SMTP id
 98e67ed59e1d1-2d8257f96d4mr1672237a91.17.1724726132646; Mon, 26 Aug 2024
 19:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:35:19 +0800
Message-ID: <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> vhost removed the support for the kthread API. However, there are
> still situations where there is a request to use kthread.

I think we need some tweak here. For example, we need to mention that
the introduction of the vhost_taks introduce userspace noticeable
changes as the worker inherit attributes from the owner instead of the
kthreadd etc.

> In this RFC, the support of kthread is added back. Additionally,
> a module_param is added to identify which mode we are using,

It's probably not identified, it's more about if we need to "enforce"
the old behaviour.

> and
> a new UAPI is introduced to allow the userspace app to set the
> mode they want to use.
>
> Cindy Lu (7):
>   vhost: Add a new module_param for enable kthread
>   vhost: Add kthread support in function vhost_worker_queue()
>   vhost: Add kthread support in function vhost_workers_free()
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add kthread support in function vhost_worker_create
>   vhost: Add new UAPI to support changing Kthread mode
>
>  drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h      |   1 +
>  include/uapi/linux/vhost.h |   2 +
>  3 files changed, 235 insertions(+), 9 deletions(-)
>
> --
> 2.45.0
>

