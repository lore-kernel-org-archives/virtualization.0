Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8243431E3
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020938; cv=none; b=mqQ3pRrImqXGtY4/zDftyfTctqauiUPuIDrRsZeLaMgI7mHp7Z8EmuBgDxs99oX6GRDmuPpOLLQQcN5iDvIFs1/tBx7+Znvnfs92p4E9OSCne7xhW9oPz/rUNeIw/Jo/DNMCmpow3GqMoF1CsM1a72Mt1K2kyPxomcrlJsWbAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020938; c=relaxed/simple;
	bh=yxr+nqFvE05ybrHpLzEUCDLnrFxx9XA8szYp/Y/bI/4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EaJBM+pCAEsQVO2LdIQavLeTECFU2sojYx3QA2eIRFn9j8o9bPlWfdCUa4z5C+SpxDsCG99mbxsBGON6cnefG/6AdTuMl12Y8Xmp/ahoxLenBO0keAWSeJiTdpUGuRJLOPEAg9NgvfAjM5nbPyu7zjyIMnPOeXxi1F8u7OldFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PpuClLlh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PpuClLlh"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43f5e285111so3783544fac.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781020936; x=1781625736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wne9u11eEr8I97omWkO8Al7ip6I2l2rLAsMnhcuURVw=;
        b=PpuClLlhpsFrqaoPKW8V+4enPIxlZ6Jqn8kHhu205Z+kRSPZMRo0/qk4Fr8KyF1cQw
         LiTSljfLm/jOwUHDxsAqXLog6jaPpI5koTwgsMAsmj8zcNQ6zLdlAQkHjl0q82sw9Coy
         XOnjAHSDVhcjoF48VUrmjGvYjBwZkcFw0lZLLKxtWVv0YwRhE4gdX7tLstz4RxNL51yr
         RG7+TRc5KnWGbg+Ys/DP0rqRwRc07K5mjt74M62Qo3QRD6JNNWcQlyUQsXucCbdMElz0
         SUFJlXo6qG/OyQ+oMrxET8K4Ewkaqi2TrgUFSZ6cWC0UZe63IMOk01b89JhqGUQrtzBF
         Qt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020936; x=1781625736;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wne9u11eEr8I97omWkO8Al7ip6I2l2rLAsMnhcuURVw=;
        b=j/R2ku0eXGDOvt9vI2pL6bt6DB2cRu4Il5+NmzyGcSCXveeRwW9KwDniBkzyN6GARN
         YbIwJQq7+51byXpfKKcKtQAFIIxQ1SYPLQRi20umhLhz5FJ+HbTmdwv3h0b0ruM+DXwB
         cpdFmQL+TWMJUelw28eNOxhPlg1Nf8GkYLyDGbBs9OHAnbf2syslNNWmi1jxROGIofj9
         tlaj2JgF6xpbYzIZA5xach3p8Puni24SyOFjK/DzjUkDtCBJQORmmnxMBcpsX0DtZ9xq
         0BYCiOlNKgUB/V4e5ndR0a+gfSxfSwpjfQdwlmf3Ccyuk8SwPQLd2CwLmYGyngsoZ1bB
         otxg==
X-Forwarded-Encrypted: i=1; AFNElJ8uUD9c3AOVPdw814LjK2HBngOMKV1QH4WFA7VMjF9jvFacW7XCwR2eRvlfIgUA6Tly86I8py7D0n9yijCIYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgbgjCpv0y8zfo4llWzfi7P6SpomlPFw3zyasvOFLpiSIRoOKJ
	1oSneuDWbghc60bc+QC6jvKReIQl1p2pIqZnjLSgglhNPNnC2AmMiAcshgykmPAgtys=
X-Gm-Gg: Acq92OE29CLHYY4FvHKAAFNRzZIwMOajERGPWLy+XMLD9vqhVJi544KLStJnt2wXhgh
	l0/THqGOe3zKOkMs7rJigtaP97f9JEHW6DBE0h5AZkgd0Q4z7IzIDakXgA9GIrQCXZRFTlvV4Fz
	1IXsHR6F356AELzfDAzUtOYOaElmQApnbA+GFr8rWc6CWO49GwYjirmXwADH9mFOSrOm1ICFZZH
	/vcCOmVhm1QTMOYsJvMiGJmPRSxnB4KdRb+q96P5YG7BHyOBm2xIxbvql17qLJwY3UEsLUJDCC5
	e3zbGYoh4iQtwv2EDnNFwFdbLYeDH1YDU7z0K7Z3gZDgnqkCPrJZ7V8uuH1C4jO7jilECuzZYJN
	B4rGheIXnKVF/dVzScvJ1q1CFfjp9pLt09L1yoyOos+KetdS1K6J2eGiN+PQlG9F1HqHVfZnq95
	fDYpclX6pg2SlVlflquPmPOTvFHX1/Okkqzv8JoIrsYAnbLgQJ6JwLkGkArtg14UETqO2wP8xoU
	NWhJNjYXmS0kw==
X-Received: by 2002:a05:6870:d8c6:b0:439:c2da:7dd2 with SMTP id 586e51a60fabf-441ed982165mr2157518fac.31.1781020933776;
        Tue, 09 Jun 2026 09:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16161761fac.15.2026.06.09.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:02:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S . Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260607124834.3059944-1-michael.bommarito@gmail.com>
References: <20260607124834.3059944-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] virtio-blk: clamp zone report to the report buffer
 capacity
Message-Id: <178102093279.1199099.8171367690352183837.b4-ty@b4>
Date: Tue, 09 Jun 2026 10:02:12 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 07 Jun 2026 08:48:34 -0400, Michael Bommarito wrote:
> virtblk_report_zones() trusts the device-reported number of zones when
> walking the report buffer:
> 
> 	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> 		   nr_zones);
> 	...
> 	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> 		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: clamp zone report to the report buffer capacity
      commit: 0fd835f5e9477ebea2439b8ada58f34e1b8cf25a

Best regards,
-- 
Jens Axboe



