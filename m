Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AACC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B0D2311F
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B0D2311F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4AC5D203F3;
	Tue, 12 Jan 2021 19:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rRovOYeiOMIs; Tue, 12 Jan 2021 19:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 11B4820361;
	Tue, 12 Jan 2021 19:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E35B7C088B;
	Tue, 12 Jan 2021 19:41:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53065C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3338F85F96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsyhA4Oag4dz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E92C85C20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:56 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id r4so3221078wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=9oioH7fTimHXbwiOIluI6SOkD883+857JncYScStEP4=;
 b=JmO6IQKgjQY+7ho4ih3Bdmj0eRPnup/UlujCGZhO4AJhanp3QH0J71/SQjiI8RlftE
 LxVkn1U86G3tkyTL1V1ekzv7AG4aQUuBC1r0RvRBoERwudQRkTXIem4aavnr56WrANo8
 gOtBpR9pRxwKu1xDJhfk/82GSYbgzv2ibgNt5w0f4THTbGm6h2zSgqNsqz15NEjpA55j
 jhso19OBmu3jzIh6d8tb1TXJSzru4eS/fD3T3nWv1umUB8RNCOvvnnPdOKeCNLkCN3mh
 BIGrXTEThybGX1OaJSNIbNpsSW/dNQUVwxByoyviBmYkIkBVcUXJ03lrcjitMvDn4T//
 igkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9oioH7fTimHXbwiOIluI6SOkD883+857JncYScStEP4=;
 b=hZTZZh5CWpFCXdrf4jvH+NDbcmCIg+prjXvc8myp9UlRNkEFHSyFJY9bqyeLfPUm+V
 MEiDQIarmlLnd6X5V2wEJHRFU7a5Az6+MZIMpVa8bOWWtWJKXR2s5e+KDtbJrKqkKT2K
 EPBPpjDsXq2CMJL+wTxdMQpi7ht+aOCAPXiXqgNYBSCb0DxezHGCekCU6FAiLDRk1Llv
 sivgl1WXpLHEkLk4OtSGoRqz3xelQZpXvEzVNfBjzJ5vgEYl6MkbOvTWU87sBCVP1k6w
 b60V9T7lholWtqg39eQw66SshtwzHk1dyEpXohVpsnOMocqAAVVk6BspDI87YVUvV8HR
 lSWw==
X-Gm-Message-State: AOAM5309B+Z2r459lEZJe7samOFBI4u7AW0NGEBCCU6nXHbBtRdSWkzs
 P4FHyAau3ZPUMJ9+8YrFl6lndQ==
X-Google-Smtp-Source: ABdhPJxLSdWWpfIxaQGNHeFfQoIuyfHcKNbVYBL99mebz4m6+1+6/6514Is75EyggDSS6XrPJMXKGw==
X-Received: by 2002:a1c:b742:: with SMTP id h63mr780567wmf.122.1610480514861; 
 Tue, 12 Jan 2021 11:41:54 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.41.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:41:54 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 0/7] Support for virtio-net hash reporting
Date: Tue, 12 Jan 2021 21:41:36 +0200
Message-Id: <20210112194143.1494-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
Cc: yan@daynix.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Existing TUN module is able to use provided "steering eBPF" to
calculate per-packet hash and derive the destination queue to
place the packet to. The eBPF uses mapped configuration data
containing a key for hash calculation and indirection table
with array of queues' indices.

This series of patches adds support for virtio-net hash reporting
feature as defined in virtio specification. It extends the TUN module
and the "steering eBPF" as follows:

Extended steering eBPF calculates the hash value and hash type, keeps
hash value in the skb->hash and returns index of destination virtqueue
and the type of the hash. TUN module keeps returned hash type in
(currently unused) field of the skb. 
skb->__unused renamed to 'hash_report_type'.

When TUN module is called later to allocate and fill the virtio-net
header and push it to destination virtqueue it populates the hash
and the hash type into virtio-net header.

VHOST driver is made aware of respective virtio-net feature that
extends the virtio-net header to report the hash value and hash report
type.

Yuri Benditovich (7):
  skbuff: define field for hash report type
  vhost: support for hash report virtio-net feature
  tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
  tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
  tun: add ioctl code TUNSETHASHPOPULATION
  tun: populate hash in virtio-net header when needed
  tun: report new tun feature IFF_HASH

 drivers/net/tun.c           | 43 +++++++++++++++++++++++++++++++------
 drivers/vhost/net.c         | 37 ++++++++++++++++++++++++-------
 include/linux/skbuff.h      |  7 +++++-
 include/uapi/linux/if_tun.h |  2 ++
 4 files changed, 74 insertions(+), 15 deletions(-)

-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
