Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53315B97D
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062319; cv=none; b=WxtV1MCxK3xxDHa3abOWT6S3/J7lF2YTKDJZbp7mtMQ6MbwsNQo7Yl/MjW/EbSrdSCPY09k1YvqCw3qkRafJ7xA/EHasBuiaj8nlM4eiTuMI6S03qQrJjQMIyXmy0+/IJ4XOsxTh6eiJ3Iy7JbNo3f6Pv4OgM8QNCcCwbYBatyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062319; c=relaxed/simple;
	bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBHHo1WwfDVe8+5azIwJWFY0+n3ez5nnGFCWb40J9zTfiwk4sg8TpQbz7qEbFNUf8SjK+DzWJ+gBaR6SQA7VdtDKGNDe2OG2QaKcT2CuI92BtyVLUkuQCiM0rLHyjXPeJ1Vz6T5rg8hGCBBtQEiEh7depKKgGH2eZXQg5QteWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHcIK352; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHcIK352"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
	b=VHcIK352jzB78mJSquQc+8UiFzfGCeyWhZn35WuUlzCwOONl7L2whq0vfPj+y8FT9/z2xo
	dq5VGgPzx5Qw+6UJmmJDwmv+1+rk64FrMJk+4OBXy2Cc+AdyVz201GrIsOcejB1TvgYQaV
	62WkXHacxSehvSeJKhiqQ4LQjylHv3I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-cgQIzTi3N--HE5cfFNE0HA-1; Thu, 12 Dec 2024 22:54:42 -0500
X-MC-Unique: cgQIzTi3N--HE5cfFNE0HA-1
X-Mimecast-MFC-AGG-ID: cgQIzTi3N--HE5cfFNE0HA
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7f80959f894so2088605a12.1
        for <virtualization@lists.linux.dev>; Thu, 12 Dec 2024 19:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062081; x=1734666881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L49LIDBnPtAmFf9YVbV95zViPnHl/I9PqKvrSf2KzA=;
        b=R8CwmF5YJhCoF6Pqr+SyynFcnfC6+h6I7RKr12odefTr1MEo+FvcyGpHKNLhPiXa6s
         IqJRsoCveJIO5ZtRyZG8BXzclN4x9v0jdy9iGIKdA6vv44mGpfHv9bBeBIpPlTYa+Iof
         2rfZYAFapHqejQyQbgyt0JfVED60lETpPlMWvAB6iWfJ/ie+bkBIH4ZnDvYXGpcd8UXC
         Lw+saj9djKVe1rW5m059x1wfEZfNqU5QlPULWWpFcNQHwpa/JM4g1KjEMtnIDgJzbPLA
         cSA/cZEUYURA5v5NNIdsLVggH3F/8M/wwXukM8ERzMyPTIfIbkwFKVacH4tYJny0Qdw0
         RZ8g==
X-Gm-Message-State: AOJu0YyqlVmHy643JzUs7/e0ndGNmWabu2V+YgSHJhaW4MajmbU/rg34
	XL1WksRiesPy3eHAtLPWud8C6IY8vlt6kotoJ8NCKETdEZl/LqBLIucgJIjgrFa4S0qTdUSLuLW
	PODfAw0vtuOyIWweH5EzU7FsZUcPeIZfEwlY7AatyfEalU+dZT6dB/N4a4/GJEqBb11X0RNEtS7
	qnLAet5Q7tMzL4KaD7yxMmrpEGWXK7/Q8Whjbw23Q=
X-Gm-Gg: ASbGncvCzr9PFInAkowWi2JuPUu3Xui/zZJ1PULzTgCVXT/PDzj4oZun2xCXccz4jAF
	EKCvPUuFi1KWkPUEOZfcWppwChSrzpOOIKbzsz+Y=
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f29153af6bmr1438491a91.2.1734062081247;
        Thu, 12 Dec 2024 19:54:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8woS+FSzGPbZaXG/65WstiqgVlj19rVJ9CgQq5B6jZDC+MUUXTBy8QYoodj0m1qywxCN3pvydmNyh0wUIz2o=
X-Received: by 2002:a17:90b:1c03:b0:2ee:9229:e4bd with SMTP id
 98e67ed59e1d1-2f29153af6bmr1438465a91.2.1734062080857; Thu, 12 Dec 2024
 19:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-1-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:54:29 +0800
Message-ID: <CACGkMEv5fNRPebMWpUSjdPtxn100egGT0bikYe2=P14Rwy9JFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BRmITfhcNVRSARKCujcxkXQBT7glTdlXaJ0KI9vX7dM_1734062081
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

