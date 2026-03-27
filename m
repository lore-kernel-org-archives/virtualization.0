Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3235C1B5
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581758; cv=none; b=RoRLIzuy6kRH3/w6oos6bYCWKQ4X1FlPZ45awUGPt/lEMonL6JOHFOzCd2J+mp7KQTSQTYwCfSXO0hNfec4SHY3lCR2OEYCwMu6dOyAZlCBZhGm9BC7ORgUH/KxmpNq8ehCETd5aD8Dwfwy60Xw2xuvPjiWkzNaNB/+FGZlDP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581758; c=relaxed/simple;
	bh=m1mIuwXXzdAaR32dcGiWLRmK4DBpjIpyB0UUnbvcEc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuPeB1qalkthTbN8lopvsUfHxEej8kLadvprPC0Ra9QcLt9DtpZ/1bKSIU2zmvzNkEkgeug1LHmJ2XROG7KJu5NyU6jr6yJkK5J+vXlrO6R4YxvnTeN2Ev9k+YM7wuRQl5YirvrAhgX7oTL03zHd3o3xgC1HAcEU4Huprt4ifTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya59lGXm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya59lGXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774581756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
	b=Ya59lGXmtb56JX4nTT3bsB54zeisejXIggD3j6iCqp7LLn9VjDOUBcqlU9oPRyo1n3Y34K
	dfaN7H7sZBK+OJNakpnHSDohdQhRcQhjwFFTVomrhlEz/HSoSvlfiMnE7SeWcH1cgRmlvA
	Sd0PVmDm3CWignKYl6AKm4KOSa06ayQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-W-d3KMZfO766jD489iF0Ag-1; Thu, 26 Mar 2026 23:22:35 -0400
X-MC-Unique: W-d3KMZfO766jD489iF0Ag-1
X-Mimecast-MFC-AGG-ID: W-d3KMZfO766jD489iF0Ag_1774581754
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1422696a91.0
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 20:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774581754; x=1775186554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
        b=o6DrqT8kVqK8+HvCWe9AY03qdKMMdBUnGhra6MtK0N0SyvrYCV7ZDf13X/5WzbqvNZ
         tgVyNpA9QIqn/DbN1tj1LvOUiYaEhwHzQUiE/0WHj1ZYST3OthArk80cHq8KE4WVoe2Y
         3qUw241cFTlwrDgQYpm0qekFfN8nkO8tcUsQUdL2T4h3VRnVRLxSsqEq1+L09ZZXdZuz
         vNN57XW5uhCcKmtE03TJoLbR3+/JEU2duYNfTn8ifj2TSIGMzR1tqyfIBcF7nL4sbjDn
         Xdp1xMRxWXiwodAyuXavm2rSFEbOYorMKrAxxI6FlPvlfho4fT0lplyQxgtREmvVHDyy
         0zzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrPXQP1lOorK+AV3Akz8SYJMPC3GyTlEiFTw96qloFw2XEA80Y10GWgQwHwQThfCEt3WxvxserkN305IwAGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztRIjwcKqzhj2AaDhG2+fmKE9f3tDa+bP0i+PgLr9uch0WAA+Y
	53p9feJzG6fas6Gy3eCHt9C5OCwMcmfmlsNmP4cZSb6BR9lKp0PLHjdR4p5OT9LdjU3l4QpCopc
	4OaYqKh6tKMLCt8Ui8HzVqkvNx85wH74KwHxsWsBYbS22N8rVFz+oLmYeH7TY/p/PRhc5NB/oLF
	Jui66Z+5yXHxitgWOGqMTImQRdnOmgXJuIWmnMOK8w9pQ=
X-Gm-Gg: ATEYQzzj34ujiFdQ80XYuQO6M2JjSh52cSFd/bvoD3XfwjBjGhsh2pIxE01TESUl5JR
	al/Iyuz50puvy41ooap9S7q3o6Ght0Ju8x9S47r/m7EJA2hpVqwuZ71oqf1iC7v+EMDNlQgGdiv
	0jo8aoAeXtCXgrdfqOWaXbB/VqtauVOK+xJ/eYQCzFhX2ltkoOlPGC8e/WRuYx3/CFP79v9sFwK
	ni5JCA=
X-Received: by 2002:a17:90b:4a48:b0:359:ff8a:ee42 with SMTP id 98e67ed59e1d1-35c2ffa83cemr950733a91.3.1774581753699;
        Thu, 26 Mar 2026 20:22:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4a48:b0:359:ff8a:ee42 with SMTP id
 98e67ed59e1d1-35c2ffa83cemr950700a91.3.1774581753140; Thu, 26 Mar 2026
 20:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260323041730.986351-1-zhud@hygon.cn>
In-Reply-To: <20260323041730.986351-1-zhud@hygon.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 11:22:21 +0800
X-Gm-Features: AQROBzCFE5yNeudv1jbnEaHKk9QQ5gzetZYF03o_GcVqfFHFVnUqST7F4_jDeEk
Message-ID: <CACGkMEsM2n9hA0WEE3B6+YcLwwh=SvGYFWcKbKTyJvYkh=N8ng@mail.gmail.com>
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
To: Di Zhu <zhud@hygon.cn>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn, 
	yingzhiwei@hygon.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y13TO0vT1SBSKmrs4tR_bvlccf25ODNfbvvy25ZYdGU_1774581754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:18=E2=80=AFPM Di Zhu <zhud@hygon.cn> wrote:
>
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
>
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
>
> Improve the situation by masking off NETIF_F_GRO_HW unless the device
> possesses actual GRO-related offload capabilities. Out of an abundance
> of caution, this does not change the current behaviour for hardware with
> just v6 or just v4 GRO: current interfaces do not allow distinguishing
> between v6/v4 GRO, so we can't expose them to userspace precisely.
>
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
> /* v4 */
>   -Move the hw_features update logic before register_netdevice()
>   -Target the net-next tree
>
> /* v3 */
>   -Update Fixes tag to dbcf24d15388
>   -Refine commit message using Maintainer's "too optimistic"
>     phrasing to clarify the risk of misleading configurations.
>
> /* v2 */
>   -make the modified logic clearer

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

