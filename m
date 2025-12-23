Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE72DC357
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485668; cv=none; b=n0aiYtgRkag/1Scq+pafFp2thwj7x/09J0qmwUu7RJHL+LH/uIJTHxBAg84Be17OlCQvqDGJKmVNjGzb08GMDMdn8GU1ARwKXTG5esWm+K23RGMvhTkmhu+TqH7eV0lSe1kMvZupSAcnotPQBoDFvAuMQPtx8EOz31zeyhB0JGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485668; c=relaxed/simple;
	bh=9E1dhQvW0zJvMjo+SEKbX4bLuVFOxDgDELOrkB3nh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DGCsemeSFQclygkg+oLlrhTU5vk33JgeqGHAbzHehg3dYOhx90uN3g4nvy3YTieawzhxT+c0ddIseyU6/A2WtPLiJioy0WA/Ad3F3uh9V4eb89OMa0XDViHGlMW4EkdGnqFh6LiVeArRIpIP70Pey9p1ceA+vXYh4Z/3AwuHYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcqXrqb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcqXrqb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuSneQFcRp+xpxbp1diVmYhq/nUgwmScL4d+4Vec74k=;
	b=HcqXrqb55FHpofzI3DC5ivRUOSiQXgwwydXR9WuzN6OBcJvnOc6lUfGKr17wXTV52OZfjb
	4Y5BrJLCK0NkFll3qo3aBbor+lYcOhkBbYrCWF0I/+y4aI599JkPMmeKkadm59M5yrmenU
	OwOlAvqsaqDvEZWKMo68h6ZpnYGilqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343--vftc7fGNg6M8r7AvmTlpw-1; Tue, 23 Dec 2025 05:27:43 -0500
X-MC-Unique: -vftc7fGNg6M8r7AvmTlpw-1
X-Mimecast-MFC-AGG-ID: -vftc7fGNg6M8r7AvmTlpw_1766485662
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so39371055e9.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485662; x=1767090462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuSneQFcRp+xpxbp1diVmYhq/nUgwmScL4d+4Vec74k=;
        b=dswXEaFSDyU8F0AkakrBUgsASeFkGY64EC4RQjxUBIwDSAdvMHfTUKqbplNZxiMVqh
         IRsfMjFQPqIhFAOHHUFw/KTv3L7IVQbXPtG5UI03t1CaCDF3hbbtcOZzqwCEdBG5WCZl
         V/2+YdIkJLoCSH6tkl5OwR8untS9nmK35OSEvVvu/EQhMdGAmmVvAkLSzW4twbSlVgk3
         gQzNYbji7sEhWlZSPe0CyMM3Fxj4AlHBfc05zPpGLz8J+PFnWPrlVClb06u7SLKOyYOc
         04cndvMXLLOPCxidOqD4BcdV0QFzy4MLYZlDsUwwShzH0fmo/gGhfV+ChT4gmfLuXOBE
         L7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZooYn6zlKPKTt4PLhzs9wwMzjSh6TH/9DY5YV0MTfyk0OWjPnuchl+z8KzsP0PcuhkfcPS3dLHXen3J8cPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfaTZlgCCQTXOIzaPo9pqVaRIcYkVW2kPfmI7unfZ94JOtECuI
	n28uaqK6yIbzZZJln/e6hHbHtRxBy55ds4yAryDZONlyERmLuCq/Im1GruCInUEPeEKuOvSJZRa
	/T3lBPu6dpb8xdpWFmfY0vZwZsXP4OcICyY7k3VRFF4ce2MwWB6fWBEI9/eqlx/uRI9Zl
X-Gm-Gg: AY/fxX6aRFcT18dAtJhdnSQvrA05EezYulIEFUmZm7HyflSfhHaT91ykleOAK8DIdaH
	xg5s29IoPDnJ73Grfh3G4d6vP/tNBSDoYeeoqKRVB538ypoepFIfr6g+1Q/Y8GqGZUQuKtcd5bY
	dasMBONI7MQUWIC2MuNu1Q3c52ZpOS8k/mfRqPwU5wneyhqgkmoUM6vA4sjeiIX/u5rv+m1aFSe
	yeGUJmz0SJGaarDky9wwoMDDAwZEZc3k7T92OYcSFkIzguB/UfLcs98AbeEm+uhBQMndf2twJiw
	jjyuMxa07WdHyQk9kcRFG7fmJFo6ZUzsX8oMbsR48aHczy0/ipvQjFClIFlkfeCr9+6NbtkE5HP
	SlROdU9F7oLw6cA==
X-Received: by 2002:a05:600c:3b0d:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d20021316mr130186875e9.23.1766485661951;
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAU8P34Cgza55aRvc7Wpg5XlBwMBb9w2I/Kua/0BmNl7IFw3gXWjgeX8hANngFkh4wwllVpg==
X-Received: by 2002:a05:600c:3b0d:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d20021316mr130186655e9.23.1766485661549;
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
Received: from sgarzare-redhat ([139.47.16.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm230722985e9.2.2025.12.23.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:27:41 -0800 (PST)
Date: Tue, 23 Dec 2025 11:27:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUpualKwJbT9W1ia@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IZ0B54_1fEQPdA00DOirPvJtNLabIBP5ymoY8NHTF2g_1766485662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>handled by vsock's implementation.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9e1250790f33..8ec8f0844e22 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
>+static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);

This test is passing on my env also without the patch applied.

Is that expected?

Thanks,
Stefano

>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -2371,6 +2399,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unread_bytes_client,
> 		.run_server = test_seqpacket_unread_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM accept()ed socket custom setsockopt()",
>+		.run_client = test_stream_accepted_setsockopt_client,
>+		.run_server = test_stream_accepted_setsockopt_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.52.0
>

