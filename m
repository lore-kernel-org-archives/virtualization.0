Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518658;
	b=iARwK5gM5gdKGiULtJXRKwUkEH4qDM9Pu1Xm7G7Q0IcCCZSawQUUMU+XMYDxbwUWmBm6
	 YgmTdliSk/ec5+T81aUKOwSGfAUOG8CyyACQyYJB8yn1YLJ6Er0/9oOmgFnRXcdlnTryy
	 A/ScmBOKT/5oYcWPOjtv0L7LU30vGnbZRIhnts1WjTxLX7ATJkqESM+yXnJl12fWA1woA
	 5fYa8nKFkMBU0s7MoSI5r13aVXjLGY5AfmnknvLiw1xuTXU1oNhszZ4CZKXJ1ux0Wfn9A
	 RZrkoBmZdCY/MSBGyJD+OoTy7EvgGQ4CLXph5f8Gy1+GZD5dXmi6LNi8ffbQBfOoDxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
	b=VKYjs3iSX6f14IVOZh4NFxi49vt+W8TMKwytG88rHu/OKjqOYZlsoQcX4ZHwUer/9dbm
	 zhkbCnaAjmobrUxw2wPskpn1ECi9DvgDFiXV/Tg2L8ZroMteqmCfpHfqOtZGTq3H+hi6I
	 dr6Rt6J4dZPe3ie5mgr1hBrl3GjpBt7Pcm0XvxjZ9hH08wbe73Ah9ZwdT/miCZr1NmJax
	 VlIGqWEl8nbp7S0bYx0LNFnok5sa/cLE9AgWolesILkgcoewk/Evo9ZJUhYQEgJNaagZR
	 +AKYZr2HZASSXD9DOlTteM5OTigvgJJ2pyLu+aOB606gPYUbLmtxpg7YGVKxVGfjPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=W0eSyNYS;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6F606A32C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C6F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=W0eSyNYS
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5432363a12.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792518655; x=1793123455; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=W0eSyNYSIZSvPM74xsibK8N2mNSX3RWYrCjGZ2wyQM8CHbLi6R3DAUKGLSgmmt+gBZ
         n1pK5H/Lgw7FypfAYlsyWLYIN2a8dKsmzPdJ/8IJxPdGf439P8ku/MiksZR1Tbdn4djs
         RWnf02YqDHwzdWTgI8/RkLQjQT7kmty/UzOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518655; x=1793123455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUauNVWehf9yJlxoCpgSpQ8hZTVkN4yj1GOVaT5sy9U=;
        b=oj4yfA6qTdQMF6dJg05+atqd3psbsyhdSe25t/ZJ4wRNPpcLcDnZD45mk3Q8kaOWIa
         znUqtWFB3sSW+mQA2dKtuYjIzD1YhAYU0JTHAiAaFpKKH3z2bV92sVmUT0g64a22fs2z
         HtMjlBZ1UcjllJAvZa4Xsz/0J58tDmnRl2WCMUh8cK6F6DyPdReFWWx8jBrVAuxQeR+z
         dLwbrpCFn75wmNFkRi6PmoT3ZhJuxRMMKYy+EMou7pvbl5e2sUrvGhQYOJIWvP/paoOp
         cG9DIccv7O0RLXJyz95WkA/PLvr4MLbUu2ELPwwQ8aVNf3bb8HQMUxQFEANLw/5YUpad
         puFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBCTeZVxwz0QseistuCw2Or8er+VnIb7SjEA+tsFws/GD5x6vg+Qry/7JFhmGy7n3M4DiXjUL/2eURSOLPPw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrDocIUPoZicwGK7IHaLDQy2SnhmoLzFpCyRpWzOhAe5wGDN+l
	XIQP7l0NdgSXUcoBupeeL4zaK7YjT7Jsy6Af5VQ4Ok8oSi2Eh62EMR2cvGKSEyVV8n2ZbsyAHDK
	umYS1Lco=
X-Gm-Gg: AYBFou0ldfr2P+HhOPeSvG7bJheaqemssDmKlgCfbD5pF88uid8TDGxSUTBN3QJQluw
	OrIvMcpUp7TnCWY+nf/qU84ekECpNUPuQy5xBUA2ohy0nOpjBN0Ya6lEKF1KDEEZgVaI70dDwaW
	KDh1Z2aqoJ9Q1Se6MPV267C9p1dmFmBHW2zSYQQ2Yzv10y3LkMBs5FAb9/OZyySaoL9XJBn1lWh
	r8Ek9FAxBNu7vh/RqaMx/0GVYL7hzx5EAxJagNpUF9Cacv7dQmn57106q6Br5b9r95wtKiWrEPc
	snx8/rom3DQ4/eNvt0FhGY3GwwU2DauDuEbqmaFCqiSvSOgVY9pSOs+jPo/8t7I8XqsOeThqAsq
	2YcYw+X9bCUyo+uMfhi1ATfmN7t9kY78vhA5SJ9WzdDl10n7U3Yp9zSCiyYbBtKwK3cNBTmRqnK
	y+MVtYkRCSqOKeJRr3EeXGprghmoSuTkkWo5p2wPDDUCaXzbIk0nByEPUP7f8CFJgSPQ2u6wspG
	Ia0mL9IqFIGr4BYcLDEybJvEJeCF9KWIYunRXsVsBqlyx4=
X-Received: by 2002:a05:6402:c514:10b0:6b4:203:a182 with SMTP id 4fb4d7f45d1cf-6b40203a58bmr245355a12.3.1792518655300;
        Tue, 20 Oct 2026 10:50:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40297feb0sm39310a12.34.2026.10.20.10.50.54
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2a4e013a44so476285366b.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 10:50:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGg4VxHz5F1jCwErWuoqopka8q+QCaQbWNwKVDc5Higz/INVqOVa/2sNOCIfVT1bXu8rwad4Ouc8dptZCdKg==@lists.linux.dev
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id
 a640c23a62f3a-c419ef2407fmr811663866b.20.1792518653997; Tue, 20 Oct 2026
 10:50:53 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org> <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <20261020102134.745ff48a@pumpkin>
In-Reply-To: <20261020102134.745ff48a@pumpkin>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 07:50:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
X-Gm-Features: AclHuK9rATEm1NS_MFfAyhy60SuMBv6wKyZqfF_GIdeIDY7VES_ZxkiFI1mL3aE
Message-ID: <CAHk-=wjUb=G+9gtaSO4bfUYKL+tVBVQq-Zfn_pGbCfxNWbz9AA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 23:21, David Laight <david.laight.linux@gmail.com> wrote:
>
> There should also be very few (if any) access_ok() calls outside of the code
> that implements user copies.

Note that that branch only removes __get_user/__put_user - and only on x86.

So there's still a lot of valid access_ok() calls left. Some are
around things like raw_copy_to/from_user() etc.

But some are around things that just want to verify that it's a valid
user address for other reasons. On example is in fork.c that just
checks that the stack that is supplied is ok.

But yes, the branch does remove a number of access_ok() calls. Fewer
than you'd maybe think, though.

                  Linus
