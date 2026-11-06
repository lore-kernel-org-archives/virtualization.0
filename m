Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975964;
	b=QVF9iuNC1FxiiNVyRbx0vxzL8J/NlaZTQpflvtBBPPRxs2X0uszZGcCtEvJ1+G5D22n5
	 JaKXT5R0jI9YQlbQ91Ed+xwT2Iwuk4BAoZIlwkeg1kYu2LOFQ2ogRzqTU8UNz+TYYkJau
	 3/Vo4B7uW3TrfYkFveDhOv6D9Ftc83L1Z5YPr/fo9IEvKNZx0lMMT4B/HYkD6zhB/zQtP
	 Kgungd3wnvuez9gQhGwU8WiDr4hKEoHYlkLdREkvO7m2nU6knqPbYM9ayTTNs+RQeMjU+
	 L5G7hy7+Y545L56Ee4fbcjiOgTmkL1zI7Y59S5DsIHEYiHa1cJtUmXz4ytVPJiI+EYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975964;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=jw4k8/l7OjfEQfabaCdma79pAAulRiNHmsMK6ks9B4zKPVJRdRfBclbXqrb1yFCLyPG8
	 Y8nJaHhS/55lLRPsvqjbnvDmaXc9/OMmNFCvmqRRxWokF2g97EceZME883TqozijROjx7
	 3B/NuDMw09Oa+5mpVQPh5+ZqWCdvwHJAQp5czAQWV8xREIpMt38FASmt0AyYURAyrTeOi
	 Q08kyPShV5BhMz857M/RbTs0nJP5jcv1xy4rXSzUJMJPdnP3x4uj/htbgCJMuiQqgW2vw
	 uNtyMey/CVksaQMl7dyf9lJCnepoZRL6Zf2FH/hsQTq9HYOysNw+Jr1oboY8qFrN02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYGl5ud9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D41606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 14:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D41606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYGl5ud9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793975962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=LYGl5ud9IUXxh8PTAMYUF372q8Djrg0tqCIJCC9Y1qWrPSwpWaMlqVQHYoFiiwQ7JqRWe2
	5P7hdkPrem5h71ewqyLbJBZJYMMDRLUV8Oc2Vpk7jzBCU9x5eqLoQZ6AwxKuXzvssZMK+W
	jyWBQjqA/WB3LZWysz6dfenVZAa5jx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-2Db06FC5PcKi6BfdHSoyUQ-1; Fri, 06 Nov 2026 09:39:19 -0500
X-MC-Unique: 2Db06FC5PcKi6BfdHSoyUQ-1
X-Mimecast-MFC-AGG-ID: 2Db06FC5PcKi6BfdHSoyUQ_1793975958
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-49090fde23aso745049f8f.2
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 06:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975958; x=1794580758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
        b=Nle/VOx1FMQydXq/xPbtRbQgvIAbV1iRYC7bzmz2cvCgI3J1x/gHDwXl45cbaZSlh8
         YpFRxvjadzwWfrzvz6EPpjOniUDgtoBrqIl+7QvJKsgFA3GHdrxbvCe5zlmP8Ie/Pm6m
         5yMasc2DHx7mPTdJ3gPiUEQ1EMmjxvGm2+S8qUEGJDEBmHAJ7CL+imHFG1pwlZSzf/ge
         tUTBVvSD/y0auvt4bx9GqXOGzJIZhK6+FXEsJ12X0fEVJwajwkeIODQODdB07HP+PIsI
         +TO0gUqcsTfnSYMu+JpYvbgclPNs8IGgYdg2FFLuwS/Llba/yoM2BczMD+Uvuc1xi5Vy
         zCXw==
X-Forwarded-Encrypted: i=1; AL+hErETBB6j4pJZJcX9n4s/H2OsxESwy7bPtuUn8ZCrlhnxGgjYmYBstrq64Ug4iiO3r8nuCsP0/0EfAb/6pUxV5w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1Hv4GjAeQbr7fUoVBQi2fTYPnuJdGHj23saiHO8Bnz+hUyCcw
	kDUBCIy+W3NXs6nbD7tpSAP2OrXZCDr2mRFUa8dK034vJjNbdoTwCEIcvQv9mVTIV/FVxBrEMqa
	TjrXsYsY4QLHDnmpn+muj+47aMN/92ciuXx8lX2qpSbGtvV/7TbXwaRiTMYI7g/CSYu2Q
X-Gm-Gg: AYBFou3PpR92XyTUBbH3jHKS1Fk0rw2L3CHmzBgUphimw3dceeuuv7K5NF8wlDZ31L8
	8qxP0aJ16YzwSmQjrFGHvQk06edW0q2DndJ/Yl+VdMlo9X78btiXZ83gHo0b0LhtmI9fg8C4KBB
	jseoHwE1DRdmzZ8yidK9a4PP+BjZzoA7aZobDEY5fSqoenclPCkP6Fnzdtd/nn9Qw94KW65SpN9
	MbfOKC3grLyPKDxJa1IJcGY5v+YR/RXnmft9f6ZogeUG18lMLXVrJgOHhLn569nUH5kq+Ld9U3c
	DjFSpb1Rduv5FBrTA5ck28JfgMYdHWs7HZE1rB9fINF8OSXkm9n+mRg8iIPw+fsjO+yGVT6XLvD
	9I41XsFzdw991P4FBmrwjcA38x7mCpPhFw28/DO+b5Rv93TZ4H4Kn
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363061f8f.57.1793975958205;
        Fri, 06 Nov 2026 06:39:18 -0800 (PST)
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363018f8f.57.1793975957758;
        Fri, 06 Nov 2026 06:39:17 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ad7sm4518709f8f.15.2026.11.06.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:15 -0800 (PST)
Date: Fri, 6 Nov 2026 15:39:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>, Luigi Leonardi <leonardi@redhat.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3k0TggFXTn6usw@sgarzare-redhat>
References: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P0J_GKPcxVG0-qKtscqdfyO1V2RyhmM_Gl7ZvJd0_Eg_1793975958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 06, 2026 at 01:39:18PM +0100, Andrea Parri wrote:
>The Hyper-V transport is assigned before the asynchronous VMBus channel
>offer completes.  Its zero-initialized hvsock therefore has a NULL chan
>until hvs_open_connection() associates the channel with the socket.
>
>SIOCINQ can query the assigned transport while the socket is connecting,
>or after connect() fails once the transport has been assigned.  Unlike
>poll(), that path does not check stream_is_active() before calling the
>transport's stream_has_data callback.  hvs_stream_has_data() then 
>passes
>the NULL channel to hvs_channel_readable_payload(), and any user in the
>guest can trigger an oops:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000178
>  RIP: 0010:hvs_stream_has_data+0x23/0x120
>  Call Trace:
>   <TASK>
>   ? vsock_ioctl+0x74/0xf0
>   sock_do_ioctl+0x42/0xf0
>   sock_ioctl+0x27d/0x310
>   do_vfs_ioctl+0x700/0x810
>   __x64_sys_ioctl+0x7d/0xf0
>
>Return zero unread bytes when no channel is available, before accessing
>the receive state or ring.  Leave the existing channel-backed receive
>handling unchanged.
>
>The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
>guest with a small user-space program, available on request.  With this
>patch, the program reports zero unread bytes and the kernel logs nothing.
>Other vsock_test cases were not run, as most of them need a host-side
>peer.
>
>AI assistance was used to identify the issue and develop the fix.
>
>Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
>An alternative is to check stream_is_active() in vsock_do_ioctl(), as
>vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
>are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
>limit it to the crash, and can send the generic check separately for
>net-next.

Yeah, I was going to suggest the same, but I agree that for net this is 
a better and self contained fix:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>The reproducer is a new vsock_test case.  I have not posted it, as
>Documentation/process/security-bugs.rst asks for reproducers of bugs
>found with AI assistance.  I can send it privately, and will post it
>once this fix is merged.

Yes please, post it upstream when merged.

Thanks,
Stefano

