Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894A8C02
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z4TBpj9f"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cd88c84949so385944a12.1
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703042291; x=1703647091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=z4TBpj9fzNkLIF0MtpRK0jaqq0IEqFIgjPNPhszlRJBDX9aV5lsarzC1v107ALarzd
         qcJ8zvb1HLXlfHEJMR6Dibt8jp1Bufil9Arc6VVp+S3RiQZdHPggK5QRxt6dS8YVuHNN
         nLKu0OCVn73BmYeOMUG9I2X9+gE+9+3BwfcdTGBm7m1yd02B9+hGJxGhZ1J2UgLl3Reg
         YWvBqaDlh52vYNEoEarkxDmyGG4/ZMxrqTgByLGYcqzi+Yn55oxZ/eiv+juzUdtgMW6M
         BPpCxr2EzdXAzzQnhiCtQDA9bjM7XyfxUjdy/sv3LNJ48E8SHjca0rhvGJXWi7bwSbu0
         SPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042291; x=1703647091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=iHc2nsRMRzYkoMj0yhJnkgh6bHYFzcxSAiC36YKNBPhmnldtdF+Gw1sIhcX7Wni5qE
         fLYuJ7fTveSLJREK+ZxotqcVc024XEF7YYCNBLqtm2K/7dU1oFqGYwLyoraTDjFARZ8X
         Q3virLSF6GzqXPTXoIqtbGriplAEc2yS9OS5rYTZhZ11VSEgKf6tGoIqM0SbI8YW780+
         uEUxSEZX3NZbAfNfIr5csQicXchOQhJ/z9Zje9Mc8sfwTNEh/EuPKzAe/q2vcIe4WyOW
         ksxmCxT+3/lVqw1dpdwuoZ7T9yX4YMoKYxEC/KARP1kckxIjcStVcMM6EZF5jZLfwqqD
         nggw==
X-Gm-Message-State: AOJu0YwjLkvuKpukJzfzoGd1o4r0gJ80/cjp4Ye9O4qNpLLR2etqp9Dt
	BHaCyQFmy33ZOKtCFoTSbDYQdg==
X-Google-Smtp-Source: AGHT+IGJy8KYnZyMHC+4fzSHET6hgmed+3GNH6+zA4QShlWQzZGtRyh4P66B+nvfNY4nmXMHOASd9w==
X-Received: by 2002:a05:6a20:3c8d:b0:18b:2020:8cd1 with SMTP id b13-20020a056a203c8d00b0018b20208cd1mr42952817pzj.3.1703042291622;
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78e46000000b006d088356541sm16958284pfr.104.2023.12.19.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, dm-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
Subject: Re: remove support for the host aware zoned model
Message-Id: <170304229020.683808.16849978519505449769.b4-ty@kernel.dk>
Date: Tue, 19 Dec 2023 20:18:10 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Sun, 17 Dec 2023 17:53:54 +0100, Christoph Hellwig wrote:
> hen zones were first added the SCSI and ATA specs, two different
> models were supported (in addition to the drive managed one that
> is invisible to the host):
> 
>  - host managed where non-conventional zones there is strict requirement
>    to write at the write pointer, or else an error is returned
>  - host aware where a write point is maintained if writes always happen
>    at it, otherwise it is left in an under-defined state and the
>    sequential write preferred zones behave like conventional zones
>    (probably very badly performing ones, though)
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: cleanup zoned device probing
      commit: 77360cadaae562f437b3e98dc3af748d8d75bdc2
[2/5] virtio_blk: remove the broken zone revalidation support
      commit: a971ed8002110f211899279cd7295756d263b771
[3/5] block: remove support for the host aware zone model
      commit: 7437bb73f087e5f216f9c6603f5149d354e315af
[4/5] block: simplify disk_set_zoned
      commit: d73e93b4dfab10c80688b061c30048df05585c7e
[5/5] sd: only call disk_clear_zoned when needed
      commit: 5cc99b89785c55430a5674b32ad0d9e57a8ec251

Best regards,
-- 
Jens Axboe



