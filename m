Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A7202C50
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959826; cv=none; b=lWWubNoIxr7HfqzuvXQp8t+P5IAqgbmXvefHFDU8ICNYefvL1kcdE6cRvOM5PzncPADbP74CqCPaXDFVWu1OAdJyWCyZziJeMKMiLS1z6WO7FtvPSjiechFXvm8tfjOuP10r3FwcNFLHpwHHPV3ksUBDwvhXqugR+VhHUkC760Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959826; c=relaxed/simple;
	bh=wzwuJqhyKPA6pFtaKqL29WQiBrCe4P+CAFqirUycMO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJJTeXMh1edqDs1enOVFvBLDeRJUZFddmCKbiwNqia1HA5gefFh7k1rb5oNnbAIyAmEwDRK6u44bPLKwYI4qJabQ0OQTD23e3hofDveHtCryqNZy01/jQNIcHXfzb3leWYKns91DPuhtlF6bgoKQwYS8VNYIhVtWOWjLHbOiS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAq7RRnU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAq7RRnU"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fada2dd785so17002126d6.2
        for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750959823; x=1751564623; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzwuJqhyKPA6pFtaKqL29WQiBrCe4P+CAFqirUycMO4=;
        b=OAq7RRnUKyM4VvqIGsoONSDEFNrTYZnveYXQQQT3bsr1yOx7/nBFxfDdVzDJbmCMyo
         458xIG6QKUjqRgQhLxgcy6FMKdZ80HGMaXXqOfx5jy4k4WUuP+tPyyptP0GXUHi328sL
         i70OxzENjYGOKoP5BJcoz1B6fRe1mz8BJURXQMssHrYnNMimqoPZFuLNlj4HzJYMQNX9
         Sub2ngupBjaGWZ9i5aW55zddx+ZXsZngJ68Eg5EWwT+y/PStYR8+y3PR12+v9XHOaSdd
         fCOD5CFDcCAvTapyN5PdVdD1E3WFppmP/h612kR8LWnv2BXOnr1g5c2VoM+m6gLbEvly
         jpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959823; x=1751564623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzwuJqhyKPA6pFtaKqL29WQiBrCe4P+CAFqirUycMO4=;
        b=vCX4y32OedOoHWBsHEq94LyhZllGKrm2SUFElp0VLUSYz4V91wYfxXOD/bbAiwP6+/
         eCcucd/2pQRfu83ytr1olSl0s5nHzi2WHH+UnKJ3vdQKAmSUsaWGa39co2FMBe7ub//n
         ch5qLj4oIpaG/Jqv8Homx5oYb3CAY3BNgPNnRg5uY1BT/u6NSQfiVtXhFsdAa0pailHp
         cwngvDBhI1JpQlyepOfzgd587KYaCjQlN88ynsgUml1g4DySGsmO4j++qQqi4uCDkQL8
         bLC5DscDF6X0UUXvcL8uF34wG0ffShjvH3Pmg/6Evk4diV5s5CBwsftAy9lbIrD1JmiT
         xANw==
X-Forwarded-Encrypted: i=1; AJvYcCWgBTA+Ja/oKBSgvU48Qh2ifzQOaLO8Z5QOPYp38sz0typ1VAnHFB54sX2RJUCvFh2x5IMuO9T+mp2/pLVaCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTEGa7YnYwSNK5DgGxa66tE7n5U5HeB9x7j7uoWTmnpIenJcj/
	CoW0Uwy0UXB4YZI+w/vznwDhBOJzXt416ezmDPvUAWW2mFq4MTi/l80rm5JyfXh4U+ZeDhe1XEn
	YOEcZtO6EtBZKbVWFVxHQhR2godJaENdUgPhv91qd
X-Gm-Gg: ASbGncvibe6xtdDhdvM02WTDz8PYS0lQfdGYPkZKBeBasU/SJ+zUtvGzKGQQ7UKwrxD
	glYM9rrhCwz5o9BN2A3cTd0Z1CQkXrEFgp6xmihfN2ZICIZSyeGQaHLm3T7McEIQAzTAjSZ6Pur
	mrPH/A9mepiZiWCyzcbrXT7EZ9HthxKbIV/NqJ6YSA9zEL0hmcP5gybwWOu6Pn7EmIMeyzTxf7+
	A==
X-Google-Smtp-Source: AGHT+IGdh/IJuNTnlJ5wP1tLYohn6WiFRhrAxLVoOATEeK6niUOWXM6UN14DbuitTFowPzRbNWX5WutFoxjvCZRzqB8=
X-Received: by 2002:a05:6214:2aa1:b0:6fb:5f1d:bf8c with SMTP id
 6a1803df08f44-6fffdcff5c9mr6100526d6.11.1750959822639; Thu, 26 Jun 2025
 10:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1750854543.git.leon@kernel.org> <cabe5b75fe1201baa6ecd209546c1f0913fc02ef.1750854543.git.leon@kernel.org>
In-Reply-To: <cabe5b75fe1201baa6ecd209546c1f0913fc02ef.1750854543.git.leon@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 26 Jun 2025 19:43:06 +0200
X-Gm-Features: Ac12FXyaDZROOxurpvkcs9ZXthsb5DglqUebhn0NTWwPhDYnIEGQjkQ7oqhUUFw
Message-ID: <CAG_fn=XWP-rpV-D2nV-a3wMbzqLn2T-43tyGnoS2AhVGU8oZMw@mail.gmail.com>
Subject: Re: [PATCH 5/8] kmsan: convert kmsan_handle_dma to use physical addresses
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, virtualization@lists.linux.dev, 
	kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 3:19=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>

Hi Leon,

>
> Convert the KMSAN DMA handling function from page-based to physical
> address-based interface.
>
> The refactoring renames kmsan_handle_dma() parameters from accepting
> (struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
> size_t size).

Could you please elaborate a bit why this is needed? Are you fixing
some particular issue?

> A PFN_VALID check is added to prevent KMSAN operations
> on non-page memory, preventing from non struct page backed address,
>
> As part of this change, support for highmem addresses is implemented
> using kmap_local_page() to handle both lowmem and highmem regions
> properly. All callers throughout the codebase are updated to use the
> new phys_addr_t based interface.

KMSAN only works on 64-bit systems, do we actually have highmem on any of t=
hese?
