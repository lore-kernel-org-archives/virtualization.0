Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77312EA15C
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929965; cv=none; b=eHMcwCTAkoDl+4PCKb6ijowSNHLYktYzSVN7PRHDor/ex1iNch6/8pOIvhX8Qw3F0oLMnehH/VUWjuunVDNkbruLJKEWmOuG9MTZr67AL/ytA2d4jV4XaW3eLPJEAQwzQ4m+1JECeJfq/bDx4GbITc93NQ1UBRzQa9xl8dWD2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929965; c=relaxed/simple;
	bh=ziWt0RFFJB//dguhCOZsTWBS7bikbzN56Hn8z31e0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwVtn9Sunnds/fmGYPeE7NQSyQuX2yDPaVXUNikyUMk88uMBDQGdkRRaLBGv1Dwg5FDj+DLzY2V5DmiHl4zyltmwhOUqy51AfEQke+NhWuXa5yHhr25EPSLdQz9s4TNumYZ8aJB1i0m4A12rzeAWCBEc5bdvlYyDi57lRoRdiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELdF3tjb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELdF3tjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tjHShH1itfWbTnxfitY+x2Nc4ZzHnojh1ZRl24kqzEs=;
	b=ELdF3tjbaFg/J34l0wBgj/rb7jg424aaQT4Sab3oGEypd+LPwEAhHc8KhW/Xq5YvfPozr4
	wI6N/VS0AnWwrf3147NDKIci1G1Hvg6KdMu+P8SdSIp2eECtpkNFYQTafCItFbkX4LveH/
	bgzoDrZ3y5fhQYy9Xc9y71l3SinClpw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-MnbU44I7OSWizFnKt14jew-1; Thu, 12 Feb 2026 15:59:20 -0500
X-MC-Unique: MnbU44I7OSWizFnKt14jew-1
X-Mimecast-MFC-AGG-ID: MnbU44I7OSWizFnKt14jew_1770929960
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48070c21420so17409445e9.0
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 12:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929960; x=1771534760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjHShH1itfWbTnxfitY+x2Nc4ZzHnojh1ZRl24kqzEs=;
        b=KXtj6hB75s8+DXRSSF4p/H65JaTpIUtbT3l7eiTbrL8HNcz2wN9p1cqqVGGbMNwrzr
         JB5lXbKNyoIqArAj7mKoU9WK9rHjPh09LaHczgawKHlRcwGGWgtuYO2VbLuJ7L6fMClp
         YGHAvOi9S5CcM/6xOm6iguCD7n1Ns83sxw5Th5RL8r+xwpFkiY1UgrZvDjSttHkwOn3c
         lIxZTi0b8zh0qSeZvg/l7uKa1b2wkNi5q2sqIYAuAAhYMXuHz0d7LlE9Gp9eoy435kx9
         lh4LEDvTQDYzgpkC4/hwydttva2IU3JkrLnxgNUYEXi6HFz9CqnfVU4k2VuPpaXCv/ss
         9FnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDE6ch4M3hnB8hxnPqKT/+qIjXXfKtkeJs1UBeHBU+IF3ocREfGXqdmYINoiXqOcTm/T/VMAPS6pPVxN9vng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo6tWm4COMd7z5J7V/G8Dr+l5ewGeb8EPg03XRQnhrmwBoDrdV
	badTH4DiC2EUk8AiRuRw7GiKsozCOW9hm8Ji2Ze42EhZquwpU183BbnnXLC3qy3Tb3adtmiy+4Y
	Xmp2y2VjMBYmWY46FjAFlrzW91rgI/SMgs2t2tp06L0wPimI6rUqoa7Ic5Bg4NhZzLVZ5
X-Gm-Gg: AZuq6aI3ViJd5C8JFeZe+9GJJu5QiSUC/b86Pfv6EdWyBkr8jtDMy0+EqlenwR/6zk4
	Gmg9l8Pg5vja6tBBtFIn2pTDVN/d72kkvn/ui1pOOJ8po/ugIXTB7Emi+6jljjTwm7IzmVSD3So
	MB9USIADc10lZam6plGkCo2gyqNky0+zDLedyM2wyq6uL80PQgKiZkugF/d5b8ELCmMtwMbU3t1
	G0magB2VVpwTNUoMoGJC8XV0XDnZAW3t593QBzdSERYWrox5WuTj5RdiAFIqm0rX9D/upFCgXuV
	g6LolUuTftG07dPU2GH9u1uqkTh76VptdZFDyhJshjzhnE3SfaucQGkxUiflY6K2BF7WpEPYoTY
	GZAvvecNvbwa4x+B+SnoUsKCX52x+3M8WOla0kj5zoycR5nyGVD3b6A8g+Q==
X-Received: by 2002:a05:600c:81e:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-48365fe67abmr42250495e9.8.1770929959677;
        Thu, 12 Feb 2026 12:59:19 -0800 (PST)
X-Received: by 2002:a05:600c:81e:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-48365fe67abmr42250385e9.8.1770929959261;
        Thu, 12 Feb 2026 12:59:19 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d930902sm189202405e9.15.2026.02.12.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:18 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 0/2] vsock: fix child netns mode initialization and restriction
Date: Thu, 12 Feb 2026 21:59:14 +0100
Message-ID: <20260212205916.97533-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ONalRsCIbvdU2MQ4-zMgcxQNYTxTJlIctSidZkObmYU_1770929960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series fixes two issues in the vsock network namespace support
recently introduced by commit eafb64f40ca4 ("vsock: add netns to vsock
core").

Patch 1 fixes `child_ns_mode` being always hardcoded to "global" for new
namespaces, breaking propagation of the "local" mode through nested
namespaces.

Patch 2 prevents a "local" namespace from switching `child_ns_mode` to
"global", which would allow nested namespaces to escape vsock isolation
and access global CIDs.

Stefano Garzarella (2):
  vsock: fix child netns mode initialization
  vsock: prevent child netns mode switch from local to global

 net/vmw_vsock/af_vsock.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.53.0

