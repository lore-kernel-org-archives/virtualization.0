Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DB1D1F54
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845482; cv=none; b=h5gr2uYbf5T75BKOb1wCXeJva88e/rBXBGYUJ8AX38EQ4s2UdGZybxwH4InUf/GV6fQ08ywlbd5LBjX6DQBHuw1k+Tb3MLgKwpQ9JoWcKjwoNAaaYDl75bv+CwKKqzYnOD/swpYusqgVIg5jGks7xGuSt9gqOC5U2fEoRpRdvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845482; c=relaxed/simple;
	bh=nVtFuA3MUXFT6qe5Nc+wclnoMmIuimggNWMscKvWImo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b4gxEDyi/x55/4wT7dsnlOLL2hXde7VyvD4d95FImTWUiSIazKDvPNP40EkdunRwDGpn6WXbR1J4y9+DY5LKNPdaHwmmjsBF0UYFcBPfIW/H/aYSa6om7ZN0lcdoJw6GWX8SbWNo/VLBHkaKY+L/WUl8gQ9EfW1JnfMOTJoVbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGYJQPBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGYJQPBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
	b=YGYJQPBgSea4wTDCfDPiddN9wWnUhya7tMEO2oBv0TSNCXXh7gBf+SxHcDmnZa2sUX7lNv
	bQxmluH1NcBu7nvBROTApQo9CLiqypwSIwSd22ir4rOf1Vl4m4Ee50FzKuMsZeIxhpbsMI
	bqo/O2UMvAMBiarnzPCzYNPh35lu70c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-p60q4oSXMXKzWrFs_pEqWg-1; Fri, 25 Oct 2024 04:37:57 -0400
X-MC-Unique: p60q4oSXMXKzWrFs_pEqWg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14cb9f6f5so267665785a.0
        for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 01:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845477; x=1730450277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfG+ldbRT2DRgi42SLD4cz1ZUxMhmfDg3K241hmjPrM=;
        b=oAWRbFzoNQDYhcVunmxrO4Iwe8ODGrdwTxuDcy8KeIkjW6Enx6cgjdG2qqP50J66EC
         Cv7cZ1avuj+i9HmZrQxVqfx8WjId6mB70kPalaowkinmvrhxNzQNgazEj3EGXyOE7QVG
         53dG/W7yI7zVhA8vAaRCcVokT8BUxvvVwxLAbukoLE+Jbjk49diRg55Wxe8AdyktWqaw
         tIjh2ktyvV4/a4G/oAaA/gcEAUwsqE6Tbqz/6R7J4Zx5LYNBueeeAY9e5xgnmkRx6+5I
         mFRkKYkyOnUbO4uYhOBKgHLSqJnsEjboKmKVVCWLkKgmSCeq+qRyw0kB7GyKpabedt82
         Cjcw==
X-Gm-Message-State: AOJu0Yz+kXcznPIqP3AJMK3KP+nn6ysVrrw60xUfy/9UQh4qZ0xbob3q
	3rP2OaMZ6WuLkG5uVZfgJApV8dnzcRzqmrHXnWuPqf/1qKBgKsdEVzvyaB4FgofMu7hOOt7JfSq
	p4iyd5Uy3/qU8LRVFOwsC1R8K5+3T4BrKLFGeCeQZjuy2c3Glf77+dOK4eShiwrmX
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614541385a.59.1729845476846;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuQEjcQhlSNMj30aQpJXJBOGKeqEjdKKGecMohH0UZa9AyzJnLZNXjh+x9iFwZinN8LX18HA==
X-Received: by 2002:a05:620a:1aa8:b0:79f:148:d834 with SMTP id af79cd13be357-7b186d0b94cmr614539785a.59.1729845476495;
        Fri, 25 Oct 2024 01:37:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a57d4csm3713716d6.132.2024.10.25.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:37:55 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:37:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v2] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <pdgrhpta6qqwa7r6zexqikcybkllootq7qwbe36i5uf3fpbavb@v4vyiclg2cis>
References: <20241024161058.435469-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241024161058.435469-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 24, 2024 at 11:10:58AM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in test failures.
>
>Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
>Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
>Changes for v2:
>- add "Fixes:" lines to the commit message

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> tools/testing/vsock/vsock_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 8d38dbf8f41f..7fd25b814b4b 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>

