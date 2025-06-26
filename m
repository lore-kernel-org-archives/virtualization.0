Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949F38FB9
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914155; cv=none; b=MnAaKswaZahG8ztqjn5eFiYZZfsmHkQuKUiwgRXuDju+l43yxM+mKBd9kev5vSviyleZJK6NhNNfKe6fNg4R07ilJwErp7HKFM3SUImFti8vbaZngy5UOo1GegFzxuo3XTxUg0BU++WSKN6KCTytFEhUtQQK8CYlN3LCKFzD9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914155; c=relaxed/simple;
	bh=NH4j2FqqJw6bDqDteI6k4MIVpp4cPtz23hroizXPlvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCbe2tKSE5DQevg3LzqdhKAdfBLVtesSnEjcO7dSLHBPTPp4kXbEW+daNke1RDVx7xVRzANHBpLwz5kgoD+HSFe5KCzG92MCpLVZpBd6FpTZ1qWxQ8pL4bOH2xdK1mKr2WmjOVcm6aM1UA87Ay9oRMOqcr80vNMqDRYFI11beYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjF4beN9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjF4beN9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747fc7506d4so672305b3a.0
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 22:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750914153; x=1751518953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAbqyCTcegVpKrpjqoB86gZ0JnTtn6KDYt9zM32bdZE=;
        b=kjF4beN9dkmk2dgxo453cTFWi9vMLc5Spb9sdtfdx3eiNCMe8NWjm2NCsSmvmNDeUi
         NQ/R+B0oZHcdI4JNInzmW9GOOhrXuEwyorBEO/UmQOMOkYG6yRi38yegyfDYHF8H8y0+
         8VvR7uaIrP8G5oKo1Q3IOkgbwKdiWOOgJ43jKZU36BmNZEx0S3/FmF2UpplzZOgGXzKQ
         my7Gaw07VN9MXlLwJ1Z2VbNXePUCA0kxEMDsm+RRQruhZRCAICMi0GlosQmzQRKnkJVO
         hc3EF2S4ioal2o1r1dnTcD2eLGyNmACcf3KwEklM/RgqBKzWljWCn35KIPezwV2pFZUW
         lwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750914153; x=1751518953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAbqyCTcegVpKrpjqoB86gZ0JnTtn6KDYt9zM32bdZE=;
        b=gLYwADLhvWR8r5BIyNFI5NzxHfoqvTtWKcQQ7fd+utwI5ldftbiZh/+/F4VyIrxE7x
         DkwfmXtrX10fW1MXxfRcnRUNFkhSgtABE35/SGoymyM5hnjxTBY8kkbab9/NwvcJ6rmJ
         kT+4R7t5zSYDxLNmbKDfQ5Una+blG8rbk5CELTcR7vCgY4EvUTRBCjaDf6F0VGoM4t3Y
         HHwOHgKO1ddqUyETeZ3u+nm99T9ASCLud15l7Bjg9pBQZtaG7P8KdQXPiiIzyhY9TbQt
         tbtVXOeaaXVMQ22Xpi0I8RW4eiyXIeqgLTGTxCbfxhytK5MXpRd2OfKqtdGzY32yn1Rd
         9LRw==
X-Forwarded-Encrypted: i=1; AJvYcCXm9bAY0rAysw/LfW38dVC1sfdZH7KDEpRE2Yig71jQkxSRPnu8pqu/95DsZJG2mjUGDfXCmKv4x8mykr/mqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0Vv8i/aRfwkAu+2XAhXYa/lWy497/+37LmBVzLXgp/MaB8ZcG
	4SPnwEK7thpYFixMghC5zZ2lqqdFpbIT52kziT5Uu5ccKMQLOrKFGVmv
X-Gm-Gg: ASbGncsBdw0W5uS5ypqhehvsVsWCGj+gZDtlknkHRAEG2AkbWC46KbMerBw9at4CG/T
	5CC9TWZ0WYSzVDJIG3h5/AnqYjv+8vc0NXkw/J5Y20Uka0gC653iQCoJEP1cAs8hnvjzPDyIV7Y
	0K5E9Xq3Z6nyp5noZobbfEA4rZMyEF3QETkRBSwd/q8qqx7dLRQXBoTAxU21HKeNwpcA5zPPkL+
	KEiSm7bofoj75HSCbSXdLoK9Bilc9An3FnBunVPEJjGSYabpPStug3Ai0fhHQBfIxEUaG/HUDQ9
	9Ccxne7ymZEJGJzQ7xHRVv4/KxC/zkpSi7AzNzThi9KcS+MfkkczX/kdEZeq+DcBCkia5ULFGaM
	Z5pRxwYQB
X-Google-Smtp-Source: AGHT+IGX8J1VxZS2sFcA0G08BiW/FQ1pEDJzIhrYph3nSUl3wWFtXA7FYdmCcKqPVRcKXEU4f7ucWw==
X-Received: by 2002:a05:6300:4041:b0:220:3ab2:b50e with SMTP id adf61e73a8af0-2207f154d7cmr9460458637.6.1750914152614;
        Wed, 25 Jun 2025 22:02:32 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e211d1sm5842808b3a.44.2025.06.25.22.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 22:02:32 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	decui@microsoft.com,
	fupan.lfp@antgroup.com,
	haiyangz@microsoft.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	kys@microsoft.com,
	leonardi@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	wei.liu@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Date: Thu, 26 Jun 2025 13:02:19 +0800
Message-Id: <20250626050219.1847316-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
References: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, Jun 25, 2025 at 08:03:00AM +0000, Dexuan Cui wrote:
> >> From: Stefano Garzarella <sgarzare@redhat.com>
> >> Sent: Tuesday, June 17, 2025 7:39 AM
> >>  ...
> >> Now looks better to me, I just checked transports: vmci and virtio/vhost
> >> returns what we want, but for hyperv we have:
> >>
> >> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> >> 	{
> >> 		struct hvsock *hvs = vsk->trans;
> >> 		s64 ret;
> >>
> >> 		if (hvs->recv_data_len > 0)
> >> 			return 1;
> >>
> >> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
> >
> >Sorry for the late response!  This is the complete code of the function:
> >
> >static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> >{
> >        struct hvsock *hvs = vsk->trans;
> >        s64 ret;
> >
> >        if (hvs->recv_data_len > 0)
> >                return 1;
> >
> >        switch (hvs_channel_readable_payload(hvs->chan)) {
> >        case 1:
> >                ret = 1;
> >                break;
> >        case 0:
> >                vsk->peer_shutdown |= SEND_SHUTDOWN;
> >                ret = 0;
> >                break;
> >        default: /* -1 */
> >                ret = 0;
> >                break;
> >        }
> >
> >        return ret;
> >}
> >
> >If (hvs->recv_data_len > 0), I think we can return hvs->recv_data_len here.
> >
> >If hvs->recv_data_len is 0, and hvs_channel_readable_payload(hvs->chan)
> >returns 1, we should not return hvs->recv_data_len (which is 0 here), 
> >and it's
> >not very easy to find how many bytes of payload in total is available right now:
> >each host-to-guest "packet" in the VMBus channel ringbuffer has a header
> >(which is not part of the payload data) and a trailing padding field, and we
> >would have to iterate on all the "packets" (or at least the next
> >"packet"?) to find the exact bytes of pending payload. Please see
> >hvs_stream_dequeue() for details.
> >
> >Ideally hvs_stream_has_data() should return the exact length of pending
> >readable payload, but when the hv_sock code was written in 2017,
> >vsock_stream_has_data() -> ... -> hvs_stream_has_data() basically only needs
> >to know whether there is any data or not, i.e. it's kind of a boolean variable, so
> >hvs_stream_has_data() was written to return 1 or 0 for simplicity. :-)
> 
> Yeah, I see, thanks for the details! :-)
> 
> >
> >I can post the patch below (not tested yet) to fix hvs_stream_has_data() by
> >returning the payload length of the next single "packet".  Does it look good
> >to you?
> 
> Yep, LGTM! Can be a best effort IMO.
> 
> Maybe when you have it tested, post it here as proper patch, and Xuewei 
> can include it in the next version of this series (of course with you as 
> author, etc.). In this way will be easy to test/merge, since they are 
> related.
> 
> @Xuewei @Dexuan Is it okay for you?

Yeah, sounds good to me!

Thanks,
Xuewei

> Thanks,
> Stefano
> 
> >
> >--- a/net/vmw_vsock/hyperv_transport.c
> >+++ b/net/vmw_vsock/hyperv_transport.c
> >@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> > static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> > {
> >        struct hvsock *hvs = vsk->trans;
> >+       bool need_refill = !hvs->recv_desc;
> >        s64 ret;
> >
> >        if (hvs->recv_data_len > 0)
> >-               return 1;
> >+               return hvs->recv_data_len;
> >
> >        switch (hvs_channel_readable_payload(hvs->chan)) {
> >        case 1:
> >-               ret = 1;
> >-               break;
> >+               if (!need_refill)
> >+                       return -EIO;
> >+
> >+               hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> >+               if (!hvs->recv_desc)
> >+                       return -ENOBUFS;
> >+
> >+               ret = hvs_update_recv_data(hvs);
> >+               if (ret)
> >+                       return ret;
> >+               return hvs->recv_data_len;
> >        case 0:
> >                vsk->peer_shutdown |= SEND_SHUTDOWN;
> >                ret = 0;
> >
> >Thanks,
> >Dexuan
