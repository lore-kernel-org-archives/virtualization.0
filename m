Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A01990B7
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753572; cv=none; b=W31qBiU5aLE9AV6wpGNVJ4BH4T/uCGGVw6mXFQUGWqVqZASYQ4AAWEs+uhReuWbpKIRMfESA0v0n8Kdw1M0ulcqulxWDj2+caKG3Lyqbru0L5c3Y0g29vWBxTgUSM7WDV15IjIh7fOLh2sJgscbBXcx5ysBhOWRqR/pbMcN0Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753572; c=relaxed/simple;
	bh=yGuboUMthTnrSr0YxktMqa6s6aGvoefMlWmXmxJDGv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Izp9GKib9gCmfoZ5xlCaKDoZl05aErauTJkcPCda214meWu0maBg/b88fxvqCF24gBvVAbcsNuIYYA6UPt4JZqXDNoATQXZx8mkHyTKHn4P3uolit/fYIgpciwE2EMoEdwk6nbkUQSyTtf+Oja4HJXjqT8FZeRdzaZJChEGAIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVMBL48Y; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVMBL48Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE67F607A7
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 07:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id weR0afgYmUmI for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 07:59:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=krah.tm@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CA0566070B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA0566070B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lVMBL48Y
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA0566070B
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Apr 2025 07:59:29 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-391342fc1f6so1473564f8f.1
        for <virtualization@lists.linux-foundation.org>; Fri, 04 Apr 2025 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743753567; x=1744358367; darn=lists.linux-foundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nr/t6BskpDZsQWS/KHvw+5O1AbfwUb+OCjtyeJ/2soE=;
        b=lVMBL48YYpT+SAAPQ/DLKYwhgvx2nn7pBJcaXdfSOLqt0HfhbDM1+KhZegWjsGT1zK
         C+6GuuwBrBJSyC+RU9XKgW2OGShfLd3B+Hnb7HuLXYIu1ga08UJgBt1MyYCSxSihcS2E
         7yKLyVyhsY3h0X62RvWeVSiwVkrVvoBdLNgGoD2gy+xxAbdp1MPoMQBAmXV94Y44bofB
         y1icVGGT0weanMdn9Pyt3o/7l6Rr/ey4LVAHJXSQryUDBE38I7kzfOcY0rxu/kgx2w+u
         2GzNU2WsPiys/6fkXnVPY+i/FvUOh1VM8FU8RzbOyo2d+BZyqHK/oiWTrxQueb9Z7wC9
         QuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743753567; x=1744358367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr/t6BskpDZsQWS/KHvw+5O1AbfwUb+OCjtyeJ/2soE=;
        b=ca65siGb27e+lWcI2fZZy9YvMLgbmM4q21sbJ5zxEn0I360yGk/0MFIOFHkd7fq7bV
         SGOQzi/UWZLKzBx/D5GwEaU8a0wa05HckgkkAFKNLE5vPEFykHD23wP7RMwgZXCg7/un
         8uquyr/UJ8mM1ipNpqJ9fWHhpFMrKOSMDGaW3jRNrzJEhBxnBxJ/31OI+ofA/mF2IIxJ
         F6sHkj18cK8Yv50Mw8Bwm97OSklOH7yoA/ZYWQLF5dnbIvH1kHs0uEmngeeE2jkaIHQZ
         Dq2hnPok7Dsp9zHPCN1mCTK4c8znXZvWd6oYb2wwGgunSkUE5AlQ4bapZ8qwxaHL83Ed
         YJQQ==
X-Gm-Message-State: AOJu0YzctrFZXqzvlgto2Z0j+GWoKKt5HP0v6/O+JSJvYEDDBsHRFk6U
	wGTUmiIf1osc8u1HGDPV5nhbBjR1ZdDcJ3j541QZF4Gtj/7U+EvIIkOJ+bK/
X-Gm-Gg: ASbGncu/acAnF7PeaYSM7x9vA0Mk4aylXPh2QiZ1bTwhZ++UhCvoaa4yix8PaJtbfZQ
	k43TpcgdGuaqow8c3F16f8Nd52c1n7d1mmJ/zrW0d+neL3it+kh/LMU+FwYEZ/R5S+YqC5T2Zz3
	U8T20P8aX361VMIB4zmSK4Ae9cYKADzfJO+ca7OPdw+iFe61WbZRURW6+gnuvREEopyngqcULUi
	qUbgAKhILLIHZp/UjtAc65/ZetUK9p+KFEoGDZl32EnpgVDUcaGSy7VlFUUPeyzcTg79MvfGWaP
	ZCUwJjqOSovs3Xtczy3ETwjqbkgPYlov4raLKf3RERNZtOjQYxeEwweq
X-Google-Smtp-Source: AGHT+IGy0FnVsV73jUujcayMrD7rYIs9G/cxOlRjUi4l53/BlPFVn3dQEG1Vf4RXOkfRc3KVHv1q4g==
X-Received: by 2002:a05:6000:2902:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-39d0de67b6dmr1352589f8f.42.1743753566484;
        Fri, 04 Apr 2025 00:59:26 -0700 (PDT)
Received: from ?IPv6:2a01:50a0:aa10:1a36::11d? ([2a01:50a0:aa:0:185:40:248:10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1794e94sm42791465e9.31.2025.04.04.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 00:59:26 -0700 (PDT)
Message-ID: <4d0c0cb9e9d513bf9ba81346ea72c9e58359ff93.camel@gmail.com>
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM
 with Linux 6.8+
From: Torsten Krah <krah.tm@gmail.com>
To: virtualization@lists.linux-foundation.org
Cc: Markus Fohrer <markus.fohrer@webked.de>, mst@redhat.com, 
	jasowang@redhat.com, davem@davemloft.net, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Apr 2025 09:59:19 +0200
In-Reply-To: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Am Mittwoch, dem 02.04.2025 um 23:12 +0200 schrieb Markus Fohrer:
> When running on a host system equipped with a Broadcom NetXtreme-E
> (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in the guest
> drops to 100=E2=80=93200 KB/s. The same guest configuration performs norm=
ally
> (~100 MB/s) when using kernel 6.8.0 or when the VM is moved to a host
> with Intel NICs.

Hi,

as I am affected too, here is the link to the Ubuntu issue, just in
case someone wants to have a look:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2098961

We're seeing lots of those in dmesg output:

[  561.505323] net_ratelimit: 1396 callbacks suppressed
[  561.505339] ens18: bad gso: type: 4, size: 1448
[  561.505343] ens18: bad gso: type: 4, size: 1448
[  561.507270] ens18: bad gso: type: 4, size: 1448
[  561.508257] ens18: bad gso: type: 4, size: 1448
[  561.511432] ens18: bad gso: type: 4, size: 1448
[  561.511452] ens18: bad gso: type: 4, size: 1448
[  561.514719] ens18: bad gso: type: 4, size: 1448
[  561.514966] ens18: bad gso: type: 4, size: 1448
[  561.518553] ens18: bad gso: type: 4, size: 1448
[  561.518781] ens18: bad gso: type: 4, size: 1448
[  566.506044] net_ratelimit: 1363 callbacks suppressed


And another interesting thing we observed - at least in our environment
- that we can trigger that regression only with IPv4 traffic (bad
performance and lots of bad gso messages) - if we only use IPv6, it
does work (good performance and not one bad gso message).

kind regards

Torsten

