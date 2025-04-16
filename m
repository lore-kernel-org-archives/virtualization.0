Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057B230BD9;
	Wed, 16 Apr 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798191; cv=none; b=MtZ9yiWCwLnYwOBqAFRs5ZiUa8cQMSOLPCaWqaVr569cUVfgGiYwdIN/oV795psVm73FsLcRNei/Q8jCg/RX3LhKeu1yuXS80V8XDOoAltLh3RxKR5KAWMC9x9CaBEiSFm4q4+D4+sNv/iFnoZp/mo7NrClp6YKXhep+SGcLfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798191; c=relaxed/simple;
	bh=K5EIWptPNf+bD6TCzDb13Bmy9OoJJigove2+9RXxBVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiSxYOfGPPzsNZaR6+5Fwc7l9QCDcHyNyvgJru+V7TOITDv4CvUb1fjKxT5pruJOThaOAftbVvfn0gPJGT8yygbEKPejzJiCF84I9Dt1K9lnQB9nPXmh0rLSFtRLCEw2+TioWrEvgOrVSNTFMsLX3z3gUXNhw9QM9dGDzRO92Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XniFCzRR; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XniFCzRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744798179;
	bh=K5EIWptPNf+bD6TCzDb13Bmy9OoJJigove2+9RXxBVM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=XniFCzRRu2XnS24lydggXG5urVMcXZNtYGK346HVOEEuRL3mwInWhW6ZpFl9EfpHx
	 v4y7I34TL18IfEU5VNVLVdmRLTBPTN+Jz2Rha/PN6P4G0IRRviQctnLPYXeFytfKoV
	 4RMBfLlzr/QUuyw1THwa8YEMR1QQRINZs8gxGq/U=
X-QQ-mid: izesmtp88t1744798177t30911463
X-QQ-Originating-IP: Y0K1gEdnjwRv1AeBDV6CCq4xv4PZRxrn8U2uvTCCyEk=
Received: from mail-yb1-f176.google.com ( [209.85.219.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Apr 2025 18:09:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8037632543476522304
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so5815090276.1;
        Wed, 16 Apr 2025 03:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7QnI9bK7XeYnhHBcD9VEPDMBwTrE6BB4sJFsCVHhxmEr87BHJ+4JB1i34NLqbQ4bg18stPQOPV5ckSEa0yrQ=@lists.linux.dev, AJvYcCWHDmwmw5Ok15S7bZsVJR+pqQfl9nlqMvPBXQ4U7lSt5DD6Iav2iGOUM8tXLhiRG6DmW9na@lists.linux.dev
X-Gm-Message-State: AOJu0YxvJbdABkAbg0fwxHUrQ7k6jmE7r6sgfEALiHFJG0Hy6lPOIKpM
	80nRhIX4c6ySFP/M8Z7S1p9MSAhdORKehEeKvfxALai/erg5v+rPg3mwC3JC26PGc06VObxAcwb
	49/FiodyxDqQsPyWGa/TE6WJCILk=
X-Google-Smtp-Source: AGHT+IFxOQerwyXR4s01cKj1FQCmW5mZBGS8EUkxg2eBy2yn8PQm4fMpJOhxMxu+WrXOTx3w5ulHOeUcX04b8xnFFTA=
X-Received: by 2002:a05:6902:2b8a:b0:e6d:eb74:272 with SMTP id
 3f1490d57ef6-e7275967af8mr1257382276.22.1744798174393; Wed, 16 Apr 2025
 03:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
 <20250416044827.GA24153@lst.de>
In-Reply-To: <20250416044827.GA24153@lst.de>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Wed, 16 Apr 2025 18:09:22 +0800
X-Gmail-Original-Message-ID: <45D187D71349584D+CAC1kPDPYiUKqRmqW=hzOyGudvUXcwxo0kgDU_j40+t7rYHsU-g@mail.gmail.com>
X-Gm-Features: ATxdqUHphIIrq227AoMvNzUOdxFn7upg3kfvytoiynDmEPipLLJsDaFiQeVe_To
Message-ID: <CAC1kPDPYiUKqRmqW=hzOyGudvUXcwxo0kgDU_j40+t7rYHsU-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
To: Christoph Hellwig <hch@lst.de>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, Leon Romanovsky <leon@kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NwayLIc/Avn/uc+dRHJ7b63Usqzraz51Cf/oicWYU1KzQUw0JkCFlCqb
	EHpejWNiykim42BXNNI7d72q3HszTlR5jcf6Xsv1+P/MJ7POWRzqMhhc1oqhVf0sTh9Q743
	pjy6RvAWrZSUzf1xk6ybfjRty0uPmMxwtbLt1/ai8cr+oUKLxn1yX4H7syybrVvXD/8CPiV
	N2z7mhyGjSMwptUGitgadmHzCyoc80WrkzZkNNQfrDrhT8K/6dFA4o5b3JftMoJM7SzWGJB
	tod+UCw6cXy073asZkPcg/Un9mxgI+tIoqg4dvoodYVHkWavX7wwXDLh5FC3/r+4Z7RP3ma
	jlnLpQDsjVD0aOOTrUBJdpUn0PbinL73i+CNsfxiGsnv/HWigLJMhQn0TclDjtChsnkI/1V
	0kwQbVZdJwHOJl4OU+VaDeaovVcWYqjUwA77ef/TjAyIalZHkYp0v+mPK+sTPzbiRvLO4JV
	dfYQUBzHqL79zmLgBgRgm8h4EchwYjJKgf7/q7TOMQrRct5QarS/+5dtgquOullcq04znPK
	jgfe9mJ3D1aiJjDmQh0XvTulLU4faFLXrI+d1/czQZ5TmhjrwidKte5Hew3eOfsdUk/xO0A
	XfQ9nsmHi8v35xzN9mRY3j8EfoUDzoATe9QmRby2aH4CyP9rdg0y3SA4XGNVDRZW0RWGKkr
	/9qZ3sCd+w5nLmkTTx59BpeMV2b0HcqdPC9xrQnGNYvNwt1nVYuC/fRk+yBHHfbPC6cm83x
	y7ynIm3VJ2HF5Bz6Z4AeP4/yVUFcvXayRHbVHglbL2kd0zDPt9n9FlAEHeN9PvwUDrvcM5R
	UyEB93Y/KPDOCt+HxnO4oUpjxKhU9xL8Fwhr0PXr4z2HvLyhHTzgf4YjzM7F8h+B6egYbpn
	CwtAxmsU9YPfRA7YaqYyg9OwAcInlCBeBajbYAoMt81SKRdD3VIs6dmsFDZqGjXPOGBSUUR
	1ZS97ZwQeJkajkOCuxOB+GmKPlm2xaNnWYyPuU14FyAADXtPaP9ZMe8+wYmSZ2daRrgFlzU
	baOryQr7xyKy0m/fSShWFBGbj9c4Wtu+9G6Pr7+Bi18eJ8Jr3FGthCni5MJn3ADs6BBtpb+
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Sorry for the mistake, v2 has been send:

https://lore.kernel.org/all/20250416-noautoinline-v2-0-e69a2717530f@uniontech.com/
