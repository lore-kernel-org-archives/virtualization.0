Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24531799F
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879440; cv=none; b=c40FffHi/3iI0R7MBlPo95RbI8DgwoC6OPmo579F1r7uF+SUfGwogcZy/6BX4PTnErNXmipJv1VXNjJ8zhv7XXwff7jBxyDyLgQlEczgA3KyhymA91+g9Fz3B8+ZhTTtZd5BpbSxqgR/Ww35xOhS2fUSezgb/82b7t6sr+7a+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879440; c=relaxed/simple;
	bh=qo67utYF/ovAn2X4y/cKDIWgVFy2L9OSLb/CZy1qQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBlDLUbnxOZptMQBK1NyNLeCBbWlbgGVefagGH1FPse4U4NE2JKAiLrD/+xCfAmlUgIGOaYmne0NSiiWBk3CLftFZAmD+Ob0Atikw6eK/8/g4glRV9tGByQ5YQuPX4wTsYLSU/Kzmhej96SEvNJzpIOcJAYUWQuM95zb1+IOPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SUtDvuAl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SUtDvuAl"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55511c3e203so2454234e87.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752879435; x=1753484235; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=SUtDvuAlbTlkIASTUPlWsglttx96NBCJSN1wU6hM3uD6kLj8UC3cdRQ/DnuSJNWpSN
         /c6cHZwuOtOh7qvwPLedIScc7bXe8aRbGh96hmPIW2rXuHZOQzUSMdEKW2PSDcILdhjq
         KPuzdYYvXz39f1UwyC4AeVMK/Y9A8hbeUsvuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879435; x=1753484235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqwKREBTKqb14178is+L3e4wy7hqQP2KCNVEXG6C+zY=;
        b=qX7KeIzCHoYweY3mUeDgQp9slHWIZSAynPo5JRcKA7GvtamTOH6gwsoCSvOX14G9Xz
         G6k3npewayyJ3pP9p0d6zC3OOLvZcmRTQRPQFUCXS689mnJdnLgYVbZxbG8YhuQMTRm2
         lHCLfEXKzPFzwpsABOYWdzz8027DbI0ue1cSW6Xmjh/IpG1QFYiahySb9671gbYTwkkD
         AGA4R2HPhEuZT9U25NEvzAkq3use8ecwqUG1JVx8f6Szxdi+PkOzzP4wciD7TXjE2jWS
         2wFw9/gyE/rVQMeKXuBz08ZKKEYT2UpauE7kElAwiOA6B25DHstF5ztrsdaZThUh/iDf
         T84A==
X-Forwarded-Encrypted: i=1; AJvYcCUBRWIMnCUBpWf9c6bjaI48k89/dYjb+aEUaBgvYiemXG7jbbBIUgTIQ4PhLbwXi+4BY/nFbYBp/zL8JoIumA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX8MDE0lIr+JDos9MZVawghbHvnZYV3zxIru5RxscyJK263IIW
	aB7VHdwLQs5b/63cgLVMIP8YcntmO7MJ5IXLvESIiWMPiB1lqLsD1x2rZOi4otiOcJK0rckB0LW
	ptbv5TUhp4w==
X-Gm-Gg: ASbGncsH+vImx6Iy9F2/0xQI4U3fDakEH6mnbp53xZE8ZsFN8/P1/PA1UyHDSK69HM+
	HE2OTV0jxS5b0Au0IftT2roX8iNbKnI7tRMmbCtdM183DX/q1IMwGnelMjrdz1ajvE9HRMTYXXo
	ATLXFWyGpYI/Cuk32BwMDniLPEfqaFMCllJpNJ4pptf6DhWwu6PAPqubLhrncy9RpdGknugadQa
	QD2+hyTI1rR5vXBYfF23rqIxOD5VjbyTznBwddbzcMesxkVlfXe1KXC6SZWGcejqRUqXpN58dOn
	2rzc/QIb+v2VGr78gZS24fxdDDQq2SM5zBSdQa0JMEFUPFRXHDCVs2uGu8y62YpNoyJmkcyGKbA
	cqBumqevTlJ5Idq/ZIut7EnGJENo4VFHosRocGut6HqNUFTPc6UAzJxFPi0a9kwx4qfO2zjkE
X-Google-Smtp-Source: AGHT+IH6KnZuSPVhlWbJNF4BEJAYmPzl9HkY4fekvbKE3P9fAZo6DpzflxY0ATHm3UtXEu111gTHEg==
X-Received: by 2002:a05:6512:2307:b0:554:f79d:ce48 with SMTP id 2adb3069b0e04-55a23f74542mr3772606e87.47.1752879435418;
        Fri, 18 Jul 2025 15:57:15 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da23f1sm427589e87.174.2025.07.18.15.57.15
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:57:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so2053494e87.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 15:57:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBAXIdVyKezKIquLYlaQ9C0bwj60ZEPLpqq4QrZJeo2JZwoOnbGXXZ9fWuV3kWb9o/qX7SxmRgH37J9sUGlA==@lists.linux.dev
X-Received: by 2002:a05:6402:84d:b0:60c:3f77:3f44 with SMTP id
 4fb4d7f45d1cf-61285ba5366mr11281504a12.17.1752878941898; Fri, 18 Jul 2025
 15:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
 <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 15:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
X-Gm-Features: Ac12FXwPQm0wFuMqO4T5e7rkg71dcrU60Bx64WOT68AUbiGf34w2BtStF_AEh5c
Message-ID: <CAHk-=whrbqBn_rCnPNwtLuoGHwjkqsLgDXYgjA0NW2ShAwqNkw@mail.gmail.com>
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

On Fri, 18 Jul 2025 at 14:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \
>
> But that second case obviously is exactly the "auto type" case, just
> written using __typeof__.

Actually, looking at it, I actually think the NIOS2 header is a bit
buggy here, exactly because it should *not* have that cast to force
the types the same.

It's the exact same situation that on x86 is inside
do_put_user_call(), and on x86 uses that

        __typeof__(*(ptr)) __x = (x); /* eval x once */

pattern instead: we don't want a cast, because we actually want just
the implicit type conversions, and a warning if the types aren't
compatible. Writing things to user space is still supposed to catch
type safety issues.

So having that '(typeof(*__pu_ptr))' cast of the value of '(x)' is
actually wrong, because it will silently (for example) convert a
pointer into a 'unsigned long' or vice versa, and __put_user() just
shouldn't do that.

If the user access is to a 'unsigned long __user *' location, the
kernel shouldn't be writing pointers into it.

Do we care? No. This is obviously nios2-specific, and the x86 version
will catch any generic mis-uses where somebody would try to
'put_user()' the wrong type.

And any "auto" conversion wouldn't change the bug anyway. But I
thought I'd mention it since it started bothering me and I went and
looked closer at that case I quoted.

And while looking at this, I think we have a similar mis-feature / bug
on x86 too: the unsafe_put_user() macro does exactly that cast:

  #define unsafe_put_user(x, ptr, label)  \
        __put_user_size((__typeof__(*(ptr)))(x), ..

and I think that cast is wrong.

I wonder if it's actively hiding some issue with unsafe_put_user(), or
if I'm just missing something.

            Linus
