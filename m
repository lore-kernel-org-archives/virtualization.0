Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863643CC7F8
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561726; cv=none; b=S996YNuDhZCucPGKJW9GO5XNB8PGgUgAY05ThA0LgsjcW2r7YOyPT9DkPn+p35ryM90S4vYJ46UgAyByaIvZt2i2pS9hcJY27SeXaNQrsbY9zVith35AcYOgoLZI5McSRfL4P0Pcthbj+tEpVex64i9eeiDj8rB3ZltYSXYG3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561726; c=relaxed/simple;
	bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nj0iEQhlBiwysGAjkbyIMWEnG8jaoPLIKUF71rsWBYAZttXdhTdrC8Hq5W81p8QYYz88eTBZvdTG0TF0bdylz3SJIjyMyMV26MQh8SOkmU2WiGhKbPci1ECoch/Tkufu+SYJzxRwQWuuh/8D9KcY63Uxjbhr38nZdEGp1Dn48sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsrbUSQD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsrbUSQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
	b=IsrbUSQD3cRT+iOwAIAGpPNTxkoOkUaNm6we2ZX8eIquEzWqtlqjvERGl3F30KJFYicLZx
	v7OUQX1NKVDlbcvLCSk1w+05om7iGDbo7jjTSgLvk8kijrIl2MunSU7oMK59gfX1ucrdYg
	4VjMa/Y7u67W2NpcHbAnHnTvgjJGWo0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-hZCv2Dw6NCO5FMgFggiIXg-1; Wed, 16 Sep 2026 08:28:41 -0400
X-MC-Unique: hZCv2Dw6NCO5FMgFggiIXg-1
X-Mimecast-MFC-AGG-ID: hZCv2Dw6NCO5FMgFggiIXg_1789561720
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso51409475e9.1
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561720; x=1790166520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xl+U70fbkUqzVeG1dKiFnh1LU4j3E1hpm3qW61N6DYE=;
        b=QZQuFVvkl7GkGqw3AyaAm9Y7COeTS0uTeM2pNklFaA4yd56lNanqg0AyY0sIJnlr68
         r/70F79+x3tzBC9EYQavfwbPgQHkdytOBwcbMzToo67DaZWp0xSV4DG/ecLwjJ+1cZfD
         tHeyKLbiib4D+YBYqygTvEgD7xMfRz2ZjkZtq5hfFyirnL37ZfsR59g0wEbZnm/sOnnc
         Bok3GbRmIi0FTK8+Z+/3Swi9JBGGqFhH5HgDLUPAs12L3J/33ObIjDMCzCXb2EL3RpbY
         RwKxRcBeDiziyvaajngMIxpm1Q7JhyJGwUiXTIJLQopeZhCFVARrHglW8cbBwEwTb6u+
         LS1g==
X-Forwarded-Encrypted: i=1; AKwUvBzT9SsPy57w/4zjkxuBgouuitnSh8ULSs/qh5w7UfC1n61uvQ2zgWcAar1RlleFpUDJjFen+3tmKYXN7zqSeg==@lists.linux.dev
X-Gm-Message-State: AFuF++n0Iq10dZH9w14zkYaxvABGPfypFYRQJwddzCc1XrJHKI9j5tAx
	AcuicgJoGttT36NkdQm3fe5WgwK26uHp07Z0dusD1VmObDTGPMGzErmhnQ+bmIMcSs7ACoDQnRs
	/gkxbxYOLThQlluSuXJ6mDAinCrYtPm6miwsU2v2Gb9yM+xXsMFpW/KadzucW4PT19rik
X-Gm-Gg: AYBFou35sobxPT8OmSIaQy7tasN33WsRQ5vhYboxOWlC6fVe70fBar1R9QMEo4I8JPC
	3exZ9+Ugs2YfH+1UnBk0Nu4AFlYeuRMlF1/lT9QosBJNG7f8XVFQ9WFnCTwZqgvHF4TmUj84Wja
	qnaMYkApdnGINt2hHJn9g6BFkR9icTmlYDcTlohLR0BrCaWZdZEcA6OyCkX45TDpPC7QosoEiDq
	6ZKaHKH67TW7NVJ8fICbh4QgIYdyKesLsXjZnArtklpxyHNASSwf1/0PToi0NR/T+E28xoCsz6L
	VXOg6k6RI+TD0jnO29e39eMJZamSgfREaJHIpTmITnM2/+5v1Kt4uUOUd+T5wuKkh4AA69yRktv
	f1JoC0hmSR4ENBIrf5ZV4UsyVApDYyBki/kCyRiBV+IpfxA==
X-Received: by 2002:a05:600c:6592:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49eb7326586mr62423005e9.9.1789561719787;
        Wed, 16 Sep 2026 05:28:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6592:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49eb7326586mr62421665e9.9.1789561719193;
        Wed, 16 Sep 2026 05:28:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7642sm6490127f8f.5.2026.09.16.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:28:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:28:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vhost/vsock: Fix socket state constant
Message-ID: <aqp2w_FZlZoR2lFY@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-1-a1d9abb472f7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _XlJLiiLN9fUu1GI1SLeqdqwbNAvVr2Ny5uHvmbsIvg_1789561720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 03:15:12PM +0200, Michal Luczaj wrote:
>Refactor under Fixes missed one: SS_UNCONNECTED (1) -> TCP_CLOSE (7).
>Until now, sk->sk_state = 1 stood for TCP_ESTABLISHED.
>
>Fixes: 3b4477d2dcf2 ("VSOCK: use TCP state constants for sk_state")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> drivers/vhost/vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

