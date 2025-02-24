Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E31C84AB
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362214; cv=none; b=eTFBXmsjE2FaLL3DrUh2Amwova4mM79FBdAeKqPk1rXYIHWOIdj2hICg98l/6vjB+BPn77RIs0tZfhYYJhRlY4vxcDMY3KgLQhAiZgDr2fxrQcrWuliTc3wK1k7IaAb4RJE4EHVuDTwDx1qfgPOCnN3MDJfpxoQJiyQmpmQVG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362214; c=relaxed/simple;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htSpapOlFpwivwStn8nLI//kdDBnBQugztNRyyh+umZX8DRarkcu8K9Hg1q0u4Gy845FRGek+3yhnnQT92Yp74yfozt7lnGLp/KGYP4n8gOJeX6EjV/0kT6+htebg8SB9vOv/Yy+GXbso9BHV/7RHxaU+TFQCM+rI+28lE2TZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amZ9AZyt; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amZ9AZyt"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9A30404D4
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hpmj-f_rb-x9 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:56:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 330B94039A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 330B94039A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=amZ9AZyt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 330B94039A
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
	b=amZ9AZytZvfph+ELQfPyTBvsQxQ6AFaNOzFbP/z/BZWF+bd6kQkFTTKxmfiIPqT3rvIWeS
	Ak/IrEM3PxU3jlbbthdqSuRmACnxMuJgWXWdGgORiSU6mSFk4t61R3Fs+6NdbQ0yN7fPoi
	k4/MGc5KaT0ykR5eeGPJPgDhLGO9X6Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-DIl-_fS0NJa-Qlq_gzfviw-1; Sun, 23 Feb 2025 20:56:48 -0500
X-MC-Unique: DIl-_fS0NJa-Qlq_gzfviw-1
X-Mimecast-MFC-AGG-ID: DIl-_fS0NJa-Qlq_gzfviw_1740362207
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc45101191so7615124a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362207; x=1740967007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph9e6jXUOHtZqZ/sNNJYjaIfG6bADSRZTI8XfhufIIc=;
        b=Ri7n8WDfzOX77FWMfI9lBpC5IupVOU1HALsEN54Y0YSlw4fINnz8kkichcvrl9tdNg
         g2e+pbxLuJ3UYkISCelg0rxMFdqiuqCAPUjuRhlvcjDF2aAhV6t5X3BkKuHQDqSO0sFL
         ycGyqTGcSZafa2CntqV5vOfDkjwbpzg/R1Nz22k+k3A5hw01HM3DNb9TcWL+2ubLhZbp
         gd/b22WJZFq32vMg+ym4ZOV6DxKPnI2gTaQ6/CMMNAXvC7Nlj2V0+aOKw9r30yBZngvn
         JtZxGmra4zqMVztQIyZ1Sqt7E7DD+vflyC0r9TUEL90PEpxuQCBacSXF7XgK3RDUEyOh
         TY6w==
X-Forwarded-Encrypted: i=1; AJvYcCXF8f5rbOl7fy6NnfURYQnhjMOygtS8FPHXjyAYAZXfi4sOS51EOTK6f3Se3RFBDOL2Qm4JqIPwYJjmFIJbzg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxRbV5dVfGu/IcR7ijl829mN44iBxVCBi+HKVTbHIfBCSKsxAMV
	Q50WAFsVbJ32KHcoFId8VG74gnmaBBlJ1aa2jdzfz8KYozdWoa0Qge5aNyFBk6o1NMDwZc051Y9
	WU6Xm8U1gTmpb9DfGfeT7gRxMVUvsNF6JW6V/AUhJ8w+4qLE9IrVtZ4ZaLX3C+4T0Hw1fzlF92p
	sTU0JmlIHfFWCaI/iyvXeueV9pUEhyAsH9flCoHXg2rFJ+xCU5k2amaQ==
X-Gm-Gg: ASbGncvRfZ1yrwggHdEYZjsNkrKmy+CPKLkYv1xhHgBJ7qjGoqhSaO3Vc/2N7REvvSo
	IIjRaQ4ydnZ0ZWbaeROIr7prEvzPLH72ozb6M6Gewp6VjGyl4/hI362LjvNaSD4OH8aRCG1+reg
	==
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-2fce78b778cmr19847390a91.15.1740362207077;
        Sun, 23 Feb 2025 17:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK9sEU4lgBSITBL7R7PIYPYfLCTP2jbN12H8uxVsQOHPrTrgk0YL/YWTUrigbXbtwUKlN+8N0guiwDqc1+JHc=
X-Received: by 2002:a17:90b:2241:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-2fce78b778cmr19847371a91.15.1740362206706; Sun, 23 Feb 2025
 17:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-7-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-7-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:56:34 +0800
X-Gm-Features: AWEUYZl6ERtQHmg9Ng-G9gBzggonYtkd5NQ0JEzUKKMbmNT88IJbeaW3-Ohq2ks
Message-ID: <CACGkMEvf-WEuFUH7FwyM9w9Ay8qkz0edL3MHfGJa3CPkrzfm0g@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] vhost: Add check for inherit_owner status
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndpWIUIvwXLA7KSod2r1JwdpwBe68I5U1w_nMD8SPaA_1740362207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The VHOST_NEW_WORKER requires the inherit_owner
> setting to be true. So we need to add a check for this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

