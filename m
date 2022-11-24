Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5EC43217
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 15:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DD0681E4F;
	Thu, 24 Nov 2022 15:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DD0681E4F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yq6WfAiu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rl1rIAmfymwl; Thu, 24 Nov 2022 15:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EA1C381E39;
	Thu, 24 Nov 2022 15:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA1C381E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB877C0032;
	Thu, 24 Nov 2022 15:00:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA7D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80AC041BB6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80AC041BB6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yq6WfAiu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKEMGa3vVpI4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12F5B41BB0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12F5B41BB0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669302013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BAjfPV4xt1OtlG9wsm8F4N47NjOLXIg1wmr/fWW5B8o=;
 b=Yq6WfAiuuEn1m94nf7XKK1+I7phj5jJsJM9CoX3+2yqDEDOMk37dLT/WPjEyPjKc5YAijs
 +R7faPcPo887CQxjrn4a2rUH7dr9ykEppMzxJsiwvgxO4Ge8eLh/ySst1Oa6AHFuBX2gB9
 a1hbs11aTk9HKTStba7/yoj0SM6JN0o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-I8xJfaOoPMqwTEETwjKAhw-1; Thu, 24 Nov 2022 10:00:11 -0500
X-MC-Unique: I8xJfaOoPMqwTEETwjKAhw-1
Received: by mail-wm1-f69.google.com with SMTP id
 az40-20020a05600c602800b003cfa26c40easo2942422wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAjfPV4xt1OtlG9wsm8F4N47NjOLXIg1wmr/fWW5B8o=;
 b=nY/cfALXCn54qln0Ez89J5twTP3PGDdmg/ZIL8kXksbaQE+hyOm01CDyEUgz1n9JjC
 DJTbwMWRavPPx9iGBlor+s0b0YhPJyPBKGcYB+NQuDnosE2I0St/mpWsx/2WWpZ3sejo
 LF7kh8rcQvq5jwRahcynJznqsOVOJugYiEbCUyq5jCpKySUGBOWfrXtXQE+iQvsv+tGG
 j3S0X98gqCSf+njEl+i/W34ZnIKtadnzN7BhnXIBBt+fy7wBm+SU8RValwZd6VcsLz7z
 +jxfGaOJjeoYTsrgfuqR8Lhck8myEH91Q2sucJg8TJ0oFfaiUDKWMSd6YaqqCmhP7wHd
 ri3g==
X-Gm-Message-State: ANoB5pmLIwa7sSQCQKNjomRbf6NfVi5rhikTCtjZzjXrzdbTjT8Nb1KO
 v2z1QF7ayJv0EPaU2QHBv8AYBetFhns+sYz6rM5FRWmET3/YlIk1x26mYoHSuf5EVwdrr7TVBRA
 8FDNef6xA/f47zmn9vlj1mhRx04e2fZ5Yn9V2Rblo/A==
X-Received: by 2002:a5d:4d4c:0:b0:236:55eb:a25a with SMTP id
 a12-20020a5d4d4c000000b0023655eba25amr20765352wru.55.1669302010703; 
 Thu, 24 Nov 2022 07:00:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5sZbbTxNTiJwbBNeC7KFcse58SdLkR/Xx9k6PAPDIUZFhtBjhA7/8RRgSdQ+ARtA68UUkFVw==
X-Received: by 2002:a5d:4d4c:0:b0:236:55eb:a25a with SMTP id
 a12-20020a5d4d4c000000b0023655eba25amr20765337wru.55.1669302010429; 
 Thu, 24 Nov 2022 07:00:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 hg27-20020a05600c539b00b003a3170a7af9sm2156923wmb.4.2022.11.24.07.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Nov 2022 07:00:09 -0800 (PST)
Date: Thu, 24 Nov 2022 16:00:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>
Subject: Re: [PATCH v4] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221124150005.vchk6ieoacrcu2gb@sgarzare-redhat>
References: <20221124060750.48223-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20221124060750.48223-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

This is a net-next material, please remember to use net-next tag:
https://www.kernel.org/doc/html/v6.0/process/maintainer-netdev.html#netdev-faq

On Wed, Nov 23, 2022 at 10:07:49PM -0800, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>Test Runs: 5, mean of results
>Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>
>Test: 64KB, g2h
>Before: 21.63 Gb/s
>After: 25.59 Gb/s (+18%)
>
>Test: 16B, g2h
>Before: 11.86 Mb/s
>After: 17.41 Mb/s (+46%)
>
>Test: 64KB, h2g
>Before: 2.15 Gb/s
>After: 3.6 Gb/s (+67%)
>
>Test: 16B, h2g
>Before: 14.38 Mb/s
>After: 18.43 Mb/s (+28%)
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---

The patch LGTM. I run several tests (iperf3, vsock_test,
vsock_diag_test, vhost-user-vsock, tcpdump) and IMO we are okay.

I found the following problems that I would like to report:

- vhost-user-vsock [1] is failing, but it is not an issue of this patch,
   but a spec violation in the rust-vmm/vm-virtio/virtio-vsock crate as I
   reported here [2]. We will fix it there, this patch is fine, indeed
   trying a guest with the new layout (1 descriptor for both header and
   data) with vhost-vsock in Linux 6.0, everything works perfectly.

- the new "SOCK_SEQPACKET msg bounds" [3] reworked by Arseniy fails
   intermittently with this patch.

   Using the tests currently in the kernel tree everything is fine, so
   I don't understand if it's a problem in the new test or in this
   patch. I've looked at the code again and don't seem to see any
   criticisms.

   @Arseniy @Bobby can you take a look?

   I'll try to take a closer look too, and before I give my R-b I'd like
   to make sure it's a problem in the test and not in this patch.

   This is what I have (some times, not always) with both host and guest
   with this patch and the series of [3] applied:

   host$ ./vsock_test --control-host=192.168.133.3 --control-port=12345 \
                      --mode=client --peer-cid=4
   Control socket connected to 192.168.133.3:12345.
   0 - SOCK_STREAM connection reset...ok
   1 - SOCK_STREAM bind only...ok
   2 - SOCK_STREAM client close...ok
   3 - SOCK_STREAM server close...ok
   4 - SOCK_STREAM multiple connections...ok
   5 - SOCK_STREAM MSG_PEEK...ok
   6 - SOCK_SEQPACKET msg bounds...ok
   7 - SOCK_SEQPACKET MSG_TRUNC flag...recv: Connection reset by peer

   guest$ ./vsock_test --control-port=12345 --mode=server --peer-cid=2
   Control socket listening on 0.0.0.0:12345
   Control socket connection accepted...
   0 - SOCK_STREAM connection reset...ok
   1 - SOCK_STREAM bind only...ok
   2 - SOCK_STREAM client close...ok
   3 - SOCK_STREAM server close...ok
   4 - SOCK_STREAM multiple connections...ok
   5 - SOCK_STREAM MSG_PEEK...ok
   6 - SOCK_SEQPACKET msg bounds...Message bounds broken

Thanks,
Stefano

[1] https://github.com/rust-vmm/vhost-device/tree/main/crates/vsock
[2] https://github.com/rust-vmm/vm-virtio/issues/204
[3] https://lore.kernel.org/lkml/c991dffd-1dbc-e1d1-b682-a3c71f6ce51c@sberdevices.ru/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
