Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4E2E7F08
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074811; cv=none; b=oShn9waoEzVUXiSUKh/DEUd4ubqXJnRjsf8FcQ9IzADsQOFbWgQZpptWFke1y6J9ix+4lZ+RcDYPshk86+hj0OvSiSK5UUYWncQFPk7JAZ5PXva7Sq4jeCf1zlviC9DAKD5LU3YnW5H8Mye3OTrupDiKZVq4Jc5MF0f4ruLWX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074811; c=relaxed/simple;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xscyxqw/bNuJJlQ6i6OmcpCmLC7awuphBKlEbXFYWTLwCJDVbNLVxKFAylYbTj2jBOTr7D1w0Ke91dMV9krRQiHsJoUmMQUX/xQ/T/mPNrdnieiivk2q7vURl+mvmedlEMpAfa1IQmsppY+viIxjat8nrLHdRA39nDUaZRVrr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7S94nnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7S94nnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752074809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	b=e7S94nnEGpSrKl0vjipYKF8SDOGfV4owufizDIvNlO0d3nq4F1+J3Q9rnuJfIZuz0PrlyQ
	V22Dsxm68Y6EPeZ5O1wcwnFTSje6dmk/5Vfje/3vpvVLhnkqh4zvF2yIH797UUrsCxVbLQ
	zd+vH/cbGBw0euLrC2d4pwUdrrRi4bE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-CEUkKmxgNJWjJxc7KNiQVg-1; Wed, 09 Jul 2025 11:26:48 -0400
X-MC-Unique: CEUkKmxgNJWjJxc7KNiQVg-1
X-Mimecast-MFC-AGG-ID: CEUkKmxgNJWjJxc7KNiQVg_1752074807
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e2d495194so304047b3.3
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 08:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074807; x=1752679607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
        b=P2pdSBajvnX19UvFhGkZ5Znb/XDKHt+RGWroMB714nXNwGHEsySr9VlinfoWGM72Zz
         9s1ncj/KBwiD02oEXF7qIvkVCW721+/B64h+DFfl4nJfu+epntcLmcS2jtZHBJWm19H8
         wjqBr0/2F7UVwwJ6QfSnHOonYkqChvp4OXvKA8NNW/Z8Ad92sHCmuXV8KWRfEjvkYuEF
         buyXn9feVzI/0LSMdt/pso+RgAV8QWKyGZx2m1FQLBTcla8OSSDfiqlksZKW01A5wWAJ
         Lyf4Y2yxPcznV3Z/vqOgfHrxmycMvUBd5u8Taoz9t0bxaux5YV/znpoXvBYPXPDPIvR3
         paQA==
X-Forwarded-Encrypted: i=1; AJvYcCUmrsfZkUAyZIMg2xdJujjMFcxk9nJvJI04MGdgYePgi6zyxoKJn8jqGlP28cvIJhA/JL0fcJN14QRim4NtfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPTUZ6ydwvYssZkcKuVi09dyHDM8yD0SeP9eUUNDm8G2sOStls
	rYZsX5bt3hb8O954oOJ+JoXeZW+260A+ERDVgc4M5vXY2lcExSmm8X6ylToI3dvuz6IhjT2leoL
	vkLUHMp/QPlDEZ32Y2mWDl65NhxwoQR5ZcvXvSo955vUWVr5tVVv/giT2uh0EmFIO91+ZsKtbVF
	MRmMKlFlfh5hRktZM6aIeZtZS/gcbYgZKal9pliSNSX1o=
X-Gm-Gg: ASbGncu7uZ31exj/R0omHgfAQK4R+fCljy9GMtIgXfHF6rIeQa9VCrRqGmqVBiLXFmh
	6UpxKaRbk8FjZcUmos4Pgx5MsP80Dt6CLXBoB1zAfQJzgdGKeeJ7uguYzp1pfpKxWSEHLC6f7Ml
	sHfhLv
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id 00721157ae682-717b1696280mr41605177b3.10.1752074807155;
        Wed, 09 Jul 2025 08:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oyUbfKLC5sveWj0ptirc82cNeL70EgaNkak6GlzIurDedMJZY/972EbTHi8rpQ5YCU07IRWEQOOiaTHdLVE=
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id
 00721157ae682-717b1696280mr41604877b3.10.1752074806659; Wed, 09 Jul 2025
 08:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:26:35 +0200
X-Gm-Features: Ac12FXyNj6u4xw4GpaDSraC2WH1PFh63NMAa2Sk2WZqN1f1LqOBvccFzhXYQrfM
Message-ID: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJfuaPSuP-fLxJFNYnP3-NeaFzw89JknjtpjiI55MKE_1752074807
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> null-ptr-deref" test. Here is how it appears to happen:
>
> test_stream_transport_change_client() spins for 2s and sends 70K+
> CONTROL_CONTINUE messages to the "control" socket.
>
> test_stream_transport_change_server() spins calling accept() because it
> keeps receiving CONTROL_CONTINUE.
>
> When the client exits, the server has received just under 1K of those
> 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> exited, so accept() never returns and the server never exits.
>

Yep, I saw exactly the same issue while testing a new test.
I already sent a fix:
https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/

Please, send a T-b/R-b on that if you can.

Stefano

