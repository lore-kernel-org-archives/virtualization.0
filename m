Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CC22A814
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792870; cv=none; b=LQN5RQHyzK+k+HUzM5yU1O8VHgDuWbd83DgLSux4EjXqRv+fp2Gi9JPv/RfIuPkgZzDLkE7ps0vOJSK/VzBS6l9a54LxHoaC4KY5IeS6UrBkuhudyrXQJ1eeuq4V2j9LNaSYBbKb5ILby3/n6FUK2V150dH4lV6wiRMY2ew1D7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792870; c=relaxed/simple;
	bh=rfD1WdfiPVKd5LCp0hGuro5Zqx3sYVINot3Bg53oUCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYIu7ZfJwOnAXj9tKcE4HWOG1PpoyOojf3x3AshRkilMqaDCnPXMM2Lb2VbtwjOLggBmDedKO+wUlznqoQF1sJq+/tmiklEhuxSoibB91ZA/kYeE1ih8gZiv2lMNuhWG9QM35OkqVxnbmlQE+/1xIxL0gC/kpBn8UY0RmQfE6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl3wDBOb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl3wDBOb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3108d54332eso212707a91.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792868; x=1748397668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n8xYtWpS3N+9P8jTX3q4mFWmzpvnHf8VvSlpwIoG/I=;
        b=Tl3wDBObWKxUYEn2RiPggfUpfnB0iP4JK5ccUX/AT92ayskqOEcelDUnJZhogR1kbs
         hsuphK4MyaFsC9NUoD940FB5BnTHicW43be4NXChdnmbI7iyb8p6ruOAy5BxfHtMYzLm
         05IYyY8fl/F/8qDaT3b/qC+v1Zltk9ap0tEZHbXZu0UodGKj+a88lRpeDmkHhJ5yrR+/
         j1l5Nl8e1hfuDQq2B0Ch298Y4Nu9Ta/rizO2IYbpe8xMAuUu113Gn8Mm7XBzGETuljWo
         1adqqBohnIG3G1yVXKnYhQZrlKZtppmh/MpoH1EwBBQDBT485Es9SxkdEiRtds2Tl9Ph
         Biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792868; x=1748397668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n8xYtWpS3N+9P8jTX3q4mFWmzpvnHf8VvSlpwIoG/I=;
        b=DMyAGMpmCCblRkZKmROp9S/oGeNjDxNbUTprp5SJpSZuZLFnXqNPG0JclPrSIGwHgP
         5Hr2hmN9ErKeAdlmxIIFCB5RugbzE2T7nh541JWY5pj1iROopgDd7saEfX1v/v7waxtO
         EudPV9IYwInMdEXJoPATmWin8hNEpvjSCdjDcq0Bmq+fR2IL8ZBNBAWGTonITcjOYDmh
         pk4+kntAg6320UqiusL6s635k1tNW/5ocz0OWTO1WD5tGlpm+TUlXaPrUHtjNK8LgNnh
         zMyHPyYEiDoqIPE8gx0Em9tXuISMU75ZGowyclCsQoAODfAwxwCzejzZVjE2a0GuW0wa
         miDw==
X-Forwarded-Encrypted: i=1; AJvYcCXRVF22JSSZ4F7gYRG8cZ5FZbwLNdlq9siMKbIiTW+CUIbIGShp48e5p1ar34UGlFCrpq7e0N+iXGQq7DIrYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySioZF9xRYTda0W5ePsLfqjF0+x/X20xCamzjNKxth/Q4CVERg
	K6+ZH2yle6Vn/LPOO0UlcgqyfcbcswDPPxjTJCd716fDaCvKHrl+4+oR
X-Gm-Gg: ASbGnctFR6AqqddAc8IMoTAnt1qFdHtuD9MgBbLbAMMzGN/QDYGw6kCF2N2EfCy5mb+
	LsmsfzYO63pgfSsuuhwNIcxIDTeDA2j+F3RhxesO2UKb5G3+utmLjHJhmwSyM4Gcu4FnmmcEiTr
	eoku+tiJJ/cBRa1SwcxiiS8IC5XALbQBBY7lDcLipfUfIOUm3goJvr7LqP/57AIL2/nq/odi4wM
	OR0tNVOxe1sTMHEW241tP1cp/qldfqerhBwIinZfXcZLruvNBHjfamA7yJ8jtu9370Ld5fqin8N
	GQC9PmzExyeC5GHAI+Z1vrl+CnnKLgCwYGSLXbwqAKlp62MgY5Hxo5ozOpgC3IvUUb2F/lIsUQ=
	=
X-Google-Smtp-Source: AGHT+IHWb+J1+0XyVk1FWW7GI32Fre4UxcrIQ+CYKT872G0qE9ugR2XJASnOtsJcO/JYKjhX6VIecQ==
X-Received: by 2002:a17:90b:51c1:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-30e830ebf21mr29331126a91.11.1747792867654;
        Tue, 20 May 2025 19:01:07 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36368e44sm2477647a91.1.2025.05.20.19.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:01:07 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Wed, 21 May 2025 10:00:41 +0800
Message-Id: <20250521020041.3215959-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <27pwterjsrrvgzcdwgkrfkthbqdaqptj6lj75gzfmhuouilexp@jg4t54gsnw2h>
References: <27pwterjsrrvgzcdwgkrfkthbqdaqptj6lj75gzfmhuouilexp@jg4t54gsnw2h>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, May 19, 2025 at 03:06:46PM +0800, Xuewei Niu wrote:
> >This patchset introduces SIOCINQ ioctl support for vsock, indicating the
> >number of unread bytes.
> 
> Thanks for this work, but please use net-next tree since this is a new 
> feature: 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev
> 
> Thanks,
> Stefano

Will do.

> >Similar to SIOCOUTQ ioctl, the information is transport-dependent. The
> >first patch introduces a new callback, unread_bytes, in vsock transport,
> >and adds ioctl support in AF_VSOCK.
> >
> >The second patch implements the SIOCINQ ioctl for all virtio-based transports.
> >
> >The last one adds two test cases to check the functionality. The changes
> >have been tested, and the results are as expected.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >
> >Xuewei Niu (3):
> >  vsock: Add support for SIOCINQ ioctl
> >  vsock/virtio: Add SIOCINQ support for all virtio based transports
> >  test/vsock: Add ioctl SIOCINQ tests
> >
> > drivers/vhost/vsock.c                   |   1 +
> > include/linux/virtio_vsock.h            |   2 +
> > include/net/af_vsock.h                  |   2 +
> > net/vmw_vsock/af_vsock.c                |  22 +++++
> > net/vmw_vsock/virtio_transport.c        |   1 +
> > net/vmw_vsock/virtio_transport_common.c |  17 ++++
> > net/vmw_vsock/vsock_loopback.c          |   1 +
> > tools/testing/vsock/vsock_test.c        | 102 ++++++++++++++++++++++++
> > 8 files changed, 148 insertions(+)
> >
> >-- 
> >2.34.1
> >
