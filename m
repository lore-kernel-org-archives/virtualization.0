Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852472C0F8E
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878042; cv=none; b=uQdXqZWwAvDdRbNjKREXcJ5jBQrDu0rNRxxO8dm4XThdrOBsxItbJvE0Cv0qZrxt9tg/Hxv+qJm+/z2Zbw6MLhCjAe+hQHUufOvjNWg2bcHaBu5AHJ34gsxnW9KRN1LQDDlIb3Gq1fFVvzEA8VZKGH0ly2vFJ3SiED3GRljRpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878042; c=relaxed/simple;
	bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIqCoFGVcr6cKY0NgAHiUfikKEROzzvCpE6OQ4Qv+8ykSQGjaaI4B3kIq4ZtahmXdaTDS0WoUlczSjWybO6cyUSwsVynHi7yrzuqq0uP1IavxeQTk5VSk4ahQZ9/FIj5chKOHkt1ExiwQFOQuHn5I/dM4UcQ0iJqYqFw8m/Z6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QzP11r0C; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QzP11r0C"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so2315052a91.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761878035; x=1762482835; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
        b=QzP11r0Cm2dnfgBLRjT1Y3jB+c4QzOWoQGORVskmsPxwYxlY+Au4Wp4v4obSfhDNOp
         WYNnFRBtRANHbiCN1o43qKBkyL9w8YWYZltzKK90/bwUAlYDoyX7bs4Y9PDbew7ONM7X
         Vn0VWZntR6a/fRsQGahV8jaNVWzfQ15xH540ueIyt8GZWT5gAJKsDVYdLZXB7+OwZwty
         jiAYNh91T9Xqdx1VxHrtSrkqckDbj3QpMIfjf6pzDsmP/CiQ1ZXaz9En5vBUgQt8StOJ
         YoDEAQfvYiDLimyI9HymYwoR5Y24l6MC4Y2lPp37GvVAmkQCp09zKKOOvnLm7MnIJ+Gz
         WkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878035; x=1762482835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64JYB4DHZTuzDjFXpfrzIZgXbdT5uWvgDU8kavKrSIw=;
        b=GiScj/g/P3B0SOhvDeN3d3nEi9FaHNJ5JNDs/5u1ZiAW4L+Sn+A+acJiyumK4SpGpK
         sw0w3T63o+tYcB5cdpSSOSjhtUsZi/olRMkY/M0L4Kh9nbjNpgjq/nkDref4bQ17mCEF
         a1o8OOjzozervp+SovnttQ5SIkhbmFkIg1vRY0C1lUsIIIru4XRsZ4fATZz0/j2EeNOV
         e1X0aekQN9Yn8yHhMjZOI802tT3BUQchfrZQi9lITF0O2x8dAnIi9UOkIGwb6GgFQ0bP
         gDIFGZC2yB1uY3ajN1QsEYwUqwMjiZX6y3ow6IrGovrdnf9SAa2HZXnX58PwOSSokh0k
         oFWA==
X-Forwarded-Encrypted: i=1; AJvYcCX6GmzWbc+rWDkiWAdXMiZ0+sXVDjOy8KLmRamOvmRKgeIxGmANZrlCu1252rJwkIgYQM8LV4X4/Da+PQDUvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9Af4DDLVxxrZciA/k8hUunwiPuMjJ3mbILZbL4rp7IMQePFJd
	SmEzxYkfFCuZP8RJUV44hWRQeqCm/fsS+CQ7/Bp1rrfkEPobWzvD9TLBy5SFUo63FjvXVjACw3l
	TIlqWx/x4yBfozdlD2NBGV4pyTQ1mC0crDWq/B4Jh
X-Gm-Gg: ASbGnct9irmAfKn/HsFV2SOEniGE4ctqhV3MtHWvj2bMnoz6sBS0+gqJD5gedcw0g3c
	BZ/Wtc7DJKMSZTrrJFyRjGGpWZ17+4pwXqYhhdAhOGnA2aUgbnXCNApp/RhTFZ/4Ac1eToQE+zP
	cAoHMv5osz8JojRDDPFG9jhxgrn243CxBVCCeSjFiAWQzeJ3Y0wqZ+9UUufnkMy8Q2aeZZyfA4d
	6wKziulRu4iFQEmJQQQaDwnc4RrK8Cr06hMn5YtuXFEwz7UnfGukXr0EMIvHsm85vK+T/Ci
X-Google-Smtp-Source: AGHT+IF1L5LfETuJY3fRNGNZWBg790ZqhCdeqmVXikkzD/x6BL82G2EbGGctb/NAtbNB4bEqy125S//o5Iz1XrH+1uU=
X-Received: by 2002:a17:90b:1643:b0:338:3221:9dc0 with SMTP id
 98e67ed59e1d1-340830897fcmr2636606a91.37.1761878034541; Thu, 30 Oct 2025
 19:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-7-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-7-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:33:43 +0800
X-Gm-Features: AWmQ_bmuXsrv-EaQgSGxrjM_8sqXlKCig3_hlgODjOMZx1KJxhUrOhWkug691dU
Message-ID: <CACycT3vHHSuWkkTZC7GK-T_nhUEsck-YPf6tfOsTC2R0SPbgNw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
