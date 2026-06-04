Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE8401A32
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569609; cv=none; b=uKZv55qI4aGHPlfBUrYJwxJBF+Waw6xyjDUuCZcNpq8NHfCTIl+9b4hlKB1TMecFntIEx0AZuFhrcgeldGyTbpCU4QoxBMtXTdLUo+d8BsawUqknVYqrWEm72rCT1mMIuEgPBF8U7XH2/zCaNoMuuk8/RB1FQ15d12UrxgARSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569609; c=relaxed/simple;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MUt4YIHbc4EvL2M5uoLiYVjP8kGnDOAIMjRFSmbbFhE1NW0sjqU1rZYU2KAaqiYc0zr6SGQEk6f1L7tXIowSDWyYkDfZMX+m/1VnLLhnHGs3b4du3tH9NlqT3sy25FbGz6j5GSl4JCwqzvm1Dw6NtCSlwy2na2ZyoB56mKKZV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6bsNIOm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6bsNIOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	b=g6bsNIOmOPnjIGgF77tWdrjJc2IBKz0cIvyUKAoSfx/3eXsF81P+8i/NhClLonuquXaXrx
	x94H0Zz+UvjRhcYfqCueIdtfG17aWzOmPlMw0LAsvIjArrnPZEN8ghdUqdMQm6fQe257NH
	tZEeZlQBO19de9OB0GgdsKsoyCiJTmQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-dYlEktFhMA6Gfug-zjkkUQ-1; Thu, 04 Jun 2026 06:40:05 -0400
X-MC-Unique: dYlEktFhMA6Gfug-zjkkUQ-1
X-Mimecast-MFC-AGG-ID: dYlEktFhMA6Gfug-zjkkUQ_1780569604
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45efa12a788so382078f8f.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jun 2026 03:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569604; x=1781174404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
        b=ESe+zyfCfGBJfJfRHkkd72BYz1NBYwAooV6SkWYXAKPVmjmznsZZ2mQ2fIZTypAwt2
         cYRoFDecddckSGtJh6gqfBCP9vRznmbLMxA0ii/baGfmxlhlVUQ1Hkdgh1eXkI3iiDfp
         8zE2QVtaomSXUOM14dzIdwK05YG3ouotJL5ztBwLyymWMiJHf339WskG4o8lXDmKh/H8
         Z8JYgS8JqR7Pll8nDr8+YpJzUa1yh161L4xtkft2cbfKiI1gyDg9zPOlxzJqOye/i5cN
         duzgcwf1OLyBvy6UyK22fOpmK2AOE4uoFpzUMEdq9GAydtBZ7LzAu+NPUBY9wWzqRrNV
         +LWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pnv9d2d8ZoeABAFo+AFD0lTs6XnNEZXnYxJUgJfFuyvaAmbET6JBGTLvYqTENpeLj6TLEN5hQLRnwaNArIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxkzj1Ge0feJsE36c4DfCOTR6LWd8P/aqI29GMlHnwYi7YJZjqy
	RhKHsBcJkBpH/vy1boVFntsVj71HlbOpooq1uQnWfO/U+/gilv6xEUyIXn6n3IG0WAkOwsxPZOI
	H2CjtvpHnfFTYKQVqeH/8FXvSrpjYKI1x3AFR2qpVDZDVjGDI8JnU9aousLnEZB+1ExUm
X-Gm-Gg: Acq92OGDDAclCyxdMlZj9V4zycMPGWZ2etFaShna7eD9pdwmtq7pNp2uyDua/T83mTd
	plU5+qn+0dWi9fskYy6YOXSYEqxot1Ek3wZHkS6ymFiHsfLg4hyjlYwkkoNYMoK3fGnVbaZdz6a
	hP851Ncs5N3sDq0Zbh8y4V7w9sckwTcxMVrmvhA5nmoIlr3KFrrhpOhuHDHpH3nZvmO4myYTA3A
	HhyDWd5YEJqmgywfw9zNPt82pf9nb+cZ8XWdP1nH7mQbqi59u8NHVqWt85o/xTYqHKZuIEP5Su3
	/G2UOu+znNh4441QOjEIgi/+uXQVLUE9oOZxbSdRjG7P9vNaJi98a8JpJCbGlGW1QIhdcIp6fx3
	o8QsvBCXPr2uScuVBngsHYn0NLFIgkzJTlleabfw+Cyvxq9wi30kpm6+M6HwsQAPCYpvuTXkeZO
	5DWj0Gmw==
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71419125e9.27.1780569604435;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71418665e9.27.1780569604008;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm73719575e9.1.2026.06.04.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:40:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:40:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFV8w-cvY2jUsqb@sgarzare-redhat>
References: <20260526104356.469928-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9a-I3gkPusnTKs2hNXIhoku-zQBtK2yhgjN5tKn6oR4_1780569604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 26, 2026 at 10:43:56AM +0000, Raf Dickson wrote:
>When vmci_transport_recv_connecting_server() returns an error,
>vmci_transport_recv_listen() calls vsock_remove_pending() but never
>calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
>permanently.
>
>Repeated handshake failures (malformed packets, queue pair alloc
>failure, event subscribe failure) cause sk_ack_backlog to climb
>toward sk_max_ack_backlog. Once it reaches the limit the listener
>permanently refuses all new connections with -ECONNREFUSED, a
>silent denial of service requiring a process restart to recover.
>
>The two existing sk_acceptq_removed() calls in af_vsock.c do not
>cover this path: line 764 checks vsock_is_pending() which returns
>false after vsock_remove_pending(), and line 1889 is only reached
>on successful accept().
>
>Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
>the error path.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

