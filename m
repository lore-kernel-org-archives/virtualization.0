Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCE21744A
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435034; cv=none; b=S1hm+N1lR2L/V5RVUtP2Zgq3+FtyImE566LOJtGqXufXey37z/nq7u41vjYNuMeD68Q/wJjzgIbLxlVCYULg/rCA7GbwYx9KETKUtXl/HIGt7eUYHeLSG/r/5glba8t1SwqpEb0rifOM334Ums1oHTsIv5M00Zr0xlbv2U7qFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435034; c=relaxed/simple;
	bh=U3/I+P/PE+eG7brE4N+kfK95FsISeERGixMLe9GatDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g9W3BKeMWw/nVx2uSmXib7hbQdxsnPo0HH5Inq/2XBjtR2g0suOodlsTB6m2kHEBl1gThNjhExeAqtJu0umiRB4UykqVEgY9TAt+ifUT2jhG6CDktH4kJh5rXaPuNOgki3AZc2cyhW5AgoRIneyKgHCMuWtVrHpfxJwncbC0HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl0vogcq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl0vogcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
	b=Cl0vogcqTpiAUges7KkqttACc+aqCS1cmMKn3vv1ogl6ldFHq4yw6eRxy71yAlsocrV7bb
	gie3sAXB2w7h78DnG8gS2+XZdvDxFC4THgO9OcqI2spYT5Haz73sFrhXwtQbgSg4KCrXmD
	atTY6bhZ2K+fwRtzqiJxGKRuf+Iy4Mo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-cYdBb93kMUGI2QZX2WyzOA-1; Tue, 12 Nov 2024 13:10:30 -0500
X-MC-Unique: cYdBb93kMUGI2QZX2WyzOA-1
X-Mimecast-MFC-AGG-ID: cYdBb93kMUGI2QZX2WyzOA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460ba83c83fso97501321cf.2
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435030; x=1732039830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
        b=r0sl+6Pp9vS7GXxXz6pRQwqHhX/ZxHxQdfLUN+cY6OPDj8HNqBnOTMZDLfPYs9SrMA
         /6nWfmc0TrBRp5v0AqVlLXAaRm3zShdB/fIt+1+3M91zsOuEO0+qcE2A5IA5dWECE9JA
         jaevIcTt0gXc/KHpCUDDvRV1FAtofjCxCVaE0JnstTDi59kRl7RzEssWQFS6MNdQq68O
         dfElK2BcYNc9toaMLEWAO1/RQKzn/OU2gGSz+jQtqF46PfgQGB2/3ClN/1Un+1HNN0eu
         fR0UPCI8gMzRHI3Gr2/WKlISpbXpI6NkORgj59vMXem7YkKPAe8SSyBWt2t1SoT7jJ5t
         IzYA==
X-Gm-Message-State: AOJu0Ywkd1cQRC4xjnC47NEPnKKfsVwlNDXsR08yEd/lmn75/NfQ62xS
	OG9Sm1h2bE+qKDx+WPX5UZz/I4ngV2nmuBfivEigQcOdTJ8HEUx7RPaTbkZ7B955iUoF/Y6vimo
	UBT+5nBMzLNr6E4II4QZo7ZAuf/54IumuUVupuD+cPPm59+00YndiYXvpwqtdQemc
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369571cf.15.1731435030244;
        Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2Qp7c2NiUDCWdk07hfTKmombDRkdlfJtECCErL4H/pgBQu/FzPw04LHhOd38aCVokx1KvdA==
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369061cf.15.1731435029722;
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff41d949sm77813861cf.25.2024.11.12.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Date: Tue, 12 Nov 2024 19:10:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/3] vsock/test: verify socket options after setting
 them
Message-ID: <jjplqknxiasru7oukfrz66eryfhtviukwchxkh4yq6woj3m7qw@augnv6adwrgc>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-4-kshk@linux.ibm.com>
 <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
 <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LX0aZioZs-xTz8zSfRTjs-G6xLKzhIv8ABrw2vjTOqk_1731435030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 12, 2024 at 09:18:48AM -0600, Konstantin Shkolnyy wrote:
>On 11/12/2024 02:58, Stefano Garzarella wrote:
>>On Thu, Nov 07, 2024 at 07:17:26PM -0600, Konstantin Shkolnyy wrote:
>>>Replace setsockopt() calls with calls to functions that follow
>>>setsockopt() with getsockopt() and check that the returned value and its
>>>size are the same as have been set.
>>>
>>>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>>---
>>>tools/testing/vsock/Makefile              |   8 +-
>>>tools/testing/vsock/control.c             |   8 +-
>>>tools/testing/vsock/msg_zerocopy_common.c |   8 +-
>>>tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
>>>tools/testing/vsock/util_socket.h         |  19 +++
>>>tools/testing/vsock/vsock_perf.c          |  24 ++--
>>>tools/testing/vsock/vsock_test.c          |  40 +++---
>>>7 files changed, 208 insertions(+), 48 deletions(-)
>>>create mode 100644 tools/testing/vsock/util_socket.c
>>>create mode 100644 tools/testing/vsock/util_socket.h
>>>
>>>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>>index 6e0b4e95e230..1ec0b3a67aa4 100644
>>>--- a/tools/testing/vsock/Makefile
>>>+++ b/tools/testing/vsock/Makefile
>>>@@ -1,12 +1,12 @@
>>># SPDX-License-Identifier: GPL-2.0-only
>>>all: test vsock_perf
>>>test: vsock_test vsock_diag_test vsock_uring_test
>>>-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o
>>>-vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>>-vsock_perf: vsock_perf.o msg_zerocopy_common.o
>>>+vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o util_socket.o
>>>+vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o 
>>>util_socket.o
>>>+vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o
>>
>>I would add the new functions to check setsockopt in util.c
>>
>>vsock_perf is more of a tool to measure performance than a test, so
>>we can avoid calling these checks there, tests should cover all
>>cases regardless of vsock_perf.
>
>The problem is that vsock_perf calls enable_so_zerocopy() which has to
>call the new setsockopt_int_check() because it's also called by 
>vsock_test. Do you prefer to give vsock_perf its own version of
>enable_so_zerocopy() which doesn't call setsockopt_int_check()?
>

Yeah, maybe we can move the old enable_so_zerocopy() in vsock_perf.c
and implement another enable_so_zerocopy() in util.c for the tests.

Thanks,
Stefano

