Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC338F98
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805149; cv=none; b=OJGfLrPNTjtVMnsYr9/n3JYjZhczZKsgM09sbdRPeFatzre7FeajFAjsVf0cSRpWf5uUJDgSNPyYcYfObt0VW0x/5iR5GINkmREo91NZP/yZv4SxGRleH/DksWPlrZ46rkJF73XHjx5PyJgu14bUuw+bicQBcnZ19AibZzJgq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805149; c=relaxed/simple;
	bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hr0F38RtrR2TTBjKGMzIRGqSyi4gapgPMuFzNBqHXUouFNZBWf00XKmH6GYt9kbKpIuwmufYKM55nT7mpWm2Nl2yK4W3vSmwP82CUWfLS1d3+/PaWlK4ysP0y5rkdgPKy4JH+laM/kiIhyQ+bG5K5eaLs6HyeVTbcE1M8uGthX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OqKhqzX9; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqKhqzX9"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FA9E404CF
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 20:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPlXzccwf9HN for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 20:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=32rtfzgykaf4oa6jf8ckkcha.8ki@flex--seanjc.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 59FE040490
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59FE040490
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=OqKhqzX9
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 59FE040490
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 20:32:26 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6f441afba80so8253765b3a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715805146; x=1716409946; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=OqKhqzX9HVjOY67J6i0t5NPHz6FnCgB0BbEYxZAE8OC7ZtJhR9f9Cco+zt38qZmImL
         ooPTJ+yxQYpYTEao0Glw9fgNLtCt2tg6odDsKyV75r8916YPI7cscqLlU7LQNe2Ftfmy
         gUqm8tN1mOXNa/AK1HRyYj6o/yI6o2YfU32rlpyw+i7As9QS6mbGqVQ488WGgilQ2OoQ
         F2OLIV+C1Lz0OpTAjH75A6CWWftPKcPo3+ye7Uo1Qz2JA9ca4aYHu4/8YTCzLyxz8zAN
         IFaY9EA15HeY9iclWUB9VVjJ8RtEy/+xcnBJp6J2+FJqCrZveQi4gm3HsaD7qlAq7wmK
         zp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805146; x=1716409946;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=J7HKJHeSOGgi0vqY1FtPGts2VEMzbM5D5bp4C/r13Zd+eU2PNESvYIOlRftLGQcZ11
         pjzos3Oy26LqpMfYj4TmOaAMWNtqgoQM3J79KWNG3+GvpFEYW0dTJVTElmrobm7aNq07
         8/JMXao3cXbGqgqzU45GfJDcqvRAQNJUZMEOyffZwmmI3SDLEAbC7gpjDTkL2hBLpnHp
         7i3oxmP01NHPmsLCjtktvhEYxPguWlgavG6d92x+MmQsLkM4aRPVeoa3SSKpy09VFhkV
         9ziRpxI2oyiIFBwuEyioeZqLtb96M5Mmgbq9NB3rhwL5u977zA0PJsBof6htWpnKdAwQ
         Mg5w==
X-Forwarded-Encrypted: i=1; AJvYcCV94euBBE2//erW/j8Trz/npoe2SUU3S0kjYCmIk+jPN6Q4ptMjy0L9YGREMADU1MjnRDpSLnNaKUXFlY7lUvNnNauyCo68eU8KwcLzgdKJwnE7QPrTVP4w0A==
X-Gm-Message-State: AOJu0YxGa+iK5V2K1dowxyt1skq/r2ElyYtNcMkiAyM8BbNaRKAPGW4I
	lq4glNEY0wHBO7EOqr5fPp3iFZVpe3bbja+gQUCKLtSOoMaA4dJGETSxSbYV/3h0NQQI6ayt80Y
	eZQ==
X-Google-Smtp-Source: AGHT+IECDBDOitjYW0H0HtQ+B5fogjE5oB/VbBha173B4uff3BsqArnMeFZozd93oJEEJOGvPRJpNAKBnf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d26:b0:6ea:baf6:57a3 with SMTP id
 d2e1a72fcca58-6f4e0431a08mr1169393b3a.6.1715805145969; Wed, 15 May 2024
 13:32:25 -0700 (PDT)
Date: Wed, 15 May 2024 13:32:24 -0700
In-Reply-To: <20240514.mai3Ahdoo2qu@digikod.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
Message-ID: <ZkUb2IWj4Z9FziCb@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> > Development happens
> > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > branch, but I'd advice against looking into it until we add some order
> > to the rework. Regardless, feel free to get in touch.
>=20
> Thanks for the update.
>=20
> Could we schedule a PUCK meeting to synchronize and help each other?
> What about June 12?

June 12th works on my end.
