Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD737A49D
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886335; cv=none; b=TjaSts8dwQgiS9RM5T6xC1FU4W0z+E1UFhuEzk5t1+LuVCUa5495AGqKpnIcNkY9bmSGUHR9X/Qb4czcfZQiOlFd3XgQNTTbZaTEJ07cWxszMTYboQIuLuQ4TjKdbCJHEhckvRfy8nJsjZG7dCHUznJAe7wRcAtaHUDbi00bwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886335; c=relaxed/simple;
	bh=/bIC/WtvmzO2UMatiyKUHoqyh6+HwZ1czcMSAuZhOrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k4xfAJ/x4zWb9C5NWLLYtixQVhIl11lMeWdQ+uBx9vsI8XC2AMrtlTeemLaF/6HacdbxuoZhGMbq5aLPRDd+HFJiKcSdKoRDewJVVQtmACxMF/ePQc4rFdy3ynYfRvQ7DXJMBEj570Z8tHHDU8WQZ0WojWmqGcq0IfYCCMI7j3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK2JOwzE; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK2JOwzE"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9707fc11so687140d50.2
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886333; x=1772491133; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9UtgbHB88uVfe270ruZfCUS90+GzEIoaTA2r5lSx94=;
        b=gK2JOwzEay3aD1PNEeFpu1TqByRqndO8b7eomusw043Yc4khMzRhKgYRccMgmsj8vb
         lMbz2R86/ucgW4a1bXIUYdPuOqezk8/D4bGHxJ37h3GRkQjqCkwv73VMEdBRoAWkO6Rg
         1fI+QZyA2AURekpAsj6g74s5v9aHTkpJBazy16XJOZKEpcAALLclKvfRabEEiWy92Zqz
         AcuBP2dEfZpfRENEH8kSy1wiyDMr10qiEUP25aACwvPjSzbEC2Cpn/8zD6XPfOKexyDc
         gmjfEhqC+RAZTfJkHxEw2A+oeMqI3R/oBGlXEgS8tXufdpuCcoZlSk/ZoDrPyx3nUyoI
         izUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886333; x=1772491133;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9UtgbHB88uVfe270ruZfCUS90+GzEIoaTA2r5lSx94=;
        b=gXXMAr46EYSlK5DG5x2qcLAoFrBA/+IJucK0d1SR2yD5Czo05IYxfxb9ibtC4KxqJu
         SImwUEXSYqndGvdWl1efyQyrX57WnF03jiiTMmarFbjTSbRd3dRMUB9g6nIpxrLNjwRh
         pQAoQ3j3omkF7O2wf9DF/asjCzrZZFeFlgXDBD8qKW/ilYgIzdGuXbYFq8K4HxHVTi4R
         dXJwhIped8MkGY4FT7qPARagG+e9gJdM4J+Sj26WZbupDBLB6UEM31P3sm4Z1NPAB+QC
         8evPtsHRM0zm1rfqKjOMZLsYa+W0tKQY0gSubU4tr4n6kOtlgvk3Q/SatfSyhbiCOUiK
         hwMA==
X-Gm-Message-State: AOJu0Yw5sgjkXeCJgpYmD4fwaQPOxo+VKq4XsKziEIOB3Z7wSHooq1tU
	Zi3OB6ku7B6nS1Q+bDjhP7e9XwrKe2KzhrPRsrtPp8RKC9dUpQHLEx4q
X-Gm-Gg: ATEYQzy+2Z6BKBp59No63gPkR91XaO/Bm6A3iCyFWrd1y+h9h8Hl9M/AygA9ZbfsM8B
	DDawbFOpQzUP+7ZjFHMzt/p4pIj/ZWF0AVXE3CSRRhcOSX0Ol+A0ysKNj9d/KueB9Bgg13OovzI
	J7expdK0IBtYFvs5jYyn72oBtbCNSi4NGblKAjYO4rZZMw0DY5yB7P19QkbXigZYTMO21yHIEt8
	3g0Q0Ggdkacw+eUAmKx+fygu786Q4YcKo+QTdnhrURSpNoz4rm+lCLM9Xu4UMvDi2mGs/ZlOO16
	K9Y8tC4819Sp+4zvKItRIFij9Og+ILqDH3Pw8fYwEj4f+evkAznr/S37Qe0qZzS8XZXoL3VIPCB
	rqRTCimWOLQB4xPeaqjbBBbrtlUnPjcwtuutQFcjLg5HsKh4FeUzWMxN7uoh9Mxu5gEoPMWHsHj
	4UwLuIEaX5g4kRqxBqXG5jrg==
X-Received: by 2002:a05:690e:408:b0:64a:db34:8509 with SMTP id 956f58d0204a3-64c78f6f039mr6063230d50.66.1771886332926;
        Mon, 23 Feb 2026 14:38:52 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a39bdecsm3726462d50.22.2026.02.23.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v3 0/3] vsock: add write-once semantics to
 child_ns_mode
Date: Mon, 23 Feb 2026 14:38:31 -0800
Message-Id: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjWnGkC/33NTQ7CIBBA4auQWXcM0B+hK+9hXCCdWmIEAwQ1T
 e9uwqoL4/ol31shUXSUYGQrRCouueBhZG3DwC7G3wjdBCMDyeXApThiScHe0Sd8RZcJg7eESrX
 dNKiOuJHQMHhGmt27qmfwlOHSMFhcyiF+6qmImv6iRaBAI+Zry2eptNGnB2VzsOFRuSL3hPpNS
 OQoNHW251PPtdkR27Z9AQT30fz9AAAA
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
 kuniyu@google.com, ncardwell@google.com, 
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
Changes in v3:
- Simplify code be reverting approach of using only a single variable to
  represent both lock state and child_ns_mode state. Instead, use
  child_ns_mode and child_ns_mode_locked.
- Update documentation to clarify the value-dependent behavior of
  child_ns_mode writes (that is, same value is ok, different value gets
  -EBUSY).
- fixed some line length > 80 checkpatch issues in vmtest.sh
- Link to v2: https://lore.kernel.org/r/20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com

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

 Documentation/admin-guide/sysctl/net.rst |  3 +++
 include/net/af_vsock.h                   | 13 ++++++++--
 include/net/netns/vsock.h                |  3 +++
 net/vmw_vsock/af_vsock.c                 | 15 ++++++++----
 tools/testing/selftests/vsock/vmtest.sh  | 41 ++++++++++++++++----------------
 5 files changed, 48 insertions(+), 27 deletions(-)
---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260217-vsock-ns-write-once-8834d684e0a2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

