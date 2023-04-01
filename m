Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D8AC76196
	for <virtualization@archiver.kernel.org>; Sat,  1 Apr 2023 01:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6FA3421D4;
	Sat,  1 Apr 2023 01:06:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6FA3421D4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RciMOpzW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZr8tEHGqHnr; Sat,  1 Apr 2023 01:06:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E513E421DE;
	Sat,  1 Apr 2023 01:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E513E421DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4717C0036;
	Sat,  1 Apr 2023 01:06:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 746BFC002F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  1 Apr 2023 01:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 488AF60BC6
 for <virtualization@lists.linux-foundation.org>;
 Sat,  1 Apr 2023 01:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 488AF60BC6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=RciMOpzW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ofkK33hEYq0
 for <virtualization@lists.linux-foundation.org>;
 Sat,  1 Apr 2023 01:06:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75F4960B79
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75F4960B79
 for <virtualization@lists.linux-foundation.org>;
 Sat,  1 Apr 2023 01:06:12 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 e15-20020a17090ac20f00b0023d1b009f52so27250499pjt.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680311172;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lptAq23Bhxck5w4z/rG8RS6tmRRir3me5yWghBfZL5w=;
 b=RciMOpzWuO92XZZ491w3Y2DRYMTk1B/OuOYYEgSqs4w2yJ0FKDEx4PyPOdLPXVASLH
 HeNugxvV6lVKFtQbAgjusSVnN9Qa3BspUavTeWaWlaIeltduRQTJSlUHWifbYgZmKH3c
 1ajobv052ByD1ZxgrIGtq1u2IKSDh1m7NdRJVyBf1RS+Ruf1FQ9wFDfES6V9whcJkHrz
 kZXHZypSh4qPhO6ZOH9F3jdQjxnrIc5h1CQas2SI7zzvi6FwmjJ87DDlt09VxHlmKZXT
 TQ5TZsq3YlPOqJ01h6OlRLwQ5bduGep0FyhfMuRNKh9+q3jDIOFIZUfrx3mzt2PnP7VJ
 5Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680311172;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lptAq23Bhxck5w4z/rG8RS6tmRRir3me5yWghBfZL5w=;
 b=Lc9s/dyq1Y7s46CU4upTGVsuAGhRqygQ6qtOCVIlpS2iI1hziC9rTcUf5JgtSIqRb7
 HnnAI8vqf2PjtEKgRpIK1dXKvFaLvjy5GCSJMrG04sZl+AR8a4ihRnKeVq95S+bWbOKK
 8oFIZmCepAjW27W1Jo+4hjBD+2UOeyOiXf/VRVJxU1S6PVt0m88OTLeINgYxzUP53E6+
 0+Gc7KJWyHExWKY/n7dIGZsidxLCGfgIYBiBf3z0r21wVBuMJTcxEpHhVfHqPgz3+NNF
 2X2LBgVf9VMy4jwHCwDL3I8rdswvEQlJ6Q2C2msLzbCTBGND+rSXPvXiyk7y1NcxtdXc
 GFdQ==
X-Gm-Message-State: AAQBX9dpN/1/s4e3OsxZ4htxH88KnoZYVzxmrY5nfgDzTqNMUT/sKGss
 nUaTuwspjnQY+pB6Jva7hx0=
X-Google-Smtp-Source: AKy350Z8u3DIY9zOK2GGbRh+IzTtZrAQZu687R480OVrDZT6cATs8RfxE2bQUMA6S8EqfzHYuLBzNA==
X-Received: by 2002:a17:902:fa04:b0:1a2:85f0:e747 with SMTP id
 la4-20020a170902fa0400b001a285f0e747mr8814999plb.41.1680311171897; 
 Fri, 31 Mar 2023 18:06:11 -0700 (PDT)
Received: from localhost ([98.97.116.12]) by smtp.gmail.com with ESMTPSA id
 w16-20020a63c110000000b0050f6add54fcsm2204421pgf.44.2023.03.31.18.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 18:06:11 -0700 (PDT)
Date: Fri, 31 Mar 2023 18:06:10 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Message-ID: <6427838247d16_c503a2087e@john.notmuch>
In-Reply-To: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
References: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
Subject: RE: [PATCH net-next v4 0/3] Add support for sockmap to vsock.
Mime-Version: 1.0
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Bobby Eshleman wrote:
> We're testing usage of vsock as a way to redirect guest-local UDS
> requests to the host and this patch series greatly improves the
> performance of such a setup.
> 
> Compared to copying packets via userspace, this improves throughput by
> 121% in basic testing.
> 
> Tested as follows.
> 
> Setup: guest unix dgram sender -> guest vsock redirector -> host vsock
>        server
> Threads: 1
> Payload: 64k
> No sockmap:
> - 76.3 MB/s
> - The guest vsock redirector was
>   "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
> Using sockmap (this patch):
> - 168.8 MB/s (+121%)
> - The guest redirector was a simple sockmap echo server,
>   redirecting unix ingress to vsock 2:1234 egress.
> - Same sender and server programs
> 
> *Note: these numbers are from RFC v1
> 
> Only the virtio transport has been tested. The loopback transport was
> used in writing bpf/selftests, but not thoroughly tested otherwise.
> 
> This series requires the skb patch.

Appears reasonable to me although I didn't review internals of all
the af_vsock stuff. I see it got merged great.

One nit, I have a series coming shortly to pull the tests out of
the sockmap_listen and into a sockmap_vsock because I don't think they
belong in _listen but that is just a refactor.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
