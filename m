Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8363C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:11:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329C12311F
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329C12311F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A215A850DC;
	Tue, 12 Jan 2021 20:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9Tdx7Vbnr5J; Tue, 12 Jan 2021 20:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FA4C8508E;
	Tue, 12 Jan 2021 20:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F61CC0893;
	Tue, 12 Jan 2021 20:11:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CDB9C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 81A738575A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRjUpvKLL6Cx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 948B18527D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:01 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id ga15so5309210ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=u0kBDkZSof0LwbMWuYCOPhj4hHVMvwb36KmGU51ii7Y=;
 b=qXPm6RRC85TTK9KaSiUv157OWNC4uLnK5R55zCcddSz/OH6u6hYx1S9F76b6fwU3/m
 L5598+Ur8w96+Gg+RoiczvrXtQYRI8O+fGupwlj+IkNmOGSHUsW9Tf1BtX3kiNe71Rgx
 WKTBblBdOSXaDLvovQo/HLN7qCMsRVlCKSDg9YBktWJQB59pnUT8dN+HdiYyVYBkhQuJ
 CvKCRk6Kcw/A1SvK/Qud7BzT6mgq06tzFkvkVxffAFW66gfIBLQhmu6VrRnGc6K1j6UJ
 Fl4DWwsqoJ4iK+vFlmlYQCh6SYdu4g5kQNpVx2IBQVS/3tq45sNhLUGPnbg8Ifcy6piT
 l22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=u0kBDkZSof0LwbMWuYCOPhj4hHVMvwb36KmGU51ii7Y=;
 b=uFGaulJ7EXtQ29Tb24R/q93u3sXqDloSuWEUstxPZZe7mVvG+5Z2OYZrE77onkV1NY
 yTej+0TkdMxf/odK7u3bIXU+RklttCXzPELA1oxQvcJtn3IGBO3sFX0VJ6/8Xp2QTgod
 lsyxcDGd9piXWJT9m4bnBH6xIGncWQGHzUPkwGyNPEk/rKJofgnFkrnW+n5izyFYmLhw
 CeVHe8RN5sfoI7dU8Dbk7OYtSxHuFARXMB5i5nDna6SWk/ESrqlHZhrH84qjG8x6S9kT
 OBPrYIp7itkjLuWEoydoKzJIQVIq8hLEr/DUyCCviCFVx2jwJ1USlN6UyXlGF29nvmA/
 oNCw==
X-Gm-Message-State: AOAM531mCcNfjqETU5gR9OMrYCxCPNomvK0FlMjivkRlo6yceOLM4N+A
 /Vm7zWgrPIDx3BhWFa1IMJa1ZpdCa1yFTQnu
X-Google-Smtp-Source: ABdhPJwQIJTkLLUDMFNxy3mBWVt2sZtp82KzceRnAi/2Dy2UB4frEHQodHJV577V0ALRuxgqVPsWHg==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr423783wrw.247.1610480527197; 
 Tue, 12 Jan 2021 11:42:07 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:06 -0800 (PST)
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
Subject: [RFC PATCH 4/7] tun: free bpf_program by bpf_prog_put instead of
 bpf_prog_destroy
Date: Tue, 12 Jan 2021 21:41:40 +0200
Message-Id: <20210112194143.1494-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
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

The module never creates the bpf program with bpf_prog_create
so it shouldn't free it with bpf_prog_destroy.
The program is obtained by bpf_prog_get and should be freed
by bpf_prog_put. For BPF_PROG_TYPE_SOCKET_FILTER both
methods do the same but for other program types they don't.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 455f7afc1f36..18c1baf1a6c1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2218,7 +2218,7 @@ static void tun_prog_free(struct rcu_head *rcu)
 {
 	struct tun_prog *prog = container_of(rcu, struct tun_prog, rcu);
 
-	bpf_prog_destroy(prog->prog);
+	bpf_prog_put(prog->prog);
 	kfree(prog);
 }
 
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
