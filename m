Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C01D54F7
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073351; cv=none; b=Vhe+xN+qeNFxynWLvECTrCsCMfnnCtMHwH3Pe4n+5APL6wHCOYj3Ud3CFIYJU9O3si69JYWWHXZ8OBBnPSYjhNNBdirC58H5oi+/8IEv2jcsPrj36CwXjDZbtwWcxs19qXpZ17oIojw5QgMSdfY+cjZUFC4/KOc3+wh1iMW9KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073351; c=relaxed/simple;
	bh=qQzR+Sm5b5Z4CzPC2NcCXxweWFm55uF7TL7SSGOdvak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ShBgukM+0AovUM8z8SYXcR68wIanOtoMh5VRO+AO0bYaiD7hgRnqOmT2fURvpyg/ueGJH+lsv60OqSN43mdzGMLzz1ZzqPzca9lu4IODWv/h/gZaAMr1/wzbM4LqDH5TS++lWs/Pq/UPcx/6L3+HRtwGSCS1wiIah+x8r6ZH+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC/YBeqC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC/YBeqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/2GYA3xGzU3Q7c5wwHJlSwh88wrrH29hih0NjGmI1c=;
	b=EC/YBeqCa3nQM9m5A8w4JUPoDCrSxAPWkjZNXzdVGF+jzS4G4QT73gLK/tPI+ta5nyBAen
	TYr9kVSUT0F3CcqiBDNCmGD0TAtur73EpRst53OL+7cEoIn1hyepDnLCtzkLxMDA3oBYcI
	1cYnsz8cEmJ2qcmWZFVYGdjoiElFI0w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-Si7mY21TNc-mVVsx9TsRVQ-1; Wed, 09 Jul 2025 11:02:27 -0400
X-MC-Unique: Si7mY21TNc-mVVsx9TsRVQ-1
X-Mimecast-MFC-AGG-ID: Si7mY21TNc-mVVsx9TsRVQ_1752073346
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso23845f8f.0
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 08:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073346; x=1752678146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/2GYA3xGzU3Q7c5wwHJlSwh88wrrH29hih0NjGmI1c=;
        b=hdmQ4uqGUj9ZA9do2H5xR8g9ssOZT0r8ii5SHfRX7GxXjLVRU+GUxi+HFrTqRwOZu4
         ziYnjkxSNV1CHD++mlHkCwkXnxRfkwzuqv4jJGeQ/Eq28nrOvaLdoByYLN6fRSclPAyk
         GI6Jc3aatxM0f/SSrILjgigEgm3fgfVoYTMSLDWzvkXQRZ37vo2XVDJqrRQYBejs9kDo
         IwxCkkiiZHjkn90QxDWOPRevIouFAUdDs17PwNKa13nLI4Vg3WzbOxjUgrsSrOEJYlUg
         aMcIMu149Iaq2/o0Als2MeMwciin35cVlDnbcJ0tdE8bjRFK2xyyIegG55Qk69vYPczq
         kwFA==
X-Forwarded-Encrypted: i=1; AJvYcCWC2y9SSp/0+JdMNVfL7u+BYDhrZ99n0Pzi3+R9oaSmY/JslzvEO+xeYI1Us+eOURkoCFf3OlJNpEBu7mqNyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGnSnikLJ6/dA4wN1ki3DEF3Gf65mNykY1y4/AUTYYN5Aef29D
	kod1wc4cWLXg2IruSozrn26cvhEV/yrWLiWnV2+OhC89Ada9ALK/xv8MrXJu/zRet0D5C1CRAWm
	BlzxPGfTzqhQykIKDt/fzihjkme6xKT3U0j43/HL4bJOp4juF/gAzdCluyY1Aat3WgbFw
X-Gm-Gg: ASbGncv1Xxc+o3tNAQJNubL7uxkYQd7sjCkZpJ/Dwgtm3jGWY2knAzz7xPkgEkFvNN1
	bR+SDKM4U4VAEAYjCJ6ZH+onxr6T6dRe34SR6oDu627PHmdy1aM4qPDlEhg/j4piickJ2NsTfja
	I69cIKzNKQ1cwbswVPcmijROEGYP1uoP+6TJW/U0RpUp8xqaX8FaHjuB98reMwvRKv7voG/euG2
	yez4qY9Y/SWB+mIJWAFyEND+v/hKlPEba38MXXzeSbQhi+v3vSGx9LqsJdoNR0IDwY/Uc5n5CLm
	Gu+Dez9tzFP+qUEx6uqu/ckEmY0=
X-Received: by 2002:a05:6000:18a4:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b5e453e95amr2687763f8f.53.1752073343921;
        Wed, 09 Jul 2025 08:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj0X5fq5/CoLZOI4l1DS8uyjk64bp7E2wVLV9ayUvzfkSXxf8Z+pKpdKwZlMv5UOeEL6CVYQ==
X-Received: by 2002:a05:6000:18a4:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b5e453e95amr2687560f8f.53.1752073341897;
        Wed, 09 Jul 2025 08:02:21 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97f10sm16385987f8f.57.2025.07.09.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:02:21 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:02:19 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <7j36bxpo4bgitf5jwi5kgs6pagrzg76thyfcyzpt2uikb7yqnl@5khvkwbgyphm>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PHcBIAwNxXgnbpYMHKDwSjOvzbgKwFeCc70KteCdks8_1752073346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:13PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int actual, ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, &actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret >= 0;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
> }
>
> /* Create socket <type>, bind to <cid, port>.
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>
>-- 
>2.34.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

