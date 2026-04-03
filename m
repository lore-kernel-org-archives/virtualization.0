Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E329B8D0
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217296; cv=none; b=eQIaIDBQjW+BZuJYXPZKnlo2pxsG9Z1re4z3HMEwIlfatmqbDKg9bASoEszQ9xr6UpWL/4C0sYMgdI3rwsDHmiXKqeEVRhZqccaTSjYDCnBYT+os/d7iloi19SKdQeRkKsct7+5X446e4+pBTT7Pb1Oa5ikdQ+ue/NZms6LJSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217296; c=relaxed/simple;
	bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rzOhXzFJg4PsLdj+NhHA9MtzEB5AydPVsI/dSQTtY1u4Pc7ZPdeuHizy0f1RHK27Q9Bl1vxKDXi+ak6p2gaCHU1tMlNU6yPFkZmKlM9qNjuIx3lG/QBJWGqNOB8fsRUUnr/YyxQ/28JA410RMzixQwilXtA7lyMKxJa1eYVSYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC2Jp9pn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC2Jp9pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775217293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
	b=jC2Jp9pnYZQN2cxZxpRkKhaGrZUFFyF2SFDEtfedQ0uuBjSYuscS5tn7MMlGUjDcx5+NQ+
	vZoUNbCJE9jVlnrtTkJRoGdkn3lIasCn/ZHjBSmOlkeKLOTmCv/la7jG/q4USQDGY2GDeX
	C2RkmmaWzWoCIjvdPjUw5v4Boq1g074=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-uGQSNO69MPqxVOZgrQxddg-1; Fri, 03 Apr 2026 07:54:51 -0400
X-MC-Unique: uGQSNO69MPqxVOZgrQxddg-1
X-Mimecast-MFC-AGG-ID: uGQSNO69MPqxVOZgrQxddg_1775217291
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48884e969f8so11392675e9.1
        for <virtualization@lists.linux.dev>; Fri, 03 Apr 2026 04:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775217291; x=1775822091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nv3rHylIcejR0LY+UFbQCkM/FJMlEN4udaemkrS4Cc=;
        b=Qc9J2TNRao/yCVsTO6HMCPIATrIrgSL5q+gdXmLA0mnSuRXpd+i4fLa3UKLlJ6f9y/
         Jx2aardgDde4d8rk7XnDLXfUg+w5VAiFQC1OAjmPOj+oaZJgwyk9cIyPxIWHt2wK3LWx
         rrrUEYG0h0efY3BxZTppxyRMuSF9MdONEsI2bDBeQF7I7myszyV2Z9/FLugQpbUH2Thq
         k1bTMj51o+sy2SdUZc6cNu+uAshXToRUz2H3y2IP5dDol0kbgIoCSAu+exvPidaBM1kT
         qP2RqrEGGIRJ/RL6OrJRgHkcDgDM9LCJbMhvMWxfUknd1AlOjmLbcBKnb0kABxkYIfz2
         u9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVIb8H1n5dicxovWkb75gef1DaYlIOhrRVGBDb5gG8DBJgD+lgCe+IIt/kAk/JRkVKHJtn2EuXn53SoiYTe7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDyqydl832cQiKa83eTiAoymSql3oFofy6ltE5WLs8tbO99xze
	Ukcnw9QPKJ8V8js93Bnbaf6Gm4sZGEHrXHe3rSeHW9Ft7oX/VGyJgnYWhX3+oZo/iHSNp2iLiRz
	vnS9UYGT/Zm3cD9y+3zo7jNlDT4aCCBRONtXqR22rWgjeKxFzJivCitsn1VMvKlCOvlUj
X-Gm-Gg: ATEYQzy1NZqK8iHYh4HSiAstJI/e7FReZZ/O4WNumK08tiK0C9ZyNgoSe1etNukZ8rL
	xNVGhcgZfH2zf6RYKHnsJHqWN61VTkTtueCdahFjRYQEZpo7McESkApUIfGGifJMLwG+7Pau6nQ
	Vu/3pwhOyQfCNaHDhti0QX+WBgDL+gb36zD4NYeo3KGzDTNmZMPzRk2SMMeIj/AGP9qsOrleWUz
	DwyV2/7A08NteN9Wsk90b1yAFCWF7OuPsnp+244O6RR19106Y1gF7+0t420mtgOo8bpStEpUMR+
	/ogyIZRFUTA4DLk0hqyyeyeM2qraPIMCTHdtBzoFxpp/yX1ClfbQnX/iBkYwnmAGUcGw+hhP5Rg
	eKEEIiWu11SxCyAKI9bhIILGHyaWPRYmnn6zDawawAD9YWXHaAAMfkiUIBI3FbKAbqDmG+1o5mp
	iT
X-Received: by 2002:a05:600c:4447:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48899785c7bmr44502785e9.17.1775217290584;
        Fri, 03 Apr 2026 04:54:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48899785c7bmr44502235e9.17.1775217290029;
        Fri, 03 Apr 2026 04:54:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm279873525e9.7.2026.04.03.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:54:49 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:54:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2] vsock: avoid timeout for non-blocking
 accept() with empty backlog
Message-ID: <ac-qD9dQU_JB9VvY@sgarzare-redhat>
References: <20260402204918.130395-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402204918.130395-1-laurencerowe@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l586HJNdjvcNspZRqhwCNguBNq89Bb-SBRaESTHLjmI_1775217291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Apr 02, 2026 at 01:49:18PM -0700, Laurence Rowe wrote:
>A common pattern in epoll network servers is to eagerly accept all
>pending connections from the non-blocking listening socket after
>epoll_wait indicates the socket is ready by calling accept in a loop
>until EAGAIN is returned indicating that the backlog is empty.
>
>Scheduling a timeout for a non-blocking accept with an empty backlog
>meant AF_VSOCK sockets used by epoll network servers incurred hundreds
>of microseconds of additional latency per accept loop compared to
>AF_INET or AF_UNIX sockets.
>
>Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>
>Patch v2 with feedback from Stefano Garzarella and Bobby Eshleman:
>
>- Move prepare_to_wait before release_sock to match previous behaviour.
>
>- Simplify not connected case.

Thanks for addressing them, now LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

