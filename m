Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172DC2E3
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZMp4HfyB"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 967ED8223D
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 19:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 967ED8223D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZMp4HfyB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rv_wrCUoa0Zr
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 19:41:02 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC52382241
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 19:41:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC52382241
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a27c65bd757so45742366b.3
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703965259; x=1704570059; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoFIhXDqs+3JV6YOccBLM5u+iUwrlM3KyelM0uyYE3o=;
        b=ZMp4HfyBNmFqp2TUxfz7wuzL2AAfeNUMQIZt8L9OG+y6jua3HZzpRynXd/CCp+wRV9
         tcjqgMHRn97ddWKKqQiZPd8jY0JBFlC74Lj3/WB8RMg8RRowVQfsT+4ype0m53OSVZW+
         oYj9rlUTnHOJ+83AyELYamJj0OYhfVcDlUgT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703965259; x=1704570059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoFIhXDqs+3JV6YOccBLM5u+iUwrlM3KyelM0uyYE3o=;
        b=cC6l3uYQJa8gzyMhHZbl9ekPKmX/9ICu/Hk6AezognDZ8SUOTDln7cW1wNbzoftBRx
         PSAS4i2dS40b7H2r9qllZlEdpUWhzWLzUMDeH3V/R1YSGRk8qg7CwXUcBm2CsAGrbz7N
         0ctEZP/XaV6H1w08lZnZaUnhc/KcSIcEIWW74IMtoj76J3dhjlRGXrm60J55Qz0g0jyq
         mgFpwSmU1cRRSxGFfZePzoVnCKESAel1M1uFRmvQZ08MUaf51V/Zc+AbLXdqzOg/dDl1
         QrpR9v4h4kB9auIDy22WdIJYgPWqbCXJUj77tIq23qYk4XNVq6u+9RTG2LJPAyCuB43p
         S/ag==
X-Gm-Message-State: AOJu0Yyq9dyYaxlLud0VMdxyV8DlTJnogWfZKtIcuEMW88c7Ldwio5JT
	7HdYhEtjDgGThAvhyRV3XWdpStdqdjIDC26kcJxrFVvfvzxbh6nG
X-Google-Smtp-Source: AGHT+IHJ1vp9p+OTAxNoxGrh3p0EdTinI/LN+PPPX6xJdqEiCHfC2alHkfkngeDv91+T6xlkL8Q8Og==
X-Received: by 2002:a17:907:944d:b0:a27:2f12:4756 with SMTP id dl13-20020a170907944d00b00a272f124756mr4591621ejc.39.1703965259694;
        Sat, 30 Dec 2023 11:40:59 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b00a230f3799a4sm9391304ejl.225.2023.12.30.11.40.58
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 11:40:58 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a23350cd51cso870549666b.2
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 11:40:58 -0800 (PST)
X-Received: by 2002:a17:906:3a16:b0:a26:e4ec:b6ca with SMTP id
 z22-20020a1709063a1600b00a26e4ecb6camr3417319eje.92.1703965258406; Sat, 30
 Dec 2023 11:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
In-Reply-To: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 11:40:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
Message-ID: <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
Subject: Re: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock code
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:52, David Laight <David.Laight@aculab.com> wrote:
>
> David Laight (5):
>   Move the definition of optimistic_spin_node into osf_lock.c
>   Clarify osq_wait_next()

I took these two as preparatory independent patches, with that
osq_wait_next() clarification split into two.

I also did the renaming that Waiman asked for.

           Linus
