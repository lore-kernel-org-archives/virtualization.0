Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AC199BC
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Apr 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239192; cv=none; b=aVDkQhmV5kCOqo9ARIv5i48Ilo3VyfDHiN0R5HB3YGAoI7GeUNZNlYApZWG+gVSbiwDBGL1ua75f7hlK9rqFhnX7w5f27ZFyawkXPzi4H4r5oS5LsLUK36EG5+8+tEzcEn783JLWXY2BYfh6D3nwvJxAfCS35Z+zKFMcBYGL4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239192; c=relaxed/simple;
	bh=5AHDPoNYz6OYyTQyPh89LCxQ98eQH/ZTlnsO1SaMREA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q79d4md944LSOgzHMA4F6Pagl4IrTiGLYYV5VthVep9WRwsq0HLv8Tjg/LSLZBgsf/4hBKI77yD13RAqZIjoyXnPvQWUB4xQtiBUr+qfwQUmDc+hxFpu2jdU0wSZsVkrRjPIedcVdExxoMzqRjPnhVi/mdPXN0G6ElAOlkpfmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UH/TkX03; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH/TkX03"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35E9860796
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Apr 2024 03:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pQffE9pP_Fd for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Apr 2024 03:46:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 621AF605CD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 621AF605CD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UH/TkX03
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 621AF605CD
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Apr 2024 03:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713239187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZDbR0tmZA4tU6Egi/VdC3qpLsZIOkOjLEJ7+EXDz74=;
	b=UH/TkX03E7QYDcRz+oQ530VqRLQVaZWHux/9TYZKwb5CkHFlIeQX3biBvf8+uRwiKRd0c8
	sOOwcCPRUGcPZVLuYXLCyTF2SLbhMQVvU529ntfo1z7ZSxS78H5yUr8zu0u6U5McZZw5nv
	LGydW33Z7EI+iNLqR849hMsMFoeW1to=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-xDyfoRpHMcWrW9JDUhgPsQ-1; Mon, 15 Apr 2024 23:46:26 -0400
X-MC-Unique: xDyfoRpHMcWrW9JDUhgPsQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so2097153a12.3
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Apr 2024 20:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239185; x=1713843985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDbR0tmZA4tU6Egi/VdC3qpLsZIOkOjLEJ7+EXDz74=;
        b=cqTvUhJY9+VLIJVSXGp61f9vfDcqIbhcADMoI2kyh1hhXk/Hk8WiDtwB7K0nH/Djko
         JFmQ5taDeINTO8ZpKTmaeVx+eteLUStW0D6CeUz+XNQx2QT/ZVzMwQWghUvMwvF7o4Iz
         Kz/wa2IGOunfgyP6EGW0FwBVeKwm78++ZHw5gwadBD5QUYnM4Lc/AJtkd8AON9rb73+B
         DjCgn+AYgJ/nvWfr7JF5DKhxZmrBmRdKC/PPL0K56g+z7CtTf21USKiik3epncHf2R1y
         krhgAyDltRXs3HRxABn2W3QNK8r1AqOerA3emhJcdBcaUIRVU23iS5G9xBZKDUFtY4gR
         psxg==
X-Forwarded-Encrypted: i=1; AJvYcCWmJuXzBa/CNk3l3szmOGh20LZqEV+vjBiZmIHZGB3Co+9URIx2n+BAQbnU7HcADjsb70EVlAzNgNioWCasacddXc1Q/NYwX8iKapQ9FMW4UE1t1XY2XbLb6Q==
X-Gm-Message-State: AOJu0YzSlT1Z8eK/O5o3QWCGjAkfyDje4nBQWAWfAtGBxbbFyYzg2QWf
	88F/N+UTerxkAup4jZsS5Pr3yh0Iz1yUIHUewLAgwe5T2BafaF14vXXGkFnJjDLYw+KuFeYzFr2
	dN7tRNqTg6EqnIzaRQD6O1nQstX4G0WcbSGTkJcJG9J5uqQaZrPPqOJZhXAhBvlytltuBy0Bs4/
	1vAQTk2eeENLw26dkYGR5WRZA94mXxUFCyzKKUxg4YLF9ibUGPkc2+wg==
X-Received: by 2002:a05:6a20:9794:b0:1a7:bb6d:6589 with SMTP id hx20-20020a056a20979400b001a7bb6d6589mr9991416pzc.29.1713239185032;
        Mon, 15 Apr 2024 20:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECsgVpj59BkwFlZnMgbtejU9EUN4yHlVQ2ayU0ha7t4veTjEQGaado8SRmWHQWczu46plU8EdMhF53J+KNXtw=
X-Received: by 2002:a05:6a20:9794:b0:1a7:bb6d:6589 with SMTP id
 hx20-20020a056a20979400b001a7bb6d6589mr9991405pzc.29.1713239184690; Mon, 15
 Apr 2024 20:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-6-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:46:13 +0800
Message-ID: <CACGkMEt3qpm=3Y=CDeA1Kyd7te-Wm-gk3j5iR96=_CaP0PrVtQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Documentation: Add reconnect process for VDUSE
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:31=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a document explaining the reconnect process, including what the
> Userspace App needs to do and how it works with the kernel.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> index bdb880e01132..7faa83462e78 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
>     after the used ring is filled.
>
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> +
> +HOW VDUSE devices reconnection works
> +------------------------------------
> +1. What is reconnection?
> +
> +   When the userspace application loads, it should establish a connectio=
n
> +   to the vduse kernel device. Sometimes,the userspace application exist=
s,

I guess you meant "exists"? If yes, it should be better to say "exits
unexpectedly"

> +   and we want to support its restart and connect to the kernel device a=
gain
> +
> +2. How can I support reconnection in a userspace application?

Better to say "How reconnection is supported"?

> +
> +2.1 During initialization, the userspace application should first verify=
 the
> +    existence of the device "/dev/vduse/vduse_name".
> +    If it doesn't exist, it means this is the first-time for connection.=
 goto step 2.2
> +    If it exists, it means this is a reconnection, and we should goto st=
ep 2.3
> +
> +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +    /dev/vduse/control.
> +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> +    the reconnect information. The total memory size is PAGE_SIZE*vq_mum=
ber.

I think we need to mention that this should be part of the previous
"VDUSE devices are created as follows"?

> +
> +2.3 Check if the information is suitable for reconnect
> +    If this is reconnection :
> +    Before attempting to reconnect, The userspace application needs to u=
se the
> +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEAT=
URES...)
> +    to get the information from kernel.
> +    Please review the information and confirm if it is suitable to recon=
nect.

Need to define "review" here and how to decide if it is not suitable
to reconnect.

> +
> +2.4 Userspace application needs to mmap the memory to userspace
> +    The userspace application requires mapping one page for every vq. Th=
ese pages
> +    should be used to save vq-related information during system running.

Not a native speaker, but it looks better with

"should be used by the userspace to store virtqueue specific information".

> Additionally,
> +    the application must define its own structure to store information f=
or reconnection.
> +
> +2.5 Completed the initialization and running the application.
> +    While the application is running, it is important to store relevant =
information
> +    about reconnections in mapped pages.

I think we need some link/code examples to demonstrate what needs to be sto=
red.

> When calling the ioctl VDUSE_VQ_GET_INFO to
> +    get vq information, it's necessary to check whether it's a reconnect=
ion.

Better with some examples of codes.

> If it is
> +    a reconnection, the vq-related information must be get from the mapp=
ed pages.
> +
> +2.6 When the Userspace application exits, it is necessary to unmap all t=
he
> +    pages for reconnection

This seems to be unnecessary, for example there could be an unexpected exit=
.

Thanks

> --
> 2.43.0
>

