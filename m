Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAA224B02
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492596; cv=none; b=t5QejfGRoAG/khw/5H23Szo3qM5RaLySwHQfs2kxvXB7O1Xh8jkPCv09BK3ssGwHaBiVa3KiyDVIgsbHrFjP12yR591+NrOV+Jq0Y+7+mWk8RgOQTAuYvphLaPafFBFPD8cfu6Qx9TpW/lelmz9bEpUk3wDEiLHSNUuQpoOolB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492596; c=relaxed/simple;
	bh=OnEK4+ktkuTBVd4LCgvO2/u1sSZlYN0t7X50RZpIPls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CaKQ1p5GLc29E8/mY/RM86ykbZZa2SvuwFcYTX82KAPzYecCh5n0ln8FBUJQzbxryLxFNTqkdUEjeCDQ8+/P3WA+tYQSX3HwsgRxMf1r3GVmrjuGe9EAYsIkjaS4HpbXQ/U7oTaep2Kmd2YUTkQnaM3CpwljUyoWTGHmBZ7TmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqUlq72/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqUlq72/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745492594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
	b=OqUlq72/cnUazuGjA5/AyJxgUHDrGr7gB8aizfTto6uoUVylNRokKp8es3Le0AJGBYOyak
	veQOMSDCLwSZuMeUzY3DkdGrIN05bxBT4XymdK7tz84Qyx5dbiKRCuVU4zGX/w9rQbvDyY
	tqMHzr/0ocDOkA50xovEqJZAiOhHHbg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-wtfelHeLPTuE3AkYbVZPxQ-1; Thu, 24 Apr 2025 07:03:10 -0400
X-MC-Unique: wtfelHeLPTuE3AkYbVZPxQ-1
X-Mimecast-MFC-AGG-ID: wtfelHeLPTuE3AkYbVZPxQ_1745492589
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so3577335e9.2
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 04:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492589; x=1746097389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB+hDp/hkN/T5Zk53qLd2kwTdWBUeriKnar6WFmgAY8=;
        b=tV9h3hUTuWfDFrz4iCnP4TaISZAW11qqMesN8V4hsENMXXGgFzrw9icncF1qzYasQC
         u/3/uU8gOmn615p/akSPnKDPdPUFud/lL1RKqyEiSSmHh8xMzJZ0mm+J6PkG4uWjrFcM
         YsfyQOwNxvYN7/kXkx0Wh+rg9m7s10BFIHvHC8y1HEPp6I6t36vz9wLpdm+TJfEE9PpY
         MXCudk6B+voOj1XuE/GMJXItxjyjwYArtpzUV6qV+FpgTytBMA+r3fqIKionQ8jJQLvG
         XyClkyco4sBZ8/bASFGx5P/B9l0dcsqgET2tGBEE1WRP2/0M5/msHdy3Tv/9TNFmiV7H
         QDBA==
X-Gm-Message-State: AOJu0Yw0ycIIUrsPGVyPRTSSE1DYnzY6lzq2UB4oRUi2ap7b3wlV7rTM
	r5FeOQ6jCiy0sFqgGiHrLb2YAsQCn4VUc3eQF78xpi8QJordg6gkMkjZwi0MdihNs21IH5EjNML
	MGqmV9Qodsgg3TdziubLd9ToEA47YRlx97KR6IIl819HKj3vUlUj7t1/Co2JYpu5t
X-Gm-Gg: ASbGncuFaQOYI+nZeDcxrk0OqNLFb2V8zlcabllnNzj0fNGVAI+EHkPmyCSyn+6Snna
	R9L+5ZNiUwFLC3N6Y/HKycaNcDIcMjXResVj3YETyPTGWlVrwA7ivSlCmGOVw2IZ2PcI8vr/KQd
	0/ZwBRmdxsnck1uY2+Eq9XnNKP9px86Ym+omfd56eOtUXbVFnR6+e87AbW8LdcTxIbC0/Khp89w
	4DQorv0+Aq1qjt/VOL1DJ1wi3kSFInx5PGeyiJScGdd+Tq8Gbdf2hn2hFK7bs3XpKu63X9fLQlu
	9S+3nA==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048855e9.25.1745492589462;
        Thu, 24 Apr 2025 04:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtu0yCr7M7AP7EC3ZZSx9xsMrsn304Zj6V6BYFUjfak8chlhsmlR6+Poqw3gaQbMFvkrartg==
X-Received: by 2002:a05:600c:3516:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-4409bda6055mr16048345e9.25.1745492588928;
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d839711sm57806515e9.0.2025.04.24.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:03:08 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:03:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250424070300-mutt-send-email-mst@kernel.org>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uKqCqgvPPwxIuEYfXyeTvzQfKJN9NhUwhskTmhHHBB0_1745492589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2025 at 05:47:13PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Version 5 changes:
> - Refactor the selftest
> 
> Version 4 changes:
> - Add force zerocopy mode to xdp_helper
> - Make virtio_net selftest use force zerocopy mode
> - Move virtio_net selftest to drivers/net/hw
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add flag to force zerocopy mode in xdp_helper
>   selftests: net: add a virtio_net deadlock selftest
> 
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     | 19 +++++-
>  7 files changed, 90 insertions(+), 6 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)
> 
> -- 
> 2.43.0

