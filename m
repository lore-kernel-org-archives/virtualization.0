Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D974157493
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017187; cv=none; b=Yz05rgfUuTFw+39s0dKu3pjdB1rsck5SfFkkRzCQhqofewE4WH4RB8zsS30BpBk41ifT8cuix2WQNVVei9vMP+kXfBXYHxK8gdGcyAqHlNBsZ4fllzwouTyPd6tQBExRKKKPo7HSPtRnyrMUB4NdTrzLB6XfRg8crERbrpU8PiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017187; c=relaxed/simple;
	bh=MPF/Ey3TyRjTHTzyJm3pQx5+0XCF+lFgrotF5uwgNQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcAUkcoL3MDSjIHzjsaaKkRwhVwxGqZ5vR9bjK0X9YfCq9g6cgJm8TwCo+0XnpW3xTXgfvtzFI1j/38p1b2QWcKVY/CS2SfZ+vwPEG05JaLx/rw4UfviVSo/Wh12X2ZN45N1qV2QeC0LPXtS60pVEBX0c2UyDLskUM/JOhPGiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCqx+NBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCqx+NBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXOs7k/gBscCMNZg5w7Zfi5dcZ0lMld0rz1Q4bQ9caU=;
	b=MCqx+NBtUsLkOQSa+5Fpujb9vfEp7Ck8JXdE2pgqz5UXwRCABLc/KxS7aTfyqBSeusM5qL
	QZxdSydAZxiLooL7eNzefDvLWuO+ZmM3UNCY7Y23TT4jEArdHcuKrpUTDr3Cp63AFxsw9w
	EZznNa5MYwyUkmthaOFOC1o+YY24vSE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-rXgo3Bg4MK-rsrXVd3vw3Q-1; Mon, 20 Oct 2025 23:26:23 -0400
X-MC-Unique: rXgo3Bg4MK-rsrXVd3vw3Q-1
X-Mimecast-MFC-AGG-ID: rXgo3Bg4MK-rsrXVd3vw3Q_1761017182
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33d75897745so6132227a91.0
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017182; x=1761621982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXOs7k/gBscCMNZg5w7Zfi5dcZ0lMld0rz1Q4bQ9caU=;
        b=ZjHMAt+81IRm/CaZ4fOaWJ6W8W4xeBDVE7Lk7I7Nk4GJtJQySvH80c8SXUrPwQGZl6
         rceMRj9qGb19O0BS68vEp61z8bjlSlH9pb0b3usaj97tfDhZ09V07jD8ivCpaOPqvLw2
         /uOkBg6azgvLk6TIFkGgs+73/Md4yZ0vOFFicqZEizo2QFUCPyTbpDJZzUzqwhugXgR4
         /ppDbBMivxFNXoXegJD5AFqx3Amr80nFh8vgXYN7AcUOszkihREQcOrIp7XRMAn1rtsv
         4qBfzBEmsl0QAArIt7QkraFWQwE8B9s594VLYACW/uDk9/wI0jRIhhP8ujdu1hgkwWRT
         H2eg==
X-Forwarded-Encrypted: i=1; AJvYcCV7lP4wD57BFi3PcNxgfmCEId2+NZOi0JSTk+vXOYoilr78CJ/jpGfv2PQO8D+8m3QX1qTSAZ5GxvsseOyuSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSEllTtINdAeLfJ1ONO6qXZXklsisIWerTqTZGxqIi2hcS1nZC
	Z9oK1+ner0qDradbY1cELNx/lUmNm/NSGF+ivY3znxlphY0CzNu5frohBiDhQZ5AHrT7dcsJVyQ
	u+ztjcj55rn30APX9NXF21g6zU1az0nphWnsSK4chs181xxGW/KpxgQz11SJk9M4Mkj5DKAHfGF
	I30oaB0yD3Jl4wtotRlfWGFZg6GPesrRkmPIncBGdEv/k=
X-Gm-Gg: ASbGncuz/w4BVUbVrTMvm/0VG1SXVRYfkVkDdQYddqtdyUB7ikqieqoslYjMdIvN/EN
	naDvzuwiQA1nIwjbqw1bvyKEPVMuj++h55jzt1yn5K1xkWkA+aSAtYTlKKC145gSxxIXlhpbDYR
	kaveg4vrEvabQxpUmU8ouVmhBtt+sMAPWOzlplTAvXoKgN+sI0kGBdDxT6
X-Received: by 2002:a17:90b:48c6:b0:330:6edd:9cf with SMTP id 98e67ed59e1d1-33bcf8ec5f7mr20369575a91.22.1761017182166;
        Mon, 20 Oct 2025 20:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZKjKUosphMmTC5NGxKeaI/AWGeDGAfI2v+IJ7wS3K0M76VQ3znMf34ZJYMevrVYlCwdEGul2tYd9w2byMVk=
X-Received: by 2002:a17:90b:48c6:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-33bcf8ec5f7mr20369545a91.22.1761017181775; Mon, 20 Oct 2025
 20:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-20-jasowang@redhat.com>
 <20251020061049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020061049-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:26:09 +0800
X-Gm-Features: AS18NWBnOxL87jmSdCbGI7Dz8sxNnbV2200Q0-rpsbUFyxlvS8QgpsrmMmWe02g
Message-ID: <CACGkMEsqqOAS2cZsMr7GptvLbqvnZzHzQeB_amXL0ZmRNBZEsQ@mail.gmail.com>
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UrKh1r39slyN-NCO8lucpVR-h9KwgWHlGYA8JEso6oU_1761017182
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> > @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
> >  struct vring_virtqueue;
> >
> >  struct virtqueue_ops {
> > -     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +     int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
> >                  unsigned int total_sg, unsigned int out_sgs,
> >                  unsigned int in_sgs, void *data,
> >                  void *ctx, bool premapped, gfp_t gfp);
>
> BTW this should really be part of 13/19, not here.
>

Right. Fixed.

Thanks

> --
> MST
>

