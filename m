Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A3188CDB
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974814; cv=none; b=fBI+MOQ6l7zxOGzeoWN2cUQQl/RkUXi+b5cnt9SiTR3uLnktH6V4ep4331Qjpt7GgU7HDZVqnfv8uxrJPW6vwG2gd71Ki8FqYhEDT/nvlpdhiOXButkWk71U+9ai6cZi8ReqEXa4CI6/ooHR8DHOOepwjCqJcCPQps7iszgiHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974814; c=relaxed/simple;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxmVMz9s4eEsFywVrE25DI0YeAXqTCTP1Q2YmXi8aJY8UzOtGaPhB/RrmplGGb8PU2k6am1wP2ptfRYzywDcEAfH3m+otKpxXKK9JfJ5vRTaZeNkfEnrshcK6766ma+0uKDPOOpcoUYUffamLCeYqyzmH0z+dsMcJPOdGfw4H4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc6u9pgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc6u9pgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740974811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	b=hc6u9pgwVV5NjNAHCrQzOlQyxCqeYVoR4Nsu4tHN5xGf1NVr+gQiFQwtTT6y18fwXFmZLw
	2zJNt+w+bCan+SDspVLgI8/p+5+26d6mJoz4XIrJoRGqPFfwUn+87h+zulJzzp3FyPc2c1
	fSiqT56bk3ByFFE0YdCFzCJQvX2NZ/U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-2FkHJsbcNx-tGGENJjfIOw-1; Sun, 02 Mar 2025 23:06:50 -0500
X-MC-Unique: 2FkHJsbcNx-tGGENJjfIOw-1
X-Mimecast-MFC-AGG-ID: 2FkHJsbcNx-tGGENJjfIOw_1740974809
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf78df3bbcso59837266b.3
        for <virtualization@lists.linux.dev>; Sun, 02 Mar 2025 20:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740974809; x=1741579609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
        b=SCkD9SEJe92rHg5seSJuWpoLRvncC4FLXOtMH9q3S/Jwf7zaPXTubPzbNfu/L5jE/C
         66YRLIrEl3J+PxmDBib7g1qidEbM4j40tItkeH+eU2C/2Q01LjM5hy+JIPaPJnlLYjsN
         ohEUWPj8R7fttzJQuLwrtQV5ckMYXqpgPLItfO65ONwtqoPaS9y7wV+VK3nK7+I3cJ2J
         FUgq519Ns3g0/bcUBwv/RH1GRLR9cy2qWKFwTN3RDnGoW523me9rymlbY+zt9AMTBFVG
         2Pa7FoNtSNiKsrajr9gWH795jUbAnhWewj0LetxeDFeMKGXQ3ziDfgXITW+fsNPP0aTS
         BMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCe2r7S+ywHA3wfCjEtDWkI8GWX5fDAbMf5ijTSYGkpyap4T0vEDl29W+4bNpc2HhQv8XjAZX0vPRfO4CvDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW9aqmIQ6TiGF4kDH5MhYIXOI4fT7EHi4oOzha2sYuZuiizT4E
	sI7PEJ3/663KmIlQU7JmBivcaAJ7m5hIEJTCEXBmMeSiATO6yFRgppoiy1t4VrS9OzVU3bWLzDd
	kdo1Q+8IRuZGiDQtFp9jlof0HWzGGU55BbyWheKWKaPF5kDjjV03JaV2mpACsZnRQ3E0h7wi04b
	ndAlQWK9zIZnK8iMDepikKl1HqryQKUWtKT6m5SiQ=
X-Gm-Gg: ASbGnctCcr7wUYA9btM1+jSkIvxdTv+gd3ycC6AMmRiZbbNlNl6u9osTJ0AdpVwjBNo
	Axqnxiu+Pvfi/Abcq6tonOtUtlAvGH0cpSGScTIc13mN27RQ2wZsQGdqywUY4Omf7UcCLa/1Rcw
	==
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id a640c23a62f3a-abf7a26c67fmr190821266b.50.1740974809384;
        Sun, 02 Mar 2025 20:06:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmtrdRGgr7U86+kr7f7l+xUDJuXUAyByaCCPcM629oXjBKkXRBVGvEXjN66jpswo1w8JgxuIRD6C81df5Lbfo=
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id
 a640c23a62f3a-abf7a26c67fmr190819866b.50.1740974809047; Sun, 02 Mar 2025
 20:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com> <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
In-Reply-To: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:06:11 +0800
X-Gm-Features: AQ5f1JqUG0YYBVOhwWGb6YuP75KRc_vcIL7Lh2pD9dN004pjvXLXIThnUsVJvbs
Message-ID: <CAPpAL=zfKkWD8BVio__qHezhs-UDht6rq7mp6Rn5Z-tQG8RW6w@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Cong Meng <cong.meng@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ilE8FZToiB4UmtBciPiQBZjOYFLdZiBZTiXDEtbvU-Y_1740974809
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net and mlx5 vdpa regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 21, 2025 at 9:13=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> >
> > create_user_mr() has correct code to count the number of null keys
> > used to fill in a hole for the memory map. However, fill_indir()
> > does not follow the same to cap the range up to the 1GB limit
> > correspondingly. Fill in more null keys for the gaps in between,
> > so that null keys are correctly populated.
> >
> > Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> > Cc: stable@vger.kernel.org
> > Reported-by: Cong Meng <cong.meng@oracle.com>
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>

