Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBC3CE48D
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035323; cv=none; b=W6ecLfvta8I32Uwn/2OKYndI01YLDYJB5JTwA8ibMhYgEGFzQDqg8AWBJHVKEz9hyt5iF4dnQAQLrWLWwbHSA2+DTDqU02PII1a7v7ByKyXF561B5hIhCEUl8DZ+1G2ybt7LbA/B2QwQt2AnpEc6AnqSiy61qqWjHNRwFWTKS3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035323; c=relaxed/simple;
	bh=5n2wUfF38eHe2KG7fl6sKQK4heAIadpsxH8OnzLRvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=TW0gydEXv6DMwWAn5JGNqQF9FEEu1BwDKIgv+qod+Njbv5XsjQhEadk3fOyBo9zPz19uL9mRj+/3HKT5pcvMlEtF3lfUgWLn9cAfFSm9quHKn0r2mnkEfbRkJfsxsRyEFFcfH68ZVzTusYnFWkvA9cAimC1kMQVbOhKiyvq8bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbbKhV+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbbKhV+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775035319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Q6ei+ntkpvDAF7nzvhz0eKbU/9b0wmVLzSpYnM4X8M=;
	b=IbbKhV+WkZs/eS5/iKbaUcJsfhDMEy+WHeKoIXwWG0gStAk1BNHyUSPtaaGCyJ3/EkCz+9
	rOtyMqxUorhIz2HhsBe5V61eULuu1YeFt7mX5uy20Icej1e6lBMWLYATHoi0q3dpuRiiEt
	l4ING07J8gMpbE0OHuLJTfaIVTMQ70k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-lqt0oH8SMu-DxSqcv7jPbw-1; Wed, 01 Apr 2026 05:21:57 -0400
X-MC-Unique: lqt0oH8SMu-DxSqcv7jPbw-1
X-Mimecast-MFC-AGG-ID: lqt0oH8SMu-DxSqcv7jPbw_1775035316
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48881eac1f2so5691155e9.0
        for <virtualization@lists.linux.dev>; Wed, 01 Apr 2026 02:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035316; x=1775640116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q6ei+ntkpvDAF7nzvhz0eKbU/9b0wmVLzSpYnM4X8M=;
        b=WYZKVulIzA4y3Cfnwu4gO77uL2sGZT8pLA6zF7EgJ+kH5c6utRcMqrm+qCd6+QntXV
         yn3p+BelH8WeI/57xSGpLB7GmUEfqiA6lsbXoWhK+IRepC6D1Ln/8K9YjpDSU4ux0tg7
         VF1RYSBh73MfeTKWcSumgtrIV8Ct0wxzMOU2IOEoLMCC/Tg0fRNxYpo+ZpcEeNJJbSuh
         6/KH6+VRDHF5AZrlGyzV8/25dfLCVEh0nMZtats0NNEut6I6M7tZ0KX5y74qyz9zcFxt
         X5DuBG+fQwe9VdV4yG/hb24QR34v1vX5k1vtBv2BZM8QEJJ7vGjNBpRHvRdbgzQslpPv
         Gdyw==
X-Forwarded-Encrypted: i=1; AJvYcCXkC3d+RliqqGBlSriBcJlPN32/XdQKio+coRYBsxcisAD5+k30k/lTlxbmIVh3TazgyNFaCZuv2d1RaLIxAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwknxPlLv/IUegOjECPLJg8g0D7JIeRhms1eDB9PDa11Pg5fn1S
	6hiTQ1gZhacXNP33vwpOys4nMAwFpuV4VkNReH2HKTo4gVCHfmPmM00+4et/G3DVeN3mEdX8Ta2
	rtYH+gG5v9iwzQglXPlJ026i1rcnir6X0WdTsmxBMitCMXTD5BedXrg/MZn+DE8vsf7mp
X-Gm-Gg: ATEYQzwyYCLJbvMAIeG45c7K6OB0udRYgunImdOJVQBwNEdISFNIT4PbvaNieBWxkZC
	Ah+FA0g111WBCRgTAPmvl7ldZaSsQ/VMMvFbezFv4o7I2bTwdDuXtiF0XXNboNGW3jyHHniofmM
	wOpGvPyY1CIGpKl8OyEFSatS598QSf1tV+d+W8cnwd+0qApgk6IGdPYbzoR8cgXo0TgiQ76jVkY
	RtTIXaKFaE5br3p2EuipDp5h/I+fLLK2F9NUZw9f08AoiRZxHHDWU8HtOQHU/aPZauEb12/mwpO
	ASEEsH2ybCiGdhkPiSRzH4CSeYqu0YkHiJwYbXjJnBLTaut0M2j/oB8+MXDq3JNOhYAhAlMGQEW
	ll0nVr/+0SFrPAxeWvvrLTh+yYz/ZPoCRXIy3gia8jkkga0U2fxBy0awsYaCS+rU=
X-Received: by 2002:a05:600c:3ba5:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4888359db41mr42390965e9.25.1775035316251;
        Wed, 01 Apr 2026 02:21:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4888359db41mr42390465e9.25.1775035315693;
        Wed, 01 Apr 2026 02:21:55 -0700 (PDT)
Received: from stex1 (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad477f6sm38285485e9.7.2026.04.01.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:21:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jin Liu <jinl@redhat.com>
Subject: [PATCH net] vsock: initialize child_ns_mode_locked in vsock_net_init()
Date: Wed,  1 Apr 2026 11:21:53 +0200
Message-ID: <20260401092153.28462-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 16ZDrHHeAK_h3Ic2W7skulbGHxMkH3PZ1-SAfNub3ss_1775035316
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

The `child_ns_mode_locked` field lives in `struct net`, which persists
across vsock module reloads. When the module is unloaded and reloaded,
`vsock_net_init()` resets `mode` and `child_ns_mode` back to their
default values, but does not reset `child_ns_mode_locked`.

The stale lock from the previous module load causes subsequent writes
to `child_ns_mode` to silently fail: `vsock_net_set_child_mode()` sees
the old lock, skips updating the actual value, and returns success
when the requested mode matches the stale lock. The sysctl handler
reports no error, but `child_ns_mode` remains unchanged.

Steps to reproduce:
    $ modprobe vsock
    $ echo local > /proc/sys/net/vsock/child_ns_mode
    $ cat /proc/sys/net/vsock/child_ns_mode
    local
    $ modprobe -r vsock
    $ modprobe vsock
    $ echo local > /proc/sys/net/vsock/child_ns_mode
    $ cat /proc/sys/net/vsock/child_ns_mode
    global    <--- expected "local"

Fix this by initializing `child_ns_mode_locked` to 0 (unlocked) in
`vsock_net_init()`, so the write-once mechanism works correctly after
module reload.

Fixes: 102eab95f025 ("vsock: lock down child_ns_mode as write-once")
Cc: bobbyeshleman@meta.com
Reported-by: Jin Liu <jinl@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2f7d94d682cb..d912ed2f012a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2928,6 +2928,7 @@ static void vsock_net_init(struct net *net)
 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
 
 	net->vsock.child_ns_mode = net->vsock.mode;
+	net->vsock.child_ns_mode_locked = 0;
 }
 
 static __net_init int vsock_sysctl_init_net(struct net *net)
-- 
2.53.0

