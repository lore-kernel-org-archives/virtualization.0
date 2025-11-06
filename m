Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA234887B
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472027; cv=none; b=OdpMa6LW2vCZOtXpj8uV0pwYmhYkOIGHtYPNWv26xpqzznV5TwF9jAthnmqGd4gU41Pkknx+PkR8UJC+P6gPdAAaTcGs7wYhQB63BzguJKNo6kiEvfWllrCWSXxd1x/Ad/Y/DxPGZ6aD9zquckMMmaIn3YhoFpl64nNbOJcKuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472027; c=relaxed/simple;
	bh=E1ekq6cGetq/EM4Mk8jO06W5nqMewZh3FMKPQXLdf8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvkgWot+ANA43iY9nRNAaEqA6FiiBMDwplpOD1q4lg4VRBrmNEDVWwQRdyPRdbSC56xV04jIng0tbCdobnRQEGl0PPJ7jOWzPDyxbxsfmg6xdxh/+CL68K2Y7h9p1DS1LQnVLRKtgry70t3hBm0FzT4iagCg7U2gMTPWS5WKsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IWXbP329; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IWXbP329"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804ca2a730so2958696d6.2
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762472025; x=1763076825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRXXfNY9pyURNKfsdcnYJbg6hRyM80+iEOQucrkOHfk=;
        b=IWXbP329xd825AWwuE+lS0gown99C0vSRdxYHjDHtVkhE6VRmmRKqdSoEboEnlENix
         twGT64CvhXPfAgHrNF5QSjSETs0DdnF+KY87N0oP3aZtv1KWH1cA6pSoPabR1dlXjrkB
         MdKXnaSSTSfUglNN4H3TVTq+S7P8enYpuAZDmiKIyFddnx8RCiU+DgipHl2DcJ9Uob7g
         Ol0FFIAtQdgjbBJeq6NL3O1JKoi2fxn2eteEu9P4hWYCKjNaDCyKmPEvTugllu4DnIyw
         H49HY49SzghfmM9V5Qi5h2byhreNbvlDobeHZLLo3zyp6XYsREMW8ybCbxxUa9I3X0Eg
         hYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472025; x=1763076825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRXXfNY9pyURNKfsdcnYJbg6hRyM80+iEOQucrkOHfk=;
        b=UAQjxzDr47IeqYj7Da+NTdkH45T2xSbvCAf5iiIuVGkpHGS1lOrpJcsaR8b6vUYn1Q
         f20BQWpCXgKyn9T8YwPz9h+TrSeSrqsKOO2JnoMe+P0PEXhrBCgm+fgjM0yEr890sIhB
         k7RP+ikYehm9tkTRNADf/wm2I8KVckeTdnBHDaRF/D8FJBLgYX/6vRtLam5bKcFOz1MQ
         7CURWJHcqTn/FSbK+H2fIFE+dVL4PZ28xzK+bJoU0qapgw1FxoYy8PgyfUni7j9D0Bq+
         I3udFqTggPt7EwalU0Go65Y2Nt9RHCjmAzEMe7ytyD1lNClCEIqJx2RcxZqzsaEmDIzd
         XkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWWCqYIK796akE/04jgXl6ayB3jxteywmOJkTgIhn3vAIlwbdZ2k+BjLIBn2cm199gmGWd6Q/InmGiKp7UhSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoUbYAuCPFQXastH/RxcwGl/T0EHxcCfWnW4Pcr8QRwlTIPg1D
	oUzU2h/ydsc0f5DlZTChC3RgYxEzb89ngNjWmU65NggRtRExMoP4zT2insodxy9Vnrg=
X-Gm-Gg: ASbGnct6RmtAQ3/8DXoIGp0FndLsRPxQ4izjV3gQmg5xOroa3CGPm2O7TVX6ks3hVmt
	j9DBlpisHubhg3wyEq9kFlSnlpqmF2bfvDQfTTm44XlCJ0GO4q4UPovUC95+D6FIavHDX8Nta29
	IUtZhnJnHEYKwYKFPNXwar7DuBQ2TvcIdHwr9j5KNvmBhulOYnQxXcJvfoujVIn/E3lwM3A4Ur3
	hHQaZUuYzniKgrewv3ypoWPQF7Me/+CQ2HqaVHMSjPZntqZy8RcrPhZwtwyYExxTRsQCQEXOu9h
	P0ZKdOZ+0idQavRBlFrQ7pdrvVb/LDtN4Yk8qCYLqKxXMmFXpH+zvJM7OxyFNF6hXug2GG/adY0
	xa9wgBGO9MxJ0xwmV92vS5neyQuU84fRGiagr8nKu9nyu1/7TOKYn/FHlv4eh4ReG+0o7YCM=
X-Google-Smtp-Source: AGHT+IEa/p1y28PH7vF+rUuXCk73+M+v/UzuRPpQS8qzH/lxCGdYQdwuZfTniyRJTftE0hYC6qkFUw==
X-Received: by 2002:ad4:5cad:0:b0:880:53b3:a9bd with SMTP id 6a1803df08f44-88167afcc3amr18286516d6.5.1762472024851;
        Thu, 06 Nov 2025 15:33:44 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829c83edsm27627626d6.31.2025.11.06.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:33:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 pavan.kondeti@oss.qualcomm.com
In-Reply-To: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on
 failed resume
Message-Id: <176247202182.294230.13399520810544725524.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:33:41 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 19:07:56 +0800, Cong Zhang wrote:
> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> is allocated, later freeze/remove may attempt to free vqs again.
> Set vblk->vqs to NULL after freeing to avoid double free.
> 
> 

Applied, thanks!

[1/1] virtio_blk: NULL out vqs to avoid double free on failed resume
      commit: 0739c2c6a015604a7c01506bea28200a2cc2e08c

Best regards,
-- 
Jens Axboe



