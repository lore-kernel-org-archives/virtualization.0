Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC13A41A
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273561; cv=none; b=aaVmkYp6K/QlHAd5bMP8eCy0uUY8hjuutKZKsPKaAbVXqt4nd6Oa0Wrm5/Equ44NxCrU1duNk8S+MV6QESk7lqJKfE43jNJQQ5SbHWwbZBoZje6FHVlPLGYUCfTD0wYPcG526Qm66UKQy0gFk8J90+8YjLbMoWwNN7Jdx68ETz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273561; c=relaxed/simple;
	bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C66dA4PRX6WjGfI/ljnQm6PZldoiwXrJP6dxWWfJv8e6Xneig432h8US61n/tah9gwPR0c0XqMv6CD1TVhvnxWOmneIzejbVbpOQc5la28ILqo0deqJ/CSm+RaIvO6qeqnHni3QrmwlT+dpElw3DNg69erkblWWQdSTdVwo9KqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QF8WI1ZV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QF8WI1ZV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e24c889618so14073655ad.2
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712273559; x=1712878359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
        b=QF8WI1ZVz+lFDcnC+KD90vAzlYBR3x/goUhvC0PTGmFCksCNUSrkeMD+Da34BhIAUe
         xAAb5UAaA2kWfzpr8Qhk75I8+9s9qHVtXPHeb90QxiTw8kSdxmZnvm5gX5d0QSUH4okM
         zOxP+3I+qqCBkfN2q2HwZ3y11vIfzA6RiFc9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273559; x=1712878359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+JcGZWerA4/j0GP5BcYvILM9CMcZQ3Ab1BvbCrrzCs=;
        b=EPEyYkfIxIr8JE14CaAelFxmFkDVqMdgaVGM2ndAWta0uuIgNrxAhk9M+VGz+s3AOo
         nj1n/XMenL8f6JqTdNfG/EFLrxOy1+im25bt2FuFA2X9K4zYwTdUQNmaGZtz7D9lcl55
         rWxpvfVpBlrrVxkPUHAamfULQTTfmg2VEEYmRcEdGWRCZ4FOsEZaox/ngJk15vH+VnS1
         HaNrGQW+v74NaLuUErxemIAvV6Hv7R28+sQG5VP0+8nO3Sun/HfSPVrebWjXGiKzPDvW
         DbYdStdkoJIP/qHdGFn1f9WFnFTglX63L68s+u8wda8aim1gSxEsJkzlCdC5+v5eGBW6
         E6lg==
X-Forwarded-Encrypted: i=1; AJvYcCVuQPMOIvcF3KJJGf6G5pb66uR6IinteUFqMhVvMkmRp6u0gLQvmeAvlPxg2+FvMrRXbKoggrwOc0z1plzi7XpysLe95EqMv7kwWZSS4Sc=
X-Gm-Message-State: AOJu0YwrL0WDxCo2IjzoPxp9lfohnObrgwqgq1SU46RJDtRO1S2JdKpm
	bQyAmKYh8lu6DlzCwq+q2oXh659qMouRi7FkmCo7WlGt5fdE7HIVcqCVl2YtQQ==
X-Google-Smtp-Source: AGHT+IGG4uDv5A1Im5aEtkPraZjP1jqit8IkG6mPT5w+o0kvHdp78WkPTKabNTc/bYh7JTK+vQvnlQ==
X-Received: by 2002:a17:902:f7cb:b0:1e0:157a:846c with SMTP id h11-20020a170902f7cb00b001e0157a846cmr3031022plw.55.1712273559198;
        Thu, 04 Apr 2024 16:32:39 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001e2a4663179sm188177plc.258.2024.04.04.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:32:38 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v7 0/7] VMware hypercalls enhancements
Date: Thu,  4 Apr 2024 16:32:31 -0700
Message-Id: <20240404233231.36294-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peter, can you please review version 7 of "x86/vmware: Add TDX hypercall support" patch.
It addresses the concern you had in previous version. Thanks.
