Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD83803DF
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507981; cv=none; b=Wye+ChfsUMEhS0uJHIxsGTkZ2u+G+pUKFX/IeUL25/MlVMW8CUmUFsDa5uE8PD8awJXN3/FOuPIISQLdnqF3tSgYquCNEkxSguo0pgzAAqWOkC9f6eouHIokWPr0unND3BFwXnpyOMrGw6sIWIforO2npTtrQ8mO7n0Qqp25TlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507981; c=relaxed/simple;
	bh=j+GvspEPFMJKw6+StUj0ft/LLbZU8zbHTx8oX1MMKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVsmuLy/kQmD52TfTKFLK34UssxO/CEVY+HMwK8irvJ8H4rb4ygIZaUDkwSvojXDQqkHzv4dMF1509xH7m30pMkcxUq0dnRdgJCLYm0Jz4uD6KrgWtKfjQoSlpAGSiBsFuIJHQd66xPch/PguLD9bwceT5rS8pRwlzCK6Vzx5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbPbKywC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbPbKywC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1925000a91.2
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507978; x=1788112778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=PbPbKywCdIJSfurcmIPDKypD10T33KyqzXg0YBAGeZNqVAfpjXpSKc3hxB2A7jYTVD
         nvjxmCN/ydjYFQKIKe2E7fbopnEBPAS67AQscHPvnlWKzH34miHRsjC+8R5tSDNdQgFm
         aF2h1hBfnggzKGb5wOZW5HmPtgp7u5Q8x1G+qatn/xObxLowhZD14pJGGfzlDlLe48Tp
         4xpb7fD5/PthEXoIzCclQvpDBd//9KbTJFxiodfvH+S6601PRYHhsbhh1v59hOQAvneF
         dGZEao+nvPe568doWsb1d9d+WzjDGarp1WeUkX1Od3jMzF3p/4UjxbHrT8ZGWStuiFDu
         PegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507978; x=1788112778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=GucoovRnlHockEU6j0bAXNnuJkm7l4A0RPxZoNnfQgnVBlZbk8kUZi98Qa0UOwmeUw
         oZvcEhB7QnXjtpREYN1K68roiiXX8tjeFRACS0hUlMyb/jtT07LGtadvp7h1OP2IPeFi
         5xGj8jglxp26zvsqTAVR1ItocNA+SvZge8KVzdhTLdpBPw0XVZNzaiDvZ+egefBA2+3f
         5Gce0yyOBK25TDD/jmVnssgO3SKVcXmQSFeZw5WWJr60CL8S9Z//5xlH7jxUgJa6PNtC
         H72eunZO/B4cfLyhfEgBbtwuVo0VuYYrj6cS4Q7ZQklyC0neoaeeGXWtdKcCzRY9AOyD
         7NNA==
X-Forwarded-Encrypted: i=1; AHgh+RoQ9Nq5FughQBvqGCFHZ+nYlukWITiRW3CupAFg49RA175J+pY5MxQuaQ6nZCgWvfktcVXNbz8sJW414JEyxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mtxkXefPo/vYXKm9Ya9cd/JdA8FE2rFVjyCs2d/m9sPeWYx6sq
	ijPwtFvZYvFw0pGI9OsdfHvGF8re11lwkTxCC4ijxjlzLdY9dbMWt6zW
X-Gm-Gg: AR+sD139vTkuDfNbDEUkIt7escPyrUjQPYa3roQJKfFe1t+ZJBBSlAU+ncnwAP5y1OQ
	6+zymWUMqAgUgeS+XOhKTsS5PZNI+YFDphsAIqBLmg+jjbMAOc5+r98+G8qj6PSieOO9ACZtT45
	XmzxGcKl1QvOdtP8oriXJTKYjjCouye0DMxDgxvEiJ1hcpauTUOmSmJfTjZXcvOUQTR/z+PtrKF
	qc35WDYKdeOTUv9lGX/rKNNQUC16jXgUHZFN3/Mk5oM7SR8vRhgOcbEoMTUXYOmdNXhPzJLeXG+
	+Sz7UOmbFAMctlRCQbB6jm5pItTgjSYO9gbNg7Trbsxj5ZCc8sONTNtC0RVXf/Rjr6gP3W1D5GP
	NxhVRcOpQU0i8hc2jBz6p81UCqcuwRnT+CjLrExMwtGftodrdFNfd0peg0MCPjepBVIZY31Wed7
	8E88X97Ut/lCXFnt1sgIGfZenVoQ3N165lidm+dMsXmfRgesvZqwxOJrYKu1kRZiTpLA/wv5L+
X-Received: by 2002:a17:90b:4a0d:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-395c3376963mr33466205a91.3.1787507977903;
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] vsock: validate packet sources after bound lookup fallback
Date: Mon, 24 Aug 2026 02:58:56 +0900
Message-ID: <20260823175858.351431-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both virtio and VMCI look up connected sockets by the full tuple before
falling back to a destination-only bound lookup. The fallback can select a
non-listening socket without validating the packet source.

V2 covered only the virtio path. Following Stefano's review, this series
moves the source and transport validation into a documented AF_VSOCK helper
and uses it for both virtio and VMCI. The VMCI patch checks both its
bottom-half and deferred workqueue receive paths.

The combined series was tested on x86_64 KASAN kernels. The original
cross-UID virtio injection remained blocked in three boots, CID_LOCAL and
CID_HOST loopback aliases passed, selected VSOCK selftests passed, and VMCI
accepted a matched RST while rejecting a mismatched-context RST in three
boots. All changed objects built without warnings under allmodconfig and
allyesconfig with W=1.

The current-tree guest-CID vhost probe could not be rerun because the test
user lacks access to /dev/vhost-vsock.

Changes in v3:
- Move transport and source validation into vsock_check_source().
- Trust the internally generated source CID for the local transport.
- Add VMCI validation in the bottom-half and workqueue receive paths.
- Send the related virtio and VMCI fixes in one series.
- Do not carry Bobby's v2 Reviewed-by because the helper and loopback logic
  changed; renewed review is requested.

v2: https://lore.kernel.org/netdev/20260820001517.2148196-1-4ncienth@gmail.com/
v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/

Daehyeon Ko (2):
  vsock/virtio: validate packet source for connected sockets
  vsock/vmci: validate packet source for connected sockets

 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 net/vmw_vsock/vmci_transport.c          | 29 +++++++++++++++++-----
 4 files changed, 60 insertions(+), 7 deletions(-)


base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.54.0
