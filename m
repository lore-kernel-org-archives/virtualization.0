Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C22AD32
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924535; cv=none; b=klMnPOaxRumduubRjXX30buhwz6s2PcU8MTZSlu+3Ct8RFZ5+f3ewYi8txK5UoPqDVaFIwY/to3+ZvokwX4reRIds6eQV7iRk2wEA0/M+YanLiAmiTadvGoY2krxPpC2NUNpB55NCMFxyfRzlN+YxQNmSBqvHsSdRTuLZqxVnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924535; c=relaxed/simple;
	bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLrRcngQA3m3rcvqmZ3VsWm66+QrAxu/5SU0B4HK66ARzbI9sLONYB7ZWGru58vrU2lngIVw7Px7uX39eVXttzKRGMslPU1IJi+s156OMaKlag4e6wlHHhbcRG6h6Hy6y2pR5wxcVF8jbRAT9GY7b6lRwgUPWhNz/UcVssN1PFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYMNX5zN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYMNX5zN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757924532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
	b=AYMNX5zNkEWzJ7zfxIpZ/hb0xU+M9QZnFBcwWMgTGKxQ/v2WWsKJkr4ULKBJJT/XwuW0+0
	m8FIZkxswjFMc0cmeZQ5OsasaoO8REh75R0UheB0QM9Yq+jj5qpKM9az62h1SLgm5HBZwB
	3rnSd1m0a8aRB5iI5jrPfvoH0HTTS0Y=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-9tek3mA2OYCOxlB8ol41Jg-1; Mon, 15 Sep 2025 04:22:10 -0400
X-MC-Unique: 9tek3mA2OYCOxlB8ol41Jg-1
X-Mimecast-MFC-AGG-ID: 9tek3mA2OYCOxlB8ol41Jg_1757924530
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c928089fdso5260876a12.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924529; x=1758529329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gOJ9B8QwFl0uqXrV6UW9f2cRGBcxSUQ5tkUncDy/Q8=;
        b=humzKTO0XkjFhNlYijEe6nF3sVh0SK0SCTpVXGKtAXAwoZ/o9sxChN+ApT40tz/ij2
         onMPWB9tXwgY/e7j4i/ImuD/dLAGT1lDs+PXx8MzaVO3+YsPWOpUvhC2fJoLZ6jI+BKC
         TjuIaDTRY6RRI6wpF+PQ9XK85uwIm8ELyhhru/wBc+C6pJH83g9mJb46zXo06JZ7bMfn
         LeNoX52mRipfSrQxUpZvIKTBsHBoBIpPgO1Qe9bKeRsDbFzn9ELQC+503KPzdUlNol0O
         vtaPcp03LimodAkFfV7jt3XLXkaKlYQ07rWsrWAtZseIz5QM809KNcQZgM9bCYI9O/7O
         OI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdHvZvnXgP0mjlLIUW3E3Oru6QDFxq4WUs8OTqVHQyu9tibSwl+uJ7Ebxpc+IaUH9qwWYm1uGP0YB5eIg4WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwteePUyI8fmRnGxLlhuRcMKpFDEI/uROynLndThgkRsiWOY6hN
	+9cdsyOhf/fdZfJhp/5OgCsSq6K/b6schXovMOkpeQaDtc9qF6Z3gqkfpd1AMigVmNxiDcdVQyg
	RdFlZO6jDSwdBaIUhqeXgR3EzLA4vx0spWZR4M5mWL+mqMcYKghyEaYHrv4GGtwKwVMbDeZljoT
	TVCpKiBCXChcw3WcdxFPmDuh3Rs/UP2bvDz5uSJZWaaGc=
X-Gm-Gg: ASbGncvFgpK5UWze41UZYBlHnsiTJg4fHQYxY3+LS/Vci9RWtaDZVQTs5Rye6p+/k7a
	+ENz6v7dLlDhC/OjDlFJvlr1BxYib8rlxThh/ji+Hhqfz1SRrHdju7nkqSxjIJ0BW7G4eEtXEv7
	Is8iq7EBfcmRKMq8ecpdL4
X-Received: by 2002:a05:6a21:339e:b0:264:94:3f5c with SMTP id adf61e73a8af0-26400943ffamr2934972637.25.1757924529734;
        Mon, 15 Sep 2025 01:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhfvI1qfGeK2cL0KlkdSylK5HkSUKW7hLP9dtt6BGBk0eKte6rAQM80xtdpM9B9QKyHyvudAhZE0QpVQSgpOk=
X-Received: by 2002:a05:6a21:339e:b0:264:94:3f5c with SMTP id
 adf61e73a8af0-26400943ffamr2934951637.25.1757924529386; Mon, 15 Sep 2025
 01:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
In-Reply-To: <20250915073429.54027-1-sheng.zhao@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Sep 2025 16:21:57 +0800
X-Gm-Features: Ac12FXzF3ZG4oBSmyEat2dYzan_yR9R2_8XYd-pPpVSxohzmkUbNAFM28bTPxpU
Message-ID: <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: sheng.zhao@bytedance.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tYuTSvxexIJ7iU9dFMuzXQ_hQIAyPrf2z2xm97pmq0E_1757924530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrote:
>
> From: Sheng Zhao <sheng.zhao@bytedance.com>
>
> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
> even small IO requests to occupy an entire bounce page exclusively.

This sounds more like an issue of the IOVA allocating that use the
wrong granular?

> The
> kind of memory waste will be more significant on arm64 with 64KB pages.
>
> So, optimize it by using fixed 4KB bounce pages.
>
> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>

Thanks

