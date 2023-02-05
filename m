Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15861C64EC3
	for <virtualization@archiver.kernel.org>; Sun,  5 Feb 2023 20:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C06560797;
	Sun,  5 Feb 2023 20:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C06560797
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FS2o67Ho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45xTmBaFC1sa; Sun,  5 Feb 2023 20:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2634D60758;
	Sun,  5 Feb 2023 20:08:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2634D60758
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D95EAC0032;
	Sun,  5 Feb 2023 20:08:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21E7EC002B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 20:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBC43819CC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 20:08:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBC43819CC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=FS2o67Ho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rChmqAnuN32
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 20:08:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1454081990
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1454081990
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Feb 2023 20:08:52 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id bj22so8223103oib.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Feb 2023 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mvIsEYybWu8qfqSxC3SNCLsX1f2a8XyZ+ZzIZVE4ff4=;
 b=FS2o67HoQ50grlACqBfjs7akK7vkBfdkIAsLQBrgfFho3YlVqkzuQiU8aMyJ/zP+Jy
 XUBdMDKvT3wZ3rMjRslvmbaGHJovDP5ENMNjSr9wH42xMGvbJ/uLz7KWluzopcoxfFVm
 0TZH/l0YAHuKXRmysAGEcUWQoAnuSB+s9LLju7juPS14nRGqX2+O8+rzeOdHv4ttAmKk
 hAnWshRUkwKnwq3EegTYpaT6YEkv4puxnPDzWaXxQS8S/tdDsDzlcHH6Tl7AotBNRH1k
 BxZPmNrqrwMUcD8tTD7ohxg1242rPv22vcXHE3CyRywCuhye1qQ9x0xQuUQj2ig17voH
 kTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvIsEYybWu8qfqSxC3SNCLsX1f2a8XyZ+ZzIZVE4ff4=;
 b=tX55wl0nRHp5NVUQIHy1Zt9r8Qr9AtUuz9OP7hcBQYlzYMR0IybhX23rBPJpHhBS6a
 ODFge3lXvYjZv+Z86GOm0HLSYrTtjz08QtZf5KeIPS5PgURtCz0l7MU6u/wEcdv9SbHG
 Gd2zcjwLttEZzjN8mHGX57H8ND9DfkCx+a6I50OoYvf/j+iBc6vFuzZADBKcRw5t5cyv
 iIOHVYzpRSEeqQvLX2YEFgwCnIgq7w7lnc/MoKHvmGc+Dg03yN8DDk7TXlHw9QeNVK9s
 aCl9k5kCbhp0/uIfKfE0l8q4hsv75NYCxO6ICTSuFU2FhslSLAqVf7WElqsDiCnMSVtJ
 2cLQ==
X-Gm-Message-State: AO0yUKUGYjiDoiE5dTMcvD02sLtsV2QtTONZXWdTk6EBM/CzslcUjvAK
 3zvTPsnE+gK7UF3oMr7r/ds=
X-Google-Smtp-Source: AK7set+eadtPZR2CC0SGrwp/7LLhs+kYqtEHVr0BtVMqUjTJF8NaoOWH6viBDXx/H5BrXYXlb+/6aA==
X-Received: by 2002:a05:6808:a07:b0:378:2df5:49f5 with SMTP id
 n7-20020a0568080a0700b003782df549f5mr7983074oij.2.1675627731912; 
 Sun, 05 Feb 2023 12:08:51 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:a80b:31f2:24c8:7c9a])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b0068d59d15a93sm4005797otq.40.2023.02.05.12.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Feb 2023 12:08:50 -0800 (PST)
Date: Sun, 5 Feb 2023 12:08:49 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 0/3] vsock: add support for sockmap
Message-ID: <Y+AM0VXW54YbvsRT@pop-os.localdomain>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, hdanton@sina.com,
 cong.wang@bytedance.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, jakub@cloudflare.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 30, 2023 at 08:35:11PM -0800, Bobby Eshleman wrote:
> Add support for sockmap to vsock.
> 
> We're testing usage of vsock as a way to redirect guest-local UDS requests to
> the host and this patch series greatly improves the performance of such a
> setup.
> 
> Compared to copying packets via userspace, this improves throughput by 121% in
> basic testing.
> 
> Tested as follows.
> 
> Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
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
> Only the virtio transport has been tested. The loopback transport was used in
> writing bpf/selftests, but not thoroughly tested otherwise.
> 
> This series requires the skb patch.
> 

Looks good to me. Definitely good to go as non-RFC.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
