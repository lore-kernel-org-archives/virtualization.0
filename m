Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095F298987
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830950; cv=none; b=RBlWz+rjvERgS5bjdBcdt1BJiWNmj5oJ8C+Q9fLRUPcENhZRDffYn1x8pdvq5W0HuGcO5QVfPEiJFrfBkbieMVY8xGuPrYtISlzXCZgGEzpm8P6p5QSq0/K9MSz8n5VF3vmhm938mMGiE3INmDHkYYpmkicxoBaX4NPK9Yjdmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830950; c=relaxed/simple;
	bh=NJ0Inq+EJxJ9/UEpmnKshMkhVVdcmrY6gWjwzOebM2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkdfKbSFKesnU3g111P/YjIjsh98xjeP+cBQP3lqajjutzZ5YGJHsMe2AgueL0Gu8GT04uiGeRSUFDEnZRsq/f0qIsiq43Xgbkc0l5QgfJCzniqAFp5oTVfchI9WgdfjHteYjd5b9GS6JcIKmJ9a6vrhB7qG52WkiUdLOQIfkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYrSkbwH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYrSkbwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJ0Inq+EJxJ9/UEpmnKshMkhVVdcmrY6gWjwzOebM2Q=;
	b=RYrSkbwHOeSWvNjLoFmAdSP3mYuSXOuKnxEilm5yACQ2M3WrS8o9f0FGlw7UNvN/Uf2iWG
	T8o9t0/lF97i4Hf2j9T9aoN88fLTag3BAtjK3SUCenfwEwnJ+kg8Ag062SiGqepil+PwSx
	+sLJ7myOJWLC/JuStv04W0pMT2p3DN0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-oyz3l1LJOfqoaAkmDgfa5Q-1; Fri, 18 Jul 2025 05:29:06 -0400
X-MC-Unique: oyz3l1LJOfqoaAkmDgfa5Q-1
X-Mimecast-MFC-AGG-ID: oyz3l1LJOfqoaAkmDgfa5Q_1752830945
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso2016651a91.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830945; x=1753435745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ0Inq+EJxJ9/UEpmnKshMkhVVdcmrY6gWjwzOebM2Q=;
        b=nXoryti1e/D/0cDxLVpLFi00SD8HBt0QoR559CDzrPvOjnyThp1YtmwXvep+9XKDls
         diUGmbkm/JULZuxDzwBdfVtJxyxJkHCV/EMZ1VImWtEodHtIl8lug5ST/ZlCWRfOvKic
         f3bD5n4Vnb/jry87fPfspkf2JpViGi0VgGzRYwpgly8NrYfJkvocBpm2ISssIJHnwYio
         JhlfhhMJuHkdGHhffrgmncCceg27/TD/PmdrPqRLiPdTIljvWOgecq790g28GjPGlvtJ
         4zTL3ShUbqC1ssi8/adA+/aehL4GrjhLMVyoqBHGmLsKG+Ej7/FynflLiIHh3YEXaQil
         TMaw==
X-Forwarded-Encrypted: i=1; AJvYcCVEctpQWdT/253JjYwLwItDqgKMfruLkXNaiZjQJofPyvdeTKuFsAGR7OjxdGjOQlLohKwXfhfc9vcJ9TdYkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeWHueh04B+SjGFUoUvN6ud5/TKHfGANV7oaTKq8QpAD3Ae7Ri
	RZ6+jN5lknIyfXUlFctSKetVxxWRTv+AcPHfvlpvZAvxQazQQZmFLjjihf0Kz3L/qxsZvl69hvO
	TBXJGsAe+uscEDUpiCYVMXiNyFuYXtf9R8Lr1k+k9h0XiSHgYwKr4v/8SapQ10kZzpSh5Lwufxo
	cUQhY6Clhd6mr6oV7ZSian3PoH3YgUilEbDi4RjIfXL+8=
X-Gm-Gg: ASbGncv22D6/08xRnwMTInDz0P0J/myyMLBK5l7I/CR6yBROguHgN4lDcPOHo1ffNcd
	HeozRkBFO2lz7zqj6zJ87Du+vMc8VeCIRJVX3YVaKex0ecWXS5/SSV17fJcrbhpFuIA9zibj99S
	3gxky0cH5gOep2e0PILi0=
X-Received: by 2002:a17:90b:57c4:b0:31c:15c8:4c86 with SMTP id 98e67ed59e1d1-31caeba7182mr9501736a91.14.1752830945411;
        Fri, 18 Jul 2025 02:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4XMUJS5nImpHr1OvwSc9FyqsTLAwRNCWYLchkR4GMoHwWll/OCX5gzgPLrrRdaRFMhUBoRrqWLsQVuXq8dVw=
X-Received: by 2002:a17:90b:57c4:b0:31c:15c8:4c86 with SMTP id
 98e67ed59e1d1-31caeba7182mr9501701a91.14.1752830945007; Fri, 18 Jul 2025
 02:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-2-jasowang@redhat.com>
 <20250718052707-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250718052707-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 17:28:53 +0800
X-Gm-Features: Ac12FXyA5pjO2PqiXm4yy00iFRnphDwnOWOSPyCQnz30JDd8r4Tvr0-C-E2G6os
Message-ID: <CACGkMEtbWu2VEQ5FXJ54TvbND4e-dgwn067NrYyoUODOGX=jUw@mail.gmail.com>
Subject: Re: [PATCH V4 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B5W6xSPK7EcmDfo29LPLn5mhhSyCAwUjU-IMTlwXh6I_1752830945
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 18, 2025 at 05:16:08PM +0800, Jason Wang wrote:
> > This patch consities virtqueue point for DMA helpers.
>
> point -> pointer

I'm sorry I miss this.

Did I need to repost?

Thanks

