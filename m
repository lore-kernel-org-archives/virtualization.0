Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005A345752
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442292; cv=none; b=bxrHqTv6Kf/3I2FuHRJs8+sLaBhB/5yJKovvDYDT+OHaJB8Xl1pkDIIW9i+PMEhFuQozfvdEh8FbKlpkCWeM8msoYzqAaAzMslpHi1RRJUjsWEpoSJtE7TJiI/5IRBKjtKgQeJwBJBLJgSItEajKAkoRL9OMfeMRL3MOD2dJ+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442292; c=relaxed/simple;
	bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9hNwESn1fk7nPMhNKkbUuDW3c/jNbgDgXnWQ3Fw9lc2GnU8JCPBCgeBiXxk/nSia6uVtfS/oYc28V5hNCsO53w7DvyFpwgrj1oahZlILT2qq3kVxxmSMdWgwwsowYjIC90DQY1Xs2VwBdcK6Sa7NX02GTbAj1YcAIxaw69Bmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z5Lg3GOt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z5Lg3GOt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so6267975e9.1
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776442289; x=1777047089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=Z5Lg3GOt5qAfeV3d2gYYfVdl07wiki3iUiP6IldscYmp0b4URNURWq0ZxMM0mAz7bT
         DvrnwPzPaf3photDut4PhbgvJZSruyYmbzLU3x1nasHphoQwBFm4c0HzmcoV07iESlON
         qdWQl/7Ka6+RxGTV2jBz9H4QLBgobVKvNMqklI5nm7tvh0/chE/yIcDct/7uSK2QszeS
         C37ShKoN18lrgVC2gyQYIv9nErrONQeHrkgbt/Jddxz99CzBpnWBLnI5O4lbnWQMcFo5
         CDqgQPkOiCcmEhX6vdPa6lDjWYI1MmepX2dzkEsu5zc9zG0UNSCWsjFVMUiK/ai9XJ+f
         EeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442289; x=1777047089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=Wc/pcbAqnnnAkl70oGC7GVGbEvZkWiTO02nuUu+/Yd0UPfkQQxjOk24lFh5nPw21Lj
         iP06+a5SfdZzewPmzHfC/w5xuspb9J/T89UNJjhO+Xd8w5JT9OMy+TIA/kAaMKOFFCvf
         S9LHRLwLLEiFePVNjLqOz3Bwj3T7F3JHO0NAqOF7reFhPfk4nTmeTioy8zPCr/jMLJOo
         y31vIN+24xTyyE9zgJRskAot2DC7SgWSw3aCcKDXpGi+AuUIXR16ndw7/lzIa6gPEVt7
         fvfu/mZ2/Yn6mw81F0t7MvNXklOeS68VckXLHPnKkkNJ9WOxa7xGXMFbifaoaXJJ9Hae
         upkg==
X-Forwarded-Encrypted: i=1; AFNElJ/HSJ2wK21REOkGXuzLaXoYaj2Rga1mcQmM5jIH+vegCxTBGcn+AllzWikE72RNULgwoI7CVRmLsSblRIZdAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyigo5MtYnq7WAXn/F9sMRUVUG0B+XjMlxaX9WAd2BUuZvrGotr
	rYtbU70/nA54lx9BoLJvht9BPHP0JMYYlf9sP+kf/E+MX6A9FtMh9l4FAVUQaSmCXvM=
X-Gm-Gg: AeBDievaCesbe6zuGLMpfaF7j7eyio0XSjSvFvJZKwnJreqfguJvuaSgb9jQNBNPUh6
	+/Whm6vDJo9UnVrPphhvDF6nNTqCO/P6TwhBrP8wxWZynzDL9VCd+R2LmMU66nLmNQcQcLOWRvC
	AJztt5ACo3jQRYIFf2UljNG2nf79Q0MfRYai61me+WP/2QhZ0tWUORouD4udcOCRwsHGIxxDakW
	kHtGHWnDa3mLdallIUMem3Dulk+GmjIKdk0qeTrLSKmYlFOxgsnU1MuSeJcAWhYAdvt2F467m7B
	xjZ+NhheiMSZ6ic/1mZb178MY+5ZUSr/LfYz9bZZYjYeyAAAuHZ+P1Yusgl0oCc1fDiG59hZ2Hn
	PzZa1CKdqA2/A9NRuapLbkNw8oVbGGKGb0x0E/AoGasrbiUY/NxzWRvR0tuPv0F+6WNOGsXstyC
	XI8f78u+GVXT0QIJuPq5YJfTlda77ic7iE2sBcNbv9FsSTNA0V2I5SOt/W+A==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr52764605e9.1.1776442289414;
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm54863625e9.15.2026.04.17.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: atomlin@atomlin.com
Cc: James.Bottomley@HansenPartnership.com,
	MPT-FusionLinux.pdl@broadcom.com,
	aacraid@microsemi.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bigeasy@linutronix.de,
	chandrakanth.patil@broadcom.com,
	chenridong@huawei.com,
	chjohnst@gmail.com,
	frederic@kernel.org,
	hare@suse.de,
	hch@lst.de,
	jinpu.wang@cloud.ionos.com,
	juri.lelli@redhat.com,
	kashyap.desai@broadcom.com,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	liyihang9@h-partners.com,
	longman@redhat.com,
	martin.petersen@oracle.com,
	maz@kernel.org,
	megaraidlinux.pdl@broadcom.com,
	ming.lei@redhat.com,
	mingo@redhat.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	mproche@gmail.com,
	mst@redhat.com,
	neelx@suse.com,
	nick.lange@gmail.com,
	peterz@infradead.org,
	ranjan.kumar@broadcom.com,
	ruanjinjie@huawei.com,
	sagi@grimberg.me,
	sathya.prakash@broadcom.com,
	sean@ashe.io,
	shivasharan.srikanteshwara@broadcom.com,
	sreekanth.reddy@broadcom.com,
	steve@abita.co,
	suganath-prabu.subramani@broadcom.com,
	sumit.saxena@broadcom.com,
	tglx@kernel.org,
	tom.leiming@gmail.com,
	vincent.guittot@linaro.org,
	virtualization@lists.linux.dev,
	wagi@kernel.org,
	yphbchou0911@gmail.com,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [PATCH v11 11/13] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Fri, 17 Apr 2026 18:11:16 +0200
Message-ID: <20260417161116.373130-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-12-atomlin@atomlin.com>
References: <20260416192942.1243421-12-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Seems like the commit log of this patch is duplicated, isn't it?
I noticed it's like this from v7.

Thanks!

--

Marco Crivellari

SUSE Labs

