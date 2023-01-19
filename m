Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E7EC004D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 10:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C5541949;
	Thu, 19 Jan 2023 10:49:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76C5541949
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=deqVDl3O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_ge2wWyf9pd; Thu, 19 Jan 2023 10:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE3BE418B6;
	Thu, 19 Jan 2023 10:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE3BE418B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93493C0033;
	Thu, 19 Jan 2023 10:49:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C368C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3806041949
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3806041949
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDMZiFmHpgya
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D2AB418B6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D2AB418B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674125352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tgsg+jKubTh3yv7ZSKQzF4Qxnk67C2646FcSbn/LaRg=;
 b=deqVDl3O5RY7y/7dCvc3fa2E684cOn/Nt87fSYJx/NekiQVWj+U4aLziAqFj1Z08EG5nVl
 xOgS+9v72VGFL8Qnogzm4wmONep+Ki2+LjVO9NJXFP1fFdwXMr3+afVrNnZP8zCkmbYTmZ
 XRrXhWF6EJYL1IzQaWqrv4asRytM9bY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-l0MsltZ-MHmTL3RBgL8stw-1; Thu, 19 Jan 2023 05:49:11 -0500
X-MC-Unique: l0MsltZ-MHmTL3RBgL8stw-1
Received: by mail-qv1-f71.google.com with SMTP id
 x6-20020a0cc506000000b005349c8b39d6so802522qvi.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 02:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgsg+jKubTh3yv7ZSKQzF4Qxnk67C2646FcSbn/LaRg=;
 b=XGT9qywf6ksBZAPqLTAFhNQG3h4m0nn51uii1SWZDwlGnoH0DYW0gLYUviZBjbbkLV
 kGHMUeIfgHArnmVmLbRtsLcRE4TXHlY3NvaB3pqNljpMRK62lbcXWcoasd+38FO5rV3K
 RPqBC5RlXjdwRE30UimAjEFZiw4GJRSS5a3hMzm6V4wb2KMHeMWjw7oZTQ+e2mUFkY0H
 TsUT1VV2Eq4hzfi831JwpI2DKJlkH6pEuhcOR0Z2QOQW1hVYCdKqiXX8XLoTFUgDKAHK
 Ld6t5zLfMztA8fc/NgJLGJ2ObL4tj8Qn3niu3918NCVd0A+0GzJpTfdRTQAjEKEJYwvN
 ss6w==
X-Gm-Message-State: AFqh2kq0kzW0IYnttaUQxNIe6ytTABo3ocCJrOGK937sN6vmBAuPmlkt
 piCCdZDg/S6DIYgrcJLdUbTxNZxEmUvyevD4zb7XERge8GwyaY3FYUeCoyG4bbWFmEutuEXdRu4
 ukKcwXlSmMDKXwz5sD0oV3o4hTyfI61eW3ZfPgmkKVw==
X-Received: by 2002:a05:622a:1e09:b0:3a7:f424:3ef9 with SMTP id
 br9-20020a05622a1e0900b003a7f4243ef9mr15448766qtb.13.1674125350350; 
 Thu, 19 Jan 2023 02:49:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsJI/f+MaH+UXrw024umAES6RkR56bZGB0+a4DzacCjXf+fQdTonSXjzep3SUU/ku7BhybcWw==
X-Received: by 2002:a05:622a:1e09:b0:3a7:f424:3ef9 with SMTP id
 br9-20020a05622a1e0900b003a7f4243ef9mr15448743qtb.13.1674125350057; 
 Thu, 19 Jan 2023 02:49:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-245.retail.telecomitalia.it.
 [82.57.51.245]) by smtp.gmail.com with ESMTPSA id
 q3-20020ac87343000000b003b6464eda40sm2568175qtp.25.2023.01.19.02.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jan 2023 02:49:09 -0800 (PST)
Date: Thu, 19 Jan 2023 11:49:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC 0/3] vsock: add support for sockmap
Message-ID: <20230119104902.jxst4eblcuyjvums@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Hao Luo <haoluo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Bobby,

On Wed, Jan 18, 2023 at 12:27:39PM -0800, Bobby Eshleman wrote:
>Add support for sockmap to vsock.
>
>We're testing usage of vsock as a way to redirect guest-local UDS requests to
>the host and this patch series greatly improves the performance of such a
>setup.
>
>Compared to copying packets via userspace, this improves throughput by 221% in
>basic testing.

Cool, nice series!

>
>Tested as follows.
>
>Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
>Threads: 1
>Payload: 64k
>No sockmap:
>- 76.3 MB/s
>- The guest vsock redirector was
>  "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
>Using sockmap (this patch):
>- 168.8 MB/s (+221%)

Assuming the absolute value is correct, there is a typo here, it would 
be +121% right?

>- The guest redirector was a simple sockmap echo server,
>  redirecting unix ingress to vsock 2:1234 egress.
>- Same sender and server programs
>
>Only the virtio transport has been tested.

I think is fine for now.

>The loopback transport was used in
>writing bpf/selftests, but not thoroughly tested otherwise.

I did a quick review mainly for vsock stuff.
Hoping others can take a better look at net/vmw_vsock/vsock_bpf.c, since 
I'm not very familiar with that subsystem.

FYI I will be off the next two weeks (till Feb 7) with limited internet 
access.

Thanks,
Stefano

>
>This series requires the skb patch.
>
>To: Stefan Hajnoczi <stefanha@redhat.com>
>To: Stefano Garzarella <sgarzare@redhat.com>
>To: "Michael S. Tsirkin" <mst@redhat.com>
>To: Jason Wang <jasowang@redhat.com>
>To: "David S. Miller" <davem@davemloft.net>
>To: Eric Dumazet <edumazet@google.com>
>To: Jakub Kicinski <kuba@kernel.org>
>To: Paolo Abeni <pabeni@redhat.com>
>To: Andrii Nakryiko <andrii@kernel.org>
>To: Mykola Lysenko <mykolal@fb.com>
>To: Alexei Starovoitov <ast@kernel.org>
>To: Daniel Borkmann <daniel@iogearbox.net>
>To: Martin KaFai Lau <martin.lau@linux.dev>
>To: Song Liu <song@kernel.org>
>To: Yonghong Song <yhs@fb.com>
>To: John Fastabend <john.fastabend@gmail.com>
>To: KP Singh <kpsingh@kernel.org>
>To: Stanislav Fomichev <sdf@google.com>
>To: Hao Luo <haoluo@google.com>
>To: Jiri Olsa <jolsa@kernel.org>
>To: Shuah Khan <shuah@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>Cc: kvm@vger.kernel.org
>Cc: virtualization@lists.linux-foundation.org
>Cc: netdev@vger.kernel.org
>Cc: bpf@vger.kernel.org
>Cc: linux-kselftest@vger.kernel.org
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>---
>Bobby Eshleman (3):
>      vsock: support sockmap
>      selftests/bpf: add vsock to vmtest.sh
>      selftests/bpf: Add a test case for vsock sockmap
>
> drivers/vhost/vsock.c                              |   1 +
> include/linux/virtio_vsock.h                       |   1 +
> include/net/af_vsock.h                             |  17 ++
> net/vmw_vsock/Makefile                             |   1 +
> net/vmw_vsock/af_vsock.c                           |  59 ++++++-
> net/vmw_vsock/virtio_transport.c                   |   2 +
> net/vmw_vsock/virtio_transport_common.c            |  22 +++
> net/vmw_vsock/vsock_bpf.c                          | 180 +++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c                     |   2 +
> tools/testing/selftests/bpf/config.x86_64          |   4 +
> .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++
> tools/testing/selftests/bpf/vmtest.sh              |   1 +
> 12 files changed, 447 insertions(+), 6 deletions(-)
>---
>base-commit: f12f4326c6a75a74e908714be6d2f0e2f0fd0d76
>change-id: 20230118-support-vsock-sockmap-connectible-2e1297d2111a
>
>Best regards,
>-- 
>Bobby Eshleman <bobby.eshleman@bytedance.com>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
