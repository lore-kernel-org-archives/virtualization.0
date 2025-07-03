Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE5221F37
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528179; cv=none; b=J2C6S4+QagYddhaJ7bqtZyI5LM6Z9pt3J5zT8BL+rP0UCHfFHFeLgEYIBsHp+nE3iQgtoqv82u6Xq8w08aWxyUoj9+rZy7HRyPkcV3AJNQZJ88RFNx+2pGiGfy7r97nH7cyMp06lpyB4kb1u60VPS56EUVcRWFtWehLMmTYK2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528179; c=relaxed/simple;
	bh=t0n49iCwwU2GbeVi3ix5QZaF6IORs6m35hJ68NMxb5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nXWvd6Jub752oO+1GYFEPEitH+LUefpcFiwJ/57Io76SZMWRyzCqbTFBjIz8MDflamLBv8wdIPU1cBxYJgO3cINkHs3eRQdsY3PYLKkfWI3j77aAJtJ9S3ILyIcSmwsqgDEWYQ/xR/2e6suzRxEfLl6LkDPjmsWdLhHEp4LEFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZkFBKjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZkFBKjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0myZD3/gO82VfB/RKtfXzE7O1oy/XulbCjkjJQJqz/o=;
	b=EZkFBKjHM05iI9251GGcp5X6ricFNT87wAgJOWzNQLqFrs3Nirpnd5we8EYZLmQIKMRSjZ
	woiNlaH5ryjWdsfeMh6Q9wpahl7QwzwHC8v6YWZI2EotDWc8V8EllAn3099ELAR/qvaOsa
	JpKavoKX1xZ5uN/hyA1XCKr31cW3FlY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-IWq74abKMbiPPu8gLLzSMw-1; Thu, 03 Jul 2025 03:36:14 -0400
X-MC-Unique: IWq74abKMbiPPu8gLLzSMw-1
X-Mimecast-MFC-AGG-ID: IWq74abKMbiPPu8gLLzSMw_1751528174
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso31040705e9.2
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528174; x=1752132974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0myZD3/gO82VfB/RKtfXzE7O1oy/XulbCjkjJQJqz/o=;
        b=RAwpkh0dt9M+1cb8xqSIE9gAnXwY5NxSc249dj57welojCxjfNhimYsWDNieb3xwmB
         isyHAGtB6Mc9RIDk990ypVEINz6NxQEDZwQ1tT9wFww6UKn9f6Anm3uWWWRf9/Novw3L
         v1fjaertiOLAYmx4XINcA7+qaXEg7nkJcM6cFYFPjTWOehtLRPY3pMhlU4U/GeYhxY5k
         wcufbKZLPSteOJxD+IPacCa/e75S9gnyom0ZpJXEvA8lrz6w6tgl0EkyMlZGQ9iAgPJc
         Hbt653jCHtv67ztqhXNeepGI6VypQ3OVhZMQuSiutot+A6tWYwvqasV5s4oS4ewBGAm7
         A1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXC1U5fWxL5KKXYFNdmq3Cw/+etJHxWsM4klngG84R4ohZnU2LdiAI9jfdSqLG8TiTCsoy7O+wTeCNsTKfflg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPL35+AQ3F8ep+n5lYYWwC2zWysb6YXIwnleieGCB9PmIDk/4f
	mnUIlQVNkISf1mz5L60awO4zl9hiDSLttxh1si8kvfFK7ofpIXgaHofJD1mslql7sEzQAQGGBD3
	N/4V1SBULLbLlUgEjISHz0KB7qj5mcteTkImJDIg2j0wBEPVtx7f/HeIQ6jl7nDj2iRi2
X-Gm-Gg: ASbGncto4OgeZ1uNOD1zlcSYF3A29n4sW5vP3AupDEPWN5eNZYxsBPKg9HhK9MI4xtO
	IhNHmc/kERksXrWfs90606hiiAg4pW5Fw2rzeWT1FYgbVEK+7bFTn5dveSVcqDYxMj5ls2xry6d
	B/NP8ZysStaG0/Ns8LAx/BAMr/etxOYJlafjNQfIGVCl8wATVcu8taeCMp1af16TcZxF+l7UFMj
	LLR1B/qt9mc77AgHWbgMLtR3sRN2Xu3hagqNrF9a/Urqu24888KKhhzaVtD2qBGWl1JgSVqhUZ9
	T4VHxiO3V1g+F5hFy4eEvnRsmpo=
X-Received: by 2002:a05:600c:3b88:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-454ab520a21mr15158195e9.6.1751528173427;
        Thu, 03 Jul 2025 00:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhjcnveMpvTzezAJ9GXUGkphlFIge/CXQt5U7gjqv9xWH7A+a8gl4/9NaXMc4bKYzsomAqnQ==
X-Received: by 2002:a05:600c:3b88:b0:453:78f:faa8 with SMTP id 5b1f17b1804b1-454ab520a21mr15157605e9.6.1751528172730;
        Thu, 03 Jul 2025 00:36:12 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8e1sm17681937f8f.88.2025.07.03.00.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 00:36:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:36:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	jasowang@redhat.com, kvm@vger.kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [RESEND PATCH net-next v4 3/4] test/vsock: Add retry mechanism
 to ioctl wrapper
Message-ID: <ceulzs7srd77t57ozaauveim4dlp6stqmbvvjh5dketapmjzhv@nu6gruoyidze>
References: <2cpqw23kr4qiatpzcty6wve4qdyut5su7g7fr4kg52dx33ikdu@ljicf6mktu5z>
 <20250703030514.845623-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250703030514.845623-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aeP38NrxdL38n4tP5sh0HoG2LVoOTH-g66QBdlkV15I_1751528174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 03, 2025 at 11:05:14AM +0800, Xuewei Niu wrote:
>Resend: the previous message was rejected due to HTML
>Resend: forgot to reply all...
>
>> On Mon, Jun 30, 2025 at 03:57:26PM +0800, Xuewei Niu wrote:
>> >Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>> >int value and an expected int value. The function will not return until
>> >either the ioctl returns the expected value or a timeout occurs, thus
>> >avoiding immediate failure.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
>> > tools/testing/vsock/util.h |  1 +
>> > 2 files changed, 24 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>> >index 0c7e9cbcbc85..481c395227e4 100644
>> >--- a/tools/testing/vsock/util.c
>> >+++ b/tools/testing/vsock/util.c
>> >@@ -16,6 +16,7 @@
>> > #include <unistd.h>
>> > #include <assert.h>
>> > #include <sys/epoll.h>
>> >+#include <sys/ioctl.h>
>> > #include <sys/mman.h>
>> > #include <linux/sockios.h>
>> >
>> >@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
>> > 	close(epollfd);
>> > }
>> >
>> >-/* Wait until transport reports no data left to be sent.
>> >- * Return false if transport does not implement the unsent_bytes()
>> >callback.
>> >+/* Wait until ioctl gives an expected int value.
>> >+ * Return false if the op is not supported.
>> >  */
>> >-bool vsock_wait_sent(int fd)
>> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)
>>
>> Why we need the `actual` parameter?
>
>We can exit early `if (*actual == expected)`, and the `expected` can be any integer.
>I also make it to be a pointer, because the caller might need to have the actual value.

IIUC this function return true if `*actual == expected` or false if 
there was an error, so I don't see the point of aving `actual`, since it 
can only be equal to `expected` if it returns true, or invalid if it 
returs false.

Thanks,
Stefano

>
>Thanks,
>Xuewei
>
>> > {
>> >-	int ret, sock_bytes_unsent;
>> >+	int ret;
>> >+	char name[32];
>> >+
>> >+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>> >
>> > 	timeout_begin(TIMEOUT);
>> > 	do {
>> >-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>> >+		ret = ioctl(fd, op, actual);
>> > 		if (ret < 0) {
>> > 			if (errno == EOPNOTSUPP)
>> > 				break;
>> >
>> >-			perror("ioctl(SIOCOUTQ)");
>> >+			perror(name);
>> > 			exit(EXIT_FAILURE);
>> > 		}
>> >-		timeout_check("SIOCOUTQ");
>> >-	} while (sock_bytes_unsent != 0);
>> >+		timeout_check(name);
>> >+	} while (*actual != expected);
>> > 	timeout_end();
>> >
>> >-	return !ret;
>> >+	return ret >= 0;
>> >+}
>> >+
>> >+/* Wait until transport reports no data left to be sent.
>> >+ * Return false if transport does not implement the unsent_bytes() callback.
>> >+ */
>> >+bool vsock_wait_sent(int fd)
>> >+{
>> >+	int sock_bytes_unsent;
>> >+
>> >+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
>> > }
>> >
>> > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>> >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>> >index 5e2db67072d5..d59581f68d61 100644
>> >--- a/tools/testing/vsock/util.h
>> >+++ b/tools/testing/vsock/util.h
>> >@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
>> > int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
>> > 			   struct sockaddr_vm *clientaddrp);
>> > void vsock_wait_remote_close(int fd);
>> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
>> > bool vsock_wait_sent(int fd);
>> > void send_buf(int fd, const void *buf, size_t len, int flags,
>> > 	      ssize_t expected_ret);
>> >--
>> >2.34.1
>> >
>

