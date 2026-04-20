Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589039A7EC
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690727; cv=none; b=iOG9JKvyMNZNKpEK4IVRidX1AOGdD6vhipcCFDKfS+jQwcCZSF23LkNBLhiw8b0IRb/Fnvme3vgDVKy3imENN7oo2+gNSabsZCzxtvWqPmY9YmQkwnAPGoYcOagMbT9wIg0HUOkF79dJk7YnXOiWimhaO4eja28pn8vE2Je1So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690727; c=relaxed/simple;
	bh=unTlZmvymtrAosC1gc38VchUcqWpH3KjnweqTsHal+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOzKkDZr3whwP+keyZyqOmg9yLUrHbNwVMBYw0GyBEChzldnXvqz1G5MlHCqOIGdRZ3YlKm4/4fpr5qDpGKx1F+c0opSRBmb7lvvEGfX2nAXhgddcAFLj6kJ1BF51Bn6b3iMuaJBy8/cXYCkVYa0LCbEql7ZFApRcXKqcuCFafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVJz7/mJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVJz7/mJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2316706f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776690725; x=1777295525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=aVJz7/mJq4v2BEd+X1pyT4WFXh3Hu5ZTZzEHnRbfvOzKfejaS6ppuN8Sw71Ap36mVk
         SazEKaAseQT45idjCksyfNpNt/vbMna3TfuHGs+bFnPz4jfRhy3ax3LAclCA8O42sk16
         HEHk2TKwLuxLFy2dAoYmOGYamyYlk8ciNaj6J8Bcq8Hete5OluR35NF0A+BYI9i1Hf+0
         J31UaS/AVjFFtIPu+ebpe0uF0gbE1Gvx64TSL8Zy3KlylOzxTLNB+fmeV24Ly87fZ8M/
         6zPAAynPFWfoPPv4Cu4+raWTc+sf66R5/aXWMCY1FrbhvspB/oikim52QPIwYDQF9W51
         uNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690725; x=1777295525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=kDaPTlnOF/0HzuXuTmwEX+RMsSCz4TUfi1lUxIPugeOFAVOkBKJ9vjFpZGqz5jBcRV
         GRWKDsw3wbKet/5HZfYSCgBSBfaCBkCvIWGOdALrJXq0Eaqp9Nzuww4wimwyPOmynsaH
         MohIOtjwQVBcxBKfvL7jJdqOYyaW29jpGHfnfOfk/YMVqUbFSJecx8hHdlXjoxbEyhaf
         s42Tfkb1TGsLd6ZV55psPFmRx/1jW+uHWXePqGZnJN0kd3aK0VPBmMF63lhX6SVR0Ujk
         EEymKEfdAEqA2ooOsdU58CYY1copM5oQPchs7+Qym9xFN35sk31mzJcm1WUvtSZg8tqJ
         GDGw==
X-Forwarded-Encrypted: i=1; AFNElJ8K1EfUh+FaOQNG/Epne91kSCgDocHKXyrHLHiWmrzqScQtfH77K27SQM+p//uMNbH0PT+olHnObZAdG2CWeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzgd3WcmaM+vYzW54+6HDZ36cE7Q1z/goO/WawRZLUyNnS87YC
	/P19KpYQgqtrKWF79npYOPf7F8Tn3f/4to3AbWSDAGxT538XCa0uUz3XpWrUK2Ateds=
X-Gm-Gg: AeBDieuxSfVSYPu22xzVjCxUtQdeqff5Wr6DwCPOAfIduLI1vK3+fmiStdHf5T1xZBz
	xBRWEb1T5tHH/Ile4gh3qK/+O4hbYv5DouzlUTld2j3dodBpzNJVlvDP4QonlHXcuk5BKeX2yOg
	AbkY2EIpd64tQrdeuZbtXQAutSaSOEmQjo6+mREO19n5ASaW/Gt/Oxo0zwQbVAJMc+ty6qbL5cA
	riSOnJfUt3eLbDDejURT9kMT3P3+Mc56jnrh4IONeDkF0jZ46xjWGMftAuEKhFybE3SAPhy8NeO
	Ui43dIzBQw0sGcLnq3XUCfvYQiDMAhbgV2z8uJr+AQiRiXRM8qYwSTn4yTOBwJNq9jqNdX4ZT6r
	XqMfk+vrxuO190XtCpyLFLgFLO4PF2vs+2NQ9nkVfKdw/nv6M6sxCJKmFdRvk/D9EoHjAvLv9DQ
	knW60REoxNU1B4Gtafp6XfgxzmlRApFfl4w3x2t1BItmvk5aAUSw==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr19870492f8f.36.1776690724775;
        Mon, 20 Apr 2026 06:12:04 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm32580385f8f.29.2026.04.20.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:12:03 -0700 (PDT)
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
	yphbchou0911@gmail.com
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Mon, 20 Apr 2026 15:11:52 +0200
Message-ID: <20260420131152.243488-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-4-atomlin@atomlin.com>
References: <20260416192942.1243421-4-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Maybe I'm missing some background here, I noticed group_mask_cpus_evenly()
is called inside irq_create_affinity_masks() and the "numgrps" it is this_vecs 
in the latter.

Looking to group_cpus_evenly(), seems it is possible to have this_vecs
equals to 0, indeed this function return NULL if numgrps == 0:

>488 struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>489 {
>[...]
>495 
>496     if (numgrps == 0)
>497         return NULL;

Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will return ZERO_SIZE_PTR:

>+struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
>+				       const struct cpumask *mask,
>+				       unsigned int *nummasks)
>+{
> 
> [...]
> 
>+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>+	if (!masks)
>+		goto fail_node_to_cpumask;

and this value is then passed to `__group_cpus_evenly()`.

Should this check be added or it is not needed? Or maybe rely on `ZERO_OR_NULL_PTR()` ?

Thanks!

--

Marco Crivellari

SUSE Labs
