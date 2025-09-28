Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1442236E0
	for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080958; cv=none; b=j2pHgVQYaDG3esr+LU71MbrhbNXRIkJOioUa70NIuXWNnOGNC6GCSEp29YqcFOOgU5mwn+NY4LGYciZdqN2XxYNqfpnZSP2P6cd88Vg9oKgVm/hNRCUUP0EuROA5iD9lyF7Y+vX3hjMJdk6JHRw+UhKabPWahXIaUuqu9LsfVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080958; c=relaxed/simple;
	bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J57KjRgLf4uxd036pYodaDoxdwcPu9Whn63uu6jqqypFDzQM+kjgue0w1SGNtSs0sfc8SU17mvOqyDYANJhiinftRtlptCv0nIPdBPK73HQdpz4ZxF0QflWskncRMQ2Z8SDx32gHhsJp2eYzON2VWwSzpi9ysN2anUfzlDwaFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/1NBur6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/1NBur6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso8377168a12.1
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759080955; x=1759685755; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=b/1NBur6houioUR9rKLwKpNv26TqlqCeRLj5WfczSuDPRygdH4ryzflqZotNfBWnMS
         pYfXGAVfME5/1ppguir3d2sc1wizHv1uQu5RIogBU5v/JNqhHyosXbZy9iBczRYsB4Kx
         M6NzIvgY4xn4lawPL+b/TAUWKC1bcjNF3AErhy/J4DemRvI/X+Pq4Y595ueryii7r8JS
         HVWIXMEBxaPvzb6q4yPek2oXWkPTpiKBgd1NcyMcskfzEbwzIfUvGjVKcbLUyM+Eu3ZL
         DhwZdwQ9R4iNF8RAB0s3KrXDyU9uYW+oQk2C4xL+f7y/uUAb+CMSz46dPQEniZVaPmlI
         lgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759080955; x=1759685755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hWHgpM/rb70qd87juqmeSrMZFHqG1itquQCJwHGhEk=;
        b=ln7TTkJR0rucI+ehMgatBGcYwQ7AtNQS6ZLCu7m0cKz7tCgj4voB3mx5ClJTPfuUe/
         l3/CYqppHRM83f152DYBVg8tchPTVodV6Czk2xXaQzKohvBLaXqSBLH6GaPS7qv8bn1D
         91OntSRFUnvn3bKZPiDFtQ2f4yEyyrs2r/r2KoyKqeM5OLnJ6P9G3f48Lc2re6jcJbVO
         p0OIE/VoKPOaCmpC7hy9KRjUaZdwlO9y2u/AqNQHuVMjQ8HSo+fksa4Vijxvkj43d6ZM
         f4aYVnXW9eXw8D/WHepgJ9L0zRnfAe7ZXJWMXMmUyZqCdDnsIrymhEzjsx4IszH/EaiA
         1wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtoXCPkzkSkkGmhCw+xs49u6TSBMVnyquKHp8M1kC23KVncIua3/JdCT08WIWwcngVKkH8oAWPoc1nkCeIUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnI0kjujp1dbx6stxta049bTS08ff8ln2whUHky5ZZI1T4Mh72
	ccKvyz/w0t+t3HFRCPshaIJSMdju03gQlO1bg7tyERz3FwI+CX2uLmSx0ciEleE+Tbvz3HLPBFu
	dW05UXNsp+f4MgEQZE0hfujZBcf5laik=
X-Gm-Gg: ASbGnctObUD7qWPEw1MFWwvGFoMm0JegvEMpS3utkxh9Nwxo9L3XC5rSYRzfjTFr1B3
	NApLhwhcjLLSysqiEuUhKNWoHt7CkJxB9v6qbonvYjDrCshpB4uGCiI0U4Czh1QELv2FT9BBAXw
	p+hGhaOMQUqZDvhSYqUxLBNfcAbQ22qZhF8E3zDTdHjz4rpdR2mQaZDvabx8bLOjbQL92gNROIs
	bx3L7bA2JLMe8av30E=
X-Google-Smtp-Source: AGHT+IF4LtUw7v9U/JYoQT0Wh7nzvSFhJ3UqproTerTY3SiJCa0Vl/rRvk3JMudUZqWnlv9RN4X9SRqdzNlv4OAcKN8=
X-Received: by 2002:a05:6402:352:b0:62f:453c:7235 with SMTP id
 4fb4d7f45d1cf-634ce845b9amr4127811a12.15.1759080955040; Sun, 28 Sep 2025
 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1759071169.git.leon@kernel.org> <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
In-Reply-To: <512d4c498103fcfccd8c60ce1982cd961434d30b.1759071169.git.leon@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 19:35:43 +0200
X-Gm-Features: AS18NWBtQV3w4fhUJT0qJjc42RZ2Y4lnsCSX8_2AFcicJQutzVlCWs2uQTVZ_oE
Message-ID: <CA+=Fv5SzdR4=NXz68gRg0iXY-6Y=GRsO24UA-DF4tuyJ8r7w7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] alpha: Convert mapping routine to rely on physical address
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 5:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Alpha doesn't need struct *page and can perform mapping based on
> physical addresses. So convert it to implement new .map_phys callback.
>
> As part of this change, remove useless BUG_ON() as DMA mapping layer
> ensures that right direction is provided.

After the changes in v1 this runs fine on Alpha. I've tested this on an
ES40 Alphaserver during load (build kernel and unpack tar files).
The v1 patch fixes the errors seen in the first revision of this patch.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
