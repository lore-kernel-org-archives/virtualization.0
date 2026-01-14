Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DF38B7B1
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385292; cv=none; b=WjyH434q2mETix+D9htXN/O55lSaDdamQz+Bb5QmI3P6VvSXOMfbh4W9Q020X10wwa23xybiYEaoGVwMYRH8L6iqR/jMrSZuMjTOdU6CpBg7+JaAuOMjtkrxKsp/XSP60auE2lSUOiDHVy0Xjfy/uxpah0D/dS0ku26CzbkWujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385292; c=relaxed/simple;
	bh=R34QuFzq0RM2B+MUSlKhuKjAZtk77eiyestyrQbTikI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dcC0TyDPobylefByguKFsjQfAoJooUB6bv++i4mClQf8FIzokxDiourOEVSTgKipZNro1W7fNryo3c2ClUkLD9Q8I3xx5Y/dlviCGpNyJD7GLaxDln6NJv5yzyKVA2houOrMwjM/aoczoeoRFtnw3mv4tgEinGTxhqSWiguj3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rtc8KOcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rtc8KOcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768385289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLVLJe5ZoPPurYSTDDy8POZ2YmIqBUOxjilC1ypOvdA=;
	b=Rtc8KOcjMycaGITEM+83xcdvYDWhPpg0oyCnXufwsbYpFMaB1PWgqQye0+Ognev1/PPq7X
	d0bJ1mpwR9v21KfvtVAxOBIbXwJ7+IjAI8hCLeDtvKCzDBXJ5tgLipX0bgB5hl0ob4+8vJ
	yJjZkbS3CYokKmtoD2Y7oNTxR5rG99E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-jU9L0xYHMlWaJoUagexxHQ-1; Wed, 14 Jan 2026 05:08:08 -0500
X-MC-Unique: jU9L0xYHMlWaJoUagexxHQ-1
X-Mimecast-MFC-AGG-ID: jU9L0xYHMlWaJoUagexxHQ_1768385287
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b872c97a2a2so298317066b.1
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 02:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385287; x=1768990087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLVLJe5ZoPPurYSTDDy8POZ2YmIqBUOxjilC1ypOvdA=;
        b=iZ99yJbFUx02TWKAmN1KWL18VVyXYxmOiVjV4KGGLODaNVgMHaGm0oS+xYX5zEixiN
         UGMZIUmYlHZmcAh7dLz/NjYG087xALjqOR8NesMCrZhkIrbA5sP9+CaesO/8Tl8tFGWj
         my8eHny4RdY5NjodxMtv0m5tcBLcW3VVoSOFnjOgb2F9Nj+nK13gP3dp0D0rRhmNez/Y
         jAeAEek2USYHnoqvdTjQ/yI5Z4SPdfY2UvnqH/QnkWrcwthM4etehFuKiXYBeoX8hP8k
         WySHz29F5mIvGM2a3KCbzILQTf1zozp8jug5kRC4v5mBzNR27q/Nkas1PnqC2eim5wMB
         /BsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vYB/2ScpKEgvfOW2WdTPbmE4rncDqZoEhgZv2SV/dEh/zOg/lMuaBqFpLhD70TXVzZ5/UWTYq9jjVXIWPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIcMRL0wO41Ud9COSJvE1dY8u2HnJycJFqkMn+3jbykhmMqf4Z
	sDIRG5PcSjFk7i2DRMXB7DZ9+wSFN/Cfa4rOCKxrzbzzmiTycLDGRKxWQsjvC/DfNE/W2m5GUDz
	BPmQYZuA56qSf65abhBBiLTYXua4pgkpxP0xWS1/oncwUCoI1Mf+hm7FvwfqecseHw6eN
X-Gm-Gg: AY/fxX7we7GYdr1m1mx3l+yIg8eUltod4QQtKlK0vr+A0i5Esb4LvMIz2vzcPWImmy7
	C4q/SoHxPDhgohzBqJFoh9qI8o7AuD46DeTz/Ckxpsk37XICcJkQUVbVbaQt0T8WSGnTyP9rr00
	3xfCC9nPNXBe7Hqn+MXz7LL5lUZDZuiEZ6tmL6j1a/LJE1lawAcZgp9tj1XlijSYrrSTD1mHfez
	dnE8WLx7dDi4Lzepasa6EStSYAeoI7tjCWHd5yf+jbBu8Se+CL3d8GsYFHAvMgj9PjYscE9NxQH
	dvITgMrITacQ1U9PziaNubhdWjD1Y3Qa/UjeSS0HKu0ySt9JdSoYNQT1a/z4QdNhagNZNdCzjVs
	olsykva+W2SzlJ+Ydt95uIdvbXqTilIawKRHYdq87pEBk60kOKrc2jziYmPj+Ew==
X-Received: by 2002:a17:906:ef0a:b0:b87:b22:f5eb with SMTP id a640c23a62f3a-b87612a48d8mr180864666b.31.1768385286965;
        Wed, 14 Jan 2026 02:08:06 -0800 (PST)
X-Received: by 2002:a17:906:ef0a:b0:b87:b22:f5eb with SMTP id a640c23a62f3a-b87612a48d8mr180858766b.31.1768385286318;
        Wed, 14 Jan 2026 02:08:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871081b04bsm952619866b.53.2026.01.14.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:08:05 -0800 (PST)
Date: Wed, 14 Jan 2026 11:07:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] vsock/test: Add test for a linear and
 non-linear skb getting coalesced
Message-ID: <aWdq75AQZv50CMPQ@sgarzare-redhat>
References: <20260113-vsock-recv-coalescence-v2-0-552b17837cf4@rbox.co>
 <20260113-vsock-recv-coalescence-v2-2-552b17837cf4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260113-vsock-recv-coalescence-v2-2-552b17837cf4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IucyqMy6i5GdyFboScVjicUUeiBOEuKVE2VXKU-XsIs_1768385287
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 13, 2026 at 04:08:19PM +0100, Michal Luczaj wrote:
>Loopback transport can mangle data in rx queue when a linear skb is
>followed by a small MSG_ZEROCOPY packet.
>
>To exercise the logic, send out two packets: a weirdly sized one (to ensure
>some spare tail room in the skb) and a zerocopy one that's small enough to
>fit in the spare room of its predecessor. Then, wait for both to land in
>the rx queue, and check the data received. Faulty packets merger manifests
>itself by corrupting payload of the later packet.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c          |  5 +++
> tools/testing/vsock/vsock_test_zerocopy.c | 74 +++++++++++++++++++++++++++++++
> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
> 3 files changed, 82 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bbe3723babdc..27e39354499a 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_accepted_setsockopt_client,
> 		.run_server = test_stream_accepted_setsockopt_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio MSG_ZEROCOPY coalescence corruption",
>+		.run_client = test_stream_msgzcopy_mangle_client,
>+		.run_server = test_stream_msgzcopy_mangle_server,
>+	},
> 	{},
> };
>
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>index 9d9a6cb9614a..a31ddfc1cd0c 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.c
>+++ b/tools/testing/vsock/vsock_test_zerocopy.c
>@@ -9,14 +9,18 @@
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <poll.h>
> #include <linux/errqueue.h>
> #include <linux/kernel.h>
>+#include <linux/sockios.h>
>+#include <linux/time64.h>
> #include <errno.h>
>
> #include "control.h"
>+#include "timeout.h"
> #include "vsock_test_zerocopy.h"
> #include "msg_zerocopy_common.h"
>
>@@ -356,3 +360,73 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> 	close(fd);
> }
>+
>+#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */
>+
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>+{
>+	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>+	unsigned long hash;
>+	struct pollfd fds;
>+	int fd, i;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	memset(sbuf1, 'x', sizeof(sbuf1));
>+	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>+
>+	for (i = 0; i < sizeof(sbuf2); i++)
>+		sbuf2[i] = rand() & 0xff;
>+
>+	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>+
>+	hash = hash_djb2(sbuf2, sizeof(sbuf2));
>+	control_writeulong(hash);
>+
>+	fds.fd = fd;
>+	fds.events = 0;
>+
>+	if (poll(&fds, 1, TIMEOUT * MSEC_PER_SEC) != 1 ||
>+	    !(fds.revents & POLLERR)) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts)
>+{
>+	unsigned long local_hash, remote_hash;
>+	char rbuf[PAGE_SIZE + 1];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait, don't race the (buggy) skbs coalescence. */
>+	vsock_ioctl_int(fd, SIOCINQ, PAGE_SIZE + 1 + GOOD_COPY_LEN);
>+
>+	/* Discard the first packet. */
>+	recv_buf(fd, rbuf, PAGE_SIZE + 1, 0, PAGE_SIZE + 1);
>+
>+	recv_buf(fd, rbuf, GOOD_COPY_LEN, 0, GOOD_COPY_LEN);
>+	remote_hash = control_readulong();
>+	local_hash = hash_djb2(rbuf, GOOD_COPY_LEN);
>+
>+	if (local_hash != remote_hash) {
>+		fprintf(stderr, "Data received corrupted\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.h b/tools/testing/vsock/vsock_test_zerocopy.h
>index 3ef2579e024d..d46c91a69f16 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.h
>+++ b/tools/testing/vsock/vsock_test_zerocopy.h
>@@ -12,4 +12,7 @@ void test_seqpacket_msgzcopy_server(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_client(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts);
>
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts);
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts);
>+
> #endif /* VSOCK_TEST_ZEROCOPY_H */
>
>-- 
>2.52.0
>

