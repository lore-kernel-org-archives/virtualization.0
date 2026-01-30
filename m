Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C0334694
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755279; cv=pass; b=o2HPw9ZCSLRi9RCCdk+bodLugjxd5g+V8wz+/S889DPWxLHCAokCKQebOeGEb87XkbehKZwHtZ3MTQrPWs2IVa0lip4QEX5K4mKRJ/ErOYXycTybWRyLuMmNwyDaKOyRmCA4CiWyebh9m7+pECEq6Bt/m3EapkpOwx4DacAfWCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755279; c=relaxed/simple;
	bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXH3WuJYODg9T+wYpUZj3s4e5BGhC0nwemAsLMcC4hPCCD9kIxkkZUvmcT4t8kGWniQy36MIadrrByB9kDwKPi7E0r8ehd4iqxJPeWjEmlf3dtPAKP8gpGvuCfCAKsnGZW6BA0QsxPmaXZNLuM7jEUO26NLTIZImu5JNJJiEJUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HmEf7VxX; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HmEf7VxX"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40423dbe98bso854314fac.2
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 22:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769755276; cv=none;
        d=google.com; s=arc-20240605;
        b=LA2O7SvAAKH7CGbKkXIIVIkZzRL0AwBOCBuIE1AD97WWUN4+SaZ7cwIHwRvMF2lW3C
         WwdlC92yYg63KgtVf90aB1BQPyRgwt3bIDHfDOPcxsW4HbxiI37hVmddGmLcMroqR+Gb
         R6up61J5Gg/9ViLJPdCVqKrBScubFCvkIKR4sm+PP5PZUYJVfy1bUK94s40LEtEX7/iV
         9krrQgGw688REW/6ybQBR/KEyujc+L741BOLvXH0kWTldi/5VOKThzy1AuzpbhtmyMJS
         8F11cEg5pO3h2qWjCL4uG1h1r/eDGt3hmFFkx79ayTM0Jw7AcQbNfLLDVhBrj92hoAV2
         fM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        fh=HtOUPL3lFFQWxocjNouLSsILjwRAxPg1Wdh8/8pHKY8=;
        b=c4s5dAA734PLqt59OrPyAueGjljW9VthPozfS+SUq+Q7nBKTbX8xnrKDFUjyDpyfb/
         ET4AlM43fx26x2S9voNYcet76MzKtrvpzm2SCN5pwIRikKo8SHdjpcklAIzA9Z8PUBgK
         Kho4hLVYWlUip+MX+PaBMD7kMm+p0KrhXA6VbaATI7oLURfsV99ORWxYSirygTJBA/oE
         k+o70n786LnKuoOHmePEGkCBrnwbJPFRzfNbUlBVrDNc6UQ5D1wPx8dmc9qWrl2E+L9p
         D6usIQdAlrX0L3eBdQQt6107DjpnN/IwCwFt52dq0Y6QtGdP1jHglH7jRS1w4xUg8fou
         ZCYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769755276; x=1770360076; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        b=HmEf7VxX1Hu9T2cmt2Re2/RlDHBT+G2jMIa6AgfbH0KJ9JPB5EBBJ33VGGSC8WUnbN
         5737A1Siur56wvEh/CXg/nl8AZt/bEYaUXpmlIjw7kFv1ooVn7Mx6+Oy7RBreL/jFitS
         1ywixTXsNWGDlzilGH72M/8j+egLbc/rcTMSL/r2940Zs1ymGMMb29fUANOg67ptd5MN
         noZ3hL3OwptIr3i0c5LvHjjpRup2JoFCR6uWeS3fIqc1zyIjtRwe2XkNMtACIVZCs3md
         OnTQif5HkgrbpZXrDHzg5wqSapzGbflUdFZSeIlrXHALrm57J9EbhykKwvCVQucrPQ7o
         k69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769755276; x=1770360076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e92lWZPVFugVAMygpaYDs5ATJ6LSykDjIR5hT6LiqIY=;
        b=XCnrMnPS07Iv2zuX7jgUEYtm4342ElestC0BDEp0tahPS1lIzXi0XGTPJjyV0iXuXR
         hO0Qn7IbCpCz8uI+ge2+Ao/jV6iXzSnzQzXSgHnEDflgJwbgn16mS68L8FRLvxIEFfTP
         JHiEil0ue1qmzOqn/DJMRJCfmLeAYJ9Re3nUtqUlpnAVgKMsee/6bQGgXt8cD7GTXau7
         BJF93PwHzWqtULmZfg5XjhKAKF3ZNes4cIGEMIjzTxPj+Z22/s+vtxnkOXUfstLB3oRY
         HrRD2Qgm3+rh3pSI+dSQtiKtCcTuuOFMPkn9PN4ea2gVT0hOWLuhTZegtVmgVQtx6ceb
         i4jg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLNvrFwHr8xzVl8XpFhiTmVSE4CjAZgpkFGLTfZbaM/uahh7c5ulTvKSWlKeXWIsBvEb3d5Kr1NG3jmJ6Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvPMB1SdEqjQqpLeEFQX6CjwSdIYtvJiZg32KBIf+sUB+UftTV
	CfhDXO3N0XAtQZSPpq3waQIHRz2JQZR+ykks+tZaE7m6qhi9dY59Su2Qy5P9saZ5KwZylKAyUtX
	AgqYcYx/Z/myBIt2cCjsknb2QIqUBcm4snaozFN7w
X-Gm-Gg: AZuq6aKX9+vem1ZBJWUyUnC4wkrLjuCDchCqlUodFHIv810k7ZzwBWbWW8jJLk4hQXE
	h3kiZvL6Wd0x+ZBDlzZkrol4jKDxazBdM0GDQtb7VFTd0+i09lhMd86FXWFPx3ledVEX1A03OFI
	v7VyHhuJEDlzVHHZZSvxkSAhH6CXKQpuvGYV1BqZm9J87r2QAmrA/LBi3G7h/Umcm2LiVkatOCl
	j3VsM95xMdE7gx3HghlqLRZ5CWYd0Bh1PewpkrK9sGc3CsSFQKEbCf6xNaYeSDJrUZ3xZs6ZkO/
	uPHQBwE=
X-Received: by 2002:a4a:ee0d:0:b0:663:c8a:f14d with SMTP id
 006d021491bc7-6630f34ec68mr804679eaf.29.1769755276000; Thu, 29 Jan 2026
 22:41:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130050750.4050-1-jasowang@redhat.com>
In-Reply-To: <20260130050750.4050-1-jasowang@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 30 Jan 2026 14:41:05 +0800
X-Gm-Features: AZwV_QjZWXvGY6fbhwTXsBsPoSEryCiwjIw8p9jgzeUbuJsf6rP1qz6KrDl9010
Message-ID: <CACycT3tVT5x3hoDrtuzqMgLgmw_1JbDtQwwJQ2o4mV2xUkFc9w@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: avoid leaking information to userspace
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 1:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> The bounceing is not necessarily page aligned, so current VDUSE can
> leak kernel information through mapping bounce pages to
> userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
> information to userspace.
>
> Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Thanks for catching this!

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
