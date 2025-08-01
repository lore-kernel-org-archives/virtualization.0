Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA819F121
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084518; cv=none; b=ER49MZCpnk6PG8Uf7pPe+euoEVUf+rzr4k4R1iBj5nzmTdQb8zIVDZsxik+gUyyw87prBxn0iJygs2iiDHKk6GNRZieR1LA8n83QGglM3vdEPVy9u1/RowNikIy22cX8TIGBoR1NahXJdbj7M6c1++TZQccCdhiLUN0JHFqGbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084518; c=relaxed/simple;
	bh=IZkwXQkh8YxYF6KhegHig00grekwiuruDFNARhibles=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3CxmCpS9SQVRiwETzqgAnLsgI8Rmq+PEZG2fhfrEz8EJr1fYyitB1PxJAFkO8hjDvtKIfBudd83xKBrp3xC5OW+CHE2Zj0cfSPF2IgarRvdxWRE81Yy1Suf0E0asHtq8l9X9FhRbvmwccmv1kgxe0lJZdsU0hsnlUYz7SXDdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZX5Dtq+p; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZX5Dtq+p"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C829D8472F
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IxaOy5vWuEdN for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Aug 2025 21:41:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DF04F84720
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF04F84720
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZX5Dtq+p
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF04F84720
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Aug 2025 21:41:55 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3645956a12.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754084514; x=1754689314; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=ZX5Dtq+pONyvPBmMt07zQFLhyo5pRoKFh/kXPrWOYQQMycAvxbqy9y7EmytN5NTqVn
         Jhhl6WcgN9eQfjKFswjhzBV74DvRiDn7Hw+VLcF4E+vsQ483qdr24J2u1uPZnAbiQIfG
         4jquzO1X3AXexE+ICmuTwJHFbzHzU7vyiVpHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084514; x=1754689314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=X10mKiDAC+ueUKQXY3aGB6N4Za2Aa7nZ8jrFo1aXj8Lh6T1IPBmUs23a3Lx78rvPvL
         /egAz7g5yCS74Qkl40mnCYWVOT0xlbL5O9gTax5D4fJ6LGaWf0NXTMcyqjL7kT82JSt4
         LK6z7QueQROQETN5fHmgdVuDt/enjHUUuaAnfZmVVBAObld+CtkGgxqPYzq6SKe9YAT0
         l9ngdjKfE0rH0Aab/9dhMcxGo9XJ/mSYlsdP2AP/RKRMLYutRJ3lsnVTD8+NNFd4hskA
         XToRJZpDtfDRU0J7SD/fgFhnWKm4N5n5kX3r3H0soR01lPwqulZiGHPrXerYzB21BMAV
         ULjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaX8L8nm9C828hHTZaiofTrljHmXMcOgvjaHiz3xxPOReeqH7/mkby2rOpvD1zcA5ARo6M1REGXB0yVxUWsQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwJYdnRoLIqdTHZTa5L1f9oGT7BMjjQ/3b8u8h46ExkcMzCMd30
	CH74uyC8pFI8nhzMo3fPC5d1ZFC3Lirzf8SktKHoFGcLOdj7qaPRoh3/lqw0VCF/P8JZr59OPd6
	RivjZ74s+gIek
X-Gm-Gg: ASbGncssniZZiKHlXXmLOxtd9gtsShrI59vAham5fbwhiDv1rAy58guGGGeTQbHL3KC
	dk2hfBDQkMYHY2g02hXcZxmIVlPUSlv+A2npGzDlWh7yfCCh0r3sIQ/r+RGoIkEt7gJ9nixcFRY
	GKIPHtJy5WN2SuQs37u8KH+3GC+GaeOL60fKjx0Vn9+A1YS375Sn22JzHenJc6FE/AWZP1wxaBU
	b8lSkP08zxbW98kGCY363R5qF5J69eO9B6iX1wA2NOabyacl7MYlJG2DcwtiUbjqwqbPeqTpf87
	QO899NmQFLUVAf6Q2vdQTZL/tre09feWcvsK6Vn8Jf/f+mgKU4+Qm2sByHKaOpEuyna5WzEdVlb
	6tAYe0DcyOZGe7wVVshG5rlje+9EN4ngtKxsJHZyLDdFDV1OX6kCr1mLBLOdIo2dW79AsecRk
X-Google-Smtp-Source: AGHT+IEpKeCP92IsPl+wNFIlwaUnhZdpaJ4Cgtv/o55mFo2Uy3VAA0gDMg90Z2FJnaN03rhfgwmpkQ==
X-Received: by 2002:a05:6402:2790:b0:615:d028:9423 with SMTP id 4fb4d7f45d1cf-615e6ebed04mr768139a12.7.1754084513558;
        Fri, 01 Aug 2025 14:41:53 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8effda1sm3196221a12.1.2025.08.01.14.41.53
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:41:53 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7920354f9so2391030f8f.2
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Aug 2025 14:41:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/Vp6bYWr36Vfb23LIkLq0tOTzgJSuvz8Y6p4TVonEmIaiSA6nhYPPwKgg60S9+c3qgJ4w4r3jSnGAlU2xOQ==@lists.linux-foundation.org
X-Received: by 2002:a05:6402:2790:b0:615:cc03:e6a2 with SMTP id
 4fb4d7f45d1cf-615e6ebec77mr689309a12.1.1754084072420; Fri, 01 Aug 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
 <aI0rDljG8XYyiSvv@gallifrey> <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
In-Reply-To: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
X-Gm-Features: Ac12FXyaANs0webz-gagQ0r78-lvtho7QphOSO_s_LZu61Rm94DR5P3bHuE7Emw
Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My apologies - they are indeed there, and I was simply looking at stale state.
>
> So while it's recently rebased, the commits have been in linux-next
> and I was just wrong.

Pulled and pushed out. Sorry again for blaming Michael for my own incompetence.

            Linus
