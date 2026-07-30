Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D476368D40
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379945; cv=pass; b=imQZRi6fB3R4IW1WxWUlXzsk/vGOZd8Klhnk/gHsIeRFRE06SVf0SPFPkCAqT4pR1/eZ0GYAcPxvcQHIiO+4lScP4Bhz4F6h+Ta0MvaFglx7KgtRuo69KypX4M16mwNbP8y70VQdgRnPphV5KlJwBIJFWBPWUlFzYZT/pgTFGgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379945; c=relaxed/simple;
	bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkHpgB+0SCUsIyOKv16TIefqTx0oRfr/kINUiUgOg5EzUyF+bBf8OdgDoFYoiC+Un/gheJFfXHgxSlZ+HLhtqXv2qqKJjWsAURlJf1TfMBn3vBZrJpWQLaX1Qf+J055NJCUUkk1SSExi912Daai+nYpo0aKXRcKbr8EhTOwoosE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPvgYpeD; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPvgYpeD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c01c79467so155771cf.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785379943; cv=none;
        d=google.com; s=arc-20260327;
        b=T5NHnJlX7W+o06+ym3fNs4IQ+xYoYNexUO7k3onia74yF1KqQn5R/Zvf+1KRf/hL5u
         2a/gqHEl4QaFK8EZbR/qvMQZUtX1lkn2z90qKmNELqVNnIkgywkPyUZR0CKTJ8E6cqhQ
         lovhCm1ZCStShQhTTUl2gqtcWA70EoSfnV8ZICM7K2/qGkjK7vb66kiwE0X0CIIPynFw
         MkQtFuD+0NnVNAP6/EIKqp0iLrZinkp4Z+gl0yRKemKa3NaPGGad96VZqxWCQm1RtER3
         TOQTLfIJot4MaMN6NtYCybSVLewA/fs4Zio7K3ItFBK8J7WRCsybpGHpg1QuDcY2C4uk
         2z8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        fh=ySYjV98uMrgl7FWO3xj8/RHhKda0pxNSTfkPSR90+/M=;
        b=FgyqcDHmSzNrVLQyEoaWUIg5ztLU311T9L38RHoSxtRoIV0PGPEiMmnQj5zmq6uZe7
         5PgB6sA9LAXGtRdYgwEW08d5euzciEk3G1OtZ00gEzBaOnot6zy2cgBqecW4D50kK0m+
         IxmB0ISU9oWK3TtpWoUiRKRelD5pPqzq3BPhemtPbEtSTxSF4/NnHz9kQK1soNEOroOp
         ShtiZ6zqPulN/OZ1JHjNYI+Yj5waRoJTu+WvcnKfwI17qK15F6PNuResU0ospgnp1DbS
         ke3hefEfYkJTot/irtmIEIfO9T/i/hdIKn7vG0I5V65gZ6XNV8GasQn00dV8Yyegc6Fz
         8q8A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785379943; x=1785984743; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        b=jPvgYpeDpja3WpLeDH+cJPZ9ChXQZ1VyJqMvXDBwWZk6SC4LFdAycRed1tzZr5/2r1
         bXXw49hPK1IEwFxomRrNJubP3azbMNxeOrTjc6cM+Yb8jhIE4dzNRvATlqg0JkF0E3oH
         oSWlilqy65fgCLk2iP7qEEWThPIYu5R0xhWcswYE1yhACwvrhzFmqpOqohC9UL6/yVBt
         aKs8sY2CsbZpfp1tsmEEq1FksIHNGOXK0ewUpdtUkm+IINASEoCxgRZpJGK6p0T5WuAk
         4nE/RzNhCX96PywdzFB1bXLG+zCq7tXvZqWfmJzOi/1bY2Lkuj38UK0JARmghzpYMlru
         GoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379943; x=1785984743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KxmpVJvWjMZMyt/jgVtLy2EX2JvxTMqxDINieHaDSfc=;
        b=UncYNnmxOu0lXOV+OyBwVd3Zbt3B1Pzs9SswHkw0lUhCNlYYmD2FMMah4lXvsALGXK
         qe8nMiFIVTDMcREMXaKbcokGzQeUxYPQGVd9J1sucP/faVLTAMRuZv+PuahOwZ4MKuqE
         Pl2wA71GFVWD4aJKjg43X30SFWj7j408SkPwmNNArW54bQHVwUw3wRBsOhP4v7D/5r50
         1SBEGtfqAJ4lgOnrbljIYFqq7NE3Zt8ZT2v0lv45tvdW+N/jTYTzYJds0QhXlbfVvHLd
         1vaaR0GvlyaP3DGKISbLp/zx+nq34UdlMBUSLKqjyIODFOO+UKenxN1qDAYAx1/ZKqdP
         UO1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqMFQB978vMDxeqAbiCnNxw0rvmUhYXI8KCmSO7ITMF4mYichwQ1CVNrM/4HfgK4EY0QVP8PVL8szqpL3gt9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUYN6ImcZVc1bBXP0E7Na6n6uGLDUBbOncckYh/U+wqIpGcG0p
	PGd6KS+ATVz7nuNykwlNxziiOmMaK1tvsfIxkaMU4ORbOVXRef3+g1lY5emfZ16udLX097lPMBB
	eZEjuHOnE0FdY70wpxMK4yCbBBLXVDyu/0cPsEAhDcOH5TjVgJ6ZAxNdEh0GoOQ==
X-Gm-Gg: AR+sD13YRobUVTJHFqAE/L5vcVWbuZyZim+1kYf2hLxfCtcaOuSpsTGHGO1XSPKPFvc
	jcFozRSf0LiKOjYtX89S8JsBtBV5MrX4vXasxC2v18ip907V9wj636RjNgDpL3hdiiQLWz0HaMN
	+2gY07TXLYzU/YUV2KcZXtivhpV1lRsUfj3m/4YUfrtD20L5MKnbNQw8mhCawUviIXWFqeu/bPJ
	v4r002sG3PUZWJsGEcaVWCPuTdJzfFRQOeQYpJv8yOjNAo42IarPfC1QyR5wS9EeBdcPZzAPe+C
	H1w59lKfgCXRoZvv95+GwVJAI+lSOeOWqYABoEepeVAVjyxsXCgkl+GN5/W75T7/SUVmg+GRs+E
	=
X-Received: by 2002:a05:622a:aa8c:10b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52b393ed56dmr4235251cf.3.1785379942843; Wed, 29 Jul 2026
 19:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com>
In-Reply-To: <20260724014605.3377283-1-linkl@google.com>
From: Link Lin <linkl@google.com>
Date: Wed, 29 Jul 2026 19:52:11 -0700
X-Gm-Features: AUfX_mxpFzT0hpVdDxPUqKHkGPgYahhbPQV0xHfM6lq50s8el3BKANlDBJ9mwYI
Message-ID: <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Friendly ping on this RFC.

We'd love your feedback on whether using a new feature bit
(VIRTIO_BALLOON_F_REPORTING_PM_SAFE) to negotiate PM suspend safety is
acceptable, or if you have concerns about protocol-level handshakes for
kernel PM fix states.

If you prefer an alternative approach for safe fleet deployment, please let
us know. Thank you!

Sincerely,
Link
