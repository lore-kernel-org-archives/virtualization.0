Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD6370D47
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822415; cv=none; b=pReGAaY2uK5ZpJX5/05zL44CcmwhWyHnni5gZJG4VCoskgzmstXmET8yZBpu2s0mV+RdpTZv6Wime6VqwHD89IH4mCN4j/l9bCuyJyptfBAnfFEVXPo+oCzQf2FGNP/DDDgOri9hp3t6i9I8g5J6Msytug2aeTYOKGFR6hvnL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822415; c=relaxed/simple;
	bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvi1HK0F8AphiF3g8o+z2CTLvBSM+lpKwNUU8Y9LFfTvCgRRIg/yesouxgPrADoTb5TIuL1dJIA6pB/gf+QELXTRa5JlzwPIMAg54wnv7PqUiXNTnieiAuE19H1TfwPVQRlboFIjCYQ2HcuZBpmQaTXkp6voWLd7qqWktsL47ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+4QAX2X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+4QAX2X"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso44464805ad.1
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822413; x=1786427213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=V+4QAX2XG3VhaO+3EK12dTO0BXPI4KHSWCh3JbmtrLVIrJi3slL+nDHTJwEm1lJYoK
         F9MxGVtQBQpfCio8SAW0WsDHRKoVmgNAU5nniaBirsrxpW2+7RU38Sha00jfsj36irVW
         IS5jvbGivvW9ZIid8A6DVE+7X3YOL7z0OBhs/k1AzruMYtto9QoQKZbNrSGRCkJ6sJx8
         BVeJ8AlDfln7ub9hQcLrtN0ot8Dksz9KkQATs6DywrcvaT8JQklUOcKhcr/Nnj38K0NF
         ZwZLGI0epn964zMzb1A9HhHM3TMM3V4wv+SJG0dLg3yxzSxHqtYuT+RsRQN2VHnRxJRu
         QBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822413; x=1786427213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Edg+9r5X6Hx937Ug59wtr9oIszVOyJNcrBmngu/d/Wo=;
        b=dwbFrgi9JEsCmDlXhI7RNYl9lBV42JQzPBfxlNOHV9L9DmBBF/xee0NJhc/KcnLyKY
         H/B9LldkOJeCt366Z8UPXwlAt0DQxms0yKQZZRuUvj/tkivFMpIv5uBRTPErbRQE+K6i
         JnH+p16+a8uLh3TyUU1UXuWRp1F5p8mq03Bd78QL7HHXEf1hL+HW7oOK1oL7Uu7ieZJ6
         qmKMj/w8tN82sMtTk+wO4kc8KQ0jTiIjNMb2R+hcm8QZYxK50krLpOjs3qGS+1JbSTwI
         4oj9YbudRl6vvxfkAWNMZmopj77jev0pH11aTsjvsN4QZlVVOxkBTC5ElvfSjqzM+oBb
         RjMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7ZavohgBtqJTWFdTc5HJ1L0ycOaet494K2l9UzhIfX+7fJohQx/vGoupV2gx4rGW+35eK/BukCY3oWvjAUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9KL1m6ZHuq/LmbxU03CZBi+cl0kB3/PRCj4xRdQDkIIRJmVSr
	TeMyvdRTUYvLNO5J7x+H+zTMeijAVpOgit2+5l3iFIe9Qx6ECNWaZv9w
X-Gm-Gg: AR+sD12iO2oqh5IpdI00Ej6fem+/wnthMgxv1VhzQtBkJSjQN1QtkPUQ4I823o0Welr
	sCrNHb7HgYJbClRUnhOyjW3sNSQgDYULYMa89FgFOXLKw9F5n3IvEuK/z4RikhjqkSm8mnG6t6j
	KJv4SbtFnZN7zw17R2YTlIi9/7SLl2lttHRhtZHdEhUs2A71X2Bmm9FhFFBnbTcJ9bKH67vOkCz
	7Ivi6gV5WST+0l9dyVx6HQSIosTpaFsf5HfWj3roLMZ1D8e4lQM01gHvsvbINQewAkBgF/HyG65
	rWZzCaeU53eIt1ACa7BGCuYpPBfABOwTpCdGekV6L0iRct59x2yn5tQnGo4k2cjRp5i7lzaRdbQ
	5y/SC1HvFaX+J6mjeqCg4iLObe1Or2VEMneiikMfEB4i7GHNWUSHOTmDPcqFq4hJIl+h9ucqakP
	2zwfbMgUuSe5zH8y7yPKBcc7wYQd6aQCiWN1pEa3WgYgYrSXpuk6uuVyzvQQhGV0g=
X-Received: by 2002:a17:903:2283:b0:2cf:dc6f:cc42 with SMTP id d9443c01a7336-2d0524b39a0mr116935565ad.46.1785822413062;
        Mon, 03 Aug 2026 22:46:53 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f0f9sm45779556eec.23.2026.08.03.22.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:46:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 13:46:37 +0800
Message-Id: <20260804054637.6238-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Okay, I will follow up with the changes.
