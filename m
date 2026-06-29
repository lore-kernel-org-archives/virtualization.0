Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8763AE6FC
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724183; cv=none; b=A4S6IEiKn7u/cNfEAyNFDMYzlCKjb+J5IybvHvFn6WwYXJMqIpEfDXk0qcS63DFNHRfQo+YzQhev7OopsyFxsA44qtQG8AC6m1vHfPGQEwRo8vPAIE24gByxfT9FcRgay0fi2dmfGfOHkhGCwHD9trdb2SwKANw/Rnd5xKfHzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724183; c=relaxed/simple;
	bh=DO2hy3VaEELpIe1xk2Qt4w/uJ2K5R5ZnILb/Ih20kAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKw7IovpnO1CQ8SpsNHeQ5x0/Sk5AgSdP069m/w5TvWBZqxhrenuTCH/QXPQqkJLiGKMNmlJTxROEOcqa9XGIbrqe7XGRVCMKNnEssZRVi1FSHqcYWicbhUJAQdvfzjexE9zEpa3+y4vSDgDRCHC7bDhCI7KC+AqqBYpX5dn3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YipubIwU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YipubIwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782724180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pd8r9rCcJi49nZQiw9Z6HNd8xI6UP5ito/Ie4AKM6YQ=;
	b=YipubIwUpP0LCTDvjwlSUdcoeoz4kE8TaRKo9V23tJrsg0RJ3lM4N86q4Vu0EYjcb3g8LL
	ZjFBJeatjpq+RxYoFnS2uul/K4mjyWt65XAZuA3e7R7iAdLLAJ+xxPyEISwvhR9Y9+lmGo
	Snu01SmhcfRK9ro67lZxpBwqPFsFBVI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-05CxeZ-8MOy4fGXDuX4OUQ-1; Mon, 29 Jun 2026 05:09:39 -0400
X-MC-Unique: 05CxeZ-8MOy4fGXDuX4OUQ-1
X-Mimecast-MFC-AGG-ID: 05CxeZ-8MOy4fGXDuX4OUQ_1782724178
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664a090b4dcso4333809d50.3
        for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 02:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724178; x=1783328978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd8r9rCcJi49nZQiw9Z6HNd8xI6UP5ito/Ie4AKM6YQ=;
        b=R54bSdENLTHP5NkEYnhJ8/9vq3FpP78oE5y60qkTvYIbBeU8qb5DnaSG1geEO+4Xcy
         J1skAzo5rs9StZ+QqW+PoYolEJ/8zIGUvO7UlhLyerFQboioSqkk0mGuLw9yddVkOUgX
         VBjwPZsO0NxON4swJNOHZ0z/VfSNP9aibJCoDbHyRtMFFRLp41a8EYyQmNhwmFxyl+hS
         dFVKc4E7RkCd9EPxMcN7g+pIRAOrylQYRL0FBd8GmbnBmY3HStz9oityn8dCsAbNk+vQ
         TtfIexN6YfqFqpBhV8NeKFkKBpnXyosTfH3hn4dkupwnUFy/iXPjZAW/WM/K7v/wCFp8
         xySQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgQ5/Okm4F6IfykE3ttgx8OceXnGFZ05ygtcOPuyFICkrGy6Aiv1ptadxTFk3xqgklQ/Rl8gG4s057w9aGRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxm4cvyPDF2B3EevnFQaJtA80fJUUxMPnil48mvzDNfWUKOhYH
	HiZZ7TGip0Oa5KJvCnZ6k1eLJv6mZN+zowFydX9CImhpPmdZHH3JSb1uVAeNLBkKm54szNaBP09
	A1CZSfmM8DVNylenPJRHSFg94OQ1UQ0RWwEY/VJ8MMSn7UdN5eyW1+d6Mb71ywemXonTcrGaZfT
	898Zife9cAOHjenlqoK4l4LjmLSL3dUzbbRTIZkyWGY+w=
X-Gm-Gg: AfdE7cnOy3XMhjju+lxbUsagR8BNq8LnYa+HSKUhn+XiJwD7iqTibESjbVfJClPA937
	F4flmq0P0BCLjhYZd+FsoHeYuLIWz0iYP/R+LMG/SlKUqHQcVHmitQKMiKsESgnEZAljvngmLyT
	Ov1H2ZX8kayqu5ffRR54LphynUQyGYvrISJ14S4xtFQaio4gDnc0rxChsxoo6WBXNxRzGDn42nf
	maUCbgTWeS1TWoRyidH0Su7qDK8qahi7IDTFhOrtN8RckfSjYZDi0xnlm7PDhVMWNsB4A==
X-Received: by 2002:a05:690e:4893:20b0:660:54e4:5db5 with SMTP id 956f58d0204a3-66487e0d2b2mr10042380d50.56.1782724178519;
        Mon, 29 Jun 2026 02:09:38 -0700 (PDT)
X-Received: by 2002:a05:690e:4893:20b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-66487e0d2b2mr10042364d50.56.1782724178093; Mon, 29 Jun 2026
 02:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629022124.131894-1-chenyichong@uniontech.com>
In-Reply-To: <20260629022124.131894-1-chenyichong@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Jun 2026 11:09:01 +0200
X-Gm-Features: AVVi8Cf6Ejxv8Mg9H2oH7NckRFNreqIs6ENUixvb0iEFgrRhruEK0eMdMrRpJuk
Message-ID: <CAJaqyWfAOA9LHZ1DQ1oyZx2WNJzfCHttoo9LPjZoKCJ6B8KX0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] tools: Fix tools/virtio test build
To: Yichong Chen <chenyichong@uniontech.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	akpm@linux-foundation.org, rppt@kernel.org, ljs@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VLA_7d-QHjsl4xin54-0_qwIIiVsZXDEmUw5YF64AOA_1782724178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:22=E2=80=AFAM Yichong Chen <chenyichong@uniontech=
.com> wrote:
>
> Hi,
>
> This series fixes build failures hit by:
>
>   make -C tools/virtio test
>
> It is based on linux-next commit:
>
>   commit 3d5670d672ae ("Add linux-next specific files for 20260626")
>
> Patch 1 adds tools/virtio compatibility definitions needed by current
> virtio headers when building the tools/virtio tests. Patch 2 makes
> tools/include/linux/overflow.h include stdint.h for SIZE_MAX, which is
> used by its size helper functions.
>
> With the series applied, make -C tools/virtio test builds virtio_test,
> vringh_test and vhost_net_test successfully.
>
> Tested on x86_64 and arm64 with:
>
>   make -C tools/virtio clean
>   make -C tools/virtio test
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Changes in v2:
> - Rebase and retest on linux-next.
> - Add the missing asm/percpu_types.h compat header reported by Eugenio.
> - Keep the tools/virtio compat definitions aligned with current
>   virtio_features.h helpers.
> - Drop the slab.h kmalloc_obj/kmalloc_objs change because linux-next
>   already defines them in tools/virtio/linux/kernel.h.
>
> Yichong Chen (2):
>   tools/virtio: Add missing compat definitions for vhost_net_test
>   tools/include: Include stdint.h for SIZE_MAX in overflow.h
>
>  tools/include/linux/overflow.h       |  1 +
>  tools/virtio/asm/percpu_types.h      |  7 +++
>  tools/virtio/linux/completion.h      |  9 ++++
>  tools/virtio/linux/device.h          |  1 +
>  tools/virtio/linux/dma-mapping.h     |  1 +
>  tools/virtio/linux/mod_devicetable.h | 14 +++++
>  tools/virtio/linux/virtio_features.h | 79 ++++++++++++++++++++++++++++
>  7 files changed, 112 insertions(+)
>  create mode 100644 tools/virtio/asm/percpu_types.h
>  create mode 100644 tools/virtio/linux/completion.h
>  create mode 100644 tools/virtio/linux/mod_devicetable.h
>  create mode 100644 tools/virtio/linux/virtio_features.h
>
> --
> 2.51.0
>

