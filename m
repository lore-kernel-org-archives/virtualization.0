Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACB1A5B92
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711010; cv=none; b=PlrV5UDpDQfloU6f50RSJVhgUSmjew8OBYq6WTPJ9WDIcd/zaGxJxrF/mliIBF2flgdQwjGqeTEOIq47o0888cPXW/bldoL2Mc6cCLMYxfOnTYXJe9/zc1JGn5ztIthdfT2o1OMxcj5GIiXpg8Q0vvxPxjkyjtA6QhhJM04Je/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711010; c=relaxed/simple;
	bh=08PF/lUsOyzjSZ16g6xMGKxp92gOt1shxG7B2bPWqkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7XHD0Ll42vWNqdlGZgpyJi+AKhz0s2ldaIzlQbjSKS5e6uFvUUNb69gRO+5sJ46wquVLyNcpwq8J2EYVcVz3KD+4rc5ni5ukaXL2FfhUMHaL6eg2ixazdWaWt8UiEhphe+I/kINSOFkpF2+X4atMQyo0yfUDJghIY4kos/CcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlYzkLti; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlYzkLti"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso602403a12.2
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711008; x=1750315808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAhUfbavJ/U3RSjlWfBGk3Y1ELwSnt4DpMvXPbLBnqQ=;
        b=PlYzkLtiOYE90ERerRhOkh7eXqGw6f0TJOQp9Ess5uhcPwmJEDL2N5AmDSZO2v0BnG
         n/H3uwcVa6jzAvxtX7axNegCWum47uN6iiOIlKDxphA31pt/CpfEAW5z+GSRh9GBBAH8
         DTVC6IBSr1CkFY5F+U6m4KXG6vYutA39P31TDQiM0M3VMPsmK+QMgbHUe67jxpdkLKi6
         3fVcam8hTwyTnPtCfm62g87fmrBe/pEBg/izekAohp2OGzmuXZs33jKf9+eXGXX7U8eJ
         JAXCQ/H3WajkKlfEKhMiYAUsiuEd7pND67sp3DySgLlxh9SgYMrGJ7oy0gdeyQB0haMI
         2m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711008; x=1750315808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAhUfbavJ/U3RSjlWfBGk3Y1ELwSnt4DpMvXPbLBnqQ=;
        b=oDxV4cezSbPYRYWxc7y8hqfnAUxTfEws2eyGloDGClANoAH9Ea7Epg2vor6gmLtlbi
         KQl/jRcSE9yQmLtWeP0ltHGn98fFYdT/4PQGAqsk49OrDvZMRZP5NVps/wGAk+kfX7Ps
         y507QlFzr5JOaIgVqzMjnqJXsrkwdVTdFgrkOiUH12jgfAAXDUS7SwnJ3l/2g9mGAAGe
         BNVl5iydlPDo60Ut6sIaJvods1VpsTpiUYbMv2RAEu+g/Mmt1v38+/yUW+vH+NP0Uwgs
         CLsYwpa3DnpbnMa1kL3DrnxDTIpDaUzhEXQfb42cFUKFKZpoS9fXm5LRHj6cbBypojqa
         tQmA==
X-Forwarded-Encrypted: i=1; AJvYcCWqysh8oO0pNz8r5IW/0lfxMGqdbRjsoBlCyKq8oF00Fnx1Oavc8jAvurqL2142WSUrMkEgzX4wwAzAawGtZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4Djmi6rtA2piZ5GHqL/PapktuJoQcpjfcXpvrhvwWFJBKxtFy
	PEJ1oiTs+TvwrIeON/pXUREydhEtjcfq/3omwuzrX5k8RZPI8J802TDU
X-Gm-Gg: ASbGncuK9jSEjXyt2VanR/I/FN/ubjYe/lKorrlTqHXsK6LqM7u7e6pMquRMvn327qs
	RHgPvcm2F2hhSLvw6xwcY24+Ow3lXT9olpK9erjzCB+Xg1VcbDSrz6oEOlwU+BY9IpZb3UEkK4t
	xjT8sGoHM4RF7Sc5e4m9gz6DGi0EJW1eeZ+yYVYkuPToNouzHVyFH43IVG1KCm+kL4ichVekkhU
	88qQGCacOSVeFxN/kre0YMZRWain0fNq6h+wB56nOOBoO6fEH13+kD8n2uePbCQICCpZO3is9Jz
	zTpQU1t/otzmn6t43Azy6eic363iScUxdphmOnR6/cy78qvpAyIB1IwkYSruhPSG42bK+Ljwcts
	GtD08KVIE
X-Google-Smtp-Source: AGHT+IGZ04n2ntr6M6gKmnZGuVgjfZIdYUzO7jRwZ6WSZQWmXFnMB4eiJ3OYjNtknt2vP06p1Txifg==
X-Received: by 2002:a05:6a21:3994:b0:215:e60b:3bc7 with SMTP id adf61e73a8af0-21f9786f9damr4116995637.26.1749711007658;
        Wed, 11 Jun 2025 23:50:07 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd613fee4sm675601a12.26.2025.06.11.23.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:50:07 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: mst@redhat.com
Cc: Oxffffaa@gmail.com,
	avkrasnov@salutedevices.com,
	davem@davemloft.net,
	edumazet@google.com,
	eperezma@redhat.com,
	horms@kernel.org,
	jasowang@redhat.com,
	kuba@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
Date: Thu, 12 Jun 2025 14:49:57 +0800
Message-Id: <20250612064957.978503-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612023334-mutt-send-email-mst@kernel.org>
References: <20250612023334-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > No comments since last month.
> > 
> > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > patch. Could I get more eyes on this one?
> > 
> > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > 
> > Thanks,
> > Xuewei
> 
> it's been in net for two weeks now, no?

Umm sorry, I didn't check the date carefully, because there are several
ongoing patches. Next time I'll check it carefully. Sorry again.

It looks like no one is paying attention to this patch. I am requesting
someone interested in vsock to review this. I'd appreciate that!

Thanks,
Xuewei
