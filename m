Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23818313E31
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138536; cv=none; b=Cpq1hUwWiHB0AkmHGGygeckknl+O7vLic00rCiA4ANkMphUFBM0XkauQ6YNCogBMpRJ+pycoWoB+9qqkxViWRt0QU0LsUW9UMr+Nbex2WP830AS48T3riPb2Vz3fupOmvcQVw/BXsg47gqx8bMZNPgirf2gbHubGvMU547TXNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138536; c=relaxed/simple;
	bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TajCP68QamFbmUHwP7BvCH+EuYuMOwUnj+3MqCd0ot3j8lNsTpk4soW7macIIhnsIvaTR8hCppxMKolWDUYg8A0mGmJ0MHAibcH5rBBkhLTyz5B47gMcC/HzU2cJ/LhbZS8lJxJmklGv/P5Yw69jyBx1KMckuWumEHoEApEOHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGdauhf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGdauhf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792138534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
	b=hGdauhf+WDsolVyOsZ8uigkkz/FyXZqjV8ZDagM3i3ApfZRw6Zq9gQjVmKRxpDLa9il3W+
	v+kMvPr+0tSzrwZ4vlRWorUSVOJq06XqBWn/aFblubMtgGpdtu5+hOW7/3+lgDrDBJND2O
	qUAWJ5uOulEqtehusWGqeCSQNeRTCAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-4VR-W-xkM6WvR0V0Mw0XMQ-1; Fri, 16 Oct 2026 08:15:32 +0000
X-MC-Unique: 4VR-W-xkM6WvR0V0Mw0XMQ-1
X-Mimecast-MFC-AGG-ID: 4VR-W-xkM6WvR0V0Mw0XMQ_1792138531
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dea677afcso570082f8f.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138531; x=1792743331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y549rUx82KGZkIt3qwDBp9IS8fAoR7mGvTJsFiDdNL0=;
        b=E1Lrv2oTJ9oNtICxnDTFeBKhXY3aDJPwLNZDwUUjAhc2BDjhtqCSb4MrkjYKaeRZl1
         CYBjOzcUYYbQEUD+66nX1KiNuJJXZOwJcxIAt7cXdL6DaJfDao2PCGSC8TslJUBKbBej
         jjUjqJaDLEU96jhGbfijLbnGQQ8zHdalsX48IqELy04+xtWgVIBTff9BoSESN4bYu14+
         sDiFcHgqUEPy4Oym1ALjqHO+kJXm9gjvR+MmjUgvB2rqFr4ipHhiS/DXRjFZLqDLHHak
         Aos4z5IqRct81Y9L/R9czNqwUEVnz6/p2ZvTVDwQkgdjfddWgO0rVCOOuJkDdRb8wNq5
         +X5g==
X-Forwarded-Encrypted: i=1; AKwUvBxlOxaxE3PYfd7mIykIBRTlTwyFATM0egR8crwWSw0/3xZDjL2R5jPRuEHFIR6XW8sR5eEwMgp+b9bO2k4P4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKhxFybBJO5/bOagHVjZLuFfkHwKxbnTEluvDAHrYjxSmg1xvjY
	5iViC7nXSXsNu1s40vltxYmJwVG4DQwT8m15B5ks7NJju6YS12rBUZFeexo0fFIlKUDS3wO5TJ0
	OaiNYgrv9+u2AWiiy6sFNGtwapEK3gnJDwJIJac/ENyGfqb/hXS1rsG9Zxglsftyj5vSa
X-Gm-Gg: AYBFou0ddWhr+U9/urQ/x0klyaqjbXtb5GQJ4uQhA392CjQST74zjYzaF6pgi4YIxdX
	1bcKP+ZpYd1QmYpztsc4F6WB/HBC9iVwaSzmc11lVopvvP89OsE/S6cQ27yNvaTL9a59JP6QlRA
	INXY+9soz/V00ZJELQAskAJmPtUOwzeFsMREQAu5atqpKCIl/DTxcQrbcYYHIZh982BjU1G+Hxt
	rvguUPQcNGOYoVYiwDjrtzmf8nSPTJkxczjLtQWSskBMLxET6UA3ODw9/sC0444K2tMSh7rNJxm
	WthPsuMdbN3qno/O7+o9tMYc7lz0d/tCiUHbwO1W08619z1BggN445ZgAiTnRKr/R17XllNgCtW
	/dgNi
X-Received: by 2002:a05:6000:4549:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48dfadf34c1mr4227587f8f.4.1792138531282;
        Fri, 16 Oct 2026 01:15:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4549:b0:48d:ed0e:6bb4 with SMTP id ffacd0b85a97d-48dfadf34c1mr4227528f8f.4.1792138530803;
        Fri, 16 Oct 2026 01:15:30 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c0894sm3190609f8f.12.2026.10.16.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:15:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:15:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover SO_INQ
Message-ID: <atHdAlIdUqNIoDNn@sgarzare-redhat>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261015154334.3217358-3-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2arFUyCeOWXBJjGA_FuLdQlqPEf5VuNUVP3adLdub0o_1792138531
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 15, 2026 at 04:43:34PM +0100, David Carlier wrote:
>Check the SCM_INQ value after a partial receive, after draining the
>queue and at EOF, that no cmsg is sent while the option is off, that
>accepted sockets inherit it from the listener, and that out of range
>values and SOCK_SEQPACKET are rejected.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
> 1 file changed, 279 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

