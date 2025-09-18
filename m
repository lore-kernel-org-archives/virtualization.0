Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4D212566
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212478; cv=none; b=r7eqOXCgR9/juys2X7O5whs+8wAN9P/2tElo0SWsUE2yVMUE9dyD4PpklBvcT+U0xS3q17J6nHbbhjpcpYgKGWTf2/iI/mWJMznP7CRfRieoeKogFF8PWtlDVBVZ8pnOK+NTNhDEf6f6m9ebcaZz4BjTY5h5NU+UthebEcyBXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212478; c=relaxed/simple;
	bh=+6DWJ9V2/s86NKsZVHhjQHyxMst7QlpPf4TiS4jwR7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsPf1tysEoBfPta3sHT17JxGcf769I9oClz/byim6CajQAPwB/1zftsbnQnUzm+NJp3J7bwDnZ5GIyh1RDck7GghMxn9nBse9TN+F473UHNJHbRBTlvHK0LJnETUFfCDq1pa255fwt56iWf0/ZC+y7L7fVwYeLNeQ6xbMitNGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P/jlUV2j; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P/jlUV2j"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89661813CE
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlobu9A6aFSS for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 16:21:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E28F804A8
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E28F804A8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=P/jlUV2j
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E28F804A8
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:21:15 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b07d4d24d09so205437066b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758212473; x=1758817273; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=P/jlUV2jWBDs/1x/hQfKEx+wlteTm+M/B7+1X5T9tehZjaYA6djLJF2zF8sTAbbUTV
         ki6ZBERAGvy4SoBWiKAnEYn6IH+LU0FM2bVA9sf3uHckSdhGK7vvaK/fqAyz9W8kiv1R
         kK6tS93Dc21qefMXEWfewICkWOsBLJRuFaLHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212473; x=1758817273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=rYCjqahyPhnVCzNq/JYySuksBwt5l6vw3rOyYoQxjJTSQuvSGpxmOU//JZSAbqZiQr
         meOqgCF/4nFUFceVopwVxXeWntfAvpqNPZAz3g4UBvVWfWOQDUh3cuYX3PSHYPGLTZ2Z
         5TV6ZVpvtJx7GuVmzhoyBCJPzUeuEGO963wNzHnoU5XjxuJPpP+z1lidWEB5SzdCKB4h
         elEenHVOo3H5mucVoi9GSGH6kXfWcGoZX2OXF9l6Yqxc4yZe9+J48lwk6T4UnZxv3mYY
         gVHPo1AW8Vh9cupBWvtEEJBwowv5I56MM/nuG3yb00srvCYQNQfrLW6Lo3ePTYl/3Ngx
         1W9A==
X-Forwarded-Encrypted: i=1; AJvYcCUqXRWO/kKkMphmZ317eWBNK8bs5LGidinb/ZQZlqQy4rLcnDFaDaN6V/1EOZ69K5UppJqFQGUKKTkgwg3YNg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxWBDeHc3yJszfRYobOGrAICRyFgvEpxc4OCPCQHhhfGYTPJmCA
	yWglbmQbELc7zYXNdcSvJ7Z/8kX3nn5ozFURSGmRAZLTL+nFQby6s5fRCBgZCnCoJuiIkR5IeWe
	zztU7mAXy9Uuz
X-Gm-Gg: ASbGncsPltn4S+bz8NEDBtptK+svjnjuecEnmpYqC6arRpLvwFa5BefdWV3eYIwKI+7
	DJChMXtqntwyIcFE77Njr70PBN7fpFJZZrEcQtR55ZGKj8Ap1op2052p4fWfZXAhEpmehH1ouAS
	E9o1qwzJCBhc0t6TuxExmlvdt5ifnGmDaqfuehtZrSF+a1Sbai5iqna71F7nO4v3SGzEqhelfi2
	E4uWHAf1QYsFll9Kuq6UK4eL93K8wk9+fjeKBoF/ejkHTC+X/S46LuS8xP8tiEI1rcboqzTRFPk
	rSLle+AvAFK/ybhWWPjrc+y38ayZv5oSemuDy3cRcYdGndNJ4MKdZlCHpJ8NXxkQLOP4EPqiq/B
	oA6OVAfhI6gRexl5o+XI6zPo7nYP35MfHAp3PrrKFLUsvLi2eaYwg054nZclSjvgj1vmalN1a7K
	vWEDshK3zKSHlETckjFhxyga+cIw==
X-Google-Smtp-Source: AGHT+IH/Krhv/fzQ+OHApVxddwNOR76mmBj2x2nlUeyW/KFf8pc/rBZz0aOigNYCzq2R7bDp1NzHaA==
X-Received: by 2002:a17:907:97c9:b0:afe:f418:2294 with SMTP id a640c23a62f3a-b1bba00ceacmr715778166b.49.1758212473118;
        Thu, 18 Sep 2025 09:21:13 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc73bb5b5sm226066866b.37.2025.09.18.09.21.12
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:21:12 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07d4d24d09so205430066b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 09:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/oPCAsWpQL9t/nNneqECc3uLz5k8DsCVk2aojUEniCo03jmE4c2nTnfwVXXkV8pZ8xarlfG6eKTFSZaddug==@lists.linux-foundation.org
X-Received: by 2002:a17:907:6d17:b0:b07:c715:31 with SMTP id
 a640c23a62f3a-b1bbc545b7fmr610549366b.65.1758212471806; Thu, 18 Sep 2025
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250918110946-mutt-send-email-mst@kernel.org> <20250918121248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918121248-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 09:20:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
X-Gm-Features: AS18NWAmxo1DLd_bNcF9s-ZOOAwZnodu5o6p8OrqHir3EF-tNoG8mT_VioNWcEI
Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com, 
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 09:14, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> OK and now Filip asked me to drop this too.
> I am really batting 100x.
> Linus pls ignore all this.
> Very sorry.

Lol, that makes it very easy for me - no need to be sorry, and thanks
for just reacting fast enough that I didn't have time to do a pull and
then have to revert later.

          Linus
