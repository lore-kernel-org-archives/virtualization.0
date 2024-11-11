Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780F158853
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314232; cv=none; b=QYKLP6sSSHmuDdIrK+wHsgVR0KhZHlE/ZcT4EuU+WYs7K8tZ4LGA67w65hYnBWSI2hoolg2n8WXXS6PPHNeonf/yfK6OInUjM5gm1j8u157Ybs9ZFi8o/H5pl7JBAR+lRjlKELfHcUxlL7sD8VklOry90vuMPPn4O2AosQ3r1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314232; c=relaxed/simple;
	bh=SSX2S4tLU3+tI1quOKFDgN4HoiaVYP+wrBKENYGKgI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A00lYDLzTQImzNYWesYRaXdrQVGX+F97hiyYcxeiR6jXhs9q0kdyFZ+9IU9cloG4yonp28gAJvH9ijz1baxnzSfrpUT3v9F/nb8MyeF+XRogGdfeU6T6K9T0svsWg0bjTjzx7jYjg6nmixAvr6urch/7v/hgvnRj6ZGlmx/h5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEYBnQ/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEYBnQ/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731314229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcpmht/nC/6Ldeh7ooxXZiHchbJtFHR1QbkXPfVWBzE=;
	b=KEYBnQ/ENkT0xudBEa8XEQYVLpP+eDjkFvXzS7YSe61/hrlYr2ATb1kvoMaKszSDolxlXr
	pbhbGm5qSEOKpKRqSSOxDAS/SNTCUa6m3bjGCOAGPJFfXGhl9MBKFSuo5xySmzIHq2TW0z
	Kb54+ivcRsw3gBDaWaqZ7Ymw6RcH4Zw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-TUFq6EtwOtan7loUDfE6eQ-1; Mon, 11 Nov 2024 03:37:05 -0500
X-MC-Unique: TUFq6EtwOtan7loUDfE6eQ-1
X-Mimecast-MFC-AGG-ID: TUFq6EtwOtan7loUDfE6eQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e9b1383da2so4041043a91.3
        for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 00:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314224; x=1731919024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcpmht/nC/6Ldeh7ooxXZiHchbJtFHR1QbkXPfVWBzE=;
        b=TrA4J0q58ZxkczBPVEiSAwJwxryTDR0zou15lkxx5ls7Rr16JH0aTGXxoG5Gm1UCst
         HFmsAHnVOhVmq3NksWeg1qxspV8E15hCZTvEahYlZmlIvhJk/qUq8mK78qjDI73wbV1E
         Z+LhzDQBkCaSPNIXTxMl5oWn0VgKGz3sVx8YFRR4If0CzSKpCHMb3rxT4F/eha/C4BOx
         pO892hpyyFBhEap1Jb9ppOMi6RwQSeTwCObG3qLNFs66jmtBkNgUF/mnWKt4+NHo31Sr
         eq77E3YvCIrGg/LYjefgBhiLpBp3vXPNIMnTv2TmWwpIM6hJJfhTP/bNltNtPMpfjv+g
         7VMg==
X-Forwarded-Encrypted: i=1; AJvYcCUQtO01vq8XlFUSTjiGsabZ9DNUhK5sy8GiRTMLjeEcxmFSdEwCXlfo9YBakRqb/CG2/SsYaiQks8IQfflMBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziBCReYfFn6I6P6f2OeeA9qlUTYoC0WPldEAtURlNnPnhdUlhI
	iEJjmt0GQbszd+RxK49nDY4dKLs3BrT/kSQKg0Rx8BMrTrhbUgsRRtmrr5GxN9MUUUboV8lvfMq
	NQarfQTWCo8vH2N7F4IeT1Zmh18GDZGLWsWlxkP04U3M729kb40Q1ywmZGk5NZGJo+6j6LJcq5w
	eXUtcOpR+cWS4dbUmqvXt676O2DiqGrykXmQTcYSI=
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e9b16ab979mr15603594a91.20.1731314223957;
        Mon, 11 Nov 2024 00:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkW8ZHgY8oLa66OOGt0FSKjysNNtKl/NkU5rD9hEEpLrZ1hrx/0G+1xyjW7t0R1U+85Oa0ZRTBG5IovF9dKoo=
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id
 98e67ed59e1d1-2e9b16ab979mr15603578a91.20.1731314223570; Mon, 11 Nov 2024
 00:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20241111022931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241111022931-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 16:36:52 +0800
Message-ID: <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jtIYSv2t5f7P7eQjU1-nyzAWC8d5GrGahb91C99I0Qs_1731314224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > There's no need to sync DMA for CPU on mapping errors. So this patch
> > skips the CPU sync in the error handling path of DMA mapping.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> DMA sync is idempotent.
> Extra work for slow path.  Why do we bother?

dma_map_sg() did this, since current virtio hack sg mappings to per
page mapping, we lose such optimization.

Actually the path is not necessarily slowpath in some setups like
swiotlb or VDUSE.

Thanks

