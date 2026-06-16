Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340023655F0
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614803; cv=none; b=eL4iBE0UiJBDs3OAwej1Ucruwh/tP3WYiyKStusPVn1MWoLeH2V+O2wViLBIa8tx1vSRSWu2O7RjcNXreFBnN1RcS1Yjap6g6HbTsxIrb3POH9tUjlvwXiOc0W9ECiSjYl+78RfgBu0T+Q8hTllqXlwZndrN+vdnvWQDqH1te24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614803; c=relaxed/simple;
	bh=bhB8cqYkdx99HnRuLaoyAkAfNvz4q6LWBo4ONFNXjmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r80TD3xZWHUJNP4xBC6XYKn5urV21X8/HSooVc88ZsfY0qPsk1wdt/hNTctAvr2lLyz2k4nOCEia2xq3r4Fce8nLXYzM56zzpZqzMROhT+j5SCymElXyPY+j87PG2E+e/SWrFshm9YI3N1egIpXxJMIeadr00/BYK3gCXrr/zmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izDkDBJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izDkDBJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781614801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
	b=izDkDBJ7Z9CQ+t9sVivC6Fwt7u0570xgxg57lwKfLkuRLZVXR7g/lOyLyRryNTXuBpzFn8
	Dpr6Rb3M93oiOWlRL2ymPSwCcImleQkcSAKSx+mrqlt5ciA2q9kRjAFZkrlHyPiTqXe2Ws
	Aw74I8u0mEIbjU253CKkjOkysy7lWxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-uUTERVajOaOU_7wHd7Nleg-1; Tue, 16 Jun 2026 08:59:59 -0400
X-MC-Unique: uUTERVajOaOU_7wHd7Nleg-1
X-Mimecast-MFC-AGG-ID: uUTERVajOaOU_7wHd7Nleg_1781614798
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso29363235e9.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 05:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781614798; x=1782219598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
        b=Mx85IZJSdbERBnsZLXyM3zaha0QhOzDBrfwVoriCNZEWwAmuzLHnN//lZVAOEsKWym
         MbtSr11eEuVHgHnIfGjAO0Tgk+7gqi8n6nJGclwer543d8TtX7JugM/JLDw/PIkJHmKv
         rtnrWDX4lC/haaGa0sCjQEW1SO2wVOJnMjfQJwOMiDWHg9tBulQghEAmCGTZQEn72xlN
         9ZIHmwjGbpwQ1deh4hlFkjoc/gDfsHcLmpmqZiTK38w2zUobqcqsyYxMaqiLrAYBktbX
         ivx/Q5YwDysc2pcPMf9S8uuPuLeigh4wkV/M+Xa9Di9w0Y6nCjWAEfWJ3wsHTy7hu9tp
         +9Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/1+WQ43NsbyujbZHn358YYs+c4MkGU9ssjq9aw+fXtOaPaM7rOt2v/ZQI/7tP30ywshwfYeWYjL4q/GBuj3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcxaTmn1dpdfo9qSExlgdLyHUdPkPlN7DxmzV6sWmNkheGlp2f
	l8YFLI+FTXBchYKO9oE8eZBRyQBRcw3DgXwngjEYodUCMM93lpVc/pHkpNDqZ4c0dK2lo4jj/Ah
	k6Rf63OPf7trjbBMuHcwsgGXnggCulm62QZVlW0UAbPcOXQsScJDBlBHIq774/u9pnDlR
X-Gm-Gg: Acq92OGmqkvXeIY/Nq9ClbICmFI4yP3rP5gpct+5oe+LyCitvZiQrd7TnUSasOGl3Ew
	cbuTG75j/l3vVSZs7RKVRoDuUHQ5fr+9M3vF2c4hnzUIHq+ADrTVVjF7bvAqVZhbcB02+FGPe5o
	6EisOYJTdht0O8zizjqx79zM3J7g6IisOmqoXAYGjH26feEBM2LKL0QmwAliS1CYwSnIsHe+lVo
	g0ajeva0ruWaKFk+rXudMs7xJJyrObJ6ylpE+iwielfxrRGiiDn6AMqt7j6zyofEzvndrwQrMo1
	SZ/5yViXlBwvy0kkMyknjMNEVPGuSMMwr6/vvjElhSC/67XSoFv0CqIkdc80aZyB8tRhW8Uv62I
	8dbH28H9IsC3PJukXhqURGfmbDQgAemfu2vBGcRn2e765dGvRv/onteqgcjjkpfKnG18YxLg=
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190086695e9.34.1781614797562;
        Tue, 16 Jun 2026 05:59:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190084565e9.34.1781614795388;
        Tue, 16 Jun 2026 05:59:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm131444255e9.14.2026.06.16.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:59:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:59:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>, g@sgarzare-redhat
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 2/2] vsock/virtio: restore msg_iter on
 transmission failure
Message-ID: <ajFEpMnHsxAYJSOa@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-3-tavip@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260613000953.467473-3-tavip@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cw2BIa6yMuFjCb0tZguAyQhmgE-dQjHGPkQ__ixYjto_1781614798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Jun 13, 2026 at 12:09:53AM +0000, Octavian Purdila wrote:
>When transmission fails in virtio_transport_send_pkt_info, the msg_iter
>might have been partially advanced. If we don't restore it, the next
>attempt to send data will use an incorrect iterator state, leading to
>desync and warnings like "send_pkt() returns 0, but X expected".
>
>Specifically, this can happen in the following scenario, triggered by
>the syzkaller repro:
>
>1. A write-only VMA (PROT_WRITE only) is partially populated by a
>   prior TUN write that failed with -EIO but still faulted in some
>   pages).
>2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
>   buffer from this VMA.
>3. The first packet (64KB) is sent successfully because the pages are
>   populated.
>4. The second packet allocation fails because GUP fast pins the first page
>   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
>   permissions.
>5. The iterator is advanced by the partially successful GUP (68KB total
>   advanced: 64KB from first packet + 4KB from second), but the send loop
>   breaks and only reports 64KB sent. This creates a 4KB desync.
>6. The next retry starts with a non-zero iov_offset, disabling zerocopy
>   and falling back to copy mode.
>7. In copy mode, the transmission succeeds for the next packets but
>   exhausts the iterator early because of the desync.
>8. The final retry sees an empty iterator but zerocopy is re-enabled
>   (offset resets). It attempts to send the remaining bytes with zerocopy
>   but pins 0 pages, creating an empty packet.
>9. The transport sends the empty packet, triggering the warning because
>   the returned bytes (header only) do not match the expected payload size.
>10. The loop continues to spin, allocating ubuf_info each time, eventually
>    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.
>
>Restore msg_iter to its original state before the packet allocation
>and transmission attempt if they fail.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
>Assisted-by: gemini:gemini-3.1-pro
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

Thanks, looks much better to me now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

