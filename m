Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6B1F428F
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387404; cv=none; b=Y73/k95akOyWzSRak1uZRRES/ybaE/zdqYk1X1NywFMosglgMtY9ZjuP/VRVQszz0N5nlLO4Ett/pjhaQVhkx5r/cAU5Vq7RzA60PpkxT7In2R/fr/p8KnPPiF6XpvjZVjoLzYHMzfAS4vJgFo3Pxu2AvwBzoUKhdUEjM5ZOqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387404; c=relaxed/simple;
	bh=wFrxDDlw3PMnJ84pTpU3+oamjHqaLYc4WDE2gz4FccE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=en8ewC8ixdMvR7Kak1Rq4/VggANOYlthNsaEjQhRE8E3HLPbuttq0u6vQ69tpo2j+Cr9jy6/Laa+MrZ9AlZ7WD49FGJepCvVNADAGurk2pstCm2w3dbnYNYAsFU1nwqppTSMETpCvrsEZ3Bec5CEaw4ONHfB9MJ1oSg2NVFmL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hg5P9iBJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hg5P9iBJ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so306195439f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751387401; x=1751992201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crWwaD/7GgCUUFcWT/Llkm7dN9wwCuiLb/qh9BwJGxc=;
        b=Hg5P9iBJUENJG8nK3AIpYU7ibipbF/QAavSttvVDcbO7VobnN32tn3pEuOwmOD0k3a
         GWL5TaI1BSNviYO4leBB7Z7ZIxzAk7pvwzbdacccTSlMw0IPglLfg0V1q65+nhgC/lX1
         RqGpnsKkYvBbPuYhqZy4W8LcUDnQXhTGcaZba/sRM6r7/8QkMMGnZB+Bw5An9qVIQGGj
         8KfNCdK4E1vtCKCbvfgWwcffCKUaRuk7LdzH9nSISQg7O2uqYcbS8wAWzgPSmlwQes/O
         r4Qb5FebxnS6ARnL7M11m5UFw1q2Lwt87bFNo+xmPAPRYw8gFluvPqh++SJ08uWLmoBC
         mYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387401; x=1751992201;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crWwaD/7GgCUUFcWT/Llkm7dN9wwCuiLb/qh9BwJGxc=;
        b=YhnQTLd8cm7+Dcn+fQ5HnVNHykB1stLMEk6U2LppoIYmTehiQH1ruIb2Y6/7aCBt1Q
         8SRptVPg8CoEdcFr5eW3Ys5qm67vJhGrbHFFdrXaurT6Q+HhoFz9z+al1eL73vrNgSVF
         dJQAjy1qqt/U3E1aghtJkxux2x5CnHeyU0/T8Npz3V5mgxDhIAyjhya06sgJ+Kz5qtyD
         RA0w9+EPbQICWNAN6Hz8pHqKryyLOtuFPj0LpcSFTW6Lsl82dKgcnrtXYxrxu1Il0PHF
         m0DR9gsccy1cpLyr2ZIOlD6YN8MhGz0mJREpJea9i7nmohqsS4BViZ8ayflvpkKGwNBS
         3s8w==
X-Forwarded-Encrypted: i=1; AJvYcCWwTwgcqqqW+GTksI+bDN5ZrREU/e37YgoyMC8S4HqnpXIQW57z2IfgGEhMvaGN3dBv5gQDCC9nO3RL0YGK2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJajMhuIteicqrS/eBCr9nQFJCgnrM0L8nBTAjqZGPdbN71lA8
	LxcAy9FoNTrGew0fvbWGyaim2b0bGYpzIq0DgBUVCAef/ColuhBlvtu0LjZXbLsnDzk=
X-Gm-Gg: ASbGncvHQ/Upu3fOSMmetoKzQl+tzP90FQCdOq50YPfEEUO7vSxwd+J9XwITBsfMlrE
	cftLQxSlkpQacDgnQibwYGklwog1L4zlu9opI+fOVnm4j2AJ+p/y5inMl2Qvuz2aQhuhZwEpNnB
	OGk3TiH+LxcjUnLqqpoPNIpJIi3Ir+70/fIUhWO90n8y75OaUEzi/kliOYNu+0buZD35+B9sTzW
	zHp/SgrvLCOYGdqzTgwInUqqCw0h/KS6Hb2ka1OL99a4pkDrp4dLRScri+V5+Z2PwgLfDrpALV6
	5dnihBGWQ8JJRoQWDN/9bb5I482VaFLxHH2lgdrJ5b47Lb37WsQylMSLv/ygq7A=
X-Google-Smtp-Source: AGHT+IGmszV/ckQKjI/KgjT/UrAo+IhSsGcXQNmla80uKgIibrMYCCf4LgGCWJe7gTvyQW/Kg7z8dQ==
X-Received: by 2002:a05:6602:2b8c:b0:864:4aa2:d796 with SMTP id ca18e2360f4ac-876882fbadcmr2169640839f.8.1751387401311;
        Tue, 01 Jul 2025 09:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687b0d3fbsm236096439f.39.2025.07.01.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:30:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com
In-Reply-To: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
References: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org>
Subject: Re: [PATCH 0/5] blk: introduce block layer helpers to calculate
 num of queues
Message-Id: <175138739958.350817.18365520328662376034.b4-ty@kernel.dk>
Date: Tue, 01 Jul 2025 10:29:59 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 17 Jun 2025 15:43:22 +0200, Daniel Wagner wrote:
> I am still working on the change request for the "blk: honor isolcpus
> configuration" series [1]. Teaching group_cpus_evenly to use the
> housekeeping mask depending on the context is not a trivial change.
> 
> The first part of the series has already been reviewed and doesn't
> contain any controversial changes, so let's get them processed
> independely.
> 
> [...]

Applied, thanks!

[1/5] lib/group_cpus: Let group_cpu_evenly() return the number of initialized masks
      commit: b6139a6abf673029008f80d42abd3848d80a9108
[2/5] blk-mq: add number of queue calc helper
      commit: 3f27c1de5df265f9d8edf0cc5d75dc92e328484a
[3/5] nvme-pci: use block layer helpers to calculate num of queues
      commit: 4082c98c1fefd276b34ba411ac59c50b336dfbb1
[4/5] scsi: use block layer helpers to calculate num of queues
      commit: 94970cfb5f10ea381df8c402d36c5023765599da
[5/5] virtio: blk/scsi: use block layer helpers to calculate num of queues
      commit: 0a50ed0574ffe853f15c3430794b5439b2e6150a

Best regards,
-- 
Jens Axboe



