Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AE364E92
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382710; cv=none; b=bGn6TkQaR7JAFc4hHH3b4llT0bbgk2bl4Fn/GNNowRtDSSONBiNqPq7yySFWQLU8SbmM4FJRPnm9KuIFeJeoR8+6kn5QdGqiip6JaP1ovSP3wyrFVIx41aVsIuslmc2zGsrttFdg8VdJDo/MVI0JsBJPBPrrvQOGbF2fDkirgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382710; c=relaxed/simple;
	bh=a7K1Vtv+M/1f5IYr5As7jmeWJ5MW5XWrjcFWBKeVOnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiqO2PNCaD1a2DvF1VTuHqriO6rQ9jBLQOiPGmXsq9mhb/DKblaNq6ly4ZNi/UKcidljuNs3lCp4+nERXl9oIPuOG7ZOUa0xkAl+YQNu9upae2RSTI8bsSC1TB0nl4e5obFrxfbMXstbZFGiXhLCl0tfvW9mcUE/eClo2ZzLRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfiH5wH6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfiH5wH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773382707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyTaVAhlozH7ysi6HEiPI7Jjaxd761LKKr6eVCbKn6U=;
	b=BfiH5wH6vbiCWDGVMJKfhyJp5tIe8FTFK77/Jf8mqKV+3NMzf6rn9f4ObmE8OzUq4VCPqG
	mfNCDzB7c9t0H47ya3XsTGS3REkCpfRjiQ185XE8uMjSWvfEj+21YsOxXP9vzl5+ciD6J2
	jXa9ftYL4+u33knqVRTyyk1qxb5VaIc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-hNAZqek9P5mtfT8COtyv6A-1; Fri, 13 Mar 2026 02:18:26 -0400
X-MC-Unique: hNAZqek9P5mtfT8COtyv6A-1
X-Mimecast-MFC-AGG-ID: hNAZqek9P5mtfT8COtyv6A_1773382706
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-359812e4fefso1867805a91.1
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382705; x=1773987505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QyTaVAhlozH7ysi6HEiPI7Jjaxd761LKKr6eVCbKn6U=;
        b=lju0YkC+GaHu5Y/p//G1FqWsKewl1g8eeBQlBy7KTEsOEnxGv2Wsq+KsUJj+ci61Ds
         4bDhVotnPr3urh4j9TI6bCtp980ogURQUe/jjL72A+aVNDby0wF2g5GLhwXLcQl72t4n
         RA0X/WWa2rBDajsZYndRLrtIQIHKyclAFmB5EAB1fGLoVLyZWqNFtcppjf3yoMtxi/dv
         PQdTq3ayMWwFxxdgyhut9jg56Rwf/qXrAVoolKj4/8GyNou3A81EphukGYnQlKKe/wyo
         h+xoYoGebinKO5/uf2rgZKwEB6K44U8ZMykLvj44QoRn9UP1Gr9q8/5fkL5pNZMot2AU
         W4ag==
X-Forwarded-Encrypted: i=1; AJvYcCWOC81jybqd1HF/pUSZMsfS99VvN0JW9wXXEst9Y2mfclCcO7F3AkZZVkE+HPE5k0T2b6y8aV3X92mYvJTwug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKYFqcF1Lt2RVlnwdDCVH5ZjPRbw3Kygf5m5iAtIPwkFGTB0y0
	jm8VI9hUQNRgrHBNzOBOXgoEv4NA9uyXoXVUgmbZdDFg2NxgtPBsJmuVc+InJraqtr11gmPl+fo
	/iRK7xn47SMeBXZKWP7BQgi9EBZOi35//k1XNIMOTb1D9Ujozml6Xgw/7QsLcVnFYHEY4qTRX6T
	ZJLaMGsBjX9IT3QQaM2juSI0DpaPsik4ez2SF4SZ6nrT4=
X-Gm-Gg: ATEYQzwaU18mqriAqnhPCd193mA28fYizV+mKSYxjnZIsjPKdES8KO4/emglu9oKUTx
	dXeBAZ26TrsTyJbI9wPWojKQ9xPPXpVIYA6aDI7SAkQ3e4JQDfUROrQaFksFR77Vsp3lJwUxt9U
	mv8KczxerLoHc/74IZQNSr+VQcaXE9OKC7rw1nZ/GXK5TXRPUcLgZkLkxaw3YB2TvfXXOXO2XLK
	e8=
X-Received: by 2002:a17:90b:1d92:b0:359:ff9f:916a with SMTP id 98e67ed59e1d1-35a11a06aeemr5281620a91.8.1773382705607;
        Thu, 12 Mar 2026 23:18:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1d92:b0:359:ff9f:916a with SMTP id
 98e67ed59e1d1-35a11a06aeemr5281602a91.8.1773382705246; Thu, 12 Mar 2026
 23:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAZVx9_Tq6afZJb-4pNKCwmB7xw=NZVCR8aSXM5N9+BbDdmTtg@mail.gmail.com>
In-Reply-To: <CAAZVx9_Tq6afZJb-4pNKCwmB7xw=NZVCR8aSXM5N9+BbDdmTtg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:18:14 +0800
X-Gm-Features: AaiRm53PdzsHn-Zro68I1g-QLJWPVJN8bggvdBE0Ax5DCNGF1gTdYn5pxhPFKTc
Message-ID: <CACGkMEvNgaRjsUjrW7PuTHrisBv0nH64SUbFYKMw4T-fia0GpQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: add kernel-doc for map and vmap members
To: John S <xaum.io@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32RSImhA-HdATgQ6H87q3jLRiOnrepvqe6Gt77UvcQ4_1773382706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 5:42=E2=80=AFAM John S <xaum.io@gmail.com> wrote:
>
> Document the map and vmap members of struct virtio_device that were
> added without kernel-doc descriptions.
>
> This fixes the following warnings when building with W=3D1:
>
>   include/linux/virtio.h: struct member 'map' not described in 'virtio_de=
vice'
>   include/linux/virtio.h: struct member 'vmap' not described in 'virtio_d=
evice'
>
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

