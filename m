Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F72F1FD0
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271987; cv=none; b=PLw6WCpmntWmzk+AVkX4hxjvwrSQDJ/Y/g4BuEcjSxfmPGFKwEzdB/G+xxqR6HEUWuLFPjXpiC8/wnivs7Tfoe/aTO9XgDHP0hiu+G0L7l3C80BkoGfI7q5SQQaTGEbA4hVuSiuvJH8RKG4yIPb42GsA4uCaNNPMAispimzs+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271987; c=relaxed/simple;
	bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wp2RmWJJ06522ka+M2gBVBRJoEFXrE/luiLsEr369X/hpwhkqxtfoztyjZLSVAWe3BgmYKuFIyZrJTNAePEYhn4WLBQ+7HIQRvquPN9Mi0AekNXlcjEkzIv2C6L8FzSagWb3ChiqEs/fhxyxPtRQqgRwothQB11nTigFWaC5ZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dotI8cEo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dotI8cEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
	b=dotI8cEooPfVcjmEX3pB5NJ7oQeC8iQC7I0/pGK4m6D76eItEpM/4rzQlfUZh1EjCvnm/0
	lItF527U9v/rjfXScl9aTYzXs+j9o7Qn8QoZLQWWflQJvOiOBVfYLSMSNcPtrGLWoaylc9
	a0xuqHi8SYahKPKLR0rmWm+sgP4QW4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-3XWa7BJoM7e-t78tMt8x-Q-1; Fri, 12 Jun 2026 09:46:24 -0400
X-MC-Unique: 3XWa7BJoM7e-t78tMt8x-Q-1
X-Mimecast-MFC-AGG-ID: 3XWa7BJoM7e-t78tMt8x-Q_1781271983
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso9406095e9.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 06:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271983; x=1781876783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
        b=VCD205vhX5U/nM2JehkCptVB9ZbG2HnrSvEWneBCibPaiv0FS+1akKaZh3jyO7fGDv
         t8rRnQ2bd5rjzVFFANTDt/ReR4J+d9eDGImeofTZMd8iVZFpSCpq9/le/XFdwErTTDoF
         TV+EM0dAH26YdD1qdpJi6J1jmcBjXK2nBOTZ7zqaKLGhH5ybgEuYeYs6IeIDhaWY1Cpg
         3HaiLX7Aa5b2iQaoSDfeqtTkiuFpVV24+t1heb89BfmB164/dgFAzrXqDZ1z3eYZkPO1
         sw0BgtnI56Riz+H1YfVbqsNA5lAJ98FOwkAHjsANzrgXYT7d8GQyFkidxiLnJrNV10Ao
         moUg==
X-Forwarded-Encrypted: i=1; AFNElJ/q/bS2ha4MIv54lT1zLRW5lZ9n43cl8rF4Vp0OfjKGgW4MGMMB5OAe/eZ9UntTBeO9gw8mcslgRxV6nw3K4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyObURPIkXHNDNx+Zq6U0fbfauPmAqyTEMCh5CoqWfU7BJpKz+2
	8dI4KJkSobK+ujTZ0jb0nFAvKVsrOm4O4zHwWCfl44I/BhxvGAL7zkubOh8XzjhUaFlzNyKZF+4
	Z5SiJKanDzraGH/1gYYHQ3MbO0nsqsi+ZDhrkQTxl3lnKX6wwcoVGC8fkElaYCFX3453X
X-Gm-Gg: Acq92OEQhgQMzxhnRrwBvpL0zOPUl8UeewV4FTfqjhEA2YtOLd/rGtoxNQMnoD1af8B
	2fmPNTV6TWtByZpsjwf1FHaBt4jmjYAXSOfJf9KxZ/28wHncUL9m5gigWFi2IMvarJ7k+GggWq/
	SZ1QOJkGL0g8/qfDBkf4fdvTGJ6fEJs+NNvIFlEORAV8T64i9oi9kKyrgcmeCQN9yBJBZOuElnP
	XQ1mQhK5xHyUaZ9yJovyRo1KeM3gW0euB5rmwfdMcTSbA56loQmCSJ11VD1Yy3O7lBVcQmisHKl
	PRZdvGnO0VsS+FBI7IZRfuHxry9PlU79qZ3cCAVUPQKspu0VKBjoNI/fqOa6DPFRJre/49Nr5NX
	zPa2sNLQHnR7v+UHaucRzBg4ZRN+24zm1eXcTQIxuu3b7c5mocjWR7dUHhiY=
X-Received: by 2002:a05:600d:8498:20b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490ec4b5ab6mr28510115e9.9.1781271982994;
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
X-Received: by 2002:a05:600d:8498:20b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490ec4b5ab6mr28509685e9.9.1781271982509;
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0bbfsm5941295f8f.23.2026.06.12.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:46:19 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiwNjEuYu9y9pwkM@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ON4wfW2N7OZy799_6iuboOlqjowcBE6rzZzolCFAmY_1781271983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

