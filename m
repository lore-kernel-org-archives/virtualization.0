Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED81509A0
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717796; cv=none; b=pzLgsF1IKg42JKCBij1+VRK0yyuQPoexdeMDONJChL7vc7KGA+MgkzVTXPoltnZgxCWG3cWGJhXlPt1qmKv1LBjiIJr101clOVjxTShp1jWAETtC+mw1EviyVmeFx+XQesSotBlZSMOgYiSBN45g6Ju/SxrPrfFpJR0Eh0RMLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717796; c=relaxed/simple;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7+6uQWmBmq6zRUN5q485FBDIHgWWTpf8uvdDkZB4TdADRZknr1r7SNsaqV8De3CskYoool36eOICYdkP0K6aqyhdTbPA/ixFD5JYwtJF+LEXydNnU/Wxal1qFgEOqRbHoWMqSXooonQKlXQTVBSbYkExeenzaNziJOG5yzdHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtSbdefn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtSbdefn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
	b=PtSbdefnu9UH02yhsvHlbfjeiyqG3WsRKPWxZbilyCMkYzB8FmToWbhjhpjtNLtMRHcAkS
	Qzo7/sV02f154kgtpNiyEyXXMTs6q1ab/1DU3uj9zYO1AAzxd3eckDjyTThRfCP7ntOd/D
	heYxYak4hvt4GFa0Wg1PRZdlsxG8SSE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-jy5vtTlKOnuMDj4QcbK-ZQ-1; Wed, 16 Jul 2025 22:03:13 -0400
X-MC-Unique: jy5vtTlKOnuMDj4QcbK-ZQ-1
X-Mimecast-MFC-AGG-ID: jy5vtTlKOnuMDj4QcbK-ZQ_1752717792
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so621423a91.2
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 19:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717792; x=1753322592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk+vMLXGoyUcWn2gdQ0TtZDnbeL6g7uxU6L7y4/AI3A=;
        b=A3ZDHoKXLY7KKD0bhow/h2FJj+9DCe5HHt485M5TAMUGdPPKJ1L+tRKUifqfJqcXy4
         X4E7M9FYV2e6z6GHxIMFbkmXvqvgHapFE7poPyWXwAuLZFe/2VdqVTWhILxUwoPUyo5H
         DsJ+T42XRhsnzij+a+SObf4YdKqTd6cTKg+gF19bZTdtGrrzy1ZwDXKUOHAzJ3hyueOk
         nWXDZus+zmLYhQmJLXTs+15ItAGAJdAuIDW6CVhSnISjGDed1FkWOV27aAPiYDB4HuVz
         HCp4PwASe4ZE4chZwRSdjHdXasLXrhnKJ5aDj5Q/YeQ7qft5PFau6pvtZstN7GTx2O55
         ObHw==
X-Forwarded-Encrypted: i=1; AJvYcCWm/Fe/4dd+u6Y4uewf+vPBjzNvdLF3dwGZf7u4HS9MLzqpPthWQDAHFR/awFm6Mw6eYCMEaxkaoPEVZdrpZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTlbNf2gumLUkUjWTG961zV4dF2Szklof8+8BOYD1WJEQyTYYv
	uFPnUqKoXwKVMNm1w4BC3kz67IjrGTbg37cydIzwr/pmesPbxHQit0+g3WQfjNSvboi/5GPTcUW
	eIhhjIOhwqQuxjWnPsrUh4QjcvG5f4LwNq1W6Ppq9QTyOn/ScQlcmxnxSive1WJH1Q13anpamki
	qlCjeGiYbwbU/UKrdc78FmS2gew72zARIUdeIt9n/kk1U=
X-Gm-Gg: ASbGncuf7rYIOLd29k+E/9dL4A72bYL0r8qT/QJDunAIB31O0qyMPYuDapzroN0xuke
	77x0gwhGT2z87GuI2x2wYqSl9lXIJRIZgxeD/DsR8bqRWaBMUZavwD06KTLsOLvyd/dqvjzUJ/U
	exmCIgoyJ/e1DCtyuNl9CF
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr6022346a91.27.1752717791906;
        Wed, 16 Jul 2025 19:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPKGtWTF3J+7pKYaN1LISu1DbprEzZA/aztw/7OAnQNJPFUO3gk780cKvvzbWsO46X8xOSSRM1m2KLbEldd7Y=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-31c9f43747emr6022312a91.27.1752717791421; Wed, 16 Jul 2025
 19:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com> <20250716170406.637e01f5@kernel.org>
In-Reply-To: <20250716170406.637e01f5@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:03:00 +0800
X-Gm-Features: Ac12FXyE_9vIZMY_ERg2TY_jtWvI4UypN_DhHze9LSPtUt7pnoEDW84dnljw5VE
Message-ID: <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GmeX7L6okHjYCapNK_Zvh1EMrxsfVOfYUEGequ5H4qY_1752717792
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > feature is designed to improve the performance of the virtio ring by
> > optimizing descriptor processing.
> >
> > Benchmarks show a notable improvement. Please see patch 3 for details.
>
> You tagged these as net-next but just to be clear -- these don't apply
> for us in the current form.
>

Will rebase and send a new version.

Thanks

