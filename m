Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DAC13D
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735784321; cv=none; b=eAt/k4WwM+TRPBtKfTGyPuTHh8pyaneG09O9PTzhZcH0Cnm+xsopcV77EHk8aiZc7bOCmMfegydayRC03TlPCeTVSK2ue2SmxTAvt/3nfiioYPX94oWIIJ7v9Y//fDOBeVtd4ekfo86AzA6mJXCoQRFXZ89UXSKTroBx1NR2wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735784321; c=relaxed/simple;
	bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0/2+kvz3LaZChEwk7E2bUHTvi30Aq3mL9zYxWptXaHRB9ihrLgGcsurnu6sewZ0ezWNYTEeYmcr3m1oD1AJKVB1amWAK8mb/m+os0z/AM3d71yvm1fTpdSlZlyZtbKn9/LRytGb2BmsHu09ph+lqmoxfknn8SDomXko3AWY97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlnnJvCk; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlnnJvCk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1092B40382
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 02:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UexzrCYqbFzD for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jan 2025 02:18:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 206614015E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 206614015E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NlnnJvCk
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 206614015E
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735784316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
	b=NlnnJvCk9A0Crq6AcAZBXcjPWLcKYvLyF09YW9WqvRcie/n9So7Kk/HSIp6xS4e7SEXvrZ
	4nEg02waXXA5aGaZlUre3+B9VKJvNPLCfPEkJ8te0UwJ3HNBC3uLtheZihTPMX8btXHrgt
	Y0ug0PGBvMz5wkdGXNyLS6meI0sj3hQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-3O2FilRjO-CS8i3qlAi19w-1; Wed, 01 Jan 2025 21:18:35 -0500
X-MC-Unique: 3O2FilRjO-CS8i3qlAi19w-1
X-Mimecast-MFC-AGG-ID: 3O2FilRjO-CS8i3qlAi19w
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef79403c5eso22681998a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Jan 2025 18:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735784314; x=1736389114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC5FSatEYmo6AysA4Ou0OTIMnH1qy7C/SgrN1QAj3ZM=;
        b=CKNSMu6a+rf9+rJdhrGi3IX7PIrSjP17m5SShx2UcLYWoL2rI0bzQn/q70c8I6eaBX
         5T32kK42/yxfsIM/nBiwAIpuE0gLO9X+7CjOLY7On0WiSweaxktlS8jVONQF9q70+UFq
         sDql1lvGd97lt+FvWOeDUUqSBRi8r/oi4A4M2sCYWR2wBJbY6KxI7ISJRyJ+rDlP1+I0
         UUm6+C+mcmdjTcBK/hzg9g/SaYk22y0DSKYGdrXJxqucvM1TBoxufTIrjvjp41hGzOcA
         ezW0v8NYRFGPn26yxhK2FYm+V5al5muN7NdR3f/fyD6w8WKqWuRZ2D9riHKgp4iJYt5g
         ya7w==
X-Forwarded-Encrypted: i=1; AJvYcCWRhGs//V6CLtDn4IreHFUpMpeJA6Bl/8hI5K5KPtGwzTzCmw8Xid1yduYlYweTzoAtU1CIwZWv25rWMdogdQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwFVNCum/jxcc4TTJdEo2WiWKR0nDefadkpiteEfsfYDQT5rRCb
	Wqrvsu8sSvSZ43bvZ0IJ+ouzYfs733xGDMfiivkhzWjVFjETlbpmY9Y0I6wm6hcoTruwkGrgxho
	hL7pdkWo5Qk9OassKV0ylhFZAlOXTMRKZjn2oZs5lIUz0Sp+TgEgPod3mZ1CmISz0tMpdnKLxGJ
	Dmo6xkm36ye8CZ1LKSdZUdbwrBf3cra+jIYVSTQkFeTMEU+IJ9zp3gYQ==
X-Gm-Gg: ASbGnct3NLcendxUMfw2BKrGehDID3BQQ1AOtZ451eCfl/igQx8SnwokV5gays/eaAA
	88q9hxwwxQZymIkd9Y7vZ77meOxoJKxuYFxmpkEQ=
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72abdeb6e80mr64384026b3a.21.1735784313837;
        Wed, 01 Jan 2025 18:18:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTDDT70rbUh8ytd2/vFAmFqT3HYe901ZEXvYhNUOvpAQ4SUsh1N+XXsejGmZK3cY/fZF7jnk8eegPa1zVpxJs=
X-Received: by 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-72abdeb6e80mr64383992b3a.21.1735784313301; Wed, 01 Jan 2025
 18:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-2-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 10:18:21 +0800
Message-ID: <CACGkMEt9c+KPuLTUA4YG84_ejo00NC8MH3LMXcTz6pXxABRNYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _HwutmrLbUyPOwS4npysTjUoby6KmyYdLzSyPUeFdzc_1735784314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner
> thread. While this aligns with containerization principles, it confuses
> some legacy userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

