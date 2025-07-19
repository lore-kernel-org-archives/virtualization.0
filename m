Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFA192598
	for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935196; cv=none; b=WEv8UZYuLiD8jB7ROXNVnoltB+lJ83jwX9h0mu6gpSj3K/jU9TzsafBWVqwcxLOqYSIHKCNQlKCT2u7Yx8bgZQbAh1FD/8+TThMmqJL/U4fkk4WR5c2UtxKyPh1AQUQ99x1LS+e1cYPJlQbwCkpB70D/Kd6rGnVQ+ce2fqojI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935196; c=relaxed/simple;
	bh=Q9VM8+RfTrjN07A2gob6Pf9y9R1h/h3neejkCLSzKKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRvLI40P0A9QSKkIXKce02Nnfv/7tAcWa9Qi1Ftex4idoYkeT8k7KkNvZVmorttG9w3lQHuDDoDpvmEH8mLVB93qZaCjQxvRVZT4TqtSIGxZBWag6hDssAnBACH4x/0xE/Fmz3VbNNk6u0/UIm940m07bSKdQi6FSctbIg1o+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7T4Zp9C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7T4Zp9C"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so5461174a12.3
        for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752935193; x=1753539993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/azvO26ioqqebf0mIHfr/fJKozOpQTGU5YXwyKRsJps=;
        b=E7T4Zp9CG0ci2+Dc/9mWNuwClFtrmL44NkRgC6Fca7bJLTzZVax3GW8JQUcHpblTcH
         RHeTDEMSJY9U0H/C1nq92/MEaOE7lOSX4L+oI+bS0nnIqjdOwZfrQ4wljxoZ+5E2gsQx
         KP5kl4rVIJMjLuKxLs59Zy321HODuJvM4iMpty+csjff8qifTXZitSVU28FIwj7J0s+P
         zpCCQyHz+W6lhwrmhWhPrwso2QuZqPkevNZGlvYmvuE8vHsBC3jPD8LIDBnRpSsV8A9/
         aPhOr4VlZy4o5lNJJbbLWWO3MXH1Y0+TTH6fpuYVTtMAW2IPIJ5JEBxXDL8jwnT4ALMQ
         +sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935193; x=1753539993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/azvO26ioqqebf0mIHfr/fJKozOpQTGU5YXwyKRsJps=;
        b=hOERZ6Dg3EXJHLj2PC8GkdSVbSWY53cDBVnIBOJAPqqQbksWp2BcPrBzp4zJGgsa9W
         h2J2DKEZ+fLbBVPeezn3gYSqhRX5JTol7PErTbTIB/XnDsWPWQya7YhWIGdSj3tjK7tE
         1ByzI1ARSL0uz8lqJY6OEIwRbJKnwwc8GovZMRQymS4LLuRalXtHQ/Fkf1udZx/erbpd
         9/P1/SVLZ4h7QyfyYzZ66pRChZ5q7JjNx9siYpEKlkS+SBKguLmgd2qNhJW6grltPpvh
         orbCYVt6LMyOeVedu1e8HshO5IM4yov4/veFGGvdOpQvBn4uPNgBCW32iyVI5vI8tyJw
         ghoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZTJRql0usg+9uaMGYNM716X1ZuwyT61prSJ/B/3CgE61jfn/3V/eD7J6d0niWiyJPs/lyDONRLlVvWakEkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA9dQ7+xMpnUiybDx4FUSU1MMGVEbMU2UWEsB1mC8ao4kHqluI
	lGR7b2RlX1I+7RCRPbSYCLiu1Iwl8AHu0HwlP1wo2mhnmwrS0WQ5jW4=
X-Gm-Gg: ASbGncvkAj1RVmUUMteqjkgI5Z23Dp+cY0WogZX7QWodsZPmLGIERpH+EyqR6uoyhvX
	Vr2O8combSKGvIr/2G/NBBZo1XC8EwK/IEPH3pFrcJ09pScxtdMJytv7P3szfonMItCIfmt0CSS
	hiV4fq7Xn6lEHpmy8WnAPbbOrhdTwmiNYlD6ilsDLcME2xk+kMzUVssbmwILOiGJ2f9exnl5zSV
	t2Az3jiSQ2C6ZNk4Lru3OZLdzZidN3Ho2nfpSELN5iRwqAM7qnONb1867in2eKAZRazQJ2djCVn
	lTQ4+4y0aXD8Kl5fFNMoJlJ5V/XNFHRcT/+VfZtrqfns3P7hQDgPtbAMHTQXnxXChwDMgs1UQQE
	3MXjBICXLw/erCEoYgaGI
X-Google-Smtp-Source: AGHT+IH4rIX/bypehArMCYVoJKbKtQr7DZ+CDQF06CuILCUV9Hj7vLhxbEx9C5tE4wNvPK/j+RVLfA==
X-Received: by 2002:a17:907:80b:b0:aec:5516:239c with SMTP id a640c23a62f3a-aec55163f91mr913241166b.58.1752935192840;
        Sat, 19 Jul 2025 07:26:32 -0700 (PDT)
Received: from p183 ([46.53.249.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79ae67sm317872366b.11.2025.07.19.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:26:32 -0700 (PDT)
Date: Sat, 19 Jul 2025 17:26:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Cong Wang <cong.wang@bytedance.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	David Lechner <dlechner@baylibre.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Uros Bizjak <ubizjak@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 3/7] fs/proc: replace "__auto_type" with "auto"
Message-ID: <63adc48b-9b81-4f35-9462-0de103474d13@p183>
References: <20250718213252.2384177-1-hpa@zytor.com>
 <20250718213252.2384177-4-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718213252.2384177-4-hpa@zytor.com>

On Fri, Jul 18, 2025 at 02:32:46PM -0700, H. Peter Anvin wrote:
> Replace uses of "__auto_type" in fs/proc/inode.c with "auto".

>  static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
> -	__auto_type read = pde->proc_ops->proc_read;
> +	auto read = pde->proc_ops->proc_read;

Thanks! I'd prefer "const auto" but OK.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
