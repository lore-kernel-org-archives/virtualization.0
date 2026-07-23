Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44D3E49CE
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804105; cv=none; b=HSbxmFIN2gcwdtN/2+cTroV4ICwdYJ2ksTicW4tsn3hFsTjWVGss9LvV9ycp81fRFACHq+oIeil2bpmxcJL+1L8abuB9mKWQIDKkPRB82zorULsIDesKJjIU51zm2ok2/THMKUBp1Ewq7t1AAW4/jQ+sS9GALLes0ZGHTpApS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804105; c=relaxed/simple;
	bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEA7Y7bqy3HWT5+1gPsW8bs9m5tGSWaH7A0KUzrnfIoak566yGKC+Ki7Uuu14Yf1di0VU1Vc47C3czQUUMHBA4R0dklyQvw8vZ67vVTdeYecdSmap/toiSwkR0FNT2NKT4vBk5JKvIV0gJ7uRFLT0agbidXlvcavgYUWEzokTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An5Y7WZh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An5Y7WZh"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so312182a12.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784804103; x=1785408903; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
        b=An5Y7WZhERWHQTU6rnl/MtepTxnitbm8y31QP57I+77k4uFGaXiq2+8yBIXm/YO+3N
         dBEPxiGPiy35aP47BN6ztlqTIGAKMpHWG0cnsNlG0f0WQ98x0giw7hjxhO2rPNcaoiDM
         ESbHzVYURrC/diRDAz7LDXVlzL7qYB7faZs5LhnekoT4JWuoXOBn6MGnmmBN5+asWRrF
         Fx3FzQ6G6vLREkW3wSWonUH9l0IkYlosOjUUJNINK2i23ZT8upNaqpdDCDMAFuUJtMED
         wVvv4v9MH9ncr2CYSo5rn5Vr1piUEfOqyopN96Jg0PWY2SsBfsypJt2DkOLG/U/Rgo9b
         nu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804103; x=1785408903;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
        b=CVN/hjLU0kA4dOSDnpOKrg/IMQV97Fw8v1gYT+AFBKqOZ/NPVtfzu2QwUxoCkF26pd
         lLSAdUdQkMRGPoL3Cf0W3+eXhvs+goS1AzsJ9HBtYu2A6e1OFT3+YH2CNGf8HgjnBYiK
         TNKbHgj2+7/kWqzG6tvsSdlVSBNRpZ9tfGidPVguMP7q6OctosOoX+eZWAsqErGPpi7n
         KCmcAnFJuP/SzcvCtAt32j7FcQwz8MfOehoF9zyC4pXKlZOy5xQnJIEvJ2pCLagW92Tm
         oVbZ20R4evnqpSm0t7vEGDPc6gniQulCQ/SRPUUADt/PlS3WBU1ek3Q1MdF87JJN01L3
         gkfw==
X-Forwarded-Encrypted: i=1; AHgh+RrIzgftFhtt7xSF7TT8SDvZUfWPSWyZ+3ClWTcEnz0xmU7cEOxBguq0wqVh/2FcxZ5UuSsXdBB67RqbvQVtvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMPBx1UcEGhpK6zjIyXZ7hECGcSNccN/jio2Zj8O0zbYpZ7C+c
	Nj3yKnWxXB513rieAJTpK0RC3J0l4rjh5amGrNlxd28nzRWe0WCvk6AK
X-Gm-Gg: AR+sD12oquHHEMaycsg4IRovTSrwv/7//+5gmYNtkyb8Yaa56no/3cJCh1oEyh+bom8
	x1sWDcCtVPL9ohGawBPE4nCchcPnyK+4Rpq9BEZH1D/M0MghY7pUybax9K8XuM+fADr+RiVJbGF
	bVrjPGBueakPvXBla12my4Qka3qwtjfRdPJNIi+9+IkLGHnHnHs1J4F+qNmsgIcni3ES9Cw5U57
	y7DxBL9Bhxntf7zyISyJ+bH55LfzxBNGOsAa8E1Pm4hQK1c1aJuWVOZ6Hw+hbtG2R5AM9hKFJbf
	nu2M9OwJYIFNtyxDHoffVe/VWJegDM741EdmXgqgSjNp9a/ET4XcKg8ASyuSJD52e/PlM+PlO1p
	vsFUDYe77uB6QYKtN9sk3jbsLL7Yj3OkqX4SOZrurYkft6yDE8JqM/pDycJWpyL6B+cc6hJMul6
	lxvHQ8
X-Received: by 2002:a05:6a21:1519:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c44b247352mr2773503637.59.1784804102681;
        Thu, 23 Jul 2026 03:55:02 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1cf8fasm19621764eec.31.2026.07.23.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:55:02 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Thu, 23 Jul 2026 18:54:51 +0800
Message-Id: <20260723105451.1563439-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

The changelog is too long. I wrote it incrementally while investigating
the stale response-HVA case. English is not my first language, so some parts
came out wrong. In particular, saying that the ioctl waits for pre-update
commands may have suggested a full stop-new -> flush -> swap -> start-new
sequence. That was not what I meant; sorry about the confusion. If the patch
is otherwise acceptable, I will shorten the changelog in v2.

I wrote the patch myself. I used AI assistance only for notes and wording
help; it did not author or submit the code.

For this specific stale-response-HVA issue, I believe the patch is correct.
The patch is a return barrier: vhost_dev_ioctl() publishes the new memory
table, and vhost_scsi_flush() switches each vhost virtqueue to a new
inflight generation, flushes the vhost work, and waits for the old
generation's references. The completion path copies the response through
cmd->tvc_resp_iovs before releasing the old-generation reference. There is
no separate stop-new phase or full quiesce.

A command can arrive after vhost_dev_ioctl() returns and before
vhost_scsi_flush() switches that virtqueue's generation. It is assigned to the
old generation and is included in the flush, but vhost_set_memory() has
already updated that virtqueue's memory table, so its response iov uses the
new table. It therefore does not introduce another stale-HVA case. This is
why stopping new commands is not needed here.

An old-generation command may complete while this ioctl is still running in
the kernel, including while it is blocked in vhost_scsi_flush(); that is
expected. The same userspace thread cannot perform the remap and follow-up
TUR before this ioctl returns, because the thread is still blocked inside the
ioctl. The owner must keep the old mappings valid until the ioctl returns.
Remapping or dropping them from another userspace thread before then is
outside the lifetime assumption of this transition barrier.
