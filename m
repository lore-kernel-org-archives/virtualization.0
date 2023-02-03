Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CEEC64EC4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 17:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71CEA61295;
	Fri,  3 Feb 2023 17:18:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71CEA61295
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R00Jv7r0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hCuM5IMSDag; Fri,  3 Feb 2023 17:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4C5B60C27;
	Fri,  3 Feb 2023 17:18:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C5B60C27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B28CBC0033;
	Fri,  3 Feb 2023 17:18:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13081C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 17:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE3A4821C5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 17:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE3A4821C5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=R00Jv7r0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQuo6EVsiVyc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 17:18:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD7B2821BB
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD7B2821BB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 17:18:12 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 cl23-20020a17090af69700b0022c745bfdc3so5543661pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K70GwBbxm76u0ZHh9QualBnSNVhMmwCaA4xLAgTOsU4=;
 b=R00Jv7r0nGI0Ztnp5TNHhM+FfJ5zmFRR/yKaJPFf48QgjKh7tXSwGMmQnOoqu8Xid4
 wge7CmaLgfoEKprgizb7/sm8rwZ8EQ9OCoyJKMGvTA4kiktJCR4NV/cva7qvSGWATdmE
 /2uT8roACaKsn4YLwQl6hQkgbKX7IYcNLKQL5KVRHggoW1I8XImpl9s6MfEiMUSpHo9Y
 S5fkZix1iQi2f9FmnThOmhtEMaBrJr9ePfucBJOf0enZnaK+aBn2RScZgWLk6sLYtLKJ
 6yN94xDkDiQ62CShnA6PepLuiQAIJ+UkyAdk860JzMBR19PnaXvBFKHmerQBvkix95On
 9+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K70GwBbxm76u0ZHh9QualBnSNVhMmwCaA4xLAgTOsU4=;
 b=NL7QpNI6n2IzZ3mOlPRJC3XAtc4Ru0oOiNm0KKNddpfnH71l4TrLUf4ZoYW2NkqBFl
 WuRvrMUyEd9+48JUgdC2qnlyfqkkSDcQsgyW0zlBmH572J9VUNtAOQLBtpG6Y02mUNal
 7ksAwqpkxZUOukxjWwSiII6rvcVydXPJU0lBd1yJvOnt5xP990EfweVvJKBU334+vW1o
 YrPeH8UXVLrZkbknM0X9rDgfX7BnWjtyAWt5vrqhyVTfdatt/xxg8Gtdcrb6RWMjiIZj
 Btxl1Zf5vT+I4mVSpUNMxE7kzV7DFy99GDgyjjiU9uvvtH9RFmErtO3kNQP6u5isUjtp
 YLDg==
X-Gm-Message-State: AO0yUKWVhGd751bzYjiyZB6PmtYxh59DFkwNz4fIZioOnrL6jgqqk92x
 eLOiQHkMNPx/XyW6CWFEx9QOHA==
X-Google-Smtp-Source: AK7set/8QyEeOBS5HCdwVVv3pX8pLqYaYDC09KN7ZX0YiSUh3tCWtH5sa+Lu+Eay2bGB3phfSCaeYw==
X-Received: by 2002:a17:90a:3c83:b0:22b:afef:9228 with SMTP id
 g3-20020a17090a3c8300b0022bafef9228mr8980675pjc.4.1675444691816; 
 Fri, 03 Feb 2023 09:18:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 s1-20020a17090a6e4100b0021900ba8eeesm5189271pjm.2.2023.02.03.09.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 09:18:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230203150634.3199647-1-hch@lst.de>
References: <20230203150634.3199647-1-hch@lst.de>
Subject: Re: add bvec initialization helpers v2
Message-Id: <167544468926.66559.8388961280734694655.b4-ty@kernel.dk>
Date: Fri, 03 Feb 2023 10:18:09 -0700
MIME-Version: 1.0
X-Mailer: b4 0.12.0
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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


On Fri, 03 Feb 2023 16:06:11 +0100, Christoph Hellwig wrote:
> this series adds the helpers to initalize a bvec.  These remove open coding of
> bvec internals and help with experimenting with other representations like
> a phys_addr_t instead of page + offset.
> 
> Changes since v1:
>  - fix a typo
>  - simplify the code in ceph's __iter_get_bvecs a little bit further
>  - fix two subject prefixes
> 
> [...]

Applied, thanks!

[01/23] block: factor out a bvec_set_page helper
        commit: d58cdfae6a22e5079656c487aad669597a0635c8
[02/23] block: add a bvec_set_folio helper
        commit: 26db5ee158510108c819aa7be6eb8c75accf85d7
[03/23] block: add a bvec_set_virt helper
        commit: 666e6550cb74e3a7206b5699409c9f31e123887e
[04/23] sd: factor out a sd_set_special_bvec helper
        commit: f1e117cbb01a38f764db2f292174b93eab7c2db2
[05/23] target: use bvec_set_page to initialize bvecs
        commit: 3c7ebe952fefb646c56b60f1c3e3388f3b938cc7
[06/23] nvmet: use bvec_set_page to initialize bvecs
        commit: fc41c97a3a7b08131e6998bc7692f95729f9d359
[07/23] nvme: use bvec_set_virt to initialize special_vec
        commit: 4bee16daf13225d6b109bb95d613fd691b04a757
[08/23] rbd: use bvec_set_page to initialize the copy up bvec
        commit: 7df2af0bb4912cf360045d065f88fe4ed2f702ca
[09/23] virtio_blk: use bvec_set_virt to initialize special_vec
        commit: b831f3a1031664ae2443bab63d35c416ed30c91d
[10/23] zram: use bvec_set_page to initialize bvecs
        commit: 13ae4db0c05107814db4e774856aa83e72e8bf04
[11/23] afs: use bvec_set_folio to initialize a bvec
        commit: a8173be1863e57393edb5c158860ec43a1f21ed7
[12/23] ceph: use bvec_set_page to initialize a bvec
        commit: 5c6542b6612f635eaa001c54af22018f1e996418
[13/23] cifs: use bvec_set_page to initialize bvecs
        commit: 220ae4a5c2ba10333b3b01fbf3dea0d759e77a76
[14/23] coredump: use bvec_set_page to initialize a bvec
        commit: cd598003206839ed1354902805b52c3a4f6ead2e
[15/23] nfs: use bvec_set_page to initialize bvecs
        commit: 8bb7cd842c44b299586bfed6aadde8863c48b415
[16/23] orangefs: use bvec_set_{page,folio} to initialize bvecs
        commit: 8ead80b2c5f8c59d6ca18cd7fb582a3ffc7ea5b7
[17/23] splice: use bvec_set_page to initialize a bvec
        commit: 664e40789abaad892737a696102052dae199a029
[18/23] io_uring: use bvec_set_page to initialize a bvec
        commit: cc342a21930f0e3862c5fd0871cd5a65c5b59e27
[19/23] swap: use bvec_set_page to initialize bvecs
        commit: 8976fa6d79d70502181fa16b5e023645c0f44ec4
[20/23] rxrpc: use bvec_set_page to initialize a bvec
        commit: efde918ac66958c568926120841e7692b1e9bd9d
[21/23] sunrpc: use bvec_set_page to initialize bvecs
        commit: 9088151f1bfe670ae9e28b77095f974196bb2343
[22/23] vringh: use bvec_set_page to initialize a bvec
        commit: 58dfe14073846e416d5b3595314a4f37e1a89c50
[23/23] libceph: use bvec_set_page to initialize bvecs
        commit: 1eb9cd15004fa91b6d1911af9fbaff299d8e9e45

Best regards,
-- 
Jens Axboe



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
