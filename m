Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B61DB122
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160226; cv=none; b=bwefPK2w9flqa4x5oLpDQqb9M3iV4ill53Esgy5PiEcP5s1C117HTHE4RTvgW3sLmprdr9iN6R0rtN4uipiq1CFgO1k9kicObcgL/HcsjU2CFalGIHI7sCfsmanpvb6xzgf7US5GQbC52QXwd+0RzSHH+eXUf9sj2o3iCfOdBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160226; c=relaxed/simple;
	bh=aBUkfhqkF2FXz15At5kVICUeq3RCC8St33BmVukZh1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPaDZQTEa4zOlqtHOeqPNDZlPrAhNPwJNiOfxvsXg4sEv6sqrNxouXMBhxUKtCl660A2EE8Cfmo6YrGnTaDUy35TtxhWGZMhMsCkeNIi3NdXc4tE1pHBb5YOHopD1wH9HlAk86+huaCAUeSdFj1cyiimanErWLaacnMGHzv5IXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cu244VOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cu244VOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9ahUxVvaQvnC1KWhSfaBgnolNJznlfPGP3pBByVDSI=;
	b=cu244VOvg/oMoo1XutSOKPLWIaj7vrYwBuceLyjht9xj+8Kt3lJ6Jsx3klUkebiulEIsSX
	qa1eDnM21uA0SKIOgpi0GE/0iMyrhus10nQiVjTEBjWxscagycCzDt4w+2t702oGSsRpFy
	H4CaWLt+1ufbBXqg1YTrureXNvXo4nE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-7al4rSc0Ocmyoqy-4cNBpw-1; Sat, 11 Oct 2025 01:23:42 -0400
X-MC-Unique: 7al4rSc0Ocmyoqy-4cNBpw-1
X-Mimecast-MFC-AGG-ID: 7al4rSc0Ocmyoqy-4cNBpw_1760160221
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc3aso8590513a91.2
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160220; x=1760765020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9ahUxVvaQvnC1KWhSfaBgnolNJznlfPGP3pBByVDSI=;
        b=a8ZX9C/vpbWP6LQR6xyRH3E7DOJqDPAt/K0BAiBlnNe9qXH11z9CDlsUQNnihUa8Qw
         xj4j+klHnJZhdZUtR6gvNKYjenJ5a41HqaI9kPbahLKiNya92nOIarXTUmv19Apf93Az
         rxgxCNLT/fgsveRSCISCUZmA/wa8waCi4xr82WJ/uUGx6jSPzpKtGxDZWPuMYbim9t0V
         atan7+i5CbqWfTUa93usMa277Q8geLRhNH3KveuDK6rmx9tuUDg0gapoc6bz1wikynA5
         jVsYIyh4gjrtTCuXmdjeAJCkVj5zkkkVQAJHJ9Yikr7FVOEbjgzO8QJhpY/Nvew+L0QX
         3ZXw==
X-Forwarded-Encrypted: i=1; AJvYcCV1txWJLFwhZFcPVLEYwSMwhwMCHgjme1FHQdHsDRaraTjFr40ATf4t0ezbQwIawiOGIdYURKHrxZpKilmjfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLDSlZa3+aubPxucNJ81dO4gzpGTXp5c7R5mBB+dg0JvB6SaPd
	ZXIZbP2Cj8P5pjRL0VzCRiV70TMoznBg+S3xg/wC+fiobMN9wjxk8dAxO9/kR0lDUSSHJ8sa1j0
	bLmZE2+87OjKEXyvNfKwaU1kuUz/ThiLTmDlWvsRnl808q4Kx5v2kd+28YTvZPPCOSnHUXQXJO0
	ZxR5ZM++m6nkaSchKGVN9D07n6Kk9WSThpUg2psS+PIDiG7y1D8JQSjw==
X-Gm-Gg: ASbGncva5JUPzwrhtpRGSqDn6zu3RZBOmyT4jUjWJLO9Q3SsSi5jRnWyMLRmUxZp7oo
	aKQ/hSfAFZQoOWDLKeimC7yQuJ3TJg50CUu9Dx8UXH8yFfQfd0OrPb54YTEflEo4oGeD1aZLz9x
	e83ZdBzWX4EE14uNHheg==
X-Received: by 2002:a17:90b:1a8b:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-33b513cedb2mr21265573a91.27.1760160220584;
        Fri, 10 Oct 2025 22:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFonCugrV0VWZfxEOqbKyiNBN0Y+G9ui5Cqzo9BO6/5qduENO1T0u6bZI6SMfTGTGPNpK2gG70HnWCCu3OI+Jk=
X-Received: by 2002:a17:90b:1a8b:b0:32b:9750:10e4 with SMTP id
 98e67ed59e1d1-33b513cedb2mr21265548a91.27.1760160220195; Fri, 10 Oct 2025
 22:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-7-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:26 +0800
X-Gm-Features: AS18NWDkZxBAjbaahFJoQUZlewfFY7UAdVcjPczSWxQOvLNedkYLahq0gmAyrDA
Message-ID: <CACGkMEuXNt2XL4yEu_5NPM4YskpqHCRXRm7bDjppJsBV4WMVRw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pv1L3F9xdPYFZAPM2CBw6XY9DTylJR9MliJn_QS7tfA_1760160221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:59=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v7:
> * Take write lock in the error path (Jason).
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

