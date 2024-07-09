Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE15339D
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504899; cv=none; b=CwnroxxIXXF6Cm1oZpGYWlOMBUfYXkjfcjzU05QKOGMZnooMxlDwj17dF8TmsaL36nT+9todFm+aXl9Mfr9JAs6ROLeTznjt0ug3WiedNMSErWvc9/oJO3b/IPZnSuitO2Ntlu+UWlHCe1FDoh1cyXZqpvH+eDG7HKSyw1xGnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504899; c=relaxed/simple;
	bh=GQK4mfK2dj6xYDaGlegfb1xbIlfpMgRKRF3xHgPIecA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DxwW2RHm3JgmV1Y8A0ZfQAbK1qww/FFqWLI+JhPnaZaS3+MWCun4FNemTvaQt8+SPyFYAlJYiUmMP6dEbCjkBFE8DBgqr/ATtRagNVniGwEfvIqTXd/UAdJOudBG3GtmU7DxCU9cDhSlAIeevD7Hzeq5CD6+F7FxMcwZt0jvF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O4lpDMW3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O4lpDMW3"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee9d099009so2061691fa.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720504896; x=1721109696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpEXxs/a3JbKNp7z3TVbrm1r6OVOY9ogohJN0enSvrg=;
        b=O4lpDMW3jH8gLDbm/+qaD0S5I9Jts4hN5fqsRXMre4/0o4ImWaylKacYreyBdR/Jqz
         jP7HA2Tojln3vIaxOzMGeuBLcsLMLPx549rEMw5H2kmTlCnSQ6TwMlaVOwlGL8qKhKnr
         cLeQA4oTHV1u4lpGpSUM5nIuq4HsHxeItXRWmC7sSkUQrrp8NVa3PItAdTurXS2lVwr+
         r/YRHJthOnZCHjvfRDi8+oRYX+ThlkUSSD7SUUAdUKyIVYhfbNYOEnHPsJhIqQTyzQVX
         w7z4yOh51CMPaMw4M1gFXizQuXZ3EAe5OMJ5EKuzxnDEleWn97OZiNPpCxdBXRxtzkF/
         obbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720504896; x=1721109696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpEXxs/a3JbKNp7z3TVbrm1r6OVOY9ogohJN0enSvrg=;
        b=wXyLtPGMSo0h6pa2BNTPeiFkhlAIrjx91QPuuacSPNX6J9JgRV0Ir030iII9CRJIxr
         jFVKDkh9zxdZQzE/XRS4viX2ZJZMPQC9k8DdTwgddMrXWEznHtmQNmgc/pnJl6yF2Ec+
         0+lRVNkRAyLVq82WazwVauUb9jrsKrRYEdaRuaHwfjHKOyA131w7eJF++rd1msm5LOb4
         ukpx7pvvsgA8SgYMCKCZC+qhpIjkl86caClWZaZNeZC0CWhu8LMEFi6BfG6qWhMs03hF
         43eFW1etexkd9S0YslmcQy3DMWMY/VWQ24GA0VyPxRDJ/WmezUAZ4f2bSB3EBohyiajt
         VUxw==
X-Forwarded-Encrypted: i=1; AJvYcCXaeQMC3rPM8cnSaxCWZv0MHGQjeHgXV8jFkPRL5+aZ0fmDJuUSSXwBXQxqiOKr8qO18IoTMTxHm/PcE58VJxiDHigRROjUWbT5YONGJAI=
X-Gm-Message-State: AOJu0YwIoLxyV5AT/eFvNxBWDKWAEsNgPXjVAXP/KzLwlPIZCJtrXQTf
	pDfRAEMrp1F5ZV2PtluGjC22I5FeOC+Bt0aH4xt7L3qlNI/XUpF48tJmPe+ZO3U=
X-Google-Smtp-Source: AGHT+IHQnuwy35QWEiBtYIJ1SNCYiPZUVvr4X2KGvjt0Tnviktb5lh7srF63/f8/KiU5FIC0a8dehA==
X-Received: by 2002:a05:651c:509:b0:2ee:7e6c:34d7 with SMTP id 38308e7fff4ca-2eeb30b86b4mr11002531fa.1.1720504895382;
        Mon, 08 Jul 2024 23:01:35 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb34338b1sm1133741fa.67.2024.07.08.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:01:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, 
 kbusch@kernel.org, hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v2 0/5] Validate logical block size in
 blk_validate_limits()
Message-Id: <172050489409.367933.1302636222826369855.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 00:01:34 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 08 Jul 2024 09:16:46 +0000, John Garry wrote:
> This series adds validation of the logical block size in
> blk_validate_limits().
> 
> Some drivers had already been validating this themselves. As such, we can
> mostly drop that driver validation.
> 
> nbd is problematic, as we cannot only change to just stop calling
> blk_validate_limits(). This is because the LBS is updated in a 2-stage
> process:
> a. update block size in the driver and validate
> b. update queue limits
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: Fix default logical block size fallback
      commit: 4ff3d01275dee10ed1f40c314ba5133e3c7a6e1b
[2/5] block: Validate logical block size in blk_validate_limits()
      commit: fe3d508ba95bc63adba661355115be340275c0d1
[3/5] null_blk: Don't bother validating blocksize
      commit: addc3a68de850fa25dcf937705e721d8eec22470
[4/5] virtio_blk: Don't bother validating blocksize
      commit: af2817229158cea7960b9132e0a8c4470ebbfef5
[5/5] loop: Don't bother validating blocksize
      commit: 9423c653fe611070d875b374fb322dc44acce3f2

Best regards,
-- 
Jens Axboe



