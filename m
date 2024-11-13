Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C66201113
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523611; cv=none; b=tOh65taLwdi3tJX+WY4B2kBYDEZy2+OmiVFB3WeHiNaqUyuQ2Bb8gXd8190miFhQAvoUEHBw19Oi0dVZ2pKKWiURsNoOHFzdOfmcGMvYuj5LvOWyBQmlwoDN3MMOOaBNKzofXlDxQS4nyRw9vVKst33lrPDiNo9dlSz51rQENxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523611; c=relaxed/simple;
	bh=8RXFfY/QwFw1iJc0lFBsu6djRAxjqHBrxSI6loa3ifo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oiak47veaAyjdelMvxAvYVXeA9sJIeMBgiH+IaGxsqbQXwJVB0P948AQg1SjDopRFzhlRIfojE7iJCy/cO3zenuMt3W8UWN/tdKIcPYcWlokAM0zbfcX5GrWg2sUUuWjj7z0V0bwCKrLmIs2OVP9c0AXiNTWqaliqhyNIr7GYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nqyuB2g7; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nqyuB2g7"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e60f6ea262so3346904b6e.1
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 10:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523609; x=1732128409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6j4wyvW+qjOuARZZJwh1G4pDZjq38FdBGsdmUpGeUg=;
        b=nqyuB2g72OMaKofBGKp8bgK/VePGqyxGAQf4QWJjGIfEBxnwKAPu72JurRZyoDn+7P
         bdGXHcKzvdNCaOn0hhy/S5ihnwc0yb/P9+pmzk3xc3nHIOYrPC2qA7VA+nr2/7Z5nRE4
         nKkE+DzAqjj4U9CJO4Neqp0pO70HMt6y9v4O30Kd9jlxfa8ym+cHa2gU5O3uaOVTIBiV
         9xAJX79dMfi3S1C0EXBeTfkqp75Ai34FmUCuIRPfZfbB9TOQqaACIBctIrHpojai3ypo
         lK0q6Or3TVBifniPQXecoqpshVbGJmS9XvfG4VgCr2b5Mkg+4l8A9L3reoemg3vGmR4x
         obVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523609; x=1732128409;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6j4wyvW+qjOuARZZJwh1G4pDZjq38FdBGsdmUpGeUg=;
        b=TdGl3KxFC3RNg48oUV2bYaFQesOCvdnConE4iwYxyNle6cIocT8utOHVPNHN7eoTto
         lVQOu7l3rMpT1JvajbsNkng5IfBukYSDhQomhPOoVoRA2RGgyqGNHm73zp1hYxW0Mf4J
         qyzEwpu+2D5SWffh2gvIBbBvDHFRdsF8W6EQzybYOAFSTgjKE5XKcrCMR/5rs0g2Wwde
         6A46Tbjln8AEQK/4xYflLbXyVtE0MAqea3idKmraINaXg1jg9Y0SrQ6ZOl6k4lMKNyod
         t4Z/b01Qpmdz+2qBFTrMlEgqTCAp3/4RIIDViVmE74sdf86HA/SNg2FtMgZvxjUsUrWS
         r3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+bnrt6glwC+MnAhhJpmPfwq88fwHwj7ZtZtTNenYV5Y4s0zDfXEjM6RpnUQ2PiuGP7vMdVjhmorCl0rLsNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOi4rwzzGzbOQnbReWSTebm0mYp8zw8HSJ3COh9q0iBlKuK8SZ
	gNIMZOhxpWyiGkGFUNOuVPJ+4tm4va9lhxOaWv/yQqG25CNAQxQ4EAisMgUMSAE=
X-Google-Smtp-Source: AGHT+IGhW5wNVuxAhg949qECoPGMVp0GIeUGc7cEDZZJFiXO83xP2SEoIWQJzy2xwUop4HsywD6gWw==
X-Received: by 2002:a05:6871:811:b0:277:d7f1:db53 with SMTP id 586e51a60fabf-29560110330mr19601816fac.17.1731523608778;
        Wed, 13 Nov 2024 10:46:48 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e92afbcbsm1023381fac.40.2024.11.13.10.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
 io-uring@vger.kernel.org
In-Reply-To: <20241113152050.157179-1-hch@lst.de>
References: <20241113152050.157179-1-hch@lst.de>
Subject: Re: don't reorder requests passed to ->queue_rqs
Message-Id: <173152360771.2243093.6096591698137056565.b4-ty@kernel.dk>
Date: Wed, 13 Nov 2024 11:46:47 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 13 Nov 2024 16:20:40 +0100, Christoph Hellwig wrote:
> currently blk-mq reorders requests when adding them to the plug because
> the request list can't do efficient tail appends.  When the plug is
> directly issued using ->queue_rqs that means reordered requests are
> passed to the driver, which can lead to very bad I/O patterns when
> not corrected, especially on rotational devices (e.g. NVMe HDD) or
> when using zone append.
> 
> [...]

Applied, thanks!

[1/6] nvme-pci: reverse request order in nvme_queue_rqs
      commit: beadf0088501d9dcf2454b05d90d5d31ea3ba55f
[2/6] virtio_blk: reverse request order in virtio_queue_rqs
      commit: a982a5637e91fd4491da4bb8eb79cde3fed2300e
[3/6] block: remove rq_list_move
      commit: dd53d238d4ca7ff1a0e10eb0205e842560f1394d
[4/6] block: add a rq_list type
      commit: dc56e2a78ba20c472c419c6f2ed8fb7d0c95ad90
[5/6] block: don't reorder requests in blk_add_rq_to_plug
      commit: 05634083a304eb3d4b5733fe8d6e2fd0c1041ca8
[6/6] block: don't reorder requests in blk_mq_add_to_batch
      commit: 65550dea43815d01f45d7ece38e458855d5e2962

Best regards,
-- 
Jens Axboe



