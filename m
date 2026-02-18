Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE9346A15
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438276; cv=none; b=EYTzMJXJx25CP7+gazing7u4Qazo5L9sdYH8efSotSn6nrQTPeEAKr00rBlYNyDL+mm/tWZVwHBUfUyQC2xOtHuYzSUTB40PnVVV5efzXJCRs3fr1t/g505FbTcoVph2bWz78MPuegFQ40svjgOyL9hXJ4m+uwTgE6XGtUXy3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438276; c=relaxed/simple;
	bh=uGK41uj6PP/iNYJl90nhzFCAJOq4jOu74IyB8IEiN9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHNDApRDEvI6Azf7duVxkjyTMgqDnxx4Xt7Ye0APMs6PJwBkE/i6IjDs5B8cQjdAgxkfk8gTHan3F5SG+Q8RpTDKh0WUG75DfQXtoRDcP2ElUJBSk4//YvIOJzRuty8S6VmGuQVOImdhYB3SyaYLbV2iiEdl14UcRIYyanhkzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxBHomcY; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxBHomcY"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-797d3864d89so1593337b3.1
        for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771438273; x=1772043073; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1wgGIa8//Y21Q1yl9IMhAVoEJrPKjw/0p7B3ammqNo=;
        b=YxBHomcYPj5v3prZvCKdAg5omhAaKtkXNXtMY1uyfAWLFLL5CXWGxd2JHrJ0guXwRy
         68smZEnXi/X4Z9BaCKap5PbAamTmG4D6zQS6eL6aF8b58/dn9qc3mbupOfFkTkQttFTL
         rvnO/+jrDJp2nX6i5dcrMzzqUK13nT8bGV+w+QyXTtak9Xxo0w0qPq44lJZURSxDaRDJ
         yGTvYVH7CZPG6g3WPd8tlUUPeoD10JR3a3tQcxdtTB7CtO5wJAuwoI40lEMzbMPIf9dL
         mQLtGxcj30tdydjDz212L5i6XNtf5dNhrtxZvj+9q/TDlWotFvUF0sPhmwIFYPRB+sSQ
         8+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438273; x=1772043073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1wgGIa8//Y21Q1yl9IMhAVoEJrPKjw/0p7B3ammqNo=;
        b=X7HumuHuzSmxExSP5dxuhu9NZetgQDeIeAW8IFY83UE4KU7QuhtR1E2Q2x60QbbEUf
         jxP2+4V2BEY4+ie7TT9wQy6K0eg7+XKYDB0kFsXI5aWFKXM7AtxS4yjCxLM+UNZWiDLK
         +tRs5ZOnUgeeg+T2bI2faWLv6uW4s2BsCRpf95dnWqQsmLu/cvEphMPxlMxl178cMLrI
         mbJgiA2kx3O8oSILthR4MkSaKve2BK8Ud1cWYv4KH6gEQXyM7q2P4/LUKOPf99CJpFvm
         FOAG08z54+0r07QZF+TEMJirAkkQpxkrVJ1Nbo0tpOLMY3JMbFNrXC8J99WBME8R6bXG
         zhdg==
X-Gm-Message-State: AOJu0Yze+HtUbGnkovn6HnM0vilHf3D+Ae18pEz+lfZKPw4Bh/XGxM3U
	z3oflVvhWe/IgiiJaFQd/2u23DmG9yZzj2HlSAU5rzSgpZeEs2hmrsxI
X-Gm-Gg: AZuq6aIGQdm1NhfJY7pcqhZXIKCAgFBVd9J16HNEMVDfpk5x+p7mLVKnrgyHQVqEl3M
	rimpcaH1pH0A6BaZxDkRq9daUm0FRTY34aloApcdfnzOxFSSYiLKBPKm+y/2gp96wnGM9p90kLy
	oAgyiHiWNW4fB/PYzPZ+1BUzUPRY2/vzVh2Tf3t4fHmKtRMMYmW/eeiEJ9BZtODqvzi+KQlEY3Z
	2EpCTd1YYzq72NJr/LOAzIAYKm4bY1CxHbY6cQ+VFO5qmkORLnbOMSqD6vMF0FR+w9AQz5TdUMP
	AoM1GQjI6jUs2kwfUns5KmAWp8uDh9aoVAq87dHf/quGARP8LJ0Zy/0AO3OWDiYlDe/0sWbDUSP
	gRYWFMJ3G9QQA02SIpNgoqxlHJH0gQy9BMQuRaxQgKTQVpiUU950rRgXr4yO27/ftRbxAYR2qKL
	JVnvWQexdP8DL1RZuCMxEQhA==
X-Received: by 2002:a05:690c:dc6:b0:798:3a6:3f4 with SMTP id 00721157ae682-79803a60431mr1995927b3.43.1771438273356;
        Wed, 18 Feb 2026 10:11:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm124246567b3.45.2026.02.18.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 18 Feb 2026 10:10:38 -0800
Subject: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
In-Reply-To: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update the vsock child_ns_mode documentation to include the new the
write-once semantics of setting child_ns_mode. The semantics are
implemented in a different patch in this series.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index c10530624f1e..976a176fb451 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -581,9 +581,9 @@ The init_net mode is always ``global``.
 child_ns_mode
 -------------
 
-Controls what mode newly created child namespaces will inherit. At namespace
-creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
-initial value matches the namespace's own ``ns_mode``.
+Write-once. Controls what mode newly created child namespaces will inherit. At
+namespace creation, ``ns_mode`` is inherited from the parent's
+``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
 
 Values:
 
@@ -594,6 +594,10 @@ Values:
 	  their sockets will only be able to connect within their own
 	  namespace.
 
+``child_ns_mode`` can only be written once per namespace. Writing the same
+value that is already set succeeds. Writing a different value after the first
+write returns ``-EBUSY``.
+
 Changing ``child_ns_mode`` only affects namespaces created after the change;
 it does not modify the current namespace or any existing children.
 

-- 
2.47.3

