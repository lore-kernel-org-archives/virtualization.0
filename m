Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3D156228
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083829; cv=none; b=trGvc/yyAFj/QZuyqP3ZH2HkGvgb06amBYvjai/8qp3DqY2vPGtW4Y8b3nXQQDE5q6fIp8TP6K0WIz5cWBqesm7n1IceMJSLFSVTqDYQpyOv3aAzUnoebKbvS9jZpU46zvrLK7Q+YBv3h8ZZlEmVDzEoZythEz0XeaNDXVr5zAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083829; c=relaxed/simple;
	bh=v8tipBw1Rg8uUUI8WgiokNzRTX+JlMQF/S8IRZIRHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tno0ZDQG29lBkFDvBk3XKz4MOjIwYxr7wqj+kYGixaQgWg7m6CdC/jP7BqrVfXhcP/iO3W7tDCtxgG5XS/ZqI9NujeUrVY+rw2KjLzFRRZeOwBbFMTZXlmulinCMmDid1L67HhnwLdUpQohiGHrGzvIF2uT4L/oyAyH8fW5P81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DANrcQj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DANrcQj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750083827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+2gsbjGMfxgj+GtSEJhJLLfivzU+vrOQd2XrrPgUqI=;
	b=DANrcQj7cPIkIJw0VOCj2o5UbdZ16JaSYlWqw3ejrcbIbeTCx8+ulthYjwglZrqOmswORW
	g711h5gGUQYJP9YeFpP2w0Xw6gZUdaZmSno3cTCmXuXuL1Y6gGEXWiCMFTmhUyvULBDzPG
	Q4Hnt1T7Km+/HecIDVCTCZHoiasgO0c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-dvRaqcJLNqiQY_2cHoroKA-1; Mon, 16 Jun 2025 10:23:46 -0400
X-MC-Unique: dvRaqcJLNqiQY_2cHoroKA-1
X-Mimecast-MFC-AGG-ID: dvRaqcJLNqiQY_2cHoroKA_1750083825
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso24138815e9.2
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750083824; x=1750688624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+2gsbjGMfxgj+GtSEJhJLLfivzU+vrOQd2XrrPgUqI=;
        b=r5dIzaNeVCp4WRkHVXXGggeG/jqBYInF2RByf25dn+Alp/h1+5xEIEwOpDfZ/FEpFh
         AhCFe3hZuXPL9glyd/QA+LGk07enodMzMgVXCg7Kgn+JdUuj7NCB8XNhhEvoslNqb7wQ
         hUy/usuSbBkoZaviPUjyfKpgH+HppGbu7dJYTEU4zyYyJSwmiTmi+e0XB0zMvhUeLVOq
         qC+N4YxmeZw6Qg2QmaRbQjajrCcOso4bzUu5wyEQB4dhrRxs8+98j47KPeuDJPuezt6K
         t5Ecusaxk7alrtjguW5DF6nLx5GQHrRiXh3FgclaZieeF90FfIgN73uifpY9xcq8TWdN
         ZCHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+e8DHWSaey7dIJTVeuiNUP/43p0F0ICQ5uGK5+gruLxh2khhgrAcGZwmM11b4Wy8oZLMHxYH3CdiNMLaKAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR5/TUh8xNhi2dwt8H+JdF8F7B2YhdE2usAgs3WMBD3cPW7NNL
	QaKkj++jy4TIN8LCot/yaS4NmYLJj/Xp/hBu+CUBs9UQso4UwxbiYnBGEim+8/7lIECi/tWSiJs
	7UDoD4P4K+ftxEr1cUnWLvIGcV86YpaglzfWladiTGkSZvTSN/y8cEmt5clQ12H1rqMblQlANkp
	JE
X-Gm-Gg: ASbGnctsWFR6LglpkyT+nH7DqxP5DWfDB+fJijmQgCN71r6dKtrAxEaU7xZPAWXJ+5B
	ASb072oDdmjnanyGBBzYAC2TDQysURe3iYtQvFJPmjtWFznsVD6mKuN9tbd5YYE/LbBWadTbx1A
	AcCmaae1P7HxGzV71Qhx4MFmqLvsF/JDMznrYdBLC7hD25SvPdhP0HKjzTC6890kQYI1eaxjphm
	nHmUnwvTdUEHXWb9RbfoEfEYkkpGb7i9wo+215OUzbweCYU7UJS1uB+AVi9qD51Aoe4uhD3BaHq
	nTlLXwXjNX+2BJDXNgKmsSeTEaM=
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4533ca4291fmr82823325e9.5.1750083824363;
        Mon, 16 Jun 2025 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1RMolTO9eDEe9qR38ZhX3HK9hH9v80M70WdDnGgFJKvA6JD25WeKSon+jf5NTkGxpDWO43A==
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4533ca4291fmr82823115e9.5.1750083823852;
        Mon, 16 Jun 2025 07:23:43 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25f207sm145671275e9.35.2025.06.16.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:23:43 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:23:40 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v3] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <pjwrj4pnl3jheypjbkcopjv7uilcdiog3pxb3m57zyeq47sc22@7sl6otxuims2>
References: <20250611-test_vsock-v3-1-8414a2d4df62@redhat.com>
 <zpc6pbabs5m5snrsfubtl3wp4eb64w4qwqosywp7tsmrfnba3j@ybkgg2cnhqec>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <zpc6pbabs5m5snrsfubtl3wp4eb64w4qwqosywp7tsmrfnba3j@ybkgg2cnhqec>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FRW98A2-ZSopOf-3H3x8nxCImpZUqbsJc6Yh-1YiSk0_1750083825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Stefano,

On Wed, Jun 11, 2025 at 04:53:11PM +0200, Stefano Garzarella wrote:
>On Wed, Jun 11, 2025 at 04:07:25PM +0200, Luigi Leonardi wrote:
>>Add a new test to ensure that when the transport changes a null pointer
>>dereference does not occur. The bug was reported upstream [1] and fixed
>>with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
>>transport changes").
>>
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>>Note that this test may not fail in a kernel without the fix, but it may
>>hang on the client side if it triggers a kernel oops.
>>
>>This works by creating a socket, trying to connect to a server, and then
>>executing a second connect operation on the same socket but to a
>>different CID (0). This triggers a transport change. If the connect
>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Since this bug is non-deterministic, we need to try several times. It
>>is reasonable to assume that the bug will show up within the timeout
>>period.
>>
>>If there is a G2H transport loaded in the system, the bug is not
>>triggered and this test will always pass.
>
>Should we re-use what Michal is doing in https://lore.kernel.org/virtualization/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co/
>to print a warning?

Yes, good idea! IMHO we can skip the test if a G2H transport is loaded.  
I'll wait for Michal's patch to be merged before sending v4.
>
>>
>>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>>
>>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>>
>>#include "vsock_test_zerocopy.h"
>>#include "timeout.h"
>>@@ -1811,6 +1813,168 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>>	close(fd);
>>+		/* Set CID to 0 cause a transport change. */
>>+		sa.svm_cid = 0;
>>+		/* This connect must fail. No-one listening on CID 0
>>+		 * This connect can also be interrupted, ignore this error.
>>+		 */
>>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>+		if (ret != -1 && errno != EINTR) {
>
>Should this condition be `ret != -1 || errno != EINTR` ?
>
Right, good catch.
>
>>+			fprintf(stderr,
>>+				"connect: expected a failure because of unused CID: %d\n", errno);
>>+			exit(EXIT_FAILURE);
>>+		}
>>+
>>+		close(s);
>>+
>>+		control_writeulong(CONTROL_CONTINUE);
>>+
>>+	} while (current_nsec() < tout);
>>+
>>+	control_writeulong(CONTROL_DONE);
>>+
>>+	ret = pthread_cancel(thread_id);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_cancel: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Wait for the thread to terminate */
>>+	ret = pthread_join(thread_id, NULL);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_join: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Restore the old handler */
>>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>>+		perror("signal");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+}
>>+
>>+static void test_stream_transport_change_server(const struct test_opts *opts)
>>+{
>>+	int ret, s;
>>+
>>+	s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>+
>>+	/* Set the socket to be nonblocking because connects that have been interrupted
>>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>>+	 * As of today (6.15) in such situation there is no way to understand, from the
>>+	 * client side, if the connection has been queued in the server or not.
>>+	 */
>>+	ret = fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK);
>>+	if (ret < 0) {
>
>nit: If you need to resend, I'd remove `ret` and check fcntl directly:
>	if (fcntl(...) < 0) {
Ok!
>
>>+		perror("fcntl");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+	control_writeln("LISTENING");
>>+
>>+	while (control_readulong() == CONTROL_CONTINUE) {
>>+		struct sockaddr_vm sa_client;
>>+		socklen_t socklen_client = sizeof(sa_client);
>>+
>>+		/* Must accept the connection, otherwise the `listen`
>>+		 * queue will fill up and new connections will fail.
>>+		 * There can be more than one queued connection,
>>+		 * clear them all.
>>+		 */
>>+		while (true) {
>>+			int client = accept(s, (struct sockaddr *)&sa_client, &socklen_client);
>>+
>>+			if (client < 0 && errno != EAGAIN) {
>>+				perror("accept");
>>+				exit(EXIT_FAILURE);
>>+			} else if (client > 0) {
>
>0 in theory is a valid fd, so here we should check `client >= 0`.
Right!
>
>>+				close(client);
>>+			}
>>+
>>+			if (errno == EAGAIN)
>>+				break;
>
>I think you can refactor in this way:
>			if (client < 0) {
>				if (errno == EAGAIN)
>					break;
>
>				perror("accept");
>				exit(EXIT_FAILURE);
>			}
>
>			close(client);
>
Will do.
>Thanks,
>Stefano
>

Thanks for the review.
Luigi

