Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7457081F
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502300; cv=none; b=GYiVaHAtJVaWTNz5g25LLrT+UVc7bYhenAjMDSHaLWRbCeV8iVTr7gW0K0f6UJwxsmmCo2eCUDRv7YqwT78YOsgxkuqbGb0Uqtjf7yY7bgeiD20nZ0KB33CbJ8Yf6itM0ms5k53abK5ppug0zXjjVhs3g+mFDFZTpEQ25RiiidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502300; c=relaxed/simple;
	bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsghNjh7VG4GqtjCeIvqti6x+uq3mCuJWLJZKSxYKZYVXCF2NOwlBkQoS5/i26tZHr8DwU+G+v8eFfW4or5Z3NBXQMzDTIO67hnNPXOyTNpbMXrRdw6T6Mrs8fVvSJoLpn1GlEMre0L5bBYSr7QrqMXJT0Hjs2I1Of43RZoDMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdpMtCzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdpMtCzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
	b=AdpMtCzuVwXaEKjY9tH4V220PZk7xvjf1ctxPBqW7+ci8GThyVVrVraaQbWVw131sJIwhR
	0c/In8o64+gwo1+ZwaMHdorGWREITyaHkYh24rb6ZLI179sLNdzEIm/H+dAeY5y5Wej57v
	vQHDrDt9SQ/ZXxDx1YeHhSsnYYopFwc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-6mGYb8tKOe2_yR_G8aeoqA-1; Sun, 21 Sep 2025 20:51:34 -0400
X-MC-Unique: 6mGYb8tKOe2_yR_G8aeoqA-1
X-Mimecast-MFC-AGG-ID: 6mGYb8tKOe2_yR_G8aeoqA_1758502293
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso4468187a91.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502293; x=1759107093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8SykSU3lPdLjvpiYnlAUhi5iNYVQF1x129DI9Omo3E=;
        b=iERoR7JUBDLoV9rGPkpPD992XyX/OjbjPdlujfU6HDBMkWP5oXcZ1y4PIE1e/9Xkab
         hWPe47ZmeJz3osqGT94//E3RryaKRyL8jFjb10VuftJEeGaJR5ND7BTxR2rN/T2zgiAK
         q8kp5NQZ1X74CR5ZSnnIgP1tTrCssfRn+SKP0yxkMqAHEbqeSfO470PTuIAFmzgBFqfI
         8LhtHuRtokn9Bsf9hjghC7Lq50VAvOICf6SSNQ/XkXdf95TNP/GUFdqQ/HRFC5vUooAx
         APFK2G8Ib9YbF/z9L9ysqA+R7L0yMlKZodTjUwYZk/mv6cXDhsUr45PYQHJSGWGrhsNR
         D1xw==
X-Forwarded-Encrypted: i=1; AJvYcCU3xx1QQztmu48TrZ2QUPjIutyUzyH7DQlQq2gvGzI6EJV3RjhbzO2B5o0oJe4uq/y3vGfQqJKQzVVA3U1LBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh94gmgelzb5QgnGSOw/nOV3O5v6nSV/viyNoTjYIYIg81m5M8
	/xNlCO57v/LHIjCr+pIRuPeldQC3whigMQy168sJFVw/QuhmgiZEHR9aCNEYe0wOJ7vRqVAM/Wz
	59dwiVBRBAIuCLeT4rq/yPyTphya0KgaZ9JgGuhKA85k4isqXArF0YLpu0i8HmKjDsKr8SwhFFr
	9AwYFhyAIoCkC3VqxH6yFuvY7F5qFkHJQ6vnEnXrMp+UE=
X-Gm-Gg: ASbGnct4eCvuNxqVmh8J1MJyjgcdoMd1gQwv/suYeyM05FlKcV9tloTTq2ySpLOEKnY
	iSfM9aN1fKprbIfocQxJ1PEIbhdYN3nqlGsmF8/MTyfk5f7pttirwxshf8JbJtdqurLLWc0QMce
	OPaNaAuB/lXA6huv6vPoXJCw==
X-Received: by 2002:a17:90b:5585:b0:32b:8582:34be with SMTP id 98e67ed59e1d1-33097ff8745mr12323827a91.13.1758502293183;
        Sun, 21 Sep 2025 17:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmPZ+UCXWP9ATTeYvrzC84/XjGYdnilWnlBNRFnXGo6v3f7HDJUGzqyEe1RfF03zBJ35TmhW0n+fWbmX49p60=
X-Received: by 2002:a17:90b:5585:b0:32b:8582:34be with SMTP id
 98e67ed59e1d1-33097ff8745mr12323813a91.13.1758502292864; Sun, 21 Sep 2025
 17:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-8-jasowang@redhat.com>
 <20250921134504-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134504-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:51:21 +0800
X-Gm-Features: AS18NWDmFIyEOZnaarbLoyCKXQe5TDpfrHph2NR2KgwbgMUxuUxt6mV4iAQXhtY
Message-ID: <CACGkMEu83s0d2UdQL+PT7yT+P2K54F7Q1B7bjotkTjbN_ChqFA@mail.gmail.com>
Subject: Re: [PATCH V6 07/19] virtio: switch to use vring_virtqueue for
 virtqueue_add variants
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjVHBR8FRYxARUviKMpNFwtinw6IVAYOsztVsKYOk1s_1758502293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:42PM +0800, Jason Wang wrote:
> > Those variants are used internally so let's switch to use
> > vring_virtqueue as parameter to be consistent with other internal
> > virtqueue helpers.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> This one actually switches virtqueue_get_buf variants.
>
> Previous one is for virtqueue_add
>

Exactly, let me fix it.

Thanks

