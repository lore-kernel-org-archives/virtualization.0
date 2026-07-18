Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312D2C0F69
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784348099; cv=none; b=oyPbfU3RrNWw6iyIV8GPMCZZWYa9XRjU2ciDk8wBLfQwYLtigFww4+WGx0cvObUQeT+GSxj1r5+j2g0hNU1zlR5UnbyFXC8PKAouyKg3kaNnz0ajjCaVcGEjTd9BZ6KikI9i+aZmEzV8TeWNbbdXTqtta7X1nVmDmxEr44/EeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784348099; c=relaxed/simple;
	bh=Ou3HEIiPKm38QTThdCiEvMGnc5Ln3dOxrXgAJKXHIXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deGH+2UhQwzj2IghvwWZ/CMxGpWed+r+Ke/KUjfd7a7wzANlj46UDqCQ21UNCtFQuwa8ME9Yx1L4LChUfEjeRJGFwqGK0FYCHrN0Z8Ehu5dq5xVyZSsYw3iOY/5jhtXlQlly46TVmHm3P8BfWUdyGDyxoyOTeD4qakMSC/Vvr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GykDk6La; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GykDk6La"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf41bab353so10727535ad.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784348098; x=1784952898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJkPJe7dnY0SCMEmzH6DzLj6JYMgIuFy9yjp47g0SPg=;
        b=GykDk6LaGdRMlBbrt13PgDuUG1z/qi30RwjqO6w2zOFAJDrv/WYbc5D5m3EyQET08Q
         bnv2t6Z3vHXNDUboBOfYL6RD313QlKjq5oTTvf0SSnfOghgEGSY/qnbyW6BGymafecP6
         AaIzlzPonT+jppZgFrD8A9xn67/qTOTfj6GVh1+z+K4BAeouURqmvpHBkt36iAsZ3Lyz
         4lFT2o+jaPNm3SolUF6uJFYiMDU5wicvtTWVm1w8WQulxe9EDzxorMYYZcvtS8BVb2vt
         MIQCUfqitKs12VElDHavPqWRGwuT6YqyNhd0bzqL9rvHD9nEeSvYwM/AplmOMJve5gDC
         bzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784348098; x=1784952898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJkPJe7dnY0SCMEmzH6DzLj6JYMgIuFy9yjp47g0SPg=;
        b=Hv1lp8tBDJuYNZ7GBkPkW5jsLdiXwHp1jQLdqy8Azxta6CBhw8R3IQrKEhyX9KwGpb
         9xhYBQwhAdj1dZITKxkjX+enBrfjecawJsFB912ypfCheQqDCh3p25/vcgfiOlY3E7fu
         QVMOO+3TeJwLonmA8hVAZV9yl6wnYj9H5q6jh+l0kTI7EaLwmxzZA/u5VwSL5OR90EEz
         K/LzIrq/ypwwbqNmENju3dLwuKJ6QX2OaqjhDa9Ph+6ipSqZWG7xuBNqAP71L60kUF5K
         WwpEOZ/1QlWlmsFlsn1+TeAEV1bYohtpkq5fe8BzyjYojUbh1Yu84rWyi20emtBjRJw1
         8kcA==
X-Forwarded-Encrypted: i=1; AHgh+RrIvyfRG7/S3RAsq0StOWVPh2I4nUFY+EThlz+ah6huW6R8cQxqXQO9FcinnWaQrsGcDYBtFem10BW4+digtA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Tz20vS2xcIJ1hTM/Ltzr60isysvqIiox5FhzsCyERlss0Ap4
	n9s8sWkWxEoSuP6qCxoyUmrsJPPieueFJmXlR83nNzFp2dry2C7lSrwf
X-Gm-Gg: AfdE7clwbwB6dr6XCxkrO7tvDSO5XsLK2n4AaAprIZN05wsiRcfUwhbMEhtId6Le8ZA
	+cU+1oVVJ3tG8htAX7FHC6mmiUm7MPI8rpMIviv6/iKTnxQC71N17ahkIr4o5TCA7UCZCOyZRQp
	umP0R65V0BXSMDPC2nqUVYUVMqQKIy21CLbjA/+MI/m8AQzt+1+5/V80+kQ4c7+X4/qrPERDbvq
	+vuhM0mzeQd0yYMmjQ85pdu8GNe5wTKReqOx+24HInh6Oo+GumadO88jRcjW3fXYOmK6syBukXU
	weSSh3xilABeuabVeRlCQb2nu0UDsoNNnLCqx+XA8FCZjI/XmmE6JHvThzceYbh/dVqqHK30LzD
	dHfi+248GpNYjP20Ly8V6ym+luw+IQaU7uaDkx53qpvYyMcbUflviwKE2XlVVNDDQGpVYBUVArB
	bVLXfJ
X-Received: by 2002:a17:903:1c8:b0:2be:3850:297e with SMTP id d9443c01a7336-2cf349bff53mr53301185ad.31.1784348097757;
        Fri, 17 Jul 2026 21:14:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346daf66sm21346695ad.50.2026.07.17.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:14:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: bvel,
	rtik,
	efwo,
	kodw,
	michael.christie@oracle.com
Cc: slf@hdu.edu.cn,
	mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
Date: Sat, 18 Jul 2026 12:14:19 +0800
Message-Id: <20260718041420.1452333-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
References: <20260717142205.103515-1-physicalmtea@gmail.com>
 <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before sending my patch, I did a duplicate check against the upstream
linux-next tree, upstream history, publicly searchable mailing-list archives,
and Patchwork. I searched using the vhost-scsi and scatterlist function names,
T10-PI, invalid protection SGL counts, and the OOM/resource-exhaustion
symptoms. I did not find Linfeng's earlier patch.

Could you please point me to Linfeng's patch, or confirm what the additional
check covers? In particular, does it also validate:

    prot_bytes <= exp_data_len

before subtracting prot_bytes from exp_data_len and entering the SGL
mapping path? I had identified this as a related PI length-mismatch path, but
did not include it in the patch I sent.

With a one-byte combined payload and
pi_bytesout=2, KGDB stopped at the following call stack:

    #0  sg_alloc_table_chained(
            table=0xffff88810bbc5108,
            nents=0,
            first_chunk=0xffff888110050000,
            nents_first_chunk=2048)
        at lib/sg_pool.c:117

    #1  vhost_scsi_handle_vq+2295
    #2  vhost worker task
    #3  srso_alias_return_thunk

The stop was at the `BUG_ON(!nents)` instruction in
`sg_alloc_table_chained()`, and the kernel log recorded `kernel BUG at
lib/sg_pool.c:117!`.  This confirms that the PI length check is needed before
the iterator adjustment and SGL mapping path.

If Linfeng's patch covers both the invalid protection SGL count and this PI
length check, I will not submit duplicate work. 

Regarding the AI question: AI assistance was used during the source analysis
and test development. I also checked the relevant code path and the
host-side behavior.
