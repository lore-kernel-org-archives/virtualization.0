Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345AB32FA14
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049293; cv=none; b=i527M4+rLmAwyKFUIV7O2iSazqMqz879d4TPFSyotJfwUtNwqe8cUvnEdfg8+9sMvSbMlqfhIARUvNlwbDrQon9ozlddc+cclWN0u7A+7xJLx/pwwuv1Yj7dyb/oOORoe+z8q/anfqJcMkHgtvnIPX/lrq2tA95n9sqyjZ8GTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049293; c=relaxed/simple;
	bh=OBug7yiFsFF6n1aW8KPArHWd9Qc43lse5OYmR0uVPM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lG1k+WXORUJcuhiFcroBIJF8xo0sm56mL7J+r4AKB6CWN1F2XHiqC0qBzCxs+qhSNp32ynD/zMQsFP4kmEUufqZCSOV4prOo+X8l8Ob0a88Q1WkcrweEnObim2ihW7LjoyORLHhao5AcpO5sS4w1uNg54nmTH11WvWGsDXQ/NOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MD8f1rwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD8f1rwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXqEGFcpHGxpgB5BTy87mhAk/a/akgsWpH/Fvq9SeUA=;
	b=MD8f1rwnDkJIuP4whzt+G3CZ15UcXo4ayzwnkPap86FmmgSEwP9IfSBSz+Dq2rNad1H08z
	lHpKAqPXVkLwQjXi0CGK/8OgfFw3oyZ62NouPIjc7niUduwbpioKH2RSkFJAtMtc2OIZoK
	ZPACNTOfstmTPmve5DLyih3AZFDZokc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-sp5jDq_gN9-6zMvtpdqpfQ-1; Thu, 18 Dec 2025 04:14:44 -0500
X-MC-Unique: sp5jDq_gN9-6zMvtpdqpfQ-1
X-Mimecast-MFC-AGG-ID: sp5jDq_gN9-6zMvtpdqpfQ_1766049283
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b800ee1a176so53057966b.1
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 01:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049283; x=1766654083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXqEGFcpHGxpgB5BTy87mhAk/a/akgsWpH/Fvq9SeUA=;
        b=kerI1t59HmPI5CEWa868zpd4eaqnMZXfVfD+mwdREuFWRW1yqqaLg9WNd29X1PbP2k
         um7/Fhhn8JgtdGtIk8SulmbE41zjnlP9o0YNq9DAdrw8WJiL1aGrYTeD7HnJgF0iQOIu
         Gx60KrUGNAuvlVcI8Ii7WT8DcYfqo90wYOeXh9nvPuWBBbekfeYFfaFbT/yiPFj2A1iZ
         DlH+SWd58QCeMGRVP94t/RBabE1QA3Gcq+3WwrHM1OlN7qLK8dDNFt62z+1W8rmnVreO
         yw4Z1CTbUVGC0UbUjYpcbUDkdJlvx9WTBDyXlWKUKjeaRFyme7vFbf0U7RDQY4lmBnTZ
         sGtg==
X-Forwarded-Encrypted: i=1; AJvYcCV+qyJbIOjdV0RkDy/VdFZdRpiX7rxdo93Xj1D9GUu7jO8AzKOXZgPdCf7LxNODv2dVLOGk6FecFO7kawnWVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5Lo3OZq2/67jv9A7aek25SYI9HY4RaA8275X4jCEjek/UIfT4
	724mE06ef0pnaZw5rM80BBayp2oFE7QmQy4FS0r/qDjdwJrFOLtv+jlDSQWZN9cpmMpYveP9PLu
	s4S+TUj6YuVrp7289LZUE1xXVpUL2uQbmtj2PXKVtYA2jCClzQUB92bUoCEtROuUo3cqJ
X-Gm-Gg: AY/fxX4eLxw6FWP5IpGVtrxZUUUz8fSksFNsj3zhK2eoMVS1Ih9JKwGLQFxrBzEcT+Z
	HWsbCITt98h4iZP69X3UHYVre+ThtCdSyGEMjoI7ImY2XrYO3YPsaA6yZ0uWyiZ9AgWjN1Gmco4
	Klnjz59kydj6DT4of62jsDthQ7IDGPBA1mK8xkSr+MaC0CbJvsfd9BVWetOJQknOB1hOMMubeiR
	lTmZRCUMT0msEx+ijDOv+R7ADidzhKjoLq6VN70t9vzNkIhHd3huFEinHUQ1IMC4NB4hHwnCPJi
	JsfPhqXNvfhsWHLC40n4zP8SJ+6DbDPnDotd2fHwnhlUJ3lCNKe0tc6QXFO0d7D8F86M49LJSnM
	3pqO5ydXQwaXFXxM=
X-Received: by 2002:a17:907:3f1a:b0:b73:7d96:5c97 with SMTP id a640c23a62f3a-b7d23c19b99mr2120356466b.34.1766049283475;
        Thu, 18 Dec 2025 01:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCcnT3/k3O13h2XJKclpGQV7xCUe86HYVyLKx9bzOqHgpuxUTtkhw6t1OXOATKEcDYxaHB4A==
X-Received: by 2002:a17:907:3f1a:b0:b73:7d96:5c97 with SMTP id a640c23a62f3a-b7d23c19b99mr2120353666b.34.1766049282887;
        Thu, 18 Dec 2025 01:14:42 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b802351fa2esm170144466b.71.2025.12.18.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:14:42 -0800 (PST)
Date: Thu, 18 Dec 2025 10:14:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 3/4] vsock/test: fix seqpacket message bounds test
Message-ID: <dt6tg3ehtz55kej2d27youm2naqjnaieczop7pzodry4lp75yi@nv5ujnxxj5oj>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-4-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217181206.3681159-4-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LFiWQIfYn9UrqsLR3-3NWPAzZRrBVulOh1fjuRKZcs4_1766049283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 17, 2025 at 07:12:05PM +0100, Melbin K Mathew wrote:

I honestly don't understand why you changed the author of this patch.
Why not just including the one I sent to you here:
https://lore.kernel.org/netdev/CAGxU2F6TMP7tOo=DONL9CJUW921NXyx9T65y_Ai5pbzh1LAQaA@mail.gmail.com/

If there is any issue, I can send it separately.

Stefano

>The test requires the sender (client) to send all messages before waking
>up the receiver (server).
>
>Since virtio-vsock had a bug and did not respect the size of the TX
>buffer, this test worked, but now that we have fixed the bug, it hangs
>because the sender fills the TX buffer before waking up the receiver.
>
>Set the buffer size in the sender (client) as well, as we already do for
>the receiver (server).
>
>Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9e1250790f33..0e8e173dfbdc 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> {
>+	unsigned long long sock_buf_size;
> 	unsigned long curr_hash;
> 	size_t max_msg_size;
> 	int page_size;
>@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	sock_buf_size = SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+				sock_buf_size,
>+				"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+				sock_buf_size,
>+				"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
> 	/* Wait, until receiver sets buffer size. */
> 	control_expectln("SRVREADY");
>
>-- 
>2.34.1
>

