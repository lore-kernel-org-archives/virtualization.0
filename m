Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58F367B97
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737691; cv=none; b=KPU/z/ovXrsqS7uRxct+SSznxC1BISI5+n56URZYTUMh0kkD27y5iq8owxsAjrpwr6m8rYCM3ONn1TzY9WAKooa6Q8GjPj/havzu2g0A4p7rwQcdQNYlb0RbNCCjhc8yPb8BKaFcnfDoMFUmfq2qbJGZtWfLloWTgHeGCM+c8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737691; c=relaxed/simple;
	bh=LxSvb3tFEHxN+UPTs1YpJcVKRl8kkg6rttQGBqjpT7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/FzEE55NlGDy26/u1q7HjNDdrdxPfYCgRgNIw/tCnTgX3VsqxCkBddsRbR9SVD/MZWZawbRjs3qS8hGVKSFc5l2Pa0efQFHL05iLLqCcfJeCax0sz1LVzbMgQV6ALK8lwE4e2/Lf2f8CmfIOrzZUX/Fm4iVUbLQHRiED7UKatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn4l9MaM; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn4l9MaM"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88379342f7fso1811958b3a.1
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790737689; x=1791342489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tADa+gUpKB6hXrMlk4JcdjCrfBHR2QIQ4vRaRu8qGQ0=;
        b=jn4l9MaMwA7JN+56OnT6m10hwsU27RH38ortO2/bdKMM6eX2iHXRyVeWPK4viwnsNh
         j8O7pdfCwfB+0ZI605i3Oqw0+TJaknu96cVdUbtRTfmoQgCtCauHwqGYgrBlCr3eWWRi
         +ReyfF9WeFKOlga0Q0Vkzoq8Ghi+u4aSackA9YeygmnDKmaNszV4+hGi9rdreRef8vdw
         ue2+wkLWjG8+ksuxJQTD7LKO1qhieWq1EycwQML0uuYmjflZmWerXwoPk6ShsxMJKCau
         FhcI4jN2bnLMV6KWeFc1kchCUcPNL0fRiIcQLzFLCMhxzYoSSnTCqxMeaRJawXao63YO
         o0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790737689; x=1791342489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tADa+gUpKB6hXrMlk4JcdjCrfBHR2QIQ4vRaRu8qGQ0=;
        b=aZwgfJHs/8dIgSlNBLLguNC7k1ZuP9Hbv6e26m0nBO2AZAlH9KOyBlF1lIiWsIKwuF
         iTBgjk5414Ad5aLpZzXjq+S0esV+B9X8Awwvr4iuPqO9n0U274GyDJMTUkrIIkUqAtKO
         lBz6JLP/CUIT4cA7tgyDLYnXERALat/bISlYL1DAqEdND4u+4AuBJ6W+9Qj9jgVo4fGr
         kFTS3iiNVxGKyfBQAVE18dOJ4qHk7WdFPweUG52mTVgxT37fFEl7wGm4Qrw/SSNyCZJu
         fFHjMSp5WWGE8ZTxK8ZgU5ezVJvlONxUpozFQI8yeZwkauyhClXVvx55qW7nDi5M/K9i
         AeAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEW5y2Q+0nLT8xi3+uT39aS5XqrG2ZM+4xzLp8Ww1wfBSAGc5WHAcyakFwvNeoAg1u3zVQibnJoiaLTb3v9g==@lists.linux.dev
X-Gm-Message-State: AFuF++n+56DsBnJ0M8fiqRXJsYmmEjD1TIiwyku3zA68MdjA2T3CPg6n
	jOwaLUOSeeIlZfTiINQ/FAGLmpmJLnT5srQ4mIYKkBlU+ZTCzU6Ru/9h
X-Gm-Gg: AYBFou2qxGoKIGfhQKqBvmHE97RAPVQcFWvsEys2CyulgqzTMMEUFfSyvizp4XKWKhj
	hNCG21b4uHeuqTsbbtu3mM1TDTygFxxMi/s6w8lj1ZZHadLHssGiij9plVEBAibIjBm2twZiSoZ
	/7EWYx5MP0kJqjq2bKojjwy+utgDuGnDCRMS+YDhgquRDa9SFhwjHXuNBTNAtLzysZDOqbMG6zG
	8m2BZqv9Jb1KqHSymgf+NsCN3PWXxGMzFkKRFTo5TYMMF3+4x8P21RlusPmLpo0oRyt1kFC7Lj5
	IVvQluUAsYkpK4YPrcJ1Ks8rL1Ioip/wTdGQNg2sid4Jf8GvcoXHzTjB7JInQS0GV9hNOd/76jQ
	at6S8j6Aco6dFryAL0nE58sIL3tLpthRzgM/ON29iOKNZOC8FWFMqpCvWCSVMWbf/KF2y+HJbRL
	jTvhkYabq8ijExW7Gl8k9c1eNV95Xkc7Dx6MDsDHRLhRZ7ryBi/L0F4kjWxhnbE+Anod+ziL8Ry
	mYWdgOky4IVmPx2kNLU3hXtrsYT8pBNpILGSgEh
X-Received: by 2002:a05:6a20:a10f:b0:3de:675d:bcec with SMTP id adf61e73a8af0-3de9e844603mr37737637.59.1790737689067;
        Tue, 29 Sep 2026 20:08:09 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88722f72dc5sm101341b3a.3.2026.09.29.20.08.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 20:08:08 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>,
	Jialiang Huang <huang-jl@deepseek.com>
Cc: lance.yang@linux.dev,
	KunWu Chan <kunwu.chan@gmail.com>,
	baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Wed, 30 Sep 2026 11:07:29 +0800
Message-ID: <20260930030747.47294-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929165603.49436-1-sj@kernel.org>
References: <20260929123241.1408414-1-huang-jl@deepseek.com> <20260929165603.49436-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Tue, 29 Sep 2026 09:56:03 -0700 SJ Park <sj@kernel.org> wrote:

> I agree the reclaim-reporting granularity mismatch could be a room to improve.

Thanks for pointing us back to the Access/Contiguity-aware Memory
Autoscaling proposal. Jialiang's description gives us a useful deployment
context and a concrete problem to investigate.

The guest reclaim/reporting case and our host-side THP/tiering case are
different, but both raise questions about how workload behaviour and
monitoring granularity should guide kernel actions.

KunWu and I would like to help move this work forward together, alongside
the existing DAMON roadmap. For now, I would like to share a few possible
areas for discussion:

1. Workloads, DAMON policies, and tiering. My current work includes
   improving masim-based experiments and studying TPP-inspired memory
   tiering. We would like to make the workloads more representative and
   better understand how DAMON's observations and policy settings affect
   placement decisions. The aim is to understand where configuration
   changes are sufficient and where code changes, if any, would help.

2. Testing and contributing to the existing PMU work. Our initial focus
   would be on helping with the Arm SPE integration and testing the IBS
   and PEBS work on x86, in coordination with the people already working
   on these. The experiments could evaluate whether finer-grained
   sampling provides useful additional information, and at what CPU
   cost. We could leave huge-page-specific mechanisms for a later
   discussion, guided by the results.

3. Following up on the DeepSeek workload. If the team is interested, we
   could learn more about the workloads and tuning questions they can
   share, and study the path from workload behaviour and monitoring
   parameters through reclaim and free-page reporting. Pratyush's
   reporting-delay suggestion adds another useful dimension. This may
   provide a practical starting point for revisiting parts of the
   access/contiguity-aware autoscaling work and evaluating their
   relevance to the reported workload.

Could we discuss whether some of these could become follow-up milestones
in the DAMON discussions at LPC, or here on the mailing list? We would be
happy to help organise the discussion and take on agreed pieces of
testing or development. We would also welcome closer collaboration with
DeepSeek and other interested MM developers, including Muchun, where our
work overlaps.

This is only a brief outline for now. I plan to bring the experimental
results and remaining questions to LPC. After discussing and aligning on
the details there, we plan to share a more detailed proposal with the
community and write up the planned work and experimental findings in
blog posts.

I appreciate how much is already on your schedule. We hope to support
the existing plans and help with agreed tasks as the scope becomes
clearer. There is no urgency to reply; we can discuss these ideas
whenever it fits your schedule.

Thanks,
Lian
