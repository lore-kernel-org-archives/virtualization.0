Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA227186A
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363157; cv=none; b=mmKpgakzf1zNu+ZMFiTmvb4/mbV4+b2N0qrMi22bmTD51Z2eZUEKeRdVDI5c1rDUPgtzh9bSF3oDsCTE27Ipoe7w1THmg23/JMJlokW0hnb0ohxz8t1Y+bDyMeYQo7HGonqcRcGoLTFMy0b9sjc7E0DETmlK8XBcMYvR3IXI8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363157; c=relaxed/simple;
	bh=s14vBgutowKcr62eIsC9ufvoPLt1SWw3DCy01V2cLUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZxCilwUmMUvZ90MWvzlJbMA/QmZuYnnojgckUuouqfgqhLswgPRN7zjXNc/aXW03/01UtXdXZ1tOy8bxkvRQBESFxE3uzXBNmEf97BR5t4WOFnpz2Ajcu/v4YdHUI8Yobpr+o2VbZpQFfhh7YNoXlFX/oQF1TdbvsGaQNt6TSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PwfEAsCj; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PwfEAsCj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76BD0607EA
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6frmFLSvetFx for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:19:14 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B9D83606F3
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9D83606F3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PwfEAsCj
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9D83606F3
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:19:14 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7178df70f28so2562535b3a.2
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363154; x=1726967954; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwVlUKckgS8bZXoI1lP3EkBH6SRbodiHKOIaI8JuFWk=;
        b=PwfEAsCj5W8dHUNid2embMqTi8vC4l7b2Hd5NItciTHfR0exPCtFgPkUCuH5EQORiu
         MxbnE44jCRgTVpXmW1f1vHfddbozhaOcMLm5Wt09mDr8kTFVOGskxRsPixeGyJo7wjnz
         LYBaZETiBvS0q0/AHFSqNIZtDJHrK0m0AWmvSEeice+CWefnExMBvfAgBCuNxcuI/mU+
         i0PDBnAprmaXs9MaU2AebGWAOxlc1929FsEElOIYkn1j1p1gOIWxYnoqdOn/NfHQJ83i
         qEndd1MfeeRh7FVY/Q8gSDcJQMUnqkQiAUyAtelovINYF8zd33dUOF6z25f+agfMC7dO
         qk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363154; x=1726967954;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwVlUKckgS8bZXoI1lP3EkBH6SRbodiHKOIaI8JuFWk=;
        b=TZE25L2C5EMGOHQzFcqyv6RoeGH0fVmUqpgxChRFGIpsLPTeu1IEckLFf/SjOEpAJ/
         ajkzh2uz3Dv70jza3L+1dfeH5UNGniBvkZJdAHABaNxGQJvcWVQg8EMmHLHKEKRt9L4I
         DsnVeamb6QEKdYGaJYLI1okZ06QYbcZlBJfxKQzx20wVsBcyRViqTgckImElvPcDA17r
         grfwco6nigYuGbkJtTQPkb3JRSP1wQX3Mzjeb17QPV8iWAnwvsJKHWsfTqDxJrDR5bRn
         EU+NTuhs5B4kCA+LlJfmBW5SNVMNfBPbbe9A6Pb27QXtOO0VF9UKw+VY/trk4wu7HXhx
         YYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV63MVJ9tOLWfAuq+lXGMkM/mI1Z04ZSIqP7mAwZNb940P4qooH4IVm++fj1o3TrrkG8HZwvZ2dRQth+JHnPg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx7tfnygDbdpQuqnboDEuyVwSpcZtENwCjjl+DUQVBENA4Z9cbO
	S1DerWT8aXsLeDvQkVebTz5pYIIoeoHPj1gbybjtsvWMjmj7uQSVBL+rpEGE0PI=
X-Google-Smtp-Source: AGHT+IE60/z5cqZPxQare5BSx0GkgFgfZEo8DkLpn1T/gnYQSXT5vBLFlsQk2V5fCDwH8OXIIkoDKQ==
X-Received: by 2002:a05:6a00:919c:b0:710:7fd2:c91 with SMTP id d2e1a72fcca58-71926203062mr13340464b3a.26.1726363153743;
        Sat, 14 Sep 2024 18:19:13 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71944b7afc5sm1522185b3a.122.2024.09.14.18.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:19:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:43 +0900
Subject: [PATCH RFC v3 4/9] tap: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-4-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tap used to simply advance iov_iter when it needs to pad virtio header.
This leaves the garbage in the buffer as is and prevents telling if the
header is padded or contains some real data.

In theory, a user of tap can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..ba044302ccc6 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -813,7 +813,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 		    sizeof(vnet_hdr))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		iov_iter_zero(vnet_hdr_len - sizeof(vnet_hdr), iter);
 	}
 	total = vnet_hdr_len;
 	total += skb->len;

-- 
2.46.0

