Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300C2FF661
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239648; cv=none; b=lrJ9vUICI1+2yw2KDQnOPwuaTGEAKrHvykNzUxHQRHMgLK32Lp1dhrsxpnAXF7RIXsu+3ozWtxNkNQdmW3xyVXSpnpmHOjyxSamq6cZwgy+ocbEywxObhqPpFNVWAUqpSvFS+mR3w+Tri2Ur9bMGULa/Jdf3r2Mh8wPsRyOBPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239648; c=relaxed/simple;
	bh=JEk3Jb3o2V3Ykrxdybm6wJkA8vNlfxfi4dCZ5w/NQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZBR0wzT78Jc19UgPNPeDLvnOH2c6TI9853NG4nI6e0vR1E8XhXeqeNFNX/h1C7xdPC0yQJ4Ntw1nslwMK9uX3ShNYP1NeD9YRBCF88Aw83uNE/yuGFZb/sUYfw6tk9wpkxTj1n22ZhM4TCesePwLVTgUCWwoigqORRu6s8eM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XtAVc7Xo; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XtAVc7Xo"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so8629511a12.3
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 16:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765239644; x=1765844444; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=XtAVc7XoHJjVo6nmA5JM3j51UAAvcpu73HvYoDu3kOAT0M6JM3u9wRXFYBnKwuoSvr
         kBsOaDNIcIgj51sV1+3XfQoQkKGz4UvjA34UgW0lgE0I2Z0iB14gFqZTEmv8tqYhUq5B
         r5GXXXsGjshXubw3GdFCj2gF6kic8l2YCRy1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765239644; x=1765844444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=AkuNiYVrvDmZqhGKpbdz+e8C3vCOWJ0wp2kg0vhBkLCR8UfbfYqn9ikG1IHJKa5B1j
         gEkkf8kByOmPxZEwUrh4YiXfevZXM2arMpeQgrFvt7nCT+xQRPUJJ8cLEkf2LD+GeGG3
         4n81RrPOvpBkxzg6tFaoyzMF/3XX1yVixizKRDwWe7ENHO6KMo0CBVPxuDNMIp3LK5NT
         SDxkwauWQRb2MHG+fXc8jDwtv+gX3qWFV0Wx7qYHyOp7hd1ZoCH1QlNqq0QWRuidd9/s
         ReygVdnG1ZTr3ePhMMH7SPfBDZ5JrnsxXHyKqmp3zxkjHmaeq1Z2uJssZWHNhwAAy41f
         MPyg==
X-Forwarded-Encrypted: i=1; AJvYcCW63jZs0iF3T26x0aM2nR78WnN7bVR6YzERvnbEr6ZWZsxPCuXBeooHnRYBCu5BcP3riFyYjqsSimRpMd0y8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYxgFnE6CGLZqp46Mx8LuPvuBMKb5R7lD/EwS2W3FytbNxP0nW
	GpRlBYwXc2S70cqHRZKQ5ZAGCUIa7hb68E072fsurBh6pKpROvJThT9/xSMVPmjWm9An/ZzvKZX
	FFjEyvdT/Qg==
X-Gm-Gg: ASbGncvSdQbNSuVqUZWyhLEArIHlDbo5B6Kf++jaEXyhVw4hqx+rsw3MbPFLPFZMrCB
	M0iKI+FBqkkr35FP73LVjqyZyMChwHqIjYUoyTZirxrdZtKs3vTjrsdQ7m52Grp0FRnCPNya8qN
	LPLRgEc+xPAuDXhm/X8E5B6gGK9P0ASjiFlO7pMrOdnVDP7XxJNY5JVlv9810UwuxYv5/i7J+Qv
	kydBSI7Cy4155kvC9XPjXD/GnoX1XlC9xvumGKtC3w3NmZ1i7hc/PqCPX/DRejK/LLJCDHFmwwe
	eHjymA/BdGiAWFZuq3c5W5QzgsBj9XtL1zOJGXC+u54UadBd17eFkSeboaWgNdWk0A2J+iO41/t
	rzXdI4xINnzFeYnjUAVDqOvSyPDuL5L1uQeWPYwcJFyB3Kd3OKOgZCskaQyQnDITP/0MNlhRwrU
	/QnhkKuXqyD8TnMITprAPRCvsTq9OlWziZRYZgiQFadBAffd2GgJRLUfDtk2Ky
X-Google-Smtp-Source: AGHT+IHJANyq3BZgWu1au6OptL84l/UePHPpuP6xscRO8v9/xrGt4Errk7rQkIAhjyGvykbdq2LF+Q==
X-Received: by 2002:a17:907:8689:b0:b6d:5262:a615 with SMTP id a640c23a62f3a-b7a2476cefamr913796866b.41.1765239644075;
        Mon, 08 Dec 2025 16:20:44 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49e3fb1sm1233686766b.60.2025.12.08.16.20.42
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 16:20:43 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so8629472a12.3
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 16:20:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY/Zj/1KHwc6lvNc94J9xbAZ9KBMFWmSLRfYZI7HiDptlMwMJeLqNcxXKX9lsuxBaWGIE+k5wq8kXkmjyF5w==@lists.linux.dev
X-Received: by 2002:a05:6402:4403:b0:647:8538:fcf4 with SMTP id
 4fb4d7f45d1cf-64919c10408mr8423201a12.10.1765239641812; Mon, 08 Dec 2025
 16:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
In-Reply-To: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 09:20:25 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
X-Gm-Features: AQt7F2roobmnBFxkxCTs46omVLlLQvijaEzayZmWK0Hwr8qZTgYHcUtxshIhuTk
Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hmm. I think pr-tracker-bot is being confused. This one just came in,
and hasn't been merged yet.

That merge commit link is for the hwmon pull.

                 Linus

On Tue, 9 Dec 2025 at 09:14, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f
