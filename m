Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176271;
	b=n3O/a8nKAAhK+x2lgZKdiAw5YUDsN/A+MP/gq3UO3vP47ELxQ4HjLWjmgCm0Z7V5rmzJ
	 ERqUh65Dld9PtmH3DQ09EFibi8Dx/5F1h4nem2VAebxhlnwG4bCbYmqO9nwo19ejlz5Lm
	 Fm0p5QOHmZtjSm48UCGUgPAYT7j6ZGCVvFUAEphtvaBwFyazXptbX2pQfvJvCyAhJiOSF
	 E2JB8SfS67lbnEzKT1vB7nsi0MlXNE/2sVoI7s/2LKtoa4XYJHwLJ44tbjin64Cem76HW
	 qkJDwluBdI4hy6CTdSc70YbR6431hv1fQ63veF/hwHWAHHEYrp/QesGuCRb3cuNJSZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=o9ZJ6pGCSDoYScJrrf6fcpGhJH3AjdQcaPHKWiQruYnKrk9MuoOiCZssr3+nw3poJs5/
	 bYP5iThdw4WCo6qhfcfFA1Lrw9NBR0JVCJOL5piMl0AFOfJ5Fy9AC/K9XY5To5Yniv1qf
	 DfVqYkacRMz30QsZ8WROQgKN5rpjTqxJS+cfPMPyYJkqze/NBJmM77jeDNLvQyt1nbXOk
	 4Z8FeaP/jGLvxWUFtkTvuPYSV2trLVMSW6nLguOuUtQw3EeGF/u5GMqSVjIYgoHXdrUAj
	 8P/JItAbsDPX4fJO7wiGeNh5Qx8ZCfBiHzInjoVucQ9P4Mwio8PM0MiwYQYUlon2SJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BA606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669BA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3uQpmZf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795176269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
	b=M3uQpmZfqbVJjPN6Ut5ffQ1KdCKMRl+8gJz1myYwkFG1aq0X3VKJEUVBQLP3doPi+DUNx9
	2PX39Dt772bPI5TJ3ToksloECLyXG7+xp/tyBJmpkxe4MCgCA9C87PzUJ9F7cyp5D37Xl4
	2D5/e7fhqHGtwbEwFgIDC3pPnrYT0gk=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-6qWEsyhyMNqvQume7khg2w-1; Fri, 20 Nov 2026 12:04:27 +0000
X-MC-Unique: 6qWEsyhyMNqvQume7khg2w-1
X-Mimecast-MFC-AGG-ID: 6qWEsyhyMNqvQume7khg2w_1795176267
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67dc4e966b5so1012173d50.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 04:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176267; x=1795781067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQu0hGy1KA1uO4Dt43vnkVWs8fGf8xNR3xdR0Qb+GQo=;
        b=P+3oJzf99FZYrKvVlsGKXM73P5W4MYWI9b9/tIHw32rf8udbZ8wkiRp7/qkNCKR1dv
         trkIjX/eLgj45IZuool5pfMcrOQgmRJyvSIz2l3anfl9zIl8tAkg70mdTV5fkTc+JEmF
         R5F7NLfV1ED13DTROiVKTpB7cc+Tn2eFnl2axk7ZKwHA9U3C/wB5WQNU8kNeQkTUKU2r
         9AjoEV5hx4jE232tC3mK+pvRLYUFGzsxLF9AP5uzNF+ymHk84GQGxShfDGrKcbx0qKwM
         f+wyMxkS2Rguj0jDiVANXbJtxR1Pjv6R+/edWWIwh0ZahbWUfGeglziqb7oF2clkSIsv
         a9Bg==
X-Forwarded-Encrypted: i=1; AL+hErGd3PigNQVvk4QtUcThnsAqXi8aP8JDCUQ93sHAEjvT9+H3wCAA/zbJq2S/N5vWMAVaBvpJ37STku0zcWRDMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5200E+nu8K1nwuM7HPxUdrbbm5PwMcKiOnAHnXjBb+hgx7gHf
	/BZgS5ISxaCQ/Zbh0AFxkXDGcFki9hcXaHCdwzf/CcEhxXT2SevlF4a2QRaISz8uC/YqOEYrHh5
	Jd83o/+1Fi9tl93CROw2Cav25Nsc4aJ/P4Ovf0//V4Oxpce3Ikrir+mcKigWgNcorwaGz+BZfX3
	u2JsryHlbUzKx6Vmy8oITg1EBK4ZUDBY/+pwSuWVcGf7Ii6D6QOpNhbQ==
X-Gm-Gg: AZFdTZcWu6IeiXZkstyEs1g0QhHkmbDjcQig9lEcebY3XdHuvnhbz5NsfulU19CUjIh
	6ZvmkXz6EO9nG8oGFW5AXnaTYPcHKUvhn/zkdtKY/T4znMGZbfCGsNG+VGK4ERT4EfCL1x8xtv4
	pe6VzS9oSsrubKrNDBXeQ00k3gwnCPFamM4J9Vgot0qp2WeLF45mLEUBayyjP2XOtmZcNxTAuQI
	7mmovTItVnVyIz8pxOz/d/jeu5N751XpHr0E7Pw5wSQ0EzJP+WgbX/ENSE=
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id 956f58d0204a3-67df43cf48fmr1438615d50.18.1795176266696;
        Fri, 20 Nov 2026 04:04:26 -0800 (PST)
X-Received: by 2002:a05:690e:4090:b0:67c:69f:b1db with SMTP id
 956f58d0204a3-67df43cf48fmr1438589d50.18.1795176265935; Fri, 20 Nov 2026
 04:04:25 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
In-Reply-To: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Nov 2026 13:03:49 +0100
X-Gm-Features: AclHuK-i5EtKvbqYrIjTizPF6lX03AG63KfWC612II-z105w9vnQhBI_r_r_XiY
Message-ID: <CAJaqyWfpkenRAYdkeG2+XEWRhJbmV4ARZ+eMm=EibcA6i0z-5g@mail.gmail.com>
Subject: Re: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
To: raoxu <raoxu@uniontech.com>
Cc: mst@redhat.com, jasowangio@gmail.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: thcirqdhbT0QBDKNTdoREuJSNQZAIWBDjyuvC9UJw5A_1795176267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:39=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> sock_has_rx_data() returns a positive value when receive data is
> available. For sockets without a peek_len() callback, however, its
> fallback returns skb_queue_empty(), which has the opposite meaning.
>
> An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
> vhost-net backend, and its socket operations do not provide peek_len().
> With busy polling enabled for this backend, an empty receive queue is
> treated as ready and a nonempty queue as not ready. This can make
> vhost_net_busy_poll() stop polling prematurely or fail to stop for
> queued receive data, and invert its receive-side scheduling decision.
> TUN and TAP backends provide peek_len() and are unaffected.
>
> Negate skb_queue_empty() so the fallback matches the callback and the
> readiness checks in vhost_net_busy_poll().
>
> The issue was found during AI-assisted code review. The helper's
> incorrect result was confirmed on x86_64 running 6.6.0-amd64-desktop
> using a temporary diagnostic module containing the original and fixed
> helpers. An AF_PACKET SOCK_RAW socket, without PACKET_RX_RING, was
> bound to loopback in a private network namespace. Across three cycles
> of sending and receiving a 60-byte frame, the original helper returned
> 1 for an empty queue and 0 for a queued frame. The fixed helper returned
> 0 and 1 respectively, matching socket readability in all nine checks.
> This tests helper copies on real sockets, not the running vhost-net
> busy-poll path; the vhost-net module was not replaced.
>
> The patched drivers/vhost/net.o was also build-tested on the net tree
> with x86_64 GCC 12.3 and W=3D1 under allmodconfig and allyesconfig.
> No end-to-end vhost tests or kernel selftests were run.
>
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> Changes in v2:
>   - Target net and add the introducing commit's Fixes tag.
>   - Explain the raw packet socket backend and busy-poll decisions.
>   - State the AI-assisted discovery method and document the diagnostic
>     module test, its results and its helper-level coverage.
>   - Document the targeted build tests.
>   - Keep the code change unchanged from v1.
>
> v1: https://lore.kernel.org/virtualization/20261110051642.249640-1-raoxu@=
uniontech.com/
>
> AI assistance: OpenCode was used to inspect the history, prepare and run
> the diagnostic module test, run build checks, and revise this message.
> The code change is unchanged from v1. The discovery method was confirmed
> by the author.
>
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..10ed2d55ff07 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
>         if (sock->ops->peek_len)
>                 return sock->ops->peek_len(sock);
>
> -       return skb_queue_empty(&sock->sk->sk_receive_queue);
> +       return !skb_queue_empty(&sock->sk->sk_receive_queue);
>  }
>
>  static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
>
> base-commit: 435cbdaf9b03687498dc16fe4af8d16a977e21d0
> --
> 2.50.1
>

