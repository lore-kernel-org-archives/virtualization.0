Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829E1DF747
	for <virtualization@lists.linux.dev>; Tue,  8 Oct 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394765; cv=none; b=g76y0QpUcSl6sCmLpR5A62YRsk/Gone3u3OZF4bjPmQYf9VLkc5XDDaigABY7+GhPh3xVj16goe7tq442yYTIzZNqoTnZ0u6eVZ1JWx8sP5K+Tuo3AbYnaIAd8CUGef/XrwFOSK0B3g1WvPmDjeEpwUMR1ZRfhlzTsYukffZaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394765; c=relaxed/simple;
	bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqXxz3U5paPwo+stzesJ7N18co+BSzJs4kvaPf0d0vF0bCHwX2Maz7klUnJAQwUPAU6ZNuL0WS/XJScUAcautpMEkPfKrtz34HW1PHSknVv80RYAff4h0gFixhhBrZ/2SZRF8P1kdbi27cDGWlCWwOb148GarDlj09y5kUaMJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FMu3SDVB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FMu3SDVB"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86e9db75b9so869338966b.1
        for <virtualization@lists.linux.dev>; Tue, 08 Oct 2024 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728394761; x=1728999561; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
        b=FMu3SDVBiXOmCmHxiZnKginA9j7jWmML9wBbEtdTLGSguMZ2ycFkh9/GYLKL44+Awt
         40PmDYIMJ51KmmqORRujo/SOUuZbpIMPeGeiLh1RwF2MAwhPRo9DxPHbRxmMaw003fiv
         6bKoUVYduakFrCz5RVZy1WLsjMGUsgn61YcBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394761; x=1728999561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcPCv63lTlFkdYZ2GwPoXLbpfIQwWmxyEbkctDukntk=;
        b=p9c2qvIWJ5bzrDlg/24OMkA955BWAvSiiSZKL72CRB5WhPP/lRdal85miVePLmEq9R
         3A5/AdYqMKaH7+gwHofT1lFpb/oEsnNzxnJNJfu6naTh3bjZgxghnxERBlAEZp7QOtYn
         uQW9HjBXZ6Hhfn6fuuGC8U0KYwJdWAZIf6mAcWcqIpvc+5z3mHrOVeKBd/18awvh6flr
         B7BcVqn5FjK2ip3SN7Td5mjnAAYR1IEXc0aMtCVmiNKO4+diaDL9tEasgt+OvaUYIESu
         EiTTzkrnBTUFRcCEaM+PpoyPXAcv33B4Chnxeg6XB6hg0XS5CRVa8i+4hOkoq7DKA9qL
         uNhA==
X-Forwarded-Encrypted: i=1; AJvYcCUXTh5SE1oCIMGqICWfR1bRH8ih3p2jhw28IJGTxL4kclOELoWpkSVZ0pNDzIZ2B1g7OP/gSAhPjruOkjSKpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEjWNI1qc7t34sJzLpzPxdbx/MQfWJioYrfS3itWGnzGqOBE0P
	VR6ZjiQPhzoKkDNVPnXdjjT3SnR04x+9Azy9lLWI2Xp1uxpf6bkkiRniLsxjmVZG0dmirBgUl/i
	5jfFKBnMUTjyXgkgYNUEOm4JkwWEHXDIbbwYeWg==
X-Google-Smtp-Source: AGHT+IGdJR4sHkDLpXK706MeQSJQA8wuiHX1WozZr72hURRz788pd/e+TCc9tNm3xWJ/iS5zYWJT8vj1i0hN7Rpw+bk=
X-Received: by 2002:a17:907:6d20:b0:a99:3f6e:2da1 with SMTP id
 a640c23a62f3a-a993f6e2e6emr1016488366b.38.1728394761064; Tue, 08 Oct 2024
 06:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
In-Reply-To: <20240831093750.1593871-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 8 Oct 2024 15:39:09 +0200
Message-ID: <CAJfpegshz4_Cjj5imF9mpY=8JSGU1riBZJr0N0Jbb3ZaP9aubA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] virtiofs: fix the warning for kernel direct IO
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 11:38, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set aims to fix the warning related to an abnormal size
> parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
> use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
> Beside the abnormal size parameter for kmalloc, the gfp parameter is
> also questionable: GFP_ATOMIC is used even when the allocation occurs
> in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
> allocation is initiated by the kworker. For more details, please check
> the individual patches.

Applied, thanks.

Miklos
