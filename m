Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854981DED76;
	Fri, 18 Apr 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971916; cv=none; b=lrGes+1MS4zwwlYvd6+wEI4VAjCSKwsZWeTNR9C6oQ9FnwoEylyon3nzJkXTep8o/X3J7JBUr94WeHCv7rku7xtZgk69v1zfK2l33NzhhigP4uX1Y668KFwzgG67I3FO5TH7HZWLD4ad86BBp/xzO8/jaM+0tOflt5j9v+KwlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971916; c=relaxed/simple;
	bh=kcuQkKYCSl4USmcoi03BAP5hQffQY2sFSoVLQiTnuR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmhnF+O8WV2zHoralKps1f+pFHNdio8f4oNoPDotOQoQ3RMhjAoUm5Q3mGqD+c9H6/joz/TkzJyYLWroTKjYnzT4SV1nRqsw6fyNalsBHIKSGZdiMHGGySGefz1/CvFOHTO5aiXVZU+ihy7NHDfV2m7KAfZbUxG6HzInJkkb7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4774193fdffso23692341cf.1;
        Fri, 18 Apr 2025 03:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971913; x=1745576713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMi6RjNLnii56OiqqTtBYh/fDGXu3JBH/VNIF3fIEn0=;
        b=kvEQOikHDfOwJsDPp+0e8Rc0tM41yED4upEr+snIeCqdzHTZRBZh800r9Xswnb+GC3
         RakKF/+BUNv224NPlnwSqAvP9mKE3zRF9tTYdTu+UqC3fE4JoBLaOXnLd+KkpOVjA6GL
         ysPKHZOpBKtsp8ydRhNosVuBQJqL9e+CVUiqbYtKmJx5IOAVgx2aSfMvT5YOoyY6Tr2z
         XZzTUFU0f1j6kfcn6FpMxeQYrwtBVZSZAn4DaLR2WbxJcaoVOonk37OP3EO1Xe4ZvYhN
         Q5JzvoYZD4jFiK+GEjwUeRa6O0Tn+vU8I7vAj2ExaZg7BEnyYCDK0HGKEWKxcS2JieCF
         5Sgg==
X-Forwarded-Encrypted: i=1; AJvYcCVGegHLT2TN46ipT1Jdx7UHjGoEPsDHuR0bbz0ItsBQL+iHqVhVFbnMz4iQVs6Ex9AY/rt42N9NC8C9rTMb7ns=@lists.linux.dev, AJvYcCWmze/sv7sluasbxSkhbdryNN3RAFLAPIDrvp6SUuVnb6ELelkilTBIJqRQJx1egnd+Z537@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+dlQkecQ+R+bXiPdutJOSxGneMAyZjzxxSolxzZIwqj5iDtN5
	WsLWMUuiie7vcKCmbsQrR60PmpvpJa2NfP4XH1RJVG2aiVLEIxzG
X-Gm-Gg: ASbGncs36OoeZxQilqYM8OGI4R/kp/u7Q6PvwIIgb5Kpvm/P4aSo2dId0dQyjH7oV26
	APiAbFmIHVs67tTdWyS2cq3zzYs+AxLiQXdbOcZBFid57k6dQoffOl4BnEwoB4xbOzPzFyxiJ3+
	JcOAGNIVGMFUHlpXuVJ95czgp6CvemgXPtBBdvuZYHWxdi2C/Pqj0PO9klhSEI6WI4iTrkfhLmL
	YuJEIHPAh/DC9vIsedWC5CXFknROleq1iEvI5TK6oxF3K/+jHmrdO0Wa6YS9F3DWXGDBXQLltjh
	igVjenGHYHE33WfZiItd5OydNJbZPOH+tcMYYJZtXO7umRLwFATVvV0b3hlbFaKh
X-Google-Smtp-Source: AGHT+IEKJZWW+CA0u03L2I1YwGaBuPS3Jq/Tgj4wyFEY1P0tyWIjeS90rjHfjPUoep1kge+Jl0aKkA==
X-Received: by 2002:ac8:5807:0:b0:47a:e6e1:c04f with SMTP id d75a77b69052e-47aec4cb1fdmr34086211cf.46.1744971913152;
        Fri, 18 Apr 2025 03:25:13 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c17673sm9266701cf.13.2025.04.18.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:25:12 -0700 (PDT)
From: Chen Linxuan <me@black-desk.cn>
To: bvanassche@acm.org
Cc: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	axboe@kernel.dk,
	changbin.du@intel.com,
	chenlinxuan@uniontech.com,
	hch@lst.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	justinstitt@google.com,
	kbusch@kernel.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	llvm@lists.linux.dev,
	masahiroy@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev,
	peterhuewe@gmx.de,
	sagi@grimberg.me,
	shameerali.kolothum.thodi@huawei.com,
	virtualization@lists.linux.dev,
	wentao@uniontech.com,
	yishaih@nvidia.com
Subject: Re: [PATCH RFC v2 5/5] lib/Kconfig.debug: introduce CONFIG_NO_AUTO_INLINE
Date: Fri, 18 Apr 2025 18:24:53 +0800
Message-ID: <20250418102453.982042-1-me@black-desk.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <bb713790-0b68-4d91-831c-b18fa1ea01a9@acm.org>
References: <bb713790-0b68-4d91-831c-b18fa1ea01a9@acm.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4/17/25 5:04 PM, Bart Van Assche wrote:
> On 4/16/25 2:44 AM, Chen Linxuan via B4 Relay wrote:
> > 2. Make it depends on X86 and LOONGARCH,
> >     as I haven't test other architectures
> 
> That sounds weird to me. Shouldn't this option be made architecture-
> independent?

It should, but I have only tested it on X86 and LOONGARCH.

> 
> > +config NO_AUTO_INLINE
> > +	bool "Disable compiler auto-inline optimizations (EXPERIMENTAL)"
> > +	default n
> > +	depends on CC_IS_GCC && (X86 || LOONGARCH)
> 
> Why "depends on CC_IS_GCC"? Please make sure that both gcc and clang are
> supported.

I make it depends on CC_IS_GCC because

1. Clang do not have `-fno-inline-small-functions`
   and `-fno-inline-functions-called-once`.

2. If we wrap those options with cc-option,
   Clang 18.1.3 fails to compile test_bitmap_const_eval(),
   with config KASAN and TEST_BITMAP is enabled.

   Comments above test_bitmap_const_eval() says that:

   > /*
   >  * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
   >  * To workaround it, GCOV is force-disabled in Makefile for this configuration.
   >  */

   It seems there are some issues with Clang's compile-time evaluations.

So I think there are some ways to workaround this problem:

1. Make NO_AUTO_INLINE depends on CC_IS_GCC;
2. Make NO_AUTO_INLINE depends on KASAN=n;
3. Disable NO_AUTO_INLINE for TEST_BITMAP
   like how we handle CC_IS_CLANG && KASAN && GCOV in lib/Makefile:

   > ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
   > # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
   > GCOV_PROFILE_test_bitmap.o := n
   > endif

Which one do you prefer or do you have any other suggestions?

> 
> Thanks,
> 
> Bart.
