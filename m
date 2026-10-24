Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827209;
	b=Ec4YZzrnLv3pzITxdqxCyIYzEeRvZmusq4ugbvY/2NGtF2KJQDBTZsBpnQ/kiKAJqk4/
	 nsEJBH/MX9DQLinYKFAobjVqjfshpI+jamDTTPOgwnABrrClvzaKXQFU5WhWd2/9wvPFg
	 rUnne0h5kvY9CDKuZkuv0RHCPJ022dbEkd1mSXi2H0QLUxTlckZZHjavrrkgA8t4J6g7w
	 Bxn8XZLdc+TdNbJry+b5UbjBS1WH+5JAbsw5D70QZk2/CCpg8yFJVccTKGNRqG/7Kp70b
	 pTYq4M6NLBtSiBVnm4P40+NN3vNHaJc/cKb+h6riQ6IAbmuC2Vr3eN2DjqLA9yZJKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827209;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ok3pjg22edXzQhuK8h6FzdRDjegD24d8xy6xP3Un7Og=;
	b=UfIQJcURWxJm84RQvyjJ10oxYouZlEhhKrNgZkuTCWfB+IMargUvxm8AqY0A80WMwlMx
	 RCFi6d3TPJ2SyD2LOfMNb10fc0tesWrvuKy1zo/Qf5vkfusleRopDuB9ahRWEMKpPoKdU
	 xtSS24ad6EGSK2MuLphNOvvWHPKHTn39CPaHvY5hK8O+0sQKKv2WHtZz147IEVe5WwNfA
	 FBPYv9RMyNovxfa2oUWuTvSHTnWuZUSZCWG5uJ5rAXEYgUPuk9kngXrQtlTeNRN600jvn
	 DCtFHK8c7uTXBCUKKb6FxQ9lOptaplwtRkLLUGbA7DaQEysH6r6pKECQtEhDyhpG0QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fzdllpE6;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DD606A31B
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 07:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31DD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fzdllpE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792827203; bh=Ok3pjg22edXzQhuK8h6FzdRDjegD24d8xy6xP3Un7Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzdllpE6O5GmIISEiixKEHXvpzrpblzndNtULG9lk+boRG5QVvg6kYzt38scv8siQ
	 x/72E1EbEy3WJe790wUVUz4/YSgUDCQH372K9wOMP8S4pxOlEMdQAIb3M69auBrmKn
	 4ycwP1iB0mEtYDnGkbI9wCgT+bq4Z+kIX24tM/F0=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 855128F4; Sat, 24 Oct 2026 15:33:21 +0800
X-QQ-mid: xmsmtpt1792827201t5bz1fjn2
Message-ID: <tencent_4528029FEDA8E7D49AEFE291032742538F07@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznoVYgx84LsIAP5h2YIyC95fLBj1+igaesL7k2a3y8AV0oqlqnGK
	 btgd/OgvLzUpyxM0HB9VguSu56OjljM2QW4Wu/w7OqtIbX34vVMB3He83DkZecQKvX49yOOBrB44
	 2FTsbOzykZZ8vzXIH1Ye2nEE95688cK4Uc8OyEzAWIczuLGbm3VOL/zX2pddpXtZ7lAwUDLbSXDS
	 d/7nQrXZH91K6eXxhd0gjSOrBXB/MXC0AatQkDjUl1ImEWkT8T82jkG0791+DqD8LY+la6w60I9k
	 LLPpbmdAM2laYP43dBS5MalHr8PtL/DW7FOps5oh9PTDK6DMn2sEDO4ssJJsZBztSTVnVL2Jetc8
	 NFErxvRoTc/0moD9/fH2GSFjHWp/rvQ1YYMPGLdNW2I7NBnpc45pJvEfkF66Kfzz4METLDmP621K
	 qVOSaPlPYWq0mjgWTZosT+TbZ8qUC3JwKpeOqfMWUtAfjCWj+wwY+x48MUfKJmCRMi+wkm48mInG
	 PhWdvrkVfAOuE2dUTL+KRVa3o9cRnoFBwalRX29Ps8xtk5VL4fRBEvcFV41sP0jjw25R+OTORkHB
	 1AS9wa3P4X1HGdHDOvsME337oNwzzfCNi6BY2l0b5nDb2w1RHMt9ZArSlnUW1fJN8oh2eoVWdyxP
	 Zk8AqZmtaSKI+heHUl4X/QvfjkTSdhcdqGAHcbzNwSums+0twgyOe52JTQqgRvU45QMqIRKe/iHj
	 gkfXHkrQ4ExzBwdswyn0KkPxCnchttF2isjJNM93q1xP3e6NTGB3+eWv+IEjcj3ZPLS92UPzSU9s
	 L1D2CxtQ2YvA0KONXcnDUfjlByj5exhl9VCwVHlKp5YKQkafVDm5pkkbACHoAbKOBfIXjs0FnTJ+
	 jNqSvFvgZY3k5kXROAq3PP3bQd7g/SRtqzt0VJ8FPmjX3+Dsy+HJBg7IPUsC3iDCGaWmP1gIaSD8
	 J9MDT2Qv1tZYmOtpqxLLufx7UpnqGeQbsbZ7WK85F1FhZTDSNWoqJU6OZkffvvVP3O8NrJeGeXU1
	 buyOLnoKzom+B9pZ3vh9EfNSf5gFE7gGqaLFao0dxclUxhefDvXLuu8rLcO9L/H8+BeD/nCLMux+
	 gylTKh7JM24jBQjGo=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Guikun Yang <yangguikun19@qq.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Date: Sat, 24 Oct 2026 15:33:19 +0800
X-OQ-MSGID: <20261024153319.61076-vhost-yangguikun19@qq.com>
In-Reply-To: <20261024150815.36216-vhost-yangguikun19@qq.com>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com> <20261023080824-mutt-send-email-mst@kernel.org> <20261024101101.71420-vhost-yangguikun19@qq.com> <20261024150815.36216-vhost-yangguikun19@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

First, a correction to my previous message: the AF_PACKET injection in
that run never actually worked.  I took the "ifindex" from the ifreq
returned by TUNSETIFF, but TUNSETIFF fills in ifr_flags there (the
values 4098/20482 I printed were BROADCAST|MULTICAST|VNET_HDR flag
bits), so every sendto failed with ENODEV and no packet was ever
injected.  The all-0xAA buffer in that run only shows that no packet
was processed at all, and the "payload starts at offset 24" claim was
wrong.  Sorry for the noise.

I fixed the injection (SIOCGIFINDEX by name) and re-ran both
configurations on 7.3.0-rc7 with a 64-byte broadcast frame injected on
the tap.  With IFF_VNET_HDR enabled (plus TUNSETVNETHDRSZ(24)) the
result is worse than stale bytes: the packet is consumed from the tun
queue and then silently discarded, so the guest sees nothing at all:

  tunnel mode (no IFF_VNET_HDR), sendto 64 bytes ok:
	hdr: 00 00 00 00 00 00 00 00 00 00 01 00
	     aa aa aa aa aa aa aa aa aa aa aa aa   <- stale 12..23
	     ff ff ff ff ff ff 02 02 ...           <- our frame at 24

  tunnel-vnet-hdr mode (IFF_VNET_HDR | TUNSETVNETHDRSZ(24)),
  same 64-byte sendto ok:
	hdr: aa aa aa aa ... (all 32 bytes untouched)

The guest buffer is never touched in the second run.  The packet was
read out of the tun queue and then dropped.

The reason is a peek/read size disagreement:

  - peek_head_len() returns head->len, i.e. the raw skb->len.  The tun
    vnet header is not in the skb; tun_put_user() adds vnet_hdr_sz
    bytes at read time.
  - With VHOST_NET_F_VIRTIO_NET_HDR negotiated, sock_hlen = 0, so
    handle_rx() computes sock_len = peek = skb->len (64) and calls
    recvmsg(sock, &msg, 64, ...) with a msg_iter sized for
    vhost_len = 64 + vhost_hlen(24) = 88.
  - tun_do_read() delivers skb->len + vnet_hdr_sz = 64 + 24 = 88 bytes
    and returns 88.
  - handle_rx() then sees err (88) != sock_len (64) and takes the
    "Discarded rx packet" path: vhost_discard_vq_desc() rolls back the
    descriptor, but the skb has already been dequeued from the tun
    receive queue.  The frame is gone.

So for a tun backend, the three combinations are:

  VHOST_NET_F_VIRTIO_NET_HDR | IFF_VNET_HDR | result
  ---------------------------+--------------+--------------------------
  off                        | on           | ok (classic: tun header
                             |              | passed through)
  on                         | off          | header written by vhost,
                             |              | bytes 12..23 stale (the
                             |              | patch under discussion)
  on                         | on           | every packet consumed and
                             |              | dropped, guest RX blackout

VHOST_NET_F_VIRTIO_NET_HDR means "vhost supplies the header, the socket
data has none", so it is only consistent with a backend whose
vnet_hdr_sz is 0.  When the backend has vnet_hdr_sz > 0 the peek and
the read disagree and handle_rx() eats every frame.

Given that, I don't think disabling "vhost + !IFF_VNET_HDR" is the
right fix: that is exactly the combination VHOST_NET_F_VIRTIO_NET_HDR
is for, and it works apart from the 12 stale bytes my patch addresses.
The combination that is plainly broken is "vhost supplies the header"
together with a backend that supplies one (IFF_VNET_HDR set), which
today results in a silent total RX blackout.

So I'd suggest one of:

  1. Reject VHOST_NET_F_VIRTIO_NET_HDR (or refuse the backend attach)
     when the backend's vnet_hdr_sz is nonzero, so both broken
     combinations become impossible; keep my patch for the stale bytes
     in the remaining valid combination.  The backend header size could
     be queried at attach time the same way TUNSETIFF-derived sockets
     are handled today.

  2. Keep all combinations and fix both symptoms: my patch for the
     stale bytes, plus making the peek path account for the backend
     header so peek and read agree.

Happy to test whichever you prefer.

Best,
Guikun Yang

