Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7482899
	for <virtualization@lists.linux.dev>; Thu,  4 Sep 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987864; cv=none; b=hEGr26tUwQzNsCmX+2am57BqaLiF4i6xU6kfmOqLUyrl5/guVwPRrCFil7zKWY6S826oWxV4liEGhJEEdAxxtzwo3DYqHEbpjWwFiBgFuNXE4tnCNAxyXN1XcAGF0ePdzPUjLzPgL5nGZdIjOOs+ugUumRAzFO7a/qM+MoW7H48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987864; c=relaxed/simple;
	bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jiud9WaeNOKWA3QniMQexhRwdIlGDJyiIzXliZYqE3DlwzG4rbULm/Xk48zL2Wbjn9oRM3A7Ky1mhZuNF5J8nvLKNgkx/h5jDcUOq18WRru/qKuj2Id0vFSlJG39YT9zEc+GnIndVQFpRwA/HMB8Zh6TzoMe2o/BUZTrAmlTEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qkkStj7J; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qkkStj7J"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-809f849bdd6so99072685a.0
        for <virtualization@lists.linux.dev>; Thu, 04 Sep 2025 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756987861; x=1757592661; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
        b=qkkStj7J7/bDOpmSY5+4SPWEhRnAvkdvUCUeMMZx1bP0XLvNspYOfoJ9LMJbveFEfp
         yyNSdSyqYxOcvY1bOo4bLUX9SMrrlOjMxhCgBsMBjjQ/4mgNYJxB2/WO7ASq1WBdwbqg
         qz0mEZIz/h5wVZy7CULYtlQITalLgfP0W2UCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987861; x=1757592661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjlVq8FpVKFgiAyllL0wB2r8/I9yHjQu5VbHsqkQxiU=;
        b=un5mA1Z2Vgbnrj89cTF/loyk98G1HVZYVZJGuoFwhvxgt8tEEuutWBIyIw4Ha9nasr
         iuSLHbzAAIfWhYBRCaq95CdBrgfKPA4lan6oqm5nNxHipZK/1BRrcR4UwZMRpi5s1Qwp
         aDmkfcDEfaMOTp9JgnztbXfOIqIWwTLb64JGfWSfHpKnIp97kYKINWFPmXkvClHecZ/1
         f7/X1wF5vX0Ecz5Fx5s+bUWSomAD8lb4pfaNenHNFpw3R9fdTO6rgvAGUoZS6SHKIEa5
         99pwb1HAIfilUgNwaqm9qfR45WmZgf1l0mWty6M9qfsdO6bECqJNoO6NtpytSfqLAn2i
         ewnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSzbM5IDcJ46fs6+JYJOLXtYNtBEWkh1/Ic3zGlsPzglXTU1NBDh/2kdDIou2lSnNYOLBNi3A/DWm1HjssRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFLjjRe0Q3ai8ADEV7GD+7NS/HPWSOubjTRL8XkJzhA5ilh0co
	D5DHVrOzQUR7ycRwPV5fcJxm38+t1U8Sx1JJWuD+g9jr5TqrXGrkOCo+zvsw8VOqsmBlL7dw15z
	IYAMOwSzBgaOIqsQWKMCoQf+/pTDQHHRJRJ3F2Xb5Zg==
X-Gm-Gg: ASbGncvFMe2lsav2CErCW3NGJaI6LWB4Z7ueY582gfaRP4wbMXCjEQPIpwoUY1uE44U
	X3HTCQ1yY7pVoFr+jFiz2otO0Sjg3LO2yJ9BLR2M1oHhtB9K8SE8lxH2nD73VXjWqy7eJd0e01B
	0s2Wq3ChVJsSOFxVgdoZSLe9FUCo5Fan7zdjNlXMMNRs5CRFeI3KW7ZuwHWxuIMOXgiBGpS0Hrv
	YKw4L8/vcB/4UOdyjmrztxLazFDetToWiGCOttNUgA+dBwIvnEH
X-Google-Smtp-Source: AGHT+IHRBKQCViOy+3E5ogp9zVpNMNg0Q43pXtgHycVq8ia8hUOj1ReM9zgzxUU55FO82PBbTz+ok2x7oLUwMlmTuHY=
X-Received: by 2002:a05:620a:2948:b0:7fc:c964:38df with SMTP id
 af79cd13be357-7ff2b5a713dmr2135908485a.55.1756987861094; Thu, 04 Sep 2025
 05:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250904120339.972-1-haiyuewa@163.com>
In-Reply-To: <20250904120339.972-1-haiyuewa@163.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 14:10:45 +0200
X-Gm-Features: Ac12FXxDCj7qXFPJlrrixUNL9wFH0RfwVg8nWGcK3mUz3g-juiYtolyxpTYsSD8
Message-ID: <CAJfpegswS_KRpOxsCYCR9-z3uCGKrJz_=-c1__CHimHC7Y=M2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: virtio_fs: fix page fault for DAX page address
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Haiyue Wang <haiyuewa@163.com>, David Hildenbrand <david@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, 
	"open list:VIRTIO FILE SYSTEM" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 14:04, Haiyue Wang <haiyuewa@163.com> wrote:
>
> The commit ced17ee32a99 ("Revert "virtio: reject shm region if length is zero"")
> exposes the following DAX page fault bug (this fix the failure that getting shm
> region alway returns false because of zero length):
>
> The commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality") handles
> the DAX physical page address incorrectly: the removed macro 'phys_to_pfn_t()'
> should be replaced with 'PHYS_PFN()'.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, can you please pick this up?

Thanks,
Miklos
