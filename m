Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2E1799F
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879521; cv=none; b=lz7+JE5brSSgzpobcQ73XB7EGlqLZI0shDqxjeZHP+PdB20MvDzTu1rJDy/yOt6HYeiKgIWcEcRthNn0qtNf+01X+snP51xjQZEGYYGP1MDiCmLh/XoKde50ck3Ae2ldiks4vl9EqxGJUXgTlizF0dDaQb/vSjKGUE2++Nz3seI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879521; c=relaxed/simple;
	bh=H40tep0Rv0U6gqMR0evT7Pj2Me2Gk77w4/2xIDdHb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeN5jaJZ+vaK457B2dRIofw9kjgKq5moKiHwDaOldVX84oZ5C7UIckcnnnuLqxW23rTF9cZJETt8OaVjhBq7KngI5s5H6hwaH7V07MauQ7fh5gXR5MpiISEgNq0UZ6DlPfS6OWq4xC1SD4zzQtMsDcnIA+c2m9OP8iV9Uf9cFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D86+aSga; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D86+aSga"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aec5a714ae9so284193766b.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879518; x=1753484318; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=D86+aSga9V88Nv/GrFbDxZYxKfW/akmrhdiDydEsSuW+ZiDzYY1+1J6G/fLeqjo+l2
         qpcMObciTqMvE/9MxUqvdo8hrmrpsOMd/5I5cFuFWP+w+Hk0xsOp9ItfMOFGkiOc1hMf
         idMOKolG54Ijnq9+luJqn+OgFvczjmP5Zx5J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879518; x=1753484318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0G8yeUdMDA9tVTNUd0r33p22vJCTOHruEzV0haxXnE=;
        b=b06YGrUhkqRLkyQytnryq5396arNvJ0jIuACRcsq+ByFOCLgCzYFpqXtvlMWSEv8Ip
         Mj8No+YRluZNKLyQkgFCxCekTyX+rn2o22IBGMu4m5Mv0HG9H/pAZtwq2K5a5ZHUtNmw
         GZjNv1jLc3zbpiteHEZEsgqXkIdhjlQduwGwNvjOZHOo/suflRrSO/eTAg7fVFLX/DL9
         8YuzWI8XRNDOEWM2AobccbTqTB+nbyMWwYTjYJUvFpT3+4I6ExVvVri+8ZvD3wh06Jgw
         sRJ4/Ey6EnUSRqhI6+6HKH4QTchkPBYYusqGmgOracFjWSPrii6bXlUJ1iD/ViKGw4HD
         G6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUILBLVGpgkIyA2A/VJWGa7XWxiei9/3UZa5iWKctX2gBB2XqaE44zqBlw75SG1qmsWsAXluMqn/+gQPVsorg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz39JvTyefat/qy7DqOxd7L2oxzjqgU81oOmkhM8IoYqzXmNEVK
	bnuOHany4g6jwyO/IWc8we7UxqRyrzf0zj1q82sNWQX3I7nrgdFXpmH9SkFDWipGN6T+5mrM4U5
	qzyAQIe3jBA==
X-Gm-Gg: ASbGncua52ecYy42874QztXDvd+DCXmDJJcTqbNRpKMrGlkCI+xZyTIObUOBxzawTH9
	DXY9oU/zAlHqXHw3LuuiGi2+47qCkofRrrK7qcSSi4MHImbeUYI8iuT7FKilQu7qqVDgcIAlceH
	j5+zl28zyXgzDUnZzvQTyPpXHCuOVYUj6Z0GkuxwXOoKXTeW80HRA4ugZqDzfq37szykBl8Q1dD
	9n5RbgThpaxDbdVV55y3Avocbkdtz4HiIYeP57LEjiG0SWF5bEPPMMMUbIotQRDOpvtOfo3lVKQ
	BeLZHx1B4LDi/aiI0j4T3NzQNJ/6j3Wf5by8zFWYPKIUr4hXc9KSJmkBYq3IKEalseystbXk8Bv
	gw86JPclLlle6n1ixnIFoZFSk6dgUT7tVRi6tvG0sKyYxwcA9O8IxWQ8H3O+mktH25RPD3rpB
X-Google-Smtp-Source: AGHT+IGwoPeL3ITdz3XLLvd4vMjyIJqf8clIkSLb8ldgsjShCOyrtOf0AmgrHmzY6fMKSrrn8vBo5A==
X-Received: by 2002:a17:906:6a08:b0:ae3:8c9b:bd64 with SMTP id a640c23a62f3a-ae9c9ac1601mr1323686966b.29.1752879517590;
        Fri, 18 Jul 2025 15:58:37 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6daf4579sm187857566b.77.2025.07.18.15.58.37
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:58:37 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so3872459a12.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 15:58:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVq6JDi+3E2Fos82ZtkJdUBo3Y3BAI6SetEKjl6OZ0ibnZjqcNfSXXSsT7drxAh4cTf3Of5WpXCdJuiU/1jw==@lists.linux.dev
X-Received: by 2002:a05:6402:510f:b0:607:6097:2faa with SMTP id
 4fb4d7f45d1cf-61281ebe074mr11282976a12.8.1752879516873; Fri, 18 Jul 2025
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com> <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
In-Reply-To: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:58:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
X-Gm-Features: Ac12FXzEvcUEKGC31NKbtJTOHrioow4MaXx8l9_sG1eUWxP_1nSQ3xv-ujuWcb8
Message-ID: <CAHk-=whiL-ieTm19zuPqC9HLHh_-L_3pSMRUwsaN4Czp0PW6iA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 15:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And while looking at this, I think we have a similar mis-feature / bug
> on x86 too: the unsafe_put_user() macro does exactly that cast:
>
>   #define unsafe_put_user(x, ptr, label)  \
>         __put_user_size((__typeof__(*(ptr)))(x), ..
>
> and I think that cast is wrong.
>
> I wonder if it's actively hiding some issue with unsafe_put_user(), or
> if I'm just missing something.

... and I decided to try to look into it by just removing the cast.

And yes indeed, there's a reason for the cast - or at least it's
hiding problems:

arch/x86/kernel/signal_64.c:128:
        unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);

arch/x86/kernel/signal_64.c:188:
        unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);

arch/x86/kernel/signal_64.c:332:
        unsafe_put_user(restorer, (unsigned long __user
*)&frame->pretcode, Efault);

The one on line 188 at least makes some sense. The other ones are
literally hiding the fact that we explicitly cast things to the wrong
pointer.

I suspect it's just very old historical "we have been lazy and mixing
'unsigned long' and 'pointer value'" issues.

Oh well. None of these are actual *bugs*, they are more just ugly. And
the cast that is hiding this ugliness might be hiding other things.

Not worth the churn at least late in the release cycle, but one of
those "this might be worth cleaning up some day" issues.

              Linus
