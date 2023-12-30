Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC96AB3
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIl9Y7yz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C40F481AC1
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 11:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C40F481AC1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AIl9Y7yz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1cWoEQdGbxD
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 11:09:26 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EFC4E81A24
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 11:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFC4E81A24
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40d604b4b30so14702135e9.1
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 03:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703934564; x=1704539364; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IV2BKMSLhIOyXxbde9JcIy67hYaYu6fjXIgvjqlaklk=;
        b=AIl9Y7yz9fm6g9izCsegfrWgihJWUYcWaJNjofyzo7+2ZP3TJSlP/gUHO6AlIk0VF5
         gUBch8y7472sVO4lh/iY2uAd6IffQB+96vvZgI0AmzNSkzQtRqscIbEuEN6EyDEy+qgj
         eavG0Y/A8cofvsthuUwiD//bCU/lD1IN6oJoxaaRUSfv7zQGIPI73JFUMbQUfEI7Qkq4
         YvWsSUnstRnAka94OxxxM1iBNmhM9X5oc3ID+UumY6EEvOotikrBWfpj/mR1n3gEn1CS
         5m/SGdnI+b4cgM6wTDfMUuZNXuTRbfQamZI0H1y2mQuMPRAVoKEVwX79m2bp57Wusmh9
         kaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703934564; x=1704539364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV2BKMSLhIOyXxbde9JcIy67hYaYu6fjXIgvjqlaklk=;
        b=dpxiYJYusX1rtEPupqBXwqNkiHTntFTpf7FIpYHy3hUBWpW3la01fxmD658OHrWb2u
         7zNBbooX7O9jg4Y/ZcYG/Z8cpS2+8/T2Wg2R8VjbwsmDiHFGxSoKYg7dxkla/3KvsIHN
         YeCBKZV2WlKSpqQva8FEYp1Tp8E4HxclLFZw+jAbjIM2Qv065PEGMe5NB8RjzdDNWX8H
         Nlc3v2K8Dh1msQXZK88HoknNjFKXLeAUtoavoeNrpJtkV/A2lho9WNySBpLZAErjwh3Z
         o0oEjbH8vBqSJKwKKlJxuVsdvktJ3wpzRR0+y1FhGx2nByk3jQA7hMcU7AENApE7X44O
         qbbg==
X-Gm-Message-State: AOJu0YzamVPgg7yjsE7sg5vzIJpAv8pMUBc4i8gCx9qxgHj9Hpy8I7ZD
	Fzg6TO9QUnNGTQVsVyYAnwY=
X-Google-Smtp-Source: AGHT+IHuqKd2XEDM9fpOy8gKESWCWJV0+bgGNvMKM9jUh8XBjrtBgKsh/lXXCzQqVstiQ9x3o0vSyQ==
X-Received: by 2002:a05:600c:5398:b0:40d:418f:a66 with SMTP id hg24-20020a05600c539800b0040d418f0a66mr6147250wmb.7.1703934563783;
        Sat, 30 Dec 2023 03:09:23 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00336843ae919sm21033294wrm.49.2023.12.30.03.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:09:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Dec 2023 12:09:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: David Laight <David.Laight@aculab.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Message-ID: <ZY/6YCNJ7tSCmiGo@gmail.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>


* Waiman Long <longman@redhat.com> wrote:

> On 12/29/23 15:57, David Laight wrote:
> > this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> > the latter can use an 'offset from register' (%gs for x86-84).
> > 
> > Add a 'self' field to 'struct optimistic_spin_node' that can be
> > read with raw_cpu_read(), initialise on first call.
> > 
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > ---
> >   kernel/locking/osq_lock.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > index 9bb3a077ba92..b60b0add0161 100644
> > --- a/kernel/locking/osq_lock.c
> > +++ b/kernel/locking/osq_lock.c
> > @@ -13,7 +13,7 @@
> >    */
> >   struct optimistic_spin_node {
> > -	struct optimistic_spin_node *next, *prev;
> > +	struct optimistic_spin_node *self, *next, *prev;
> >   	int locked; /* 1 if lock acquired */
> >   	int cpu; /* encoded CPU # + 1 value */
> >   };
> > @@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
> >   bool osq_lock(struct optimistic_spin_queue *lock)
> >   {
> > -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> > +	struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);
> 
> My gcc 11 compiler produces the following x86-64 code:
> 
> 92        struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
>    0x0000000000000029 <+25>:    mov    %rcx,%rdx
>    0x000000000000002c <+28>:    add %gs:0x0(%rip),%rdx        # 0x34
> <osq_lock+36>
> 
> Which looks pretty optimized for me. Maybe older compiler may generate more
> complex code. However, I do have some doubt as to the benefit of this patch
> at the expense of making the code a bit more complex.

GCC-11 is plenty of a look-back window in terms of compiler efficiency: 
latest enterprise distros use GCC-11 or newer, while recent desktop 
distros use GCC-13. Anything older won't matter, because no major 
distribution is going to use new kernels with old compilers.

Thanks,

	Ingo
