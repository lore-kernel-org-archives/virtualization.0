Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE831C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 08:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7279A60ADD;
	Tue, 28 Mar 2023 08:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7279A60ADD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y3mqYqdx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kw8sizZaW04Y; Tue, 28 Mar 2023 08:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 051C760B00;
	Tue, 28 Mar 2023 08:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 051C760B00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB0A4C0036;
	Tue, 28 Mar 2023 08:20:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97243C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 08:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6553460B00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 08:20:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6553460B00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFykmE6uGUQZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 08:20:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B6D960ADD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B6D960ADD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679991614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q3X0O+/TM7LVotJgrmc2xoQ/T0kA0UQLhsWOW/x515A=;
 b=Y3mqYqdxq1z3MEV+ITgCqpS4jTeOZP0aha3maPOaIOyhNk3Fg7rqMEYLW7BmtQa5Qye+vk
 sqZlEFSGNlOV/Rc0K+7yDQUCv0RlPAqpKrz+RCbz7RkHI4dloGw6Z4IniC3wU+6o/5GR7w
 JSQlMpdPO9iJiLGWZRCtaMffFiREOWY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-aupTKQfROWmhsB9muqFzGQ-1; Tue, 28 Mar 2023 04:20:11 -0400
X-MC-Unique: aupTKQfROWmhsB9muqFzGQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 b142-20020ae9eb94000000b007486a8b9ae9so2644099qkg.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 01:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679991611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3X0O+/TM7LVotJgrmc2xoQ/T0kA0UQLhsWOW/x515A=;
 b=CYfAl4y8UdP290JfdwtnqbHYys7Q1gGJOVjvOs+WiiEHBavCTQEeKtBZeGyhRR3YqS
 0NLcypcIrBkWA7E5EV0cURzUHRXP9i+URfpksJEcYf5mcZiboF5LJkAiBBlwg7SA6gek
 8Ljdh/NHAvigINh35bI7Iz6uJmV2mGZksHbQedBRsgg+wMRRwibYzvxXl5fBBKoJDKi4
 F+c916ZBzIC2jVWXGa8OGko54HESAr7nkG9vgX2G16lXI0M24U7HqOo5cnu7zLvnmNy+
 DXXmzvZsuv7aVuStinLJAcLmoKxfNqC5KHDuNIX84dvZWMRzyM5g4dGU830q00MJX/h/
 f5xA==
X-Gm-Message-State: AAQBX9dIumNcFtw9J491y9gXgtKy/dza6v3CIce11ZlPldFyjjJM+U5C
 h51orSSxHoNQHNuSTGwu3Mi9MsrnWxdU7MthPRAtvWFr9EiwJSbt2N0tHwOxaAMaTsPjdjCrU6p
 j/bYp8tZB3x3JPB7Egtwg+A0EX+rsr7fzbX6Hf1caAw==
X-Received: by 2002:a05:622a:118a:b0:3e4:dcb4:162 with SMTP id
 m10-20020a05622a118a00b003e4dcb40162mr17628912qtk.4.1679991610931; 
 Tue, 28 Mar 2023 01:20:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNpzeZ7gjbtIL2Ka8dMo1Bzn5V8O4UfVAoHsG5EFh/3BhzXlyah+r/S5EZ4D3ccfOazp/h+A==
X-Received: by 2002:a05:622a:118a:b0:3e4:dcb4:162 with SMTP id
 m10-20020a05622a118a00b003e4dcb40162mr17628888qtk.4.1679991610700; 
 Tue, 28 Mar 2023 01:20:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 4-20020a05620a048400b007468bf8362esm11708565qkr.66.2023.03.28.01.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 01:20:09 -0700 (PDT)
Date: Tue, 28 Mar 2023 10:20:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v4 1/3] vsock: support sockmap
Message-ID: <6eyspnma2esx4nzi2kszxkbuvh3xjb2g4nuhvng6tkvtp3whn6@hpyehyt6imdn>
References: <20230327-vsock-sockmap-v4-0-c62b7cd92a85@bytedance.com>
 <20230327-vsock-sockmap-v4-1-c62b7cd92a85@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230327-vsock-sockmap-v4-1-c62b7cd92a85@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@google.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
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

On Mon, Mar 27, 2023 at 07:11:51PM +0000, Bobby Eshleman wrote:
>This patch adds sockmap support for vsock sockets. It is intended to be
>usable by all transports, but only the virtio and loopback transports
>are implemented.
>
>SOCK_STREAM, SOCK_DGRAM, and SOCK_SEQPACKET are all supported.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> drivers/vhost/vsock.c                   |   1 +
> include/linux/virtio_vsock.h            |   1 +
> include/net/af_vsock.h                  |  17 ++++
> net/vmw_vsock/Makefile                  |   1 +
> net/vmw_vsock/af_vsock.c                |  64 ++++++++++--
> net/vmw_vsock/virtio_transport.c        |   2 +
> net/vmw_vsock/virtio_transport_common.c |  25 +++++
> net/vmw_vsock/vsock_bpf.c               | 174 ++++++++++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |   2 +
> 9 files changed, 281 insertions(+), 6 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
