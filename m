Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B73265284
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749994165; cv=none; b=K/N8w5OQ95/F9QexoR67Q+CxMgbTkZeC62kIgfacTKrSvoEqpOxvMe4Y2eUTPtDGQSmVgtdZJirliGiSWjYhW5OVPi6Lzx3MU9QeThOMFRIRO/tpV/UjWScjVJo7Ixcxdy428OQP1tA+uEpTq8urmFCr+g+ezv00+08vWD3FXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749994165; c=relaxed/simple;
	bh=v7dGi/p+QSLBmuZdO0Pxmvmie/0m+xW4GL9DCkwJXzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooL6NiZ1P/XxzWutL+nfCMZK1aMdj8ulOXEPfWEFbi3MPiIISApizeYsRpHZbKqsaBg5xoy4OFZiIcbsZ3DvivGoGCmGJQ/+qOEXspwn/F23Q8lrNWLXV8Eyawp2dgx0epfASktEhCyZbGonh9SEsUst7B9eZ1xx2Mzc7dIxpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNHkR1rh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNHkR1rh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso6643834a12.1
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749994162; x=1750598962; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9zzygSfhWf1n304tmrO/WQZpUfmYOrJexVlvQBWi7o=;
        b=VNHkR1rhsVrQ3P7HCknFDzamRbDUHT/GXDmaGCnQarwhdQZL/OsWk6CjTSprh3ghNI
         y4gouvjLK5nB+fIIH/3B9p0TPT/0qKJoK4E3lq7jponRTZnCUTyk/X46TPv6ihQZyxSS
         6RialmtHlvIP/jab9RjC4GQo60QexnHjqL447yt9PxXh8UANX4GwL4PR461YGG/teqJ2
         Z1v+WEgWBVO9MynoPd5mbU2L8rz4igyDpZVAPijP42mhfNEvvIOIhW8+zPNtfOC3IKHw
         qELCGuZ0DvBjnuiLEbgluwYGGaKl0PHQCQxAAoyKVsmnCLw9aM0BeevSo5lB8RujVWy4
         OnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749994162; x=1750598962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9zzygSfhWf1n304tmrO/WQZpUfmYOrJexVlvQBWi7o=;
        b=lY7iyBm9wvegBcmRted6TCprivrdOPDJ9xicb8r+2sDiEehC5NQZmCBScTQ7l/DQLM
         V2Dq93DCv/ySfoQnPh25ZP2bykx2HAXiHEVNbm6SY+U47ZzRDPGP4JD7hs3C5SyCcMWo
         zwQIjcomwT3weDWJW+RQDUaBoMTQ7W8DCwnb6LRI1hIAt3VFH6mFJfzKSLzWQ4PwTdld
         keA1/nYh+vsfGtiNXfoYsIQQvZeZ2o7+aqo6BF5d+LjHNX/8NOoaEt3BiqFtoqKb9IAS
         xoaV/NMzi8mvscd7wUlV1SI2rOUPKehlBXt35WI91RKaodtML3bk20FdOvY7NRo4IuqB
         +uFw==
X-Forwarded-Encrypted: i=1; AJvYcCWPYvbsxEYtUeCBKE1bbXcZ8IF34r5I5x+w/jr3BIQ+3ary627DyJiHIBPd8qdD0o0jc9aAk9ZnBGCtgPXMyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAFptPZ4mRv18g88zGnnrKENikZ7CAOqOIXDoRUv2kwPa5BbvI
	A8M7RTRjEvQBWO7OyNF/xzcIthP8h3UvMrq7Tj/YZaMKw+k9tMznXaChMKRattNM25Qwc09DYpA
	1asagmYWABVnoJ9yd9SpY5od3Btr0pUo=
X-Gm-Gg: ASbGncufDOc5kDuy1sxm5DImtiiwdvcJ33eP3CRraH5QaA3NC3QkJrYwZ+fmCX8NqZp
	Y62SQa/MrskkCkPtvBvatlMlsVOSKKLCDcJjokqwvmgqME6tEj1t3jLBmQXYWcpWuOEXS5hW8ZI
	8DhuMXL+5iR1tw5Jp+ZL6DSasXl8p8hl6N/yMOOahWfA==
X-Google-Smtp-Source: AGHT+IE8bk707t0OYabD32X0uuptPAFaenGnljG03MN2dCI0Nn1BAVcSVQibvjvVSWlhTEkC4lLoL94xTmuXxM5uUMU=
X-Received: by 2002:a17:907:7e94:b0:ace:d710:a8d1 with SMTP id
 a640c23a62f3a-adfad3cf8cbmr453975066b.24.1749994161696; Sun, 15 Jun 2025
 06:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250615132039.2051-1-lirongqing@baidu.com>
In-Reply-To: <20250615132039.2051-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Jun 2025 09:29:09 -0400
X-Gm-Features: AX0GCFskEWnSzjEVlyduxkbxWa6zBOSHODMc9LMP88HxKFSkOWF8KXIB41_td1I
Message-ID: <CAJSP0QV8bq_zbxAQD35c_D_3uYO8jnXoVHgp_c2h=FOjPxBgrw@mail.gmail.com>
Subject: Re: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 9:21=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: remove unused variable "fpq"
>
>  fs/fuse/virtio_fs.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
