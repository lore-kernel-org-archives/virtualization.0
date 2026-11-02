Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610143;
	b=PHieoAJSQpiHc94phBXksV6YqWRXnVWyN/d2TkE9GgUiieEM5qBG9/XcdB3oruGrEOJk
	 CZrCO7epRw7O1dEKF3PX+rEnPmi7mgr9oFjzYkgFwfCbHkXyACdZzf+3dnYlcQutayvNh
	 98AbZFyatHDXDM4JPzR0yT052zK9coBKwGAJu8RBS0b0tTBtklXINVw844Z0ImWhuJyyu
	 x2S//1Mnnefpa2lTOogmmq2/0xAc+iCLJIVwgKIndX72qEbSqhbNKV818SOk2g2V9iApl
	 UI76gAkBG7gkYF1BVEuCget2fDbT71gDiYi9UZ5jUPijVk3z+mDpdMNfd6GYvLpRW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
	b=aPFjOOiU6s6VRgTH6eNYsR2SQTIrXkPS37d6zff/CsBAdulcOIRhh2kW4e42mCfDBFs+
	 nOgk547ObOgpwWPJuQcJia/zI/Rt1/O4JLg+OhiSkQ5/NMpfTLhtY1JWcI+RjBDRh45dN
	 JB/ZRXFj+aRi/ecZTSkx4fkRM6T6dRQHE0vjLv+/ppT8sSbzq2hstGEiBCs5C6C+vLmri
	 ONN8PbGaoGtoNyUrdfpkZuob7ChytzOpFo9RyHUBlJ4CyCjjVVbycCBAYJFCacUGr6NVu
	 aWPxrXZRdWJ9HimpE66NOO9fbIqogsSjj3PjhzujOu86l+9dE5adY5D4tZCSpTL7UDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TVeLehq7;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB947606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 09:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB947606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TVeLehq7
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so1936420f8f.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 01:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793610141; x=1794214941; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
        b=TVeLehq7T+A8yrNw+lguAM8iBXVB1/cnSBcHCgHJOSa1Jsg2skphg16kqdc5ou886L
         f/rjilV48UQ5ryd22k9OeDYyJKiKQQpqImWLE6vQeQPGAwX9ey/KDAAJRcTFvg3jBUVP
         IyptyouW61lGeno6/OfaotADBswbbE6UUxU4HM7+IjV9gTGQa/mzQIp8KXGTYiY8SOgf
         MvGNP6KhPe3V0lQzGXU38u9W1NFDcxJqmQ2wviZ1mQVxTlF1pgIxJASclk+riYzAcn9r
         l66KHkGMOLRVNKBTRF3egUDVlF95+fupF22KMXt7EL7wCTApCEN5kLdVO0Bw2jAeRuVg
         C9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610141; x=1794214941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
        b=Wx0+07z4v+ZI3+HjE9lIBdFP5kHvXqhzNdIL1+5Gx+ZBSnP02xUlajFueeJQ8Yw4vf
         57nzt36zw3Fbg6KIAUe3AdkknSNpX3djdCe8Q8UNGIvNJIU9R0RY7v2lmr4BCg0kifYZ
         8osYLPTZQO452Dh4Rc2IZWABHBtFZes5BIz66/9K0AaxWJmNncXB6fBe5zegpKizRPBn
         NRy0e8T/GKivnT9i9hgiGEFeebSPa/SyImMLkGDFdatVOKYmT4CBKATyTdk1GwtD0o3u
         rrJ0eesVimKorfU6t1PZenCUVSF6MaUCj7d60TS9rBkNt2NoZs5x/eQoxqRwMidJX02p
         D4nA==
X-Gm-Message-State: APuU4Z+SczjslXNHl2JhSpMTx+qTf902K1aO9pqSW5KZfv0oBLwN8NKG
	/3VUdEZyPCWjo4fecsqBcFktaKqopjCcDimRDjK7hpzsup3aA+XmaWJkpzsHpTPO/6Q6bxafo9Q
	lDfM2z7sIdEV2Q5W/QsPQ83YWvYuotGz0pQ==
X-Received: from wrox17.prod.google.com ([2002:adf:f0d1:0:b0:48d:f214:2440])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e001:0:10b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e6e30722amr15896125f8f.13.1793610140239;
 Mon, 02 Nov 2026 01:02:20 -0800 (PST)
Date: Mon,  2 Nov 2026 10:02:17 +0100
In-Reply-To: <20260918135120.1261150-1-sergiiushakov@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260918083557-mutt-send-email-mst@kernel.org> <20260918135120.1261150-1-sergiiushakov@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102090217.3324999-1-sergiiushakov@google.com>
Subject: Re: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring size
From: Sergii Ushakov <sergiiushakov@google.com>
To: mst@redhat.com, axboe@kernel.dk, stefanha@redhat.com, hch@lst.de
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pbonzini@redhat.com, sergiiushakov@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Michael, Jens,

Gentle ping on v4 of this patch:
https://lore.kernel.org/virtualization/20260918135120.1261150-1-sergiiushakov@google.com/

All review comments from v3 have been addressed. Please let me know if
anything else is needed.

Thanks,
Sergii
