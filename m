Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F215AD3
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/ROensU"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB15B40399
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 18:54:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB15B40399
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m/ROensU
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAVkmJCJiJTn
	for <virtualization@lists.linux-foundation.org>;
	Tue,  2 Jan 2024 18:54:48 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9688B40150
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Jan 2024 18:54:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9688B40150
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-680285e7ce8so50794606d6.0
        for <virtualization@lists.linux-foundation.org>; Tue, 02 Jan 2024 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221687; x=1704826487; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+SZED/A1h752GveqQ8KwOCCj8k8UMoXQ0xqbzwkRoU=;
        b=m/ROensUWBBj809BhI73VRs+hueDtuB4B90U2DZwgwlTK/kAInTs3NiEEPZHuUfvVN
         Kv2Bxty7uOHuAhMgSZ+IBclw8nqXywjXKIr7ZJhZeHt2XLhsRAxnxAVal+oBBqyBiWVS
         yywSdQdSp52aJ1zdvxb9D1ba9SGkUOqH50MMVVeRFcZgZP3KCNm45SQvAPS6vkry0Aot
         tes2kgfxTE3ZiFXMDgnyYJxSXZUrnri9WZT5q6b4eGeEybjKeniECXxZ3xDmcvjPV8Oe
         KQ91oXTdz6bPvhA64LhElU3RcoEwtiwmoYcaeTo+C6w6Lb6gHhZn1wwabKRN0cKEAt5V
         G9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221687; x=1704826487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+SZED/A1h752GveqQ8KwOCCj8k8UMoXQ0xqbzwkRoU=;
        b=dayiFBjVL7WQngsYstjRkIDydmbKNSRsnYJvFk1jk7rHysCkHxOz3SKRr+/tKcpVTA
         vnb4sXvIeF5Hs8Kn12f+vrly7lTGxifhXPUlcJsD9OrDC9e2HZxYAGC8QbMgj54A8AkF
         EPIWIyKnZKsi9SXZ7O0xzIfEIPnGp71CmP0+dZqDAjieX+4QNBPt7K7LLed7FVUyoeWF
         rm7IApC7yWrIKWNbtSdMwpNl9j040ULNPObyQtAZJUzABRW4F1q3z8XqXkYIeXh6te4g
         w2qi9gxLVkkvmBF+Drip+tKiqkEN8+Xhpg2huZX6yR0HWuCCfs2W8foder23EUEUaukq
         9dow==
X-Gm-Message-State: AOJu0Yw33ryN/EQfmsatMJtSXUBAHBaXp0j0Qvqbv/ieTcqasljWin/Z
	Zy5aPWJzz5rUAaV0ij1aHwc=
X-Google-Smtp-Source: AGHT+IHt9oM7jcNvtSrnx1JCFtehkduc1/Ie4c2Q+Lqt/rA5TSXbSiTNystkkxgnUkG8KVlm6pshZQ==
X-Received: by 2002:a05:6214:2388:b0:680:b8bf:f844 with SMTP id fw8-20020a056214238800b00680b8bff844mr3313901qvb.102.1704221687335;
        Tue, 02 Jan 2024 10:54:47 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v7-20020a0cf907000000b00680b1947dbbsm1771086qvn.111.2024.01.02.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:54:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5EDBD27C005A;
	Tue,  2 Jan 2024 13:54:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 02 Jan 2024 13:54:46 -0500
X-ME-Sender: <xms:9VuUZWgN9VGSUQIcIAw6Qm5nngKre_n2hLqvl9x109fIYhrB92EY6Q>
    <xme:9VuUZXBBOOOiIs3Mz8Qj0sFo_wFcqCRGFQ9WVEI3nWTn5yyMkI4eHMTHmXOqxRsij
    E9Q7lo7ml833dWhKQ>
X-ME-Received: <xmr:9VuUZeHUXrTJJt68x7O0dVBX6t1mJUwg2J1heirT8LfzdU8Hklb6bSl50jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9VuUZfQ18qHaofXyXVaU2589e0q4QQ9vZUtEqam379RRIvm7oDBwPA>
    <xmx:9VuUZTz1zSFoSABJEAW-NwIAAwC7tPga1q9lclCQ2jHPxFRDp5e_ag>
    <xmx:9VuUZd7uOws8DGaDpJg6wGguHL2vWrT3Q-IJc35Zh-f-VS3YAZyQmQ>
    <xmx:9luUZbe7kBIC5qlFDrTWkyYNxbMwBrUQ7OMf4Yrkw0bcsprhFabA9Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 13:54:44 -0500 (EST)
Date: Tue, 2 Jan 2024 10:53:43 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Waiman Long' <longman@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local
 cpu's 'node' in the osq_lock() fast path.
Message-ID: <ZZRbtwwcusePltww@boqun-archlinux>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <fbb1f9ed42b2460c93eeac43a92157c8@AcuMS.aculab.com>
 <835f65d9-a041-4956-b89d-7cd3660c3ab8@redhat.com>
 <fedbf107b9344e7b85711c0de59ae0a3@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fedbf107b9344e7b85711c0de59ae0a3@AcuMS.aculab.com>

On Sat, Dec 30, 2023 at 03:49:52PM +0000, David Laight wrote:
[...]
> I don't completely understand the 'acquire'/'release' semantics (they didn't
> exist when I started doing SMP kernel code in the late 1980s).
> But it looks odd that osq_unlock()'s fast path uses _release but the very
> similar code in osq_wait_next() uses _acquire.
> 

The _release in osq_unlock() is needed since unlocks are needed to be
RELEASE so that lock+unlock can be a critical section (i.e. no memory
accesses can escape). When osq_wait_next() is used in non unlock cases,
the RELEASE is not required. As for the case where osq_wait_next() is
used in osq_unlock(), there is a xchg() preceding it, which provides a
full barrier, so things are fine.

/me wonders whether we can relax the _acquire in osq_wait_next() into
a _relaxed.

> Indeed, apart from some (assumed) optimisations, I think osq_unlock()
> could just be:
> 	next = osq_wait_next(lock, this_cpu_ptr(&osq_node), 0);
> 	if (next)
> 		next->locked = 1;
> 

If so we need to provide some sort of RELEASE semantics for the
osq_unlock() in all the cases.

Regards,
Boqun

> I don't think the order of the tests for lock->tail and node->next
> matter in osq_wait_next().
> If they were swapped the 'Second most likely case' code from osq_unlock()
> could be removed.
> (The 'uncontended case' doesn't need to load the address of 'node'.)
> 
> 	David
> 		
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
