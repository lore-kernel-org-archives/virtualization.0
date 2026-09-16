Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AE4E66A3
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567630; cv=none; b=ZsxittHk/qqpSxRDELfcKWIxWn5jRhx/QqO3yyO71sa0lE4vD/hpkR3dxM04VvYvNy/41pFLD24jOW+0S5gE7GgFkDwws220trPzL1+T4RJ4WEirAm8bwXy0FVDhDjKXvaMfcTSZCVY+FLvgfecK7Zdq/J0WGYkhBt9UmbmQFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567630; c=relaxed/simple;
	bh=Snbn5c5QxnFMnYmtk+1+uVBQ2tmnh0qgUgwDmcynQCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oD7uy2hflwR0xSdeqqUugApp0T1kyLRA1PUGx/MpeHRSNq528YlpSGq4WvyTqbYBBYs7MRUwBskabmX8Kq7a4Q144S7W2dSq+ekCGeUctVC3Vb5nE7/SoI4AQ6Kr4AYufMLSmG7RM1Ii+RDxpWDD4URcyQ2A0af81+jw2fjMyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqbRcAyj; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqbRcAyj"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e635a6002so63181685e9.0
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789567627; x=1790172427; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Snbn5c5QxnFMnYmtk+1+uVBQ2tmnh0qgUgwDmcynQCk=;
        b=MqbRcAyjn+SFV9vY1FtRad5ABOK4J59g8AZTuaC5SRk5TEzFldCAp4razSjO3Wb4TQ
         3OaR2+KnM1UlzXjVeg1HFGqiqCtTpkh2H2V1JDJzrWJaXx72QkvJ6VSw0bKY7mRUmTCe
         1zgFrSHRUzL4Jp+8ipO10tL3cZXhQTDaSkqkRdzwX0l9QRUEfaQ3y25XGr6W2nb3oN9T
         zIVDlT6RQLvsfyuhqEKYBuNT0pjaMNk060Z0+FkK0+mNFgNewCUJXbly802sf2Avfj9O
         IzozGUSThdcDxddMX6J37fp/9C7dsEo8IP5zFhrPBjlF23Bl+9mmcRRolXCwVquQ3cK6
         VF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567627; x=1790172427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Snbn5c5QxnFMnYmtk+1+uVBQ2tmnh0qgUgwDmcynQCk=;
        b=qjqaPH4PhaBhuyWOnm1QJGgowKqemdT3FahhB9b88fmt0MwA0CDXN6ZHBDPZXXCNt2
         mcjKZmjgzQHEPmLf63OHEqkUiRuHa/spO/mXAmqjUzmbhHK1PpjZwWEgdZ8CB+0LgF0M
         uZoQigxTg/wF3/s+ljDj3BtZXYrN3fjsvOtR4Dx5r3KG+H0UWSi1AQBWsvghfJm2J292
         tXNgEFe2esg9hIYY4BkeIomiO/188pfTUhVrSfuzQKR+zc/IrZWEidvmDLpgAreWBaBS
         clCjDJiS4shXFCicMFnLvZqngMO8bX6y2jG2gbM4DUE5HKSbpcrXJr/xDAL8ROAyoD6n
         Y5ig==
X-Gm-Message-State: AFuF++nSQsyhhgII7OrVXAeeS/i9KvivRgTCYKZlI419HARidGzuTXmP
	oiU6yhhmPkLwaLQnWvyZ1Xt0sktP9M5KoFqB3jFNsrY+qRh3w+BvAl76mNJvmnCczG4mEQoT2ZG
	7ztvDEtUDUxgZIzbuS0s65RVwYtCLF7ywxg==
X-Received: from wmbju17.prod.google.com ([2002:a05:600c:56d1:b0:49f:5465:6f37])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6097:b0:49e:6e94:7cae with SMTP id 5b1f17b1804b1-49eb734096dmr28885925e9.28.1789567627026;
 Wed, 16 Sep 2026 07:07:07 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:07:04 +0200
In-Reply-To: <20260817134202.160669-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260817134202.160669-1-sergiiushakov@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916140704.2839472-1-sergiiushakov@google.com>
Subject: Re: [PATCH v2] virtio-blk: clamp max_segments when indirect
 descriptors are disabled
From: Sergii Ushakov <sergiiushakov@google.com>
To: mst@redhat.com, axboe@kernel.dk
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, hch@infradead.org, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	pbonzini@redhat.com, Sergii Ushakov <sergiiushakov@google.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

Hi Michael, Jens,

Gentle ping on this v2 patch. It has Reviewed-by tags from Stefan and
Christoph:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

Could this be picked up for the next cycle?

Thanks,
Sergii
