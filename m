Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69798C54EBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 08:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E832760B38;
	Tue, 10 Jan 2023 08:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E832760B38
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MSNpQQHD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJnNHq5op17q; Tue, 10 Jan 2023 08:36:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84C6360B65;
	Tue, 10 Jan 2023 08:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84C6360B65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5993FC0032;
	Tue, 10 Jan 2023 08:36:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBDFEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A69CD60B65
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A69CD60B65
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiA02DbZb_Up
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E932160B38
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E932160B38
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673339792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA5uFXsjy9VOrtOt4v6gI0JId1gSQ8b6AXjXO1XR9p4=;
 b=MSNpQQHDq9J+7CHQGnl8US8z5dB1A9e7G5E2LYfhjsFkni5Pwfx8zzHRCcHc03auOP0Xcb
 iEhs/iE3b6WB3mQCwuoJMi4uXYxAxN4njQHE5cW31KQojtexjRfogi55hIIBz8nzjKfA72
 LNSlnztZfesUo95sGBQrx1tFmEnqdik=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-4rEsPfW2NJqpxjKcFBSYUw-1; Tue, 10 Jan 2023 03:36:31 -0500
X-MC-Unique: 4rEsPfW2NJqpxjKcFBSYUw-1
Received: by mail-qv1-f71.google.com with SMTP id
 lp10-20020a056214590a00b0053180ee70f1so6560435qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 00:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OA5uFXsjy9VOrtOt4v6gI0JId1gSQ8b6AXjXO1XR9p4=;
 b=A0Xl/vIjxPRhRmexDZQX8utSMZGlTxhB/wHU/T+WJzBNH9Shkv+KrDcZvXfIRrilO3
 NMR7qJxDsuhRAUidLFKsxqLoWkF59PTPgrZ4oNcPE2dFAiMK093qbn2HGf/xoOXHJasq
 KDBfIpOLBQK7+nXv1d7wgqkJ/NbTkVTxp03XK1L223MZWC0YZPbxzSy0wOaABDbwhg5P
 M74MrgPXJyexIxo+OVrD0GyVbDMfLDdtYGtHNzV0ymXcXfHhbdYkXnCLdhcEK1nWu2HC
 IK4bwBWHwhAYWacYabw+FIzfmoEYQW5T7OYHaZmyOipa2sVvr8PROjfrMCx1V8UiYPwW
 twQQ==
X-Gm-Message-State: AFqh2krSNoMomfqjjCrRkfx/REZ9zdAOkhl2ZlNjbi1Qm38RTj/vnyc8
 sdp8ayPvA4pksnyH5Ma5gPixZqMpA9TukLJE2qV+A4GT7K+HW6Oag6cRhOEzD0drcsdDOVQIe9W
 yT1iygutwlrdQ8/yEVMAXKyZpHzrb2pboZPG33FhNqg==
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id
 c7-20020ac86e87000000b003a811f3b81cmr92473603qtv.53.1673339790900; 
 Tue, 10 Jan 2023 00:36:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtHKXcGwIf1YTV+2xcYytzlbmWmXvkPsMytlZlxe1TCEXregd5S2XFcyMVIu2vtJs6MCGLTzg==
X-Received: by 2002:ac8:6e87:0:b0:3a8:11f3:b81c with SMTP id
 c7-20020ac86e87000000b003a811f3b81cmr92473590qtv.53.1673339790644; 
 Tue, 10 Jan 2023 00:36:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it.
 [146.241.120.128]) by smtp.gmail.com with ESMTPSA id
 s24-20020ac87598000000b003a7e9db074asm5687861qtq.67.2023.01.10.00.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 00:36:30 -0800 (PST)
Message-ID: <91593e9c8a475a26a465369f6caff86ac5d662e3.camel@redhat.com>
Subject: Re: [PATCH net-next v9] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
From: Paolo Abeni <pabeni@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 10 Jan 2023 09:36:26 +0100
In-Reply-To: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
References: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Sat, 2023-01-07 at 00:29 +0000, Bobby Eshleman wrote:
> This commit changes virtio/vsock to use sk_buff instead of
> virtio_vsock_pkt. Beyond better conforming to other net code, using
> sk_buff allows vsock to use sk_buff-dependent features in the future
> (such as sockmap) and improves throughput.
> 
> This patch introduces the following performance changes:
> 
> Tool/Config: uperf w/ 64 threads, SOCK_STREAM
> Test Runs: 5, mean of results
> Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
> 
> Test: 64KB, g2h
> Before: 21.63 Gb/s
> After: 25.59 Gb/s (+18%)
> 
> Test: 16B, g2h
> Before: 11.86 Mb/s
> After: 17.41 Mb/s (+46%)
> 
> Test: 64KB, h2g
> Before: 2.15 Gb/s
> After: 3.6 Gb/s (+67%)
> 
> Test: 16B, h2g
> Before: 14.38 Mb/s
> After: 18.43 Mb/s (+28%)
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---
> 
> Tested using vsock_test g2h and h2g.  I'm not sure if it is standard
> practice here to carry Acks and Reviews forward to future versions, but
> I'm doing that here to hopefully make life easier for maintainers.
> Please let me know if it is not standard practice.

As Jakub noted, there is no clear rule for tag passing across different
patch revisions.

Here, given the complexity of the patch and the not trivial list of
changes, I would have preferred you would have dropped my tag.

> Changes in v9:
> - check length in rx header
> - guard alloactor from small requests
> - squashed fix for v8 bug reported by syzbot:
>     syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com

It's not clear to me what/where is the fix exactly, could you please
clarify?

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
