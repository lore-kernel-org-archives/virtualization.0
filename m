Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6E238D54
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681896; cv=none; b=WBFqMJBiS/bne9gBwztP/pcKHvJd6fgPDOjuoJU77740p1eVPpN8GAfJWdL5EVYo1tte4AX/8VzUMEb6kvoUecKFtWUBBDPMAUVb7awBu824t3yqisL0ebs3Cp8k0iYmI3UNuw494XTxuwGtqQI1eKnB8n8qpTvhJm8djznFLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681896; c=relaxed/simple;
	bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoT6QX0aNZMlwJUJbMz2zvsrEawoXu5rA3Wu5kUNxQ5qEpeYg7OQzN41wo3EOQdWcuXEm7lM5SFj3Cvb+myxezWaDZl7npaQtxT391+8JMqRzpv3Iu3i3+dVynAb2jJ1GURHnk5tq8mJFaMupEpY+qyRBn/R1DPK033jwL+oiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrYA+ci+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrYA+ci+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so496193a12.3
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681894; x=1787286694; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=HrYA+ci+xh7VSEdqs3M6cpjS9h5JIGFuE6VTaPPt52a1z7TspIRYc5NI2wk6Xennd9
         HYy9EtdLFYBhE2ruqnV/t1sCgowIIX5OYKg89ZkIPKF6W+zoe102xQWnsvJaIJbbcRqi
         21nkjXGHT1sB/wSYLHcTIv1hjUINP9UvZLqCjO4rv3HRTbGQg14UFbjKNPGAkMZ6Z8u6
         amg6XdcqRPihbBMWTPUTrTkxdyBrK4RXoqRLyOQp2ej+CWsw/w/DR6rQFJ87GpynSAeP
         fgOVOxscbVD+WBHYxwxi5Tg+79K3Q9QLTN8jUArk/v8yD99G3+IKdjSsG/YSri5HzFuV
         ilPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681894; x=1787286694;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=fbPOMQFCZNBJY8gG8FYbuL8rO8xw2EDkgbm9IrsJmaD0zhrPc6bd9P1WIlvYIsU7bN
         yhIEKs8xzlKLHqFKY2+805NxgeHXhwVtErbfCIiaFCuh/pB/2eIdPh08/n5FypHYHffZ
         4RLZQWX+O5o6m7gOYYXs3XxRIlWX0S49SBT6WBvIgPhriNpUWkqQWpvVzq9jnYILlDOt
         aeq0FsZopfF23vrtYe9cgHCcG/lbc6r6fTo23IMBSN8oce12DCLJfvhnRQwtkoCoAgBp
         XjdCy82j/RYwcHsuBX03eXUaBr/ca5w2ydEdiji6iSZ9uK4ewdvZSIcQzkq1fsqgZ1Tx
         iB1w==
X-Forwarded-Encrypted: i=1; AHgh+RpSbZxCupjVpj6kyD58GO54a6FTUnI+wHmZIj2xyE0Uz1C+JWjUinbNhV0JnEEsD0d4qvz4MoqzqR4bi0tafg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQXhJmov9pltVIVce2HGjuFqvZGijyvgOYtZe/Ys4R6rjGmlY7
	8YZ1c0H+ok80FG+qb8fkiF6EqOFtrZOSMVHrhB53kdedPGgHzmDVsDyW
X-Gm-Gg: AR+sD11c7UlzA1T1JKabZP47K0YoRPBgNBecXQy1NCwboTMDj3TC9YOVFaAP5uxc3kU
	/MZ+FV6fYOp7XOtNxL1NcyqIP3ScnbWHD3rtfVnSWXQC6grvfPQK04NFTb5twcvJBKXGuGCkMhz
	QbvX28lnIivhdjNHviQrYjpQ0grkfXzxw5QRTR3SpUZ5yD5G4moa5HfUQL+RgpWEvD4WiiTUX8e
	QwWo0I/h35A76QjrIpwMfEVwZedgblFJwYfudd/LNuHtVG/HaCAAJoLkix4uggoUEJVQIRF0c52
	yDqVgvWFX2AOGoCt1cvpi/Iwn20s0BcH0VUWElu6noy0ppJ8MZqUJFlXAJ6kwd1rbdMBr8ew4+w
	vJWbKxyheUbWe3LM3k5lUkiracZvfriK1RDuaBP9GP5aJrCM3x7QODVzkhKfS2Uhh372GrBrHdo
	qO0VdeRL63Ko/mWbdDjfBuLRIYaZVTnBTK1MCu7+tp9bZVTb3qf/2GGLp/yleClO0=
X-Received: by 2002:a05:6a20:4321:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3cc71a2974cmr3124821637.10.1786681893513;
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889d914sm4450683c88.13.2026.08.13.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 12:31:21 +0800
Message-Id: <20260814043121.59610-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
 <an2RzeZ2zI8mWFRM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Do we need a Fixes tag here?

I overlooked the Fixes tag. Thanks for pointing that out. I will add:

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")

> Do we need to do the same in vhost-net too?

Yes, vhost-net has the same IOTLB lifecycle issue. I previously posted a
separate patch for vhost-net:

https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

I will update that patch in the next version to use the common IOTLB
teardown handling for the ACCESS_PLATFORM transition, while retaining
the vhost-net-specific checks for IN_ORDER and other unsafe feature
changes.

Thanks,
Jia
