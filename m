Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B01C2C6
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TeuCtirG"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C8184159F
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C8184159F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TeuCtirG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrC_5zCfWuVg
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 20:59:29 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FAA14051E
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FAA14051E
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso8753401e87.0
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 12:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703969967; x=1704574767; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGj2dvokpHswaDS3CEAC9U/qRCEFu6exlHCSnvHBeOU=;
        b=TeuCtirGpZiERVEhxpsdlgyJ6HzZb/ywMbcepDNFZVfPF7kuRJSbh6EUfuZjsVsF8R
         ZtBaRUeBsDxr3QpiIvlSPRQ3Rj6myIPQiCC80ljOyh/ZI+Z9tkbhaeUX6FOrcZuRSjwd
         dJ06bIaTg4nJFb5fE+7UdOYFpzzT13tpyyuXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703969967; x=1704574767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGj2dvokpHswaDS3CEAC9U/qRCEFu6exlHCSnvHBeOU=;
        b=k4x/DGVHFH5/sCaalCjr8kcj8v5FfIRRuBb1HHDUKbXLb25pgAlLD3puhnDOHc9bCX
         hzeEC25JFxBaIGyp5wFOjEH+S7EvGHQ7KCNTxqrcqqRFDfO5N7GZNNOYyv7XzVw6G8sr
         95+ObgHEvD+pYTMw4UnFc5LRRW6dRH4znCk9zEB8GZ8njWPKAhPVlo2pxzVIgnSmWjeu
         GgwNWz6DXgLdmSq0HaHaATDGNywOCcT0xYsMhhRs8JUguOY5HAwtAqvKXKJg7Y+tP0VS
         DWq6H+nVRnfabY9GYOhl4yClvopBE1nx1NtYMMu8cR8aHOK9BmBr9MXjCeK602yVUuYQ
         pjOA==
X-Gm-Message-State: AOJu0Yy4i66aRxtPfwZ+h2SO/QEQUllItXcDS5R2F72LyBdmi3YTctQJ
	GScSaHJ2wPSiqeWZzcO5Yc46V7acsvNblD77+mZTIAW9+LqV9iSA
X-Google-Smtp-Source: AGHT+IGjkj3tYvoRd1TUsZx7zniJusg2pZyzevb2DLcarcG++olj5KlvLkj/1exI+wrxDgNtWbjdGw==
X-Received: by 2002:ac2:5f55:0:b0:50e:7554:d33b with SMTP id 21-20020ac25f55000000b0050e7554d33bmr4564448lfz.26.1703969966861;
        Sat, 30 Dec 2023 12:59:26 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t13-20020a192d4d000000b0050e770a3b21sm2197733lft.5.2023.12.30.12.59.25
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 12:59:26 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso8753395e87.0
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 12:59:25 -0800 (PST)
X-Received: by 2002:a05:6512:3e24:b0:50e:6b5d:5976 with SMTP id
 i36-20020a0565123e2400b0050e6b5d5976mr6269030lfv.40.1703969965196; Sat, 30
 Dec 2023 12:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com> <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 12:59:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
Message-ID: <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data accesses.
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Dec 2023 at 12:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> UNTESTED patch to just do the "this_cpu_write()" parts attached.
> Again, note how we do end up doing that this_cpu_ptr conversion later
> anyway, but at least it's off the critical path.

Also note that while 'this_cpu_ptr()' doesn't exactly generate lovely
code, it really is still better than caching a value in memory.

At least the memory location that 'this_cpu_ptr()' accesses is
slightly more likely to be hot (and is right next to the cpu number,
iirc).

That said, I think we should fix this_cpu_ptr() to not ever generate
that disgusting cltq just because the cpu pointer has the wrong
signedness. I don't quite know how to do it, but this:

  -#define per_cpu_offset(x) (__per_cpu_offset[x])
  +#define per_cpu_offset(x) (__per_cpu_offset[(unsigned)(x)])

at least helps a *bit*. It gets rid of the cltq, at least, but if
somebody actually passes in an 'unsigned long' cpuid, it would cause
an unnecessary truncation.

And gcc still generates

        subl    $1, %eax        #, cpu_nr
        addq    __per_cpu_offset(,%rax,8), %rcx

instead of just doing

        addq    __per_cpu_offset-8(,%rax,8), %rcx

because it still needs to clear the upper 32 bits and doesn't know
that the 'xchg()' already did that.

Oh well. I guess even without the -1/+1 games by the OSQ code, we
would still end up with a "movl" just to do that upper bits clearing
that the compiler doesn't know is unnecessary.

I don't think we have any reasonable way to tell the compiler that the
register output of our xchg() inline asm has the upper 32 bits clear.

              Linus
