Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49773EC69A
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078288; cv=none; b=ib7tu21TIte10vFzXS+dclvKn5HjXhB20qHIr/3hQAMgGobpLF7v9c/tL6QrR6G4cIhfcyzeETVmhfrE34FWrtHz9RrJMFABvBYm56WqjYkRz7M2kqXwMC5c4KVb64kw/g8CKkp1Qb9il7eA1CFKmrh0EmxxpjOIzLDo8xtukqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078288; c=relaxed/simple;
	bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGdA68zfuC6k+Vt9DrOB0nT+FhfeGFawU9HYfZDHo/a+X+U+88yWsEgEl1XM7DihfENw9+USE/++3xs4MThSStWHNXigOeyLLbm9J6Dj4RWueGW8NDVisM2KVr4hzuNw5DayNiHJqDuZFMxtljuKX3JCTvG6SyKoTDZyumXG8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBr0Ypwn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBr0Ypwn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so384643a91.0
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787078286; x=1787683086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
        b=qBr0YpwnANEUI5aOwe9hK5sAQ0+0IB/P9pZlOPnZ2R2BhI4jy9OPTRicI8GgxaPSNB
         j66I6lG9iGeuMhoHzubp+Cmcb4P9Codxd50Uzxx/yBWHuF9c8cmH/AydmhcgCUQrQsYx
         AmwM+QsrSCxDjQvPGAhzzHoCpnd59kuQZFitaEWmkj7pQk1gkGaHn3fWQiw9d9MUS6MT
         727eToYF8bdUz0I1JOpdvd4CyjTConxYoRX69K/oZ6gc1hOBXQcDLv9BRzoubi6+fuMG
         mNveiVFdCuZXkcQUSHz1MN9FPDVDdRJERIlTdk+73qwVb/ZAkN1amLbCoaub4VC0dfa0
         nVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078286; x=1787683086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
        b=ViF9rB5BgM0glu691zW7VXhrWfwzhARb44iH7xncYf9HrQNwGPswQWNQsO/2euzMFL
         XlI+etaf+TMRdbFQaReLUlJOb+t/aO9W87EcSOAZX40XNWCm3Ep+2P4a/GlkCSJGwdyu
         EgfUexl2a4ixhHPfVf1oVXTGZoHahT2Ap1Pu/ILPz3J790JAGUx+wK7WljwZ1MOAeV55
         DHQLXan6996jIM3GrUUUJfGheSXaayxJ4j3J+0hOtDXLVklExqxJRP8p90u1w2TDL3Iv
         6zGNbnv1j7OrWpZ35ITQVtjfpFx9xyI3NwG156CCEgaX0+sugGgFswYMmrkniF6JgbAd
         0Sbg==
X-Forwarded-Encrypted: i=1; AHgh+RrnO51blTdy3qF211kwal0IBFonquVaTwDumhmX+RCcVJIheZnw0+N0DdwtQtbglTlGmDvqYEpk+3azSKGn5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw71EBBSdmWbOgRlw9eTv7vEfy2Jtz01ExDY+VmaMNjDmAyKhBg
	JFaTDSZb5VRmSrOM/8v1m6E1m/y+WWPOxCP0uSvFLKcZg2s/rmmhAtpg
X-Gm-Gg: AR+sD10+FWZxs2sgxP3zWPblaWsL/tcZbMG+CjJpjxF6BjHo5UfmeoQLLREKrxnAEGC
	uKsfbI4hBi7UM8KJrVgqSXiZagC1wXqJAPt6KKJXVc5Y0PyWN64hxA7uIg3DZZU0M0UA/F50liP
	KxACPqf1RPgYyzS38fT3Ncye4Am7/ahMkU/x0fxXYUVpyX2ttmvfRCD2F8yjU+YoEaPIVmh7Hwm
	eOijYMzdjIwYL42kySlR8FZW2lyo9QJ1jWyDWflZuS2MOJaChAl3m2/S5Vd2JCGOiLWfACpM3fQ
	78OuI3PbUn7cm6GOZjR3EwwmCoxVW0itw5mFh9d29kfhrjcxCTsp+lO9GSTJo7xU8n7mUmJHfNU
	o5pnJLRqtT5UA9GiqlIczMtnV737nIP9c74O744Ra9VfkWljuWfyBeycuUMjTxeSrwKqRsXXTsC
	InrLkbylJYxl1WPhHrOnTxnC/ofo3a6dwDpVmQb39LdAwFzfPBoAl+L+NoYY7QPuMziTkZPvabn
	ayjXckl79w=
X-Received: by 2002:a17:90b:57c7:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3955a724c64mr14674987a91.7.1787078286069;
        Tue, 18 Aug 2026 11:38:06 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2de41dsm6684128a91.5.2026.08.18.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:38:05 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected sockets
Date: Wed, 19 Aug 2026 03:37:47 +0900
Message-ID: <20260818183747.3382905-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com> <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 10:56:38AM -0700, Bobby Eshleman wrote:
> Does this equality work for loopback, when the CID may be
> VMADDR_CID_LOCAL and/or VMADDR_CID_HOST on host or the guest CID in
> guest?

Not in all cases. I tested VMADDR_CID_HOST with no guest-to-host transport,
where it is routed over loopback but packets carry VMADDR_CID_LOCAL as their
source. The unpatched kernel transferred data in 3/3 runs, while v1 timed out
in 3/3 runs.

The v2 candidate requires the source port to match the socket's remote port
and accepts VMADDR_CID_LOCAL as the canonical source CID for loopback. It
preserved the CID_LOCAL, CID_HOST, and guest-CID loopback cases in my tests,
while the original cross-UID injection remained blocked. The selected VSOCK
selftests also passed with no KASAN report.

Stefano, to clarify the original description: the victim socket received the
exact 16 attacker-chosen bytes; the intended peer-side socket received none.
I will use your clearer description and keep the comment minimal in v2.

I also confirmed the analogous VMCI destination-only fallback. With two VMCI
contexts, an RST from a mismatched context reset another context's pending
connection in 3/3 runs. VMCI also has a notification fast path before the
workqueue handler, so I will address it separately with validation in both
paths. Hyper-V does not appear to share this packet lookup path.

I will post the virtio v2 as a separate thread.

Thanks,
Daehyeon
