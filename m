Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76D16CD33
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520442; cv=none; b=lz6FZYY3W62+u2Onk/JntjMt3wDg5jZuuG7U11klD7YXZPWbeTz4bDDBf053zf1dS4m92FVW/+6swx8xdf7SDq+TARG3UQsfoFnIKqDLRz+YSrBqJYxXbeXdODhv1AChrqhFzgdXeKmfyvA48FnGkhhRmLYIhZzkwyL+Q9xryUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520442; c=relaxed/simple;
	bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9/wcSP11fHy++xr5fA31Ti6/CaF9j8ubprIhCyO9nLbXKTZGSD0dwav3dtGNCMl76gGMjI52H/Rsb6cqGd1AGYwc/bNvKmZ0Za0n6CflaiwjrLSm7MiA+OJIk61AFDFx0vQpkS+vpkjQsSRlpnGUQioDEkzM00ZCQ90ssYtm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4ggjYGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4ggjYGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772520440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
	b=I4ggjYGnPK80gRLD4RutQxbQqfBgi7axjlkKw14NMjKxYBxVxwn282W3s/j6WuVUPRFPZK
	AWmEaVyZ+1+PQsuAg8YPS9yKzpEw/gl2cAINkH4DLWjGf6F/Y0L8eIfdjq6R4+kUPs5Z+S
	HhJix4Jei82iVmx9HnDS9LjZPVtSS48=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-JkT6gBlGNlGYzSNRdChssA-1; Tue, 03 Mar 2026 01:47:18 -0500
X-MC-Unique: JkT6gBlGNlGYzSNRdChssA-1
X-Mimecast-MFC-AGG-ID: JkT6gBlGNlGYzSNRdChssA_1772520438
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3598733bec0so12808460a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 22:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772520437; x=1773125237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
        b=u8WJxzTTNNsu4skCWMWArj3NaXWwJMSxmip+dZG1h+KTEiOBrq/k7It82yR4vyx6rs
         42OZ0bJag2w218w5SGaUk38EvjToGm0a/Zjs9sygCMU4+gBoFs75hjOIP8Hhx+DsbLaZ
         Vu4xWUsegcIGypmMw50uFWx4PBAzU5GxtRMmYENOp/FfV50+TtPNqQ4rzRe3mpS+m6Az
         fN+N3yqOzM4ig+2ppZQQ66AScX/9DIUSTVmp7pc4iBPxEuz3h3dpNT9NTvIxth8bS0Y2
         UKbbAN2ordOHxiutJTXZ26b8VRzR5Ui2WDM7wSPbEI87uacxjgvAeaKbHOQ0RDo4eFP4
         Yseg==
X-Forwarded-Encrypted: i=1; AJvYcCWyC13OUdq9GoB5CCVrqHLYUOl77iEfW/WSSrqFR7vIqpi5AK0kroVdDDY6RlszbmY4Y5EF27OYBYjpCSlZAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4AWlBXlX8i7uZkz/ztGvj0GcEqa58FuwH268+Xy1MeBo4T+6V
	VpsfrFALajYmyI2WKAunKCt1qlkAF0jWLtHqShVbWxTKv4cZ8WulFu0v6OG2I/OH0LLPr3pZf6O
	fgXGqRc/EHnC+ddH1QV6wQ86k5oug40xTFCJSfBBYkzntFp7cSnJ129nEG9PsIbVwfSZ5yZBk/x
	NRfD9407Qwhsbf6PWiJWowlWR7OjBQLh5BkqmvimAwCUg=
X-Gm-Gg: ATEYQzxK74emoV3NvK261gpMOBNNeZ83pQlqo4o5V75nP9WhzCWGcGwvfSvxozcUAEk
	2dwteIXCSygLoOSWJwzp56Ahf4RvMAUu47lytoCOfifeZViI6d8s+7ZNMaV4dj6cxZ1JDR1aS1C
	vcQsYhQCtPYwetQmY4bVIvPFXTB4enmDCNezxISETAroaU5Pwh4qFJ8LBHmmfXX4GLtyyC53IJt
	w4Uwqvz
X-Received: by 2002:a17:90a:dfce:b0:356:3cfd:3ee1 with SMTP id 98e67ed59e1d1-35965ceae6emr13314994a91.23.1772520437651;
        Mon, 02 Mar 2026 22:47:17 -0800 (PST)
X-Received: by 2002:a17:90a:dfce:b0:356:3cfd:3ee1 with SMTP id
 98e67ed59e1d1-35965ceae6emr13314963a91.23.1772520437210; Mon, 02 Mar 2026
 22:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226152924.38790-1-evg28bur@yandex.ru>
In-Reply-To: <20260226152924.38790-1-evg28bur@yandex.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 14:47:05 +0800
X-Gm-Features: AaiRm53kGlh2Awdy28xoiAuCbe7shyoxelpKNPYu-3mpDcUBtvJikJBhEZg_LaM
Message-ID: <CACGkMEtt39WgBDgAGFG9pSJe4t-vRL-0EELA3zs1dEZ7euu0bg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lingshan.zhu@kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EWplnsjlPlqb3TdcEoW4kjIaCDe_Ykyk6SD9XfSLIQ4_1772520438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 11:36=E2=80=AFPM Evgenii Burenchev <evg28bur@yandex=
.ru> wrote:
>
> dev_set_name() may fail and return an error, but its return value
> is currently ignored and overwritten by _vdpa_register_device().
>
> Abort device creation if dev_set_name() fails and release the
> device reference to avoid continuing with an improperly initialized
> struct device.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

