Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B810C6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 09:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2173A404C2;
	Thu,  2 Mar 2023 09:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2173A404C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXsw1My4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpdkB-gKRllz; Thu,  2 Mar 2023 09:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9642640025;
	Thu,  2 Mar 2023 09:54:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9642640025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67C1CC0035;
	Thu,  2 Mar 2023 09:54:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A93EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7645D81F27
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7645D81F27
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXsw1My4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0plS_ZL5Y23
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5FAC81443
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5FAC81443
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677750890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jl4deYgtYQ06Ijfay6FIS+BGHtz4sq6QUOH6s3fzXLM=;
 b=SXsw1My4FTyV9TBPuaUpEFo35yG1c6TjEVYqDD2eIndRJ4CNx2AmNv3MOLFR55necD/4mq
 GRePcNi7OJiblzxyGNiFzOKxbvl8HLiwAtZsdz7+G5TcVXQfg4Cd3GmDh6ZpWMkbfBt1GX
 gOKlbKHJ6eW6SXNnsR2BI4H+2X1g+Qw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-330-FUsNhVRNN_24odykuztA-g-1; Thu, 02 Mar 2023 04:54:47 -0500
X-MC-Unique: FUsNhVRNN_24odykuztA-g-1
Received: by mail-qt1-f198.google.com with SMTP id
 r4-20020ac867c4000000b003bfefb6dd58so3982320qtp.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 01:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677750886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl4deYgtYQ06Ijfay6FIS+BGHtz4sq6QUOH6s3fzXLM=;
 b=c243JyGSm7x6yyOkIwPt2UGstHr5ozJ7U4RWjj4ucWq3YtEbl33K5Jhcg0EsaeZbw5
 WLKPtjgKPtPCa35F0i/7J6uDW2fKFYRIymuhuFA6nd/MQ8jlexGXBxWu/Fh4TnHm7auB
 YLpGpxnvOApdNcER9qJcnVmGn+0vZ1B68PJlqkf7BlJ3N0egmeCh+KiV7ve0whoiaomb
 roBiT+Ukn8VaDeo4LDWpJdIUhBruO3wBYNeFxn3o2xdwIxw+8ay6cA/kRjqaQuFGBGP8
 oDHQD+ZxUe0Lw3m15TNdcfchzUrz6ZAEsKrpGoom1nLqAHl1i/ffE4vPYQZyq876wklI
 Yjvg==
X-Gm-Message-State: AO0yUKV+cY6AAxKAxzHIXzr8cqDKo4es5PhhwH1LeddkJMKKSsXK8yiI
 PXvfKifE1/f7A48ZotCl4w/Pc5RYDyK39IP6LFdiW+VfW+Vwj3ynAeZ0SPHX1VSnkaQv2m6k/2a
 1XHIne5JTFfku9DpyvMhuqoQmNotbcRHrHOoQplCaZA==
X-Received: by 2002:a05:6214:1c4f:b0:56e:ad32:2d66 with SMTP id
 if15-20020a0562141c4f00b0056ead322d66mr20116653qvb.10.1677750886520; 
 Thu, 02 Mar 2023 01:54:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/zHXtLONQKHsTMxBoLmedRcRQY43vgPItc+r7atw2mN0yr6/437PDMUCFGDoA9aWymkxnO/g==
X-Received: by 2002:a05:6214:1c4f:b0:56e:ad32:2d66 with SMTP id
 if15-20020a0562141c4f00b0056ead322d66mr20116604qvb.10.1677750885976; 
 Thu, 02 Mar 2023 01:54:45 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a37430b000000b00742a252ba06sm8395133qka.135.2023.03.02.01.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 01:54:45 -0800 (PST)
Date: Thu, 2 Mar 2023 10:54:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v3 3/3] selftests/bpf: add a test case for vsock
 sockmap
Message-ID: <20230302095434.opufchwk7efiw4dv@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-3-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-3-7e7f4ce623ee@bytedance.com>
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

On Tue, Feb 28, 2023 at 07:04:36PM +0000, Bobby Eshleman wrote:
>Add a test case testing the redirection from connectible AF_VSOCK
>sockets to connectible AF_UNIX sockets.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++++
> 1 file changed, 163 insertions(+)

Ditto.

For the vsock part:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
