Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29325A625
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860317; cv=none; b=ZWhX538OiDYGAHKjRxJztJb01LAtmICGU5N6yCdfzRyMPO1L+KQB+AA/6gDO7KhraOvi0WLwc6B+gKynaUY/+h+UjlnUL/UXRMSTosQhzHa6xsrfAVOeflWqe18inWjnn3/SC1+/Y62g3OFzqBRZ5wwCe89y9q4jdA1konxzNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860317; c=relaxed/simple;
	bh=5EZI+GclKHIjsF4G2WIeh1ZGmWmiooX/yZgB5YiBNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhCH9bIugOgZsKy1Rq3GA9MGHtTgoIQ+r554kdhygWaUpeyHGS+ifSHVjvbEJvc/dH0yVh70hKvwDxbkKXVeQ2h77ZW3unALGHsh99EFv7quGiCATxRM7PmRw71eEPTQkc5m9N0L2lafmTEce5UuIhjAsDwshpEhA1S54CqtbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGfS9Tar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGfS9Tar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751860314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EZI+GclKHIjsF4G2WIeh1ZGmWmiooX/yZgB5YiBNiM=;
	b=FGfS9TarJ9GKf3tLQbC5nP4DEqhtMqm13Eg9HPE5URzfhhbXETAwGKctXTWuIH/A4CkHeD
	G+1+RBkUTSPppiJPfRaeEjQQsVl1X0ojTEgIyDPIE5JuL067EgVUMGbMAP76AA4YCd3KZi
	i++zo8xU5dZv547pyoD8C0ve+NIL9Qg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-IO-zLXDHPMmOd8eUzEi81A-1; Sun, 06 Jul 2025 23:51:53 -0400
X-MC-Unique: IO-zLXDHPMmOd8eUzEi81A-1
X-Mimecast-MFC-AGG-ID: IO-zLXDHPMmOd8eUzEi81A_1751860312
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso2058291b3a.2
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 20:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751860312; x=1752465112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EZI+GclKHIjsF4G2WIeh1ZGmWmiooX/yZgB5YiBNiM=;
        b=Kxiai5fbc3Yi4zwolFljXVgrYz/MvYp6qpKIF7n+f0T/KNymIWYsQE/CxQP4Xv4SFd
         PaP/fscTg98WbftSfgMPys5X/10WT62WQFo+dqq/TDnIyJndcUcE1rlvn7oXr621HJBb
         p9gsNvKkV/zhZ0OmUXqtHwHPILVZAfAU7U4NfLALAfngAkzc0aZFvQPJTq6uaYp5IuR7
         lT7rTUK5xjuK6E7CGjcvTG3tPlhVf1lGV9JskPmgM65J3gKLX2fNtMSLgIk77SUj1Fqh
         EQC0Hq+DEHNj2MBQvS1Ky7A7A6Js/YAo4l5yBpu+rrFhAram6ZbS/hVg2ZJ67Qd4kV1y
         1unw==
X-Forwarded-Encrypted: i=1; AJvYcCXsUez1xXitczHkHyYkbSkOYN89Yi4tM/Md2rh9SClo3yYUk+raeD4Jce6l6EN1bKkYs8qRitZZsZgYvmyCcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJsmILdkinWKol9Iba7QmXenaXm3I8EEH4eWGW+800MgEmNG+4
	SnmDVkaw4Yz90Mb1r+hL0B668tvnxh2aH7pZWugGuS4AAk4n5UyPVnBMeOE/xl2MwgHcSyrIDH4
	oLeX1FIme08SGqtaVI7cnNaQZToSepBX+XFfPz9mRvboPieAfW9tZym0sgBo9SBQZLsQRP2oP39
	iVQYCnHmxJVLajKT2zkNd8DJ3PjgmRzNsGcvkkCMjeQ+s=
X-Gm-Gg: ASbGncvmiBCiYe9LFrlXY92xHmiY74Q9jLHK9YwruyGtknVlRh8MNv6DuJkgC+DmzzB
	MkQT8LYnLWhR0QlR0kk17+HnxjbmiaLrLqkDs3bbyqMigKEpLoFKVaHxZQjRtFNPnP0lUQSAbR2
	gAwA0X
X-Received: by 2002:a05:6a20:939e:b0:216:1ea0:a526 with SMTP id adf61e73a8af0-2260c04c9d3mr18347322637.40.1751860312143;
        Sun, 06 Jul 2025 20:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFYuA1/SDv4DPAfRBP+N/dVZPXqJ7DNMQUuxoTwmIei5Gv5QAB/rrDAkSfUXI5du2gE7RHIZofQPd7Xgc1Iug=
X-Received: by 2002:a05:6a20:939e:b0:216:1ea0:a526 with SMTP id
 adf61e73a8af0-2260c04c9d3mr18347280637.40.1751860311651; Sun, 06 Jul 2025
 20:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250628183405.3979538-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250628183405.3979538-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:51:40 +0800
X-Gm-Features: Ac12FXxCOhDwwDbuNentETbGphcvFtPA7kSwG5_ttKgdEpYwjr11UVtKgtQBWUg
Message-ID: <CACGkMEs1m3guN=vgTKbSMyfP1SXZqTRcEqTrghwHA9VRPk9RAA@mail.gmail.com>
Subject: Re: [PATCH RESEND] vhost-scsi: Fix check for inline_sg_cnt exceeding
 preallocated limit
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: mst@redhat.com, michael.christie@oracle.com, pbonzini@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, darren.kenny@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOBR58H8bipCURa3uZqYoTQ5qWPRbGhZmEFDkD6s26I_1751860312
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:34=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> The condition comparing ret to VHOST_SCSI_PREALLOC_SGLS was incorrect,
> as ret holds the result of kstrtouint() (typically 0 on success),
> not the parsed value. Update the check to use cnt, which contains the
> actual user-provided value.
>
> prevents silently accepting values exceeding the maximum inline_sg_cnt.
>
> Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

