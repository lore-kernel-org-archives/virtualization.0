Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F219006B
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863757; cv=none; b=eKsPx5sZzNncJSKytcM6NFg125gBe6nV4Rk0qc52Smpqx9HUeUWMRW+jjeX6uOtvivTPwEePbq/YIvqsSwkKXgm/aDQKlHhZjiE5w766haMd1WotQhhiUf1db1KdyLD8Iv/u9ZRkBxd5xMMPFISqWFds0et2jtTTi1NXyt/TCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863757; c=relaxed/simple;
	bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flkHzHcQ0ckikLc3VkvKZPkv2Ux1e1IhG5Cq0h18EvGeueNku1hcN6HnMOVH+kdypyTFtAkMgE0K3+hCsui1PibxqAn1FC1ih02OaP0xBZDhe89h3pua2/h+5nHOv7NzG2OnWKUuR8/JUN0IICo0x1WirGZOYmm0U6iMUdqAiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlxPspo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlxPspo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730863753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
	b=TlxPspo5t4LqbSEECOEVfG5QXE3ImxWyLseUtUqy1uYxho8Coi9hSQjoggCZwTdi9e8wYs
	4JOtCOVXqwjSYqSJpjpdjBEv28ru6oC40rDZUYxr7dm/oDBlV/tEFqe+RFYHkeE6cLBqz+
	3AR24KYu92HHloVtxdzuuZ66KGvdN9k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-7mNS_9OKOUW0Jg5fgBIlkA-1; Tue, 05 Nov 2024 22:29:12 -0500
X-MC-Unique: 7mNS_9OKOUW0Jg5fgBIlkA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e7858820eso8007934b3a.2
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 19:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730863751; x=1731468551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
        b=fL/97fklYnkW9xNT8QZIBwMN9tY3yk7OxpTrvb8i04WXB5AZkeAM4nKijdqjHn1AM1
         F/nrJ7nGNm6uD2bmrnFAxsa/QbvBFmvcNserUJ63WCz3n8Qh3dwvg3Wnl1vqXxlQycaf
         RpzQrnMwWNt6zMH4pZKM3ZeQJYvDipNRQUwxKUJwYq5kpHK4FoGe7u6sE6cVcWqwkylW
         ERt1D/nf+gCvW4Do1ksuWcGRICXPfgxNtZL/nxvAe5LGu9Q5PmvgqDhRfGdKA+4oXQ1B
         KnhYLQ7FdZ8UIY70GGA79Xtu674fB4OSnDsnuw3ZFrDwDPxeoNCCLrS5oDR+iEm9ksaZ
         e01Q==
X-Gm-Message-State: AOJu0Yy+pEi4BX44XJJYPRPx01Eg5cjgLCNiapLCGrdXrdrsD4e75+vg
	wqbKI6djKCUApa96quogINAt7q43JxBGM4Hm9MQIu5jFuLd6IrXHdqfUab4cJrSQ2mEtwDYx6kW
	9K4Lp24bCE7ocqVX0x33TlQkEigGlcxqqCTDKY3IrX0QXUimLglDAOR/9PBHRN5m3KwSatTzO2T
	S53iWTHCNfDrsAgpUNpNtzq/xAZJ+FSQJyJwCsia8=
X-Received: by 2002:a05:6a21:6d95:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1dbe0d7d5a5mr11226477637.13.1730863751266;
        Tue, 05 Nov 2024 19:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx61FBBG5j53znRiOsXbThjFE8yVx8cJX3fGJ5TJniNqc/KssM4f1OUImXXv2t+j7CgZ/mWxaKbxS+WYdiaFY=
X-Received: by 2002:a05:6a21:6d95:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1dbe0d7d5a5mr11226463637.13.1730863750851; Tue, 05 Nov 2024
 19:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Nov 2024 11:28:59 +0800
Message-ID: <CACGkMEuYswywBX6P9GQEd4nz179RoCn6TZCseiCprm5iqRW3XQ@mail.gmail.com>
Subject: Re: [PATCH V3] vp_vdpa: fix id_table array not null terminated error
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>
Cc: virtualization@lists.linux.dev, stable@vger.kernel.org, mst@redhat.com, 
	parav@nvidia.com, Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:35=E2=80=AFPM Xiaoguang Wang <lege.wang@jaguarmicr=
o.com> wrote:
>
> Allocate one extra virtio_device_id as null terminator, otherwise
> vdpa_mgmtdev_get_classes() may iterate multiple times and visit
> undefined memory.
>
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Cc: stable@vger.kernel.org
> Suggested-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

