Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86772770B
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422533; cv=none; b=eYfjHST8RRrXihwtluVELD5s0iIp/SAxcbv9VLpQDDAvSNcGnGavy2WdwiZQxZBFw4Z1m6ycuvVOHI70h7626491JPukz6J5A83KVB/D68UXSviOyKwmwp/U3hFLhaHoyJf0/G8jYU6OUK0+lhgfzCNSUneDIcmPKIou8MnP2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422533; c=relaxed/simple;
	bh=mf227kKncoURIdLp1KReMZcMntXVrdskgCzq2WR7B3Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LgslTRGhABJBIKRFyTcjMdI5Ive2XZwg81oYeeKwXNO8MT8zE4gjshlYaQOl/W1p+OkZGm/F6aYFJVyyssUx7icWrIeZ9UM5GtjTp5P+eSUFYrDZT34wjGqPcnTa6OjSsMmEkPXr0fWpIOyypayX1iOPGr4vofzRQfMjKHEHyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlT4kJje; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlT4kJje"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237311f5a54so35545715ad.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751422531; x=1752027331; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g31GsV5you24XaAPrCY89ZjlDVNyI0JUrwAbjHIC07c=;
        b=NlT4kJjeSpDPQQ/CP2A1JY/O/PqevoqdK7f6FObMzvfVZSN3B3FL8dQcOtcNm9V0sI
         aIrqL59IQl34JofBpAL0fVyzQIBbWjmhdBYj2YJK0IwscrIxwNZRxLwdfpUrhYnwzhRE
         AIb0BS+Fg9Ru0M4h1Vm/SPhFjQltmnbpjbEIW1q+u27W1jjR0dCEr173IoN2Jq0yUwuL
         uL1Z4xipIwESvXlGaqwpV8577UwV6YTC8qtz43qzb3+1kA0m2OtQ2bsSMqig3uPG4Il8
         ofb3bNVu0Nd2kSsadzA1wLN/X36bOmR7nyyQgh9H795ogfPR2kszwx4krriCWVML+Um4
         1gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751422531; x=1752027331;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g31GsV5you24XaAPrCY89ZjlDVNyI0JUrwAbjHIC07c=;
        b=tBWkHofKWz2qBlUCrH4siXWBWtZ3Gq631BTewFQ+otlnhrwYz+8Zxkpmou03CZ/E9W
         brFblsVoT9zRSxEJmt4iA7zIMvXiqKGqncBbwvlQHm7DycpoA45XT2h7yjUHuF7CaNzn
         SvmO0xIOST1Ndap3aaCQ67Oy7Ou/DEqZL5NRC0/Z05wJzwMt9RwbQaYENxUecnIFB004
         xZg41Zu/lsxDyQq1H6VoWS9O86qssdMwwu70qCTY24xo9kG9cu2UfiVRJSib66WK4WfO
         DxDieAb5eIgr6ekksh6adFVMdKtM2mdkx2XlcoE6xQtpZAlbxN0ftYtZlmO/GW2GaQ06
         20vg==
X-Forwarded-Encrypted: i=1; AJvYcCVAcALlz1BfEXLRFukto6sR8PJ4L4D4VA56I7MWwahOabvPYJV4A4z7PuIoaNkkcxpjrDYxMTfo70NV3LSEMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3FKOvTEFN3IxEK6mu5k5vnvmuWHoHqPzh4bhRVU5UXaAJudI3
	AjRFmei/5VXv7CZyQpC+cmarYkdexLyaRdua8yCoLMrnt/Age8lgp6/B
X-Gm-Gg: ASbGncvNPK1vksW9YF78D6w8seUorMwD7NLPrFxSRDOFvUZGYBSSBrOeH3mvLpmi/dV
	CRbUudDc4Q2Zrc4vcZd/fdGWW5C6d1FStMJy0qfOVepfA7FNI3DjVMcU1SK56TpIloZUhw71MPA
	AG2GS3Ilk0JXdHnz5AglAzew/ezfhWM2YY359LXBP5hZEGR9P9BnRzMypv0gUsP0kc3Y428v+y1
	9qkA2oyFTzm1hA8mwYLeNde3KXadGJZmvKBJGKmzCDcDrm/IEiz4toRD+0SlF33yHG10fgxWZ1R
	6M1yYu51CxwU2ezhsu8QUwNJXs3FWTJAp20VW6mfidGG2YtqVXG5G61NN4SFYVlFP+YhbKw=
X-Google-Smtp-Source: AGHT+IFU7cSFIO4KkQO2gT16lJGhF5dZmQEW6QhVLm1Oe+2lHVb75yDHEuhj6lpjbfnNle+xNLPuDA==
X-Received: by 2002:a17:903:2341:b0:234:9375:e081 with SMTP id d9443c01a7336-23c6e5c8868mr13451135ad.42.1751422530838;
        Tue, 01 Jul 2025 19:15:30 -0700 (PDT)
Received: from smtpclient.apple ([23.132.124.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da818sm10336762a12.61.2025.07.01.19.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jul 2025 19:15:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RESEND PATCH net-next v4 0/4] vsock: Introduce SIOCINQ ioctl
 support
From: Xuewei Niu <niuxuewei97@gmail.com>
In-Reply-To: <20250701180927.2cafbb5c@kernel.org>
Date: Wed, 2 Jul 2025 10:15:14 +0800
Cc: sgarzare@redhat.com,
 mst@redhat.com,
 pabeni@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 davem@davemloft.net,
 netdev@vger.kernel.org,
 stefanha@redhat.com,
 leonardi@redhat.com,
 decui@microsoft.com,
 virtualization@lists.linux.dev,
 kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 fupan.lfp@antgroup.com,
 Xuewei Niu <niuxuewei.nxw@antgroup.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E6A8AF53-7AB0-46C1-AE41-FAB5F443911C@gmail.com>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250701180927.2cafbb5c@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> On Jul 2, 2025, at 09:09, Jakub Kicinski <kuba@kernel.org> wrote:
> 
> On Mon, 30 Jun 2025 15:57:23 +0800 Xuewei Niu wrote:
>> Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>> bytes.
>> 
>> Similar with SIOCOUTQ ioctl, the information is transport-dependent.
> 
> This series does not apply cleanly on current net-next.
> Please rebase & repost.
> Please note that we request that repost do not happen more often than
> 24 hours apart:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

I'll rebase, and send out v5 in a few days, in order to have more comments.

Thanks,
Xuewei

> -- 
> pw-bot: cr

