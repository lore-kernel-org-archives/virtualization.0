Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFE3290B9
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986256; cv=none; b=XAIT2LbIhiP5CoeYCBmBZ+f09kGM0Qpg5nMcJbCBwvCh6KQCy2nllMq02ItzVkhqJtIh8q00SI+XwPexSsmpvlNIq+R6WcLHjdxj2Pi5mCDEBELfyhGlXe+utqayZHrKSAoPTi9A3pDNVJD5uM9zy35SDBX63claafRtA3dFDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986256; c=relaxed/simple;
	bh=8MWVjZeYNhTx+esotBwcokXLnFU7Ndf702RfLQ8p8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baaivbOhT8MurpCJJb1uuSQ31URYcEsZEsxkDS4dEZdXKGomgHrp7xNJlZ53LPGZeYkPJYEsYLOUMKYdhpkPeQ5UjU+Bow3UGURlLx113YHw47mfE4OVQZKKWk8bAZRWIeyp5oWoP0gple2/ljE8677Jc+xHSzQmpgmBC0s3dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8jVR5/g; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8jVR5/g"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D38054021A
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 17:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3V5pn3858Pd for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2026 17:04:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=seedandsyntax@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CDE3440204
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDE3440204
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T8jVR5/g
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDE3440204
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 17:04:13 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-848643382fcso3781532b3a.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986253; x=1787591053; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MWVjZeYNhTx+esotBwcokXLnFU7Ndf702RfLQ8p8/I=;
        b=T8jVR5/g8uLCwt0n59DKFx4VcQbiAGjPP1gPNIQbFNQuAbLr8o847HoaELNDegXD/E
         QnZzkuu1KK+drTzXJd/Z2UAZfjSHKbjaIFXE6fM0IS5I9BRGKnGddJK0+EgQDfqxaW/Y
         LcLUmX3m01ejEsIyD4pmC3n3cd+8q+HG1mdOipeuWdDCp7rmzAu2msc8fMHT1dCpPbQr
         Zbv7/VMCFKncHjKaPAIeOgWV3GXT9inAmtRhGKhLns6KfzPKtm7r0080HGEorQn0OTwd
         QeLWDmZhZ6Cygs/Q7Zr2NA06T0+S/tinEgV8InGJS5pfZv3DtaFIBRlx6kydosk5z8fd
         seVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986253; x=1787591053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8MWVjZeYNhTx+esotBwcokXLnFU7Ndf702RfLQ8p8/I=;
        b=PWqgrF72wGfBqCcEkKYF5a2d/9ATB0HQ68M8Re93EIA5aqTTa0f5ESAn1jmsAPgCrq
         chVRc8WadZPDZk7+dlY6EoxJd8FQAi+JG4SnLf949Yb1paxusqkAFF+RTknGvwNHIj5v
         VLRToLvu2Am25UGIi4WfY5VLlBfFXJS61DmNycaYOsWnxCGAsUtzcK4JbPbOKN2N5q1V
         K4VkgE8R56N/QGcxfNMufPVCzYBtkrj+NnZg/VKp5LIt4v/Rh5Ua+q5mnQJjvF00VUp1
         X2o+a/U8fcrCz1bTQnTXU7+VF0n2FOFNpHEFzNPV1K0lFQNm4RC+p7at3JOuLDwrEesA
         P8nw==
X-Gm-Message-State: AOJu0YxZfGVXKs4Y/vKDqC5IniAZK5PLqEeieuS8pofPhqAfUtVqWToX
	Hoe6S601Nic4GBN2dMp9hT3yua+o0UEKGyHYxEeIjH5UuiHuGUU+s/oa
X-Gm-Gg: AR+sD13UsTdqd7lqnxsEHaqXxCWhPHcqMo/RL+OeD95pAkCYAT48XPHrBeGGFYTq9lN
	j2MoolQdYGobv9/WNDvttCOPaUrIdU9WMXe7kwYfoUBs3uziDhjBtMaO8uNx7/kDBUxfKtDWGzc
	Htls4PSeMrkU5i7Lx4Oi5SO8Jn5Zq1yLcHi8gSEIeEhqHN8mfeQqVg2VTHL9cDnsVUMcGs46lXf
	GMJVABL2/jcGioIDyq1POa49YQQdbpE7fFm3hcqPt20kQnhXpTsyV6DdHBlBGKhy/GbtB0IybHr
	8CVe/87gOw2yR6wfJ49s5BhNSBTAyxJVJCX54jv5twhjoGj0LK2DPCuqGOlMp12BGQgTDgJk/ZO
	bdV11hzBUyAIXgbvTzuPaaXgWawRuRFRnDwWuYsDMp7sHb4c9jeK8IDblKS2drje10f2jEJ6kDA
	1x9fQXL4oKpwio9xti2vmb9xzwztoEFnx3h/ff3X6/FAv5RNMvNvr8Gm6qxYKSmcz1Kah9hwaR/
	UQZxuhO3RaKdj3IHr3Ko0MD
X-Received: by 2002:a05:6a20:6a27:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3ccda9f7871mr1640220637.14.1786986252598;
        Mon, 17 Aug 2026 10:04:12 -0700 (PDT)
Received: from Debian.tail44843d.ts.net ([183.82.161.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c0445c6sm1057913a12.32.2026.08.17.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:04:12 -0700 (PDT)
From: Mirza Ishan Beg <seedandsyntax@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Mirza Ishan Beg <seedandsyntax@gmail.com>
Subject: Re: [PATCH] virtio_pci_modern: replace msleep(1) with usleep_range(1000, 2000)
Date: Mon, 17 Aug 2026 22:33:31 +0530
Message-ID: <20260817170331.219615-2-seedandsyntax@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816173806-mutt-send-email-mst@kernel.org>
References: <20260816173806-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 16, 2026 at 05:38:06PM -0400, Michael S. Tsirkin wrote:
> why do we care?

Hi Michael,

The motivation originally came from a checkpatch.pl warning, but looking directly at Documentation/timers/timers-howto.rst, there is a practical penalty here.

The documentation explicitly notes for the 1-20ms range: "msleep(1~20) may not do what the caller intends, and will often sleep longer (~20 ms actual sleep for any value given in the 1~20ms range)."

In these queue reset loops, using msleep(1) means each iteration may be extended to 10-20ms depending on HZ and timer slack. The document recommends using usleep_range() to avoid this overhead and provide the intended precision.

Let me know if you'd like this explanation folded into a v2 commit message.

--
Mirza
