Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73A2E2678
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073547; cv=none; b=ZIiNS5cy/dUJ7lxbm7sCR6PmLMyu0OiDhvb8yfRUg79PiJ1nNvmjfSMUyEsvRTUd9DxhcdG54qnBCfyGg+ESxI68nJa5S4qiGvItG+sWQu0FjS45nEhQMy/WO8yx3z4DEDpMGtyob5QAhYYSgnpSZ18APn3UvoQFWi0fmzkRdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073547; c=relaxed/simple;
	bh=m/tt151z5ux7hMXhmxhJ7BxLJ0o0bqtGIuFQnn5UosQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B57XaWEwzeWH72qlUe9ydt4KfguRSjaNchzp4RrUX7z4Fz1TE4dJ+tieD8DC3IFYBwnvDHehlnlyKBFmcYnxwj+70ETvd4dATUQxZETNBOEJX/7d8Qz3znDqR/aJXwbdZtDtxlALVYjB7AOwB22fdjh+YBWX3bWfM81X5ACiX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug2C6jGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug2C6jGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uvFBU/K6+KINjVqqjT8q9fA6T2cNaO+u1OFb0NSXgPM=;
	b=Ug2C6jGTCKnL1XgEsNQ+fmrX2PTI1pusI5GJD4cMthS0npSfBrOexyR5uqNePfJGv2CNOk
	QrBsp7A7BgnX369UKvKHWyB4KCJ1yK2AdXC/J5g5RKYiZgc+kpdo/ykraWTPdgRtorJAEs
	+kFwr2F4ql+9fDq1YqrAVdyfMUwg8aM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-JtYSNO6WMu2XyUAjlMuM5Q-1; Wed, 09 Jul 2025 11:05:43 -0400
X-MC-Unique: JtYSNO6WMu2XyUAjlMuM5Q-1
X-Mimecast-MFC-AGG-ID: JtYSNO6WMu2XyUAjlMuM5Q_1752073542
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso20654f8f.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 08:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073542; x=1752678342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvFBU/K6+KINjVqqjT8q9fA6T2cNaO+u1OFb0NSXgPM=;
        b=N9TWkNCU8DOPQ4+GZMxrP3L1kIbGN0eWVp3iR8AC+ARlXVIxkoFbnk3xX2QS8gVuX/
         j/8Y7xMw7RJW/dhaBnrLn8LXvf4rB8i+L5BPsk7meGCXghwOEG5vd6kvXuDNGXMCFlTr
         QLmT+wiq5XS+XKi3dm8UUqO1kZOhuYyFZ3D97wRcJ0a6FMhYg/Wt33I3d9luMX1JKA4r
         Xk4WHcUtMZpHk910yz3ZppjZ5NsIPcvIuPw/2yfDyrmlv6+prIwcRXHiqXIggOKPrfFG
         mHL77utd6PtshAhMmGFJGHjcP4Ey1yRO5O3Abssg7c4G82LpLuog6GbZvIvUhwviYfjb
         1G5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQosjqRT8OKgTvdGBqQB6FOZGpffOnnbUqTZEM8BJ+y0fpMjW0lc1ftAeLrGAtZlmvnQTGAXL+Yl5SLTNuHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI70h9FzVBM/NVcsVv4O9ak5tEWZeCRAmm3Mi1AJJtxSSQCMl1
	we7F94tSmVOVPSM8ARYb/2Hi5DYYrl56tv1ic/ZH4rERKdygZpUHW4UCnNgC7Py+6MrMl3n8m3Q
	ggmn7q56Y+pW9nd1UMiat8lWZfxdmDcMwQTwZBcEmDoNBPLrdysmCxNumAw1dxrHiPKVW
X-Gm-Gg: ASbGnctNL00yOPAMZO/bRlmsYK7gYAkSHW/9aK1HmnbjVtcuuN6YuVtnH5Qqx2y0n6i
	eaHWITEyKOGbFzXjzzmEaXBU3gCHLLyQmBfbwz9Dl1669MIun793lDXZii3soJ+P51Gq9Twd9Kj
	IbfZgtBZlvGNCzks4k55f52mH0qWUKw3I/XjhO6uq/7XD5kpTvXWgcSItzpxHdMOZqrkclMjXLj
	hS9HclFEZtMe5zoxTBxC/nxNRWMxjWeahoCqL/fYVT9bgF+IHKSSn7ggO7dUxVtUguiWnpIlb8E
	C768o4ugXyCAcP8fTeuv3vujDCA=
X-Received: by 2002:a05:6000:22c8:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b5e78d8e4dmr304367f8f.44.1752073541706;
        Wed, 09 Jul 2025 08:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENULoeyQE4yUr9Bfl1DIihXJgUXeW/D01393xr1qgElFSMbyNkVPQ2AkcIO7O6Zl3RAG76Pw==
X-Received: by 2002:a05:6000:22c8:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b5e78d8e4dmr304275f8f.44.1752073540970;
        Wed, 09 Jul 2025 08:05:40 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd4dsm15901270f8f.7.2025.07.09.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:05:40 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:05:38 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 4/4] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <j6dgi7ptup6op37lgwpwdvrkfxpnelholoyc3rk6hb26xamgxk@h3nfy4ypnf36>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _rIZNfR21kM1JsfBMRAfONvmT7gBWc6qVjX3xvS_f7s_1752073542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:14PM +0800, Xuewei Niu wrote:
>Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f69480c0f9c3e2288fc19cd2e74be148..a66d2360133dd0e36940a5907679aeacc8af7714 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -24,6 +24,7 @@
> #include <linux/time64.h>
> #include <pthread.h>
> #include <fcntl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1307,6 +1308,54 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	close(fd);
> }
>
>+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int fd;
>+
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	if (!vsock_ioctl_int(fd, SIOCINQ, MSG_BUF_IOCTL_LEN)) {
>+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	/* All data has been consumed, so the expected is 0. */
>+	vsock_ioctl_int(fd, SIOCINQ, 0);
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1327,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> }
>
>+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -2276,6 +2345,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_transport_change_client,
> 		.run_server = test_stream_transport_change_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>+		.run_client = test_stream_unread_bytes_client,
>+		.run_server = test_stream_unread_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>+		.run_client = test_seqpacket_unread_bytes_client,
>+		.run_server = test_seqpacket_unread_bytes_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.34.1
>

I ran the tests, everything went smoothly!
I had to apply this patch[1] first otherwise the transport_change test 
would cause problems.

Tested-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks for the series!

[1]https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/

