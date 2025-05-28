Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DE2441B8
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416251; cv=none; b=bmDcZ69q3wtJN8ucA/uW8hOUPiIvbylKDJHYFGcEjtU5N5CKF6hVDjdGul4RNB3FKU7S73kAyI0B98DJ5aHrzZHGWz6CSUpl+xzicVSYOwitjVUWFz4lPX6VJCoAs4XbBWMAz3RjW4Dt+8Pz4hbTEHZTH8XnigJGPLitPp2cfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416251; c=relaxed/simple;
	bh=xJQPB2jy1v7zTbPkh6FR3Feggx+J19/Zgl2VfQfYFmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlFlJ9EoMAqi7Kr8GyOqISBjfn5GPLNzDl0XbWJ5oEZeOav7pY7/zJBcsL4NZ7TZwIcKg9vKQqPr67Y0xll03sBaOXfVmjxvktHTshZQ4lku1Npw7X8/+KI2ayHiPyy3s3DZUii6Htep6VE4y2M73pH7SlqRBQQ8EbsSjMB6g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhbfL5RL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhbfL5RL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748416248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssZ9dBa9v+HNDbUH5Jeunvi9xbhwLoe63txxouNgBgo=;
	b=dhbfL5RLeBJu/r3EwTXGdWyYny4zQux79QQHIxELhFyfNvyNL5rRX0OPFV6NB+hATY/vSg
	gQIIwsWa8zf5kE6jTwkkTOj9Ox1kCuvawp4ay6PdaeWWSlT2jf05HmLpORZM54jX7tunRE
	tRFzk/nMqSq5jmWwU8d+wzPZMOdHZgs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-m2Z_OXQVP1Wd42AO3yek6w-1; Wed, 28 May 2025 03:10:46 -0400
X-MC-Unique: m2Z_OXQVP1Wd42AO3yek6w-1
X-Mimecast-MFC-AGG-ID: m2Z_OXQVP1Wd42AO3yek6w_1748416245
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-604607bb62bso2292822a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 00:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416245; x=1749021045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssZ9dBa9v+HNDbUH5Jeunvi9xbhwLoe63txxouNgBgo=;
        b=DV2wA1kGLPOq9OVT3sFkJ8dEvnDCQqEX9FUI3pmzX+Vg++Gr8BT5MTyogFdPjxHg+t
         IJFDEEBw18+7yGHD90nBUl+NJmuCLucKcMlBmpWrv4ztYPz/w+i40+Hxfy7bo3c+5F34
         TQi7ml2UNSHbb/gBDTKGYxHcRXtSFVO6A0AYuH0lmm4U6OtwgZCNtFvq/xCaxwcwa9f/
         RwK5aa+Z52XJdhFD/1z5pb2HcBETLQfs/tBKErCvbRtUenqt5nM+YLWehH/3edr8Ia96
         f0dN7nJWtP2SkRkiVZVZE0xYE3ILTn4aOHUrsUqpuW5MwtJV2ly1IBpuVn8HAmoTpyPX
         muKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQfUeIsA5Ho4Y/ZZpCZc9ADwsAxH6fXclyaMMBp3U3eisfhYoTyXErC4I1nRz4WyyrmtekK/EZy6V14Zgkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza9zvOg4MQsJIsptS3myMRo9F7J5MGKRRto5OgEGdnlGq1Zo1O
	5BT3UwktHGV3FJ3qRXJThmABguX/tVRaj8/3fHTnFOU1BBkFJCbSrecdRfK1oxue5cW6m40Oa6x
	oYcO7w3shU1OtGakfXbv9WyEgSlPNIsSxFgm/e+0F17KdYURY6IA9Quq4vzzlQs1byjquXF/OAc
	D6mTGe3xAHlUHCWcvAR1tz5HvpO0Ku6spXGX125NOW7wM=
X-Gm-Gg: ASbGncv3BGS79RL6aL78geMxlVQz4iTJ15FNTaLPEN1B8DPqFdF41O9x9ACmg6WFWoS
	Ohxdk9FdFojUL9+USZZmTSIu1hiR5Mi5SQ1rOUt4bbXCVMac0MxV2lkpFi+/UhzsBJ6Fb
X-Received: by 2002:a05:6402:26c6:b0:601:96b8:afe0 with SMTP id 4fb4d7f45d1cf-602da2fefabmr11888264a12.23.1748416245452;
        Wed, 28 May 2025 00:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhePeWEVZFOz+kI3JlZIyc3qnBTWbWKY31bwy6WgdYOBXQx5QKLLmHYdASVWDKNw5R6TVEFe3x2F1cl46tYTk=
X-Received: by 2002:a05:6402:26c6:b0:601:96b8:afe0 with SMTP id
 4fb4d7f45d1cf-602da2fefabmr11888240a12.23.1748416245102; Wed, 28 May 2025
 00:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250528064234.12228-1-jasowang@redhat.com>
In-Reply-To: <20250528064234.12228-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 28 May 2025 09:10:06 +0200
X-Gm-Features: AX0GCFvrQcz0mEYQCyDO34FgjW8CGt8vHecpgrGd5CfDkSoAIVHfSNiJO934Pvs
Message-ID: <CAJaqyWd=L75X6umxBzOd1SYfk1vTbBcPMTSmxJZQZ9kMMsbrXg@mail.gmail.com>
Subject: Re: [PATCH V2 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zu5I3Y3PZ3qpHyGlkK_f6Hv_j6zb8OC9bSOu8czvacA_1748416245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:42=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
>
> Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
> testpmd on the host.
>
> Changes since V1:
>
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
>
> Please review.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Thanks
>
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
>  1 file changed, 684 insertions(+), 212 deletions(-)
>
> --
> 2.31.1
>
>

