Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E2C54EBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 14:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31C6E4174E;
	Tue, 10 Jan 2023 14:45:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31C6E4174E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZXxeIdQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0XwYnsrQJjY; Tue, 10 Jan 2023 14:45:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7521341719;
	Tue, 10 Jan 2023 14:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7521341719
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC41C0032;
	Tue, 10 Jan 2023 14:45:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9346C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 14:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CE2C41719
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 14:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CE2C41719
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFhRrQgs7Br7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 14:45:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 247204174E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 247204174E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673361938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEPL9QhdiHtl81dbBjJ+8ZxqD3DaFE7xqIq6L14Xhs8=;
 b=aZXxeIdQkz4azqTwrReSXhPGPehgF3V6YjKS880WUfh/hqgiosavOuEJPyqllULJrdTVT4
 luK1Q+zuFwMh42LaS+jI9pjsqtxQD3XNxY6UOJqlx8SkIDLOfRdrrulIesbAuOnJCjR/pt
 5tYZZJbx2g8ThBxd+mIMqvmWL/eYAIQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-VB8PE7oxMyi3RI1uYhrXqQ-1; Tue, 10 Jan 2023 09:45:37 -0500
X-MC-Unique: VB8PE7oxMyi3RI1uYhrXqQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 az39-20020a05620a172700b006ff85c3b19eso8891183qkb.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 06:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEPL9QhdiHtl81dbBjJ+8ZxqD3DaFE7xqIq6L14Xhs8=;
 b=oEcLLdHrBkR0isAZBVh++wxyDhZtBEXgMZ/Ia9EUbdWrE/0X18N5RvrK6d3eLJt2+s
 vhMXQ3gyeWG4D+af4xqSpEY6J9QLt8re97DFJ5qfXMgmHNyB9R65bXhhi92rGDCqTgRY
 rhjbo0cayUx9Y33tuOpmWIwKUnHUdoi1rvlgrg0i8GDCm74TJSRIvGZR/0Rt4P8q258z
 Gu43pKqGKHRZT7aMW7oCgnwe5Fyp6MxEg4pvzX08Dm7zYR/FCZBlLg3tGIB3RM8VXeFf
 5AY4DcHDrP7UNmRtKrAbMLg/99Mt8IZ6EC3CGcodcOQ5v9IK43sMd6QM60dQ1BLpkN+D
 Wfgg==
X-Gm-Message-State: AFqh2kpvIw/jESbskZn1VV7JWBjv84ETzPtYJOXVQy50wzZjOiTWDEI7
 nacnjMgclCsAnfbShS1VKVTWBnx/V1feXKZc3+5LPUC8MEnFYG/b369CRYWHodbiB78bkr8bsbV
 uBTLW4KNJP4KlyzqBLs8oaTwVz3rUsCbyVC9NiUrNyA==
X-Received: by 2002:ac8:6ec2:0:b0:3ad:8c10:593b with SMTP id
 f2-20020ac86ec2000000b003ad8c10593bmr9867758qtv.24.1673361937200; 
 Tue, 10 Jan 2023 06:45:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvc9OrhHN3k+CZGP5U3fDQ1GYsd6lcDLuDFqR7M320N5BIicIHK21UGYcRCxL800iX3rtAQ+w==
X-Received: by 2002:ac8:6ec2:0:b0:3ad:8c10:593b with SMTP id
 f2-20020ac86ec2000000b003ad8c10593bmr9867721qtv.24.1673361936919; 
 Tue, 10 Jan 2023 06:45:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-128.dyn.eolo.it.
 [146.241.120.128]) by smtp.gmail.com with ESMTPSA id
 z13-20020ac875cd000000b003aef9d97465sm1259788qtq.43.2023.01.10.06.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 06:45:36 -0800 (PST)
Message-ID: <5042e5c6e57a3f99895616c891512e482bf6ed28.camel@redhat.com>
Subject: Re: [PATCH net-next v9] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
From: Paolo Abeni <pabeni@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 10 Jan 2023 15:45:32 +0100
In-Reply-To: <91593e9c8a475a26a465369f6caff86ac5d662e3.camel@redhat.com>
References: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
 <91593e9c8a475a26a465369f6caff86ac5d662e3.camel@redhat.com>
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

On Tue, 2023-01-10 at 09:36 +0100, Paolo Abeni wrote:
> On Sat, 2023-01-07 at 00:29 +0000, Bobby Eshleman wrote:
> > This commit changes virtio/vsock to use sk_buff instead of
> > virtio_vsock_pkt. Beyond better conforming to other net code, using
> > sk_buff allows vsock to use sk_buff-dependent features in the future
> > (such as sockmap) and improves throughput.
> > 
> > This patch introduces the following performance changes:
> > 
> > Tool/Config: uperf w/ 64 threads, SOCK_STREAM
> > Test Runs: 5, mean of results
> > Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
> > 
> > Test: 64KB, g2h
> > Before: 21.63 Gb/s
> > After: 25.59 Gb/s (+18%)
> > 
> > Test: 16B, g2h
> > Before: 11.86 Mb/s
> > After: 17.41 Mb/s (+46%)
> > 
> > Test: 64KB, h2g
> > Before: 2.15 Gb/s
> > After: 3.6 Gb/s (+67%)
> > 
> > Test: 16B, h2g
> > Before: 14.38 Mb/s
> > After: 18.43 Mb/s (+28%)
> > 
> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > 
> > Tested using vsock_test g2h and h2g.  I'm not sure if it is standard
> > practice here to carry Acks and Reviews forward to future versions, but
> > I'm doing that here to hopefully make life easier for maintainers.
> > Please let me know if it is not standard practice.
> 
> As Jakub noted, there is no clear rule for tag passing across different
> patch revisions.
> 
> Here, given the complexity of the patch and the not trivial list of
> changes, I would have preferred you would have dropped my tag.
> 
> > Changes in v9:
> > - check length in rx header
> > - guard alloactor from small requests
> > - squashed fix for v8 bug reported by syzbot:
> >     syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com
> 
> It's not clear to me what/where is the fix exactly, could you please
> clarify?

Reading the syzkaller report, it looks like iov_length() in
vhost_vsock_alloc_pkt() can not be trusted to carry a reasonable value.

As such, don't you additionally need to ensure/check that iov_length()
is greater or equal to sizeof(virtio_vsock_hdr) ?

Thanks.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
