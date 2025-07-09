Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590C2D8796
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065969; cv=none; b=rmDTgIWvgX50/FjbbNznhBLvv+Lb7jF/UR1A/AJuHrcAQ1H1xuejjrJEdgWyNiZGgJjl+8CELGnxTYKUZ60laE8buwhncrAt8TgEIrSAgzzou+NFbzhDz3x03tyQ9L0nUh0P5610JB/zNBEWg9Xd16snzkQmDzYabznVXp8jtKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065969; c=relaxed/simple;
	bh=0StkDmuuvL+AfiJz6PaaQNAwUp8OPufWzoDnCsmhvlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5NmOYF07nCOrecj513GBaozm1+R/9n3DOv2VmELb5apQkbdrbroloSKhhswoYH0gBiF9Doz5azvypaAJNSUa1RHXfnjKpeYoxGmIq7DBynK4HHzrqxHIAYTrWlqaSmoNdaAa2oLSOSP4nP1naucQCIKAWNIKrOd/DzZ/cbkNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OW0EKDhF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW0EKDhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752065966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igovJW0pR7wb0Ds++Jg4wUlad2xwvqDXC6cO0WvsjHE=;
	b=OW0EKDhFCY++8bJ/eku4c9pg8TXHSbjB9DnM5FxzyvC3uRUwdFpTT8PVTd+AjeJrHR/p4P
	sDf0X8/4U1eGZgl7s6mLeBo/f89QSMklBZcSTdGETB0cHN4ke3sPv8Oqeb3ixN8LXthg66
	qMJDamRHeiIXsoMngtGMtzIvMjC1rwM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-15YqB1a4Mj6gZBCU8qLEdA-1; Wed, 09 Jul 2025 08:59:25 -0400
X-MC-Unique: 15YqB1a4Mj6gZBCU8qLEdA-1
X-Mimecast-MFC-AGG-ID: 15YqB1a4Mj6gZBCU8qLEdA_1752065965
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5316d00ecfcso1875740e0c.0
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 05:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065965; x=1752670765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igovJW0pR7wb0Ds++Jg4wUlad2xwvqDXC6cO0WvsjHE=;
        b=ULL5LC441ITHbMGGwz3Gu8wl39sK553Ad38lY5qpKCorRwx4KYufygUJ/WjyEe90Y1
         QPIZ1krRZJXCEw8aFvVaz4s7it8R+ZqCW9UB1bePbFQvLMeLTxId0cu9PVnpE98/WAau
         P9xa5HSG1I+4IDEbcoB2gvyZxTuGx5HEI98yO5QfKDoAOeD8rWqOXkx+q60rOBKwXv1K
         o6UonL9WtoNFy4pwK3GAox6iBDIW3K3hcVsvn21qI5+qSSFCRNDlrPk/pYCkLNGdnDm5
         RkcFuYWrjV6bH0RIxsF6EZ8IljRYpftauVKN5LQhakG2guwgIMgTSWYBOHt/fiVHJ3fM
         YBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXcUs07daFwKXujf5khC9F0a2H8Y85V2aT4ts/87oQVCbpZxyai/SwMDgsDHNMMLEZFMWVufRKRi4t91miXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzztmixiVR9fUCvCPtl1HBta5npbud0IG7+XwZ8xojpGKOnTJAm
	Wvt7SUcQ5wOmOBE+9ua/94lbBR97oVp0s3A2jwLNVzmh98xf1nAYNzbEDkIVDTuu9AcfEh0q1jX
	nA82yF3Uoxso07pUiIllBlFvowU5hQbdibp811iTvs9rkFmbXfCk+QUaO1ChknVDSdQWMKMVlF+
	Z/Amb3zIYnETn/HTcmckjGj6UsKRutnJnHGEY61ou74+o=
X-Gm-Gg: ASbGncutAl5DqkZM4znjIc/fY6pvkCJ2lGKuh3aeXXqc6Aiir+1Pw4PfLUOv2ArS+qZ
	Xdb1CXboNbeIrtGNGu3SlJYtAGfSZxhRghmbBhjh3gAMQun9+LNVNhWWyKK5lwQwlflSN8lWs69
	7JAg==
X-Received: by 2002:a05:6102:6209:10b0:4e7:b728:e34b with SMTP id ada2fe7eead31-4f54143a787mr1073866137.3.1752065964773;
        Wed, 09 Jul 2025 05:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX4oNLuBV03qQaDSqBipZYTD3634NeWRK7WfWEPjyluLD//GpT0gI0nJr14wq5fTCAzGpJfN9/8GLz7V46OeU=
X-Received: by 2002:a05:6102:6209:10b0:4e7:b728:e34b with SMTP id
 ada2fe7eead31-4f54143a787mr1073859137.3.1752065964492; Wed, 09 Jul 2025
 05:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
 <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
In-Reply-To: <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
From: Wenli Quan <wquan@redhat.com>
Date: Wed, 9 Jul 2025 20:59:13 +0800
X-Gm-Features: Ac12FXz-la9KqWF4kQRcXjTZuiR33OemUCz5dgkLQHQsatf71ew01jkuCn7CIIM
Message-ID: <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com>
Subject: Re: Host Crash when re-running vDPA device creation script after interruption
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: utTvvgXDu9Ry7bodNvgRtuuKSS-Drgi5mfPrZcxB_tg_1752065965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > I am reporting an issue where the host system crashes when re-running
> > a script that creates a vDPA device after interrupting its previous
> > execution. I am attaching the script for your analysis, as I am unsure
> > of the exact step causing the crash.
> >
> Thanks for catching this Wenli. We'll look into it.
>
> > # uname -r
> > 6.16.0-rc2
> > # sh vdpa-setup.sh  0000:b5:00.1 1
> > interrupted by pressing Ctrl+C
> Could you specify during which stage of the script do you interrupt it?

Interrupted after running for a few seconds.

I encountered the same crash on both the 6.16.0-rc2 kernel and the one
with the "[PATCH vhost] vdpa/mlx5: Fix release of uninitialized
resources on error path" applied.

Best regards
wenli

>
> > # sh vdpa-setup.sh  0000:b5:00.1 1
> > Then the host creatshed, please check the crash dump in attachment.
> >
>
> Thanks,
> Dragos
>

