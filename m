Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521628DC8
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753049; cv=none; b=ksDQfjq0KpN4OyjNNek1hh7KkDfaXIH8kEI5IyyH9Gq8gl+JOY9YS5N91semBrRBDYLQrGZyZIhLMzuGUKn4tNGvTLPP+KxpUWc3SAi19fOjNdMf3fiVsi4AIrEi2cB37RELBLJNKmEPcag0er17s5NqlLlVA9F83A5U/q2mEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753049; c=relaxed/simple;
	bh=GMZ677o8MXMXiSv4h8mvXL5gZjYj5c1FwMqptPvTaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0+DXH6X3FYk1nsu+WteWLldzK6RrKMw3hiWbEOVYfKGxi78n7Qmz/J+t2fC6B2CWAQ2bS/suWr0jlHXouzf7N8hpuOZqfThB6Gg+VacJtb+p6dEkaL7yqzi7fDc15s4SwQaX3JFUCryGyxPbG8sCOuudhHrrso6P74BQAqCmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LqGK/Q8A; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LqGK/Q8A"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C431400F8
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ya6Kfq1tpNK6
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Mar 2024 09:10:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::133; helo=mail-il1-x133.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B326C40017
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B326C40017
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LqGK/Q8A
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B326C40017
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:46 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3662feb90a8so30877385ab.3
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710753045; x=1711357845; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgQV9frW8RnICjhCsBOh9fiyAly3vsXKMsPIiymkwaQ=;
        b=LqGK/Q8AaTtPs3z4RaD37tqu6CiDeVOM/JHdvNehImREIfu05Tpw8Qh9JC1KSs9plz
         EsJwVbTOMeHkMvHpYDBKIiIDOSeopTKPqVdMAUVyXR2c4VMEJrJgOq11wZd2YtlY7KSd
         mqCPORZ57bSaVU/ypYKU6s6PHdlD611bpUDko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753045; x=1711357845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgQV9frW8RnICjhCsBOh9fiyAly3vsXKMsPIiymkwaQ=;
        b=dDS1M0OvG9CTb3IFoWXh55dD3Z9Dlh5WJuJlKToj/zoDUr1rUqZjAS7iU+1f0Rgfwu
         EK4GztkQFJ/dnlD6cv+hC/PuYW4CKkE1dQv5Lstmnkbo8rxxZubHroRJyB+8/UX25Yj9
         0nT+H3X/nHY/PFyroJUIt71gGVvY8Jv/mDPRQI2+wvDcwPpLXsabUXpnE58CZOqNYJ66
         225m3LAEYwMGN0Z5vOuMyimwx5SbU+EMCP1K5z4QivgF2CO4wQ3a+csJlYrqklJ5h0qF
         nf8oJwMbGFINB8pmjvzfgrDN9VF5+2oeJS5NJRJplbuHeameS4Jg7vmeV41c5KjI2++j
         Ow2w==
X-Gm-Message-State: AOJu0Ywf91JQ08H1/nWowtLDEWosPqtsLS9/rZlTa0/3lnegBUUvQXWU
	AEIN2D2IZ0QwTdeWGjYSBD6N7n7hh6JHPJH1omEpv8oqX1q8bu8gPn0j+EA+jg==
X-Google-Smtp-Source: AGHT+IG0cB7zGyiKSLMYQArEsPlbj+Pzce168Z3n8zBAgOe+pLyNBhxXOnjnY5ntbeL3bLG/AJUWYQ==
X-Received: by 2002:a92:6c03:0:b0:366:c678:599 with SMTP id h3-20020a926c03000000b00366c6780599mr1857042ilc.13.1710753045597;
        Mon, 18 Mar 2024 02:10:45 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:171e:5cf4:dcfa:390f])
        by smtp.gmail.com with UTF8SMTPSA id f35-20020a635563000000b005dc884e9f5bsm6638068pgm.38.2024.03.18.02.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:10:45 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 0/2] Improvements to virtio_balloon pm
Date: Mon, 18 Mar 2024 18:10:32 +0900
Message-ID: <20240318091034.535573-1-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

The virtio_balloon driver uses wakeup sources to allow the guest to
enter system power management sleep states (e.g. s2idle) without running
the risk of becoming unresponsive to cooperative memory management
requests from the host. This series fixes an issue where wakeup sources
for inflate/deflate were improperly shared between drivers. It also
closes a race where stats requests that come in immediately before a
sleep state transition could fail to be handled in a timely manner.

David Stevens (2):
  virtio_balloon: Give the balloon its own wakeup source
  virtio_balloon: Treat stats requests as wakeup events

 drivers/virtio/virtio_balloon.c | 76 ++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 29 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.291.gc1ea87d7ee-goog

