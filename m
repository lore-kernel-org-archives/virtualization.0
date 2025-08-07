Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AA2566F7
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Aug 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570851; cv=none; b=N6/dzXnEMf/Fxh1x1LPpmXhTzm5IPvV4eavhuyxvg7hrK2LnGSygZAT0wMW65STw92TVV1944u/VSUd7/nk1tVuudkhoBQGEFyTEqzIVw+cXMfYioBQZ+P8tnKxhIZVCtCx0++6I7UpkfGkGi0BF56W/9Md7s80YD/Tq9JM6tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570851; c=relaxed/simple;
	bh=un3RrEaBjFQNWnpFNJaSEVX8CHxrowanZGwCtU3ENaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ERz/9Albgu0JCEXa++cXDMDPB18eLSkur+s4JulQ2VZHnxaHwVfdfO43SUP8dEiojHsJHJCUo79fHtlhA1PkjCyrMtX9npiC4r5Lhzv01Nuyh1FoN8+PBCtCljLgDeSsCRCF+8TR9dhQXynZLp7hwwrloSorE78uL4DOa9k07vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+nGFL1O; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+nGFL1O"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AB5A84DDE
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Aug 2025 12:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddvwxpK4LZk2 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Aug 2025 12:47:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 67F6884D6F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67F6884D6F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+nGFL1O
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67F6884D6F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Aug 2025 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754570847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aTK69kQaFZtjtvMSMDYC7o+QFQbEWEankqiOa7dNWH4=;
	b=F+nGFL1O2otRqpfrcqPVxpXrKDNGDTW1qF14NO5224K5lJR0xcoka33xxsxRTIbaQEDwhJ
	rEF4CSKWe4kPUOgtFJVpj8wimaGX2Dwxq1mi0kHbL5GTZ6w66S0s8fcECwBB3oSXrS3URO
	rxWyZ7T3OMJEhZdlDPWUk6FKRnP7JXk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Z9wWtln_P4635MZ9PN8mdA-1; Thu, 07 Aug 2025 08:47:26 -0400
X-MC-Unique: Z9wWtln_P4635MZ9PN8mdA-1
X-Mimecast-MFC-AGG-ID: Z9wWtln_P4635MZ9PN8mdA_1754570845
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458b9ded499so7940105e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Aug 2025 05:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570845; x=1755175645;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTK69kQaFZtjtvMSMDYC7o+QFQbEWEankqiOa7dNWH4=;
        b=LteXrZlCDMlrhBYETKhdjvNBeptNliKv+J11THDL723axX6OAcIVaXwTs6RHMhgiYw
         nWs02vP5SukGBUputwpN0bBuaRVgtZN9clZ+3EnU4PL5aBxSNq2X/Z4vkECIPuZx5FPV
         2ZrL7ILXJUUkYspaA6corhF4Kebm8l8LtUz8AkOvhpZLQNnmMfZMHqM0OMXAVd25mfpB
         ahoPdIMxdJG8d93hIlEoVWme8CGYB7d4EE8ekTLQTg2TZF4ocEMLH5zQRB4/nLOCH7dQ
         fToHsCkoVk86mEEqfcGpv/+O5loH4405+7frGKz+x7//iVbHrOticCzxDOPxGZBwuJmF
         I9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXIMnFdUGbM2Mx1ousTG9UwlvmnWsMBsH4G0xCRrzvoAO9i3v4+sGgzmJGkgSY3Xd3KSSY+ehWCtGx/6mWNVg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzySQHcIacL1ANAb6Tv57OFHfXDPZdC2amfAC9YBIbbwWEqZI2k
	TtKoMdBLeQFrgmfHRsHqLBE7bClXaUkIeiHRErNZhdebvVD+lKH6JQkbyiAVFT8HpGPztKZ3ptC
	deD6mn8M2f4ACAP08YE/IAc+g/Gge96IKDKdH5d1repF9MFfQLhGZPPM/AyFuV7J9gslw7siFx4
	ipwZgbvCM=
X-Gm-Gg: ASbGnctop9vqOJw0bbm7oy4iFDhk7iSOvDp657FI8SbNZEMUbp4ScBUgGgBAMCXXgEW
	BfXNEIJiKnwGhoa/2js/KuhBAerZ8qmzdlTpLZGx4/CKVxp9RG06diIZVR0tMx89epaP1MJ1L3R
	UbJTJtQRTjWXEN9aIFxU1mD8dYjpkcdHQODActD4N04CQIOwgvLJGEU0PneFn4N/3VcgdPJUl3T
	viBXDcI/63q9NKdZQttQX+n8Eh/WCaOC8xDdoXn/vY/mf09/bT/eyilqOeAQJoZRcPbbGGzB2WA
	qQLfCzdHiI7oxLLrZjcgLtV+UouxDD0V
X-Received: by 2002:a05:600c:468b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-459ebd12934mr46363035e9.12.1754570845008;
        Thu, 07 Aug 2025 05:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG09B4jVXtQ521CCCpSOE6UxD7Ba5Baj1YjRug6kR2oAgnAlGT6bbB3OaejRPpTTtCumhOhhg==
X-Received: by 2002:a05:600c:468b:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-459ebd12934mr46362755e9.12.1754570844604;
        Thu, 07 Aug 2025 05:47:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm120608885e9.1.2025.08.07.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:47:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 08:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, jhkim@linux.ibm.com, leitao@debian.org,
	mst@redhat.com
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20250807084721-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OyPUJ1lxMCtKPOVsJ1KFkoWQxFEUaWH0YPbcmi3EwFg_1754570845
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7e161a991ea71e6ec526abc8f40c6852ebe3d946:

  Merge tag 'i2c-for-6.17-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux (2025-08-04 16:37:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6a20f9fca30c4047488a616b5225acb82367ef6b:

  vhost: initialize vq->nheads properly (2025-08-05 05:57:40 -0400)

----------------------------------------------------------------
vhost: bugfix

A single fix for a regression in vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: initialize vq->nheads properly

 drivers/vhost/vhost.c | 1 +
 1 file changed, 1 insertion(+)

