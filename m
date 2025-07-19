Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA51E5B94
	for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916003; cv=none; b=TfYgoyfJ+i8+rn3dWFprBbXWNvKc54DV1kyiQwATacUHUsF6RWa51pqQRA/KRId9L6BLIJZovsrIuHtIy485iPsG2KKql6ZuG/ASfKaUADJonBjaKMht3b4vIICXzozIzWbL2OHaMyFZDR7IcLAfVD55Q5ccsXak0UPnvLxJ5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916003; c=relaxed/simple;
	bh=debctRQjSzlJnYfyYhsd6s1lTimVzgSBxJR2tnVBhTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PARdFzuKFcarctjB4XBIsio99DK4cqK+tH5rvPrefFqcXj6/NcI+wcgCcEARqGr0Iu/nRQ16eiAQx1nRBcB9YG9/9eUkCZWJ0M95YsMBvj7Jpayx1fJl5GYewIzQwDwho5Sy2dPHb+iXA0RVWhV2Gp22TrE98rEIRxMp0bpjYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxgO5CnY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxgO5CnY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a510432236so1673164f8f.0
        for <virtualization@lists.linux.dev>; Sat, 19 Jul 2025 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752916000; x=1753520800; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ4/BbAm7q5b5dUXzy7e13UOkoRfXmjmgAGnC5vo4+w=;
        b=UxgO5CnYGRBCZmgsx0aBqG3StQ4zXaimqz0067ruLj0CAlRqz6MXTuoSUtsZoGuIFJ
         iDMaWlC++zZCypsKQrUeapHCmxArSpvJsz8SSrof+gIceMn12dHobTK3XLRIhHlu8YhL
         cGau1vAoItzIQXSNqKiBgJ962WXo3/mNZobroHHn0FMrAt3LBb3WHuWw2fYvCyTs1HEO
         6KJv51JzWz9PEPeIjjgLDHgVNlMG4vjmg9dOwLDJIfJB2diaYFqMElIDsyA1yI4MVLTZ
         N21EHJRfCUGWq6pM8qJ9f05ULDkAVlgVK3v032WDsbYi3LbjEVNxysgx+X7ah8Slg97k
         xkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752916000; x=1753520800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ4/BbAm7q5b5dUXzy7e13UOkoRfXmjmgAGnC5vo4+w=;
        b=Vs2wkdTv9c6ci+hw4NiXhPyKiB5EjtCn/YrQ/+Xko3iUODnenuNjapXq17ncV3cadc
         e6kmQjE7SDqn3R4JGhkBkbVPM7Gq7LftoyfeV3I3KN5OvR/rNU1wuMsmpJAnsuBPed+8
         CDu8af8+AOcqHT1GVOPhccK+9Uz8IyAwb12614Vd2UDvKiZ496oJlzD4Js8LAC+35Yk/
         JLqp6SQP+mtotaHOkfZDRZQCM0iicT2wDYIv4SseMTy5U1OlPFnyBdsxgl2bPY4ReXNz
         QWI18oGIIbIAYQCeod2yp4ambCXxO7bNMUiv0gJNWybYvEJcnKC160VsAkg7fFXjQa7F
         fzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5duPGf8Tmy3R8t9WttH/HARKbE91MG9jRYuyQcfjA60VdvSRDw4iJfCYaUWYpRZuzv875Et55jxYSEhSccQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5HmF2nAXW6z4JGBGKlJhGFnisGvmKk7fUwPbaU3GO11dF9DzW
	c+obcybAbEGXu7UOJ2zZigtQlWr/kMbzIREHINPjf4UbBl7XYj86JXra
X-Gm-Gg: ASbGncsZEkmxdV6p5t+NpHJeyC2tf3i3lKO7t3/OGl2jWkBFQ8j7wE7zgiq6CXBCJQ3
	ZCRLhuTXe3H27QjKSOan8Mxv8vdQdfuYR9aE8JVyW0LYeiBS062YIamLuxLIKJCb7mZkz7IbO/M
	cIB+QWI4bq0kcg2XWd/Vi06YB0EMNbevkCdVJpsEUJYKdNVVzye2bp/XgCuZGPea0IBKAOlcwDS
	3FtBJlueMwirmqFU3Ev/xj36GrnicLjtkKVPu4/uI1I1XVnB2AfW8FVN7dAaRuzgOeuCl6lFNlm
	fjLTLblpXxrATZS0pHzfMsmy8O+8Kc+QUJOZw8+QNu3LsBJ65sVLUE4f9LPOAFXWW5eligDqEvx
	pabSa72lcNFEGy3/ZwWBNY/qm5bkS15g1+jXAAM3X0pKoQbsxK0i3b11+BN/UihibG2KWH2Q=
X-Google-Smtp-Source: AGHT+IF2V+UaRRGWERhibmmvf++qHDKUS+GtMYh7BtAfk0WgUMadD9FW5R+2I2VCTdG51w3bMa1o2A==
X-Received: by 2002:a05:6000:3102:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b60e4c910dmr10702500f8f.5.1752916000122;
        Sat, 19 Jul 2025 02:06:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f9c0sm42586495e9.28.2025.07.19.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:06:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:06:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, Dan
 Williams <dan.j.williams@intel.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Jan
 Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook
 <kees@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc
 Herbert <Marc.Herbert@linux.intel.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj
 <mhal@rbox.co>, Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, NeilBrown <neil@brown.name>, Peter Zijlstra
 <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Thomas
 Gleixner <tglx@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>,
 Uros Bizjak <ubizjak@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>, Yonghong
 Song <yonghong.song@linux.dev>, Yufeng Wang <wangyufeng@kylinos.cn>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-sparse@vger.kernel.org, virtualization@lists.linux.dev,
 x86@kernel.org
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
Message-ID: <20250719100637.361bcf09@pumpkin>
In-Reply-To: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
References: <20250718213252.2384177-1-hpa@zytor.com>
	<20250718213252.2384177-5-hpa@zytor.com>
	<CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:49:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > -       __auto_type __pu_ptr = (ptr);                                   \
> > +       auto __pu_ptr = (ptr);                                  \
> >         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \  

You need to align the \
Plausibly possible by post-processing the diffs.

	David
