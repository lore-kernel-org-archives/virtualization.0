Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85B2853E0
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745164; cv=none; b=svyOOr2AArNz/4A/VOfG1DgWqcwIyphCIvdyJbN1PnF+jCWGnH/mhAUDcZAHeGfXPsYyEI135iKcSy2341CBsp1qRRHuJYFNcrLxiiMUD6lKPlMBFKeOPBxyvYbY+L62g+Gahl7nejw7VyOKbfYpazWv6MXYNmidyD6ub7htlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745164; c=relaxed/simple;
	bh=4knX7UdpV5PqcFPGudPF/uxcuJbYSUmyGMDEJIBJ6aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M47End10PyHYeZgOgCiScszUXOpe9rbxWnRQ6xNmGPIxa5fYvS5p5sj4PeEU2gE1+qczfFNsNClNf+5f/+FgoYLiX6LgpoNoqLhZbtJsyJTpdkTMkNPhVRpDuU7oBZwvVGHp0RRVKpWrQo4LDNgbc/jUYVStB/LT4jJ4Zow9JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtU+lgK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtU+lgK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763745161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
	b=KtU+lgK2JIHMhPTnrlcOFEvNZOemC2MZ+MBg6YGZ0FsIITfucxfh+HT6XJrrawsv1znYv8
	8cCPXHuEoLP3fR1+vNR92maYNl05b8qtORwInLRObCAalvA3ozGOosyIgHbQyPfYy//gIw
	2d7bJcupW+eFpa+PBI+Pq4nWOoPxKF0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Yi7RdWf2MEiugxiS8jqLMA-1; Fri, 21 Nov 2025 12:12:40 -0500
X-MC-Unique: Yi7RdWf2MEiugxiS8jqLMA-1
X-Mimecast-MFC-AGG-ID: Yi7RdWf2MEiugxiS8jqLMA_1763745160
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78a82709389so25094767b3.0
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745160; x=1764349960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRU2qLfbf/wNhvSHqqWH92nPqYewb6NVEbhZtNPwvUI=;
        b=CpeN0yjv0rRTXaFwtezwVaTUqt0XAk+Ac8JBDsxBncY3FzG73oSfH+gEUGCL3lWOMg
         Z39xzrQgfiOcaIQXlhp3cHVmAzlUBjxLETx3r/McerUoUg+zT/D8f84AvB/EPdhbDdpB
         prNrDvXkesSx43Wk2j9h3olA1n4pzPnMKf0oynHslRLIsnBzeLzDdikt4dzjqQKQF3od
         hvtl1eSYoGfpb6aK8BAzzhZIMIMEt8EMhHX1nT23QfsKfJAbeACkg/7NVAhRgjiUi7ue
         //UqbPhD0u90b572ay4bl1jZsOWveer2vD1/xszC4elkuDc3RNBdp8pLLNPXedpY9kvW
         djMA==
X-Forwarded-Encrypted: i=1; AJvYcCWfOOXuDU9pi1BCd5fdcz/Xhx3wObWgur84LZCDcxjxl0eZgtq6WfheCld2gcSGM4vC95DnSbagd6aBp8P85Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTm57dhMu/jkCp9X5tma+3izmT2Ijuaf3xBsXO3UleG/yBLdu3
	tb86xDol9FsPl/bff4jJrtIwb9bWbeL/uNcMX1bTkEPXSLxbU+JhBVsOGL4YFp2CwFsMdYoWEDn
	mL9J9tZ7R+0reyhnKb9YTIABfyVTEN0Op5lfRGqTWG+lNKmANXp8Aw9UiNvDss6Npt14XGSQcQj
	uhJ9mLhac1e5IkGnWyWGkiCT3Ajvy43orjWn6wH5wOlpI=
X-Gm-Gg: ASbGncu38EfGor7uHtXNkzRPQElv2UT+rIi0vFR4tQcKrYUqUB0OoTWoTynUvpawQgK
	wkv4TzD5EbhxAjZo+uxYu9OwR0YoZCQpGM7Ee3CourdPtx6RI0FNHWm3XKPDZiXAWDikf+vWqb5
	gc1nvuXz6MhngU96K4MZN2L3PRlCPoL96C0LUP70cnZjPeFDOH2wNa1uy64zcJpTi/
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id 00721157ae682-78a8b5681a0mr24167057b3.62.1763745160077;
        Fri, 21 Nov 2025 09:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJMtLvkeHiv5tBcVk8Zunn6fcLBfbMFj2OlEQ7sDWssH1e01yWoO2IMY4KicgI4AI0qMGjQLfshccde2mHq/o=
X-Received: by 2002:a05:690c:4c09:b0:787:bf16:d489 with SMTP id
 00721157ae682-78a8b5681a0mr24166847b3.62.1763745159764; Fri, 21 Nov 2025
 09:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <20251121081748.1443507-3-zhangshida@kylinos.cn>
In-Reply-To: <20251121081748.1443507-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 18:12:28 +0100
X-Gm-Features: AWmQ_bnhlFe4bz2evbPrSI0Jb0EHnrWDpAVAemzJqi8jgCPnPPGI5CuseKDcbLY
Message-ID: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2aA0c9GkyjNnT8hozrlcJ11iVgKYIGzMtXUTMGSdMjo_1763745160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..a6912aa8d69 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, st=
ruct bio *new)
>         }
>         return new;
>  }
> +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
>
>  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
>                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> --
> 2.34.1

Can this and the following patches please go in a separate patch
queue? It's got nothing to do with the bug.

Thanks,
Andreas

