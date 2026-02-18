Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF03348463
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443437; cv=none; b=crOMrcAIG8jdbGkjcZ84RvgkkGWPC3UF9krftLefwh1akZVXrKTef2S55GD4EAueNecNpi6jEGvv1eeTo58GM+XYd7EIRCUeT9K5BZn6clcy3HkBzbgi7k5VNuXBUasaih34GqZiEkXRQAib2eCZH3RmpAZhWiOyFWm6tnZ2Txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443437; c=relaxed/simple;
	bh=vBUAyAbacjfaRDxMQvWcGcFT+qxiW9zxnAxYnB8luFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aDdmjrHcFBfh4oz1CR9+nyQ1dPjHtJls8MlBy9Mc1aUS0a9SrdsZph2soZbXlPKejTrGk3Qw/eWM4psaEZOl/Rg3R67P3HCuaQXmizP2ejaGepE6E/epLW/MWCMFisKnCfy1HTzR/F/f12oN7vgzJ01PZUExwzVFzoxqmQy5dsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1vUOWHf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1vUOWHf"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89577f866d6so2980366d6.0
        for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443435; x=1772048235; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=P1vUOWHfUabi1XDP9wgTdh4cO4pgbt8ThRz4IE22lOkejNQowO0xkTI0GmrbwGgb9X
         WbFXEwYNQxlvbf9npt8oIRmpVCQSiNuuGPD8E7wj9n0O+yVRAduaCOsFCaJ2WtfBTKhT
         GKNa2uj/Fl/3YCQZQMZmR1EcJKL5KthuEOzkA2l5HchB95qK7TgVb7mzrZIvhmzotrTw
         LmbEEG9SwnqmHyjpK047BACNUvcsnP+Z4D6uMHnyY8AUVUgCVMDNAmWDDw1vX0mXFxoV
         eWvarh+mv/Pjhv5/LWDslbKlnXEvs+ZFetJTN7nFIT6BJf9AHaugWohSCNckgOw9hGXw
         2oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443435; x=1772048235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD8Ttwe5Tegj8OFrv2Q7m/YBq2wmzpAVQJC0WJWjYy8=;
        b=XBB98RyEnB9jqizrob8JzM/mh+9wZnyAW3bz79HX0Qt2ipx87A6VdZjlklNHgKnQ1c
         HKh94eJsGRW7+BC3m42JPvLkLCSRHoZcr/w/2mYJfZLuQHH6fQ3RUlgjLh+Hr0UGoD7D
         lRMMAsYhmwYA0mChYH1lp/AFXerbXD0HpRIXk0fpMcGkkwEGjc3ZVbIuvsbDygmmwd9N
         VG/ji8bcyOQsbNWHppJZgsv3HXrTIN+I3cUPd4D3a1CZe1ehdFHThWRiNd3Rw54bHl5C
         gh8I6h3Z+m4pu/Awtzkl+v8t07FrhRXKwStHMnQo0pGW3A/SU1ahajDo1W5lS29EbW6I
         bdIw==
X-Gm-Message-State: AOJu0YyOT17pAa9ErLPa3fAWH+I3ZR4m8GrY4Aop2HBfNQRhJJCyoRno
	uFfl9E9wqSAL6by1UHOoK6xiggXow61EVqv+d7keoBSxMdr1WuH/uEHWYMsANg==
X-Gm-Gg: AZuq6aJWYBx2Mgmy2d+1+LUIkXv28yVd58CzQmdaJRyGPLrTOZsA/W4OigZQ9Iwl4Zy
	KMB5TPFnXpYTH1Zhi665l2FcIDe7l9gpB6jbtZ/PegABOlNzfFg/b/UFoyuKhNVph+65KefV8Lu
	WDxDLrikkjlsoCcG9w3tI2KbKZRE51iUHD33x6TqSJ0NTnTDeYqxx0CATW/CkfbZ7tDFHTudrGc
	X1WCOeDnTKiiU9vvyV1gVEmaqE2DlDddW8U9uD4E66x2qv7EGdqRHfgiPey92Kn6KaGWGaC3PQW
	IksKW/Ke3bzCU8jESohfolOme460BOjrlUS4TeSafOlhCBmimDMo8+JZ2vgTvlBwug26CK7ZZ9T
	AIXCVeQkV16JIXVYdC0E7gVNfdwMzM3BG3XQCGgbMbfTJxTH2gHj9/nkzs0CplUfrUHR/DbFI8K
	gNnh0qqSrqIMVl5YhZAT2s0g==
X-Received: by 2002:a53:b118:0:b0:63f:b605:b7f2 with SMTP id 956f58d0204a3-64c557eae43mr2160180d50.10.1771438271298;
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fb1d22sm6051799d50.17.2026.02.18.10.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v2 0/3] vsock: add write-once semantics to
 child_ns_mode
Date: Wed, 18 Feb 2026 10:10:35 -0800
Message-Id: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwAlmkC/33NQQqDMBBA0auEWTsliWKjq96juEjjWIdiIklIW
 8S7F3KArj+8f0CiyJRgFAdEKpw4eBiFbgS41fonIc8wCtBS91KrK5YU3At9wnfkTBi8IzSm7eb
 edCSthkbAHmnhT1Xv4CnD1AhYOeUQv/VUVE1/0aJQoVXLo5WLNoMdbhtle3Fhg+k8zx//dlzIu
 gAAAA==
X-Change-ID: 20260217-vsock-ns-write-once-8834d684e0a2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3

Two administrator processes may race when setting child_ns_mode: one
sets it to "local" and creates a namespace, but another changes it to
"global" in between. The first process ends up with a namespace in the
wrong mode. Make child_ns_mode write-once so that a namespace manager
can set it once, check the value, and be guaranteed it won't change
before creating its namespaces. Writing a different value after the
first write returns -EBUSY.

One patch for the implementation, one for docs, and one for tests.

---
Changes in v2:
- break docs, tests, and implementation into separate patches
- clarify commit message
- only use child_ns_mode, do not add additional child_ns_mode_locked
  variable
- add documentation to Documentation/
- Link to v1: https://lore.kernel.org/r/20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com

---
Bobby Eshleman (3):
      selftests/vsock: change tests to respect write-once child ns mode
      vsock: lock down child_ns_mode as write-once
      vsock: document write-once behavior of the child_ns_mode sysctl

 Documentation/admin-guide/sysctl/net.rst | 10 ++++++---
 include/net/af_vsock.h                   | 20 +++++++++++++++---
 include/net/netns/vsock.h                |  9 +++++++-
 net/vmw_vsock/af_vsock.c                 | 15 +++++++++-----
 tools/testing/selftests/vsock/vmtest.sh  | 35 +++++++++++++++-----------------
 5 files changed, 58 insertions(+), 31 deletions(-)
---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

