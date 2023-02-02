Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82282C6379F
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0412C419A2;
	Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0412C419A2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=aJY+fw9Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofaGGOjxa3zS; Thu,  2 Feb 2023 09:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47211419D5;
	Thu,  2 Feb 2023 09:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47211419D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 182C6C0077;
	Thu,  2 Feb 2023 09:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4E5CC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B312940BD9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B312940BD9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=aJY+fw9Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XESKW_pxvZ61
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BC4140AC9
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BC4140AC9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:44 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 c10-20020a17090a1d0a00b0022e63a94799so4954096pjd.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
 b=aJY+fw9Yr3mDpnG1pelzv7csrHxEYkyQh1y4fJRjzdswGPzA7ZfQWGtLMrdepTq9Dc
 i54BlCMZFSoUglW7CIdfRuIWEikWbQJiNqMYVJEbzig77Z6tb2CH3BBs7l0OH9E6hnG9
 3S4L/tGa2DFZtFkutLppOiZoBaxQsseNNwyBHkaacm/QpTuTDolJpgl6nIUDMMNRCgSu
 J04eoysVHd3Gew+kM8SK7/yDFqf+7VeLP2hfhiCLWNmgtMkGBe1bRZOzDYtx8AupPuo5
 vbtBh3DCYD3HrQucGK/ccN7augOUbzp4NhQj1WC5ITcvXA+qdYar2P2fR0ZyOpGGjo9O
 +cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
 b=Q+q3DvFrDr2lsep4rpYvVKg/dNNTqb8aKtmYgweOevXvsHwyxdrT+KVPI1DYXr1AxC
 /RRDhi5XKVu7ebZQN5BS6Oo18mfwD7l9gN3snnJAKblBs+3NvDqiOrZtpog3EXX7PMVd
 erRUSDwFjJHGhWc2zGvQ2UhvhiphcZJR5V1tKGcA60YuPkfhOkMA3aigwTTAf2cQhnPy
 me0rpMaNiUc8FeYoE4I7nxLJoJ0pYEZJDgZy9xZFBpq/83IgWsf5tdaHNVJV5dzsyVHU
 J3XgY63VXcm4NRsmqxxdyFJ8BFRmWIgSY4j3aeKaUKYVCfIee9JgLwDMswzmtAn99nwm
 t80A==
X-Gm-Message-State: AO0yUKXYfJyx7ZKHxMuM7oxhydQDMi8hXc5DxVzWK79rS0fQL2cOkD3o
 rtW/NIQ51QDq557JdKNPSVzM8g==
X-Google-Smtp-Source: AK7set8tx+u5ePofxYMmfqsidTs9Png9ELrgrcDtRFgGE1ZkOU3rNSgt+Gog2PZBE6m4rN7yBj+JCA==
X-Received: by 2002:a17:902:f355:b0:196:8cd2:15b1 with SMTP id
 q21-20020a170902f35500b001968cd215b1mr4593128ple.37.1675328983805; 
 Thu, 02 Feb 2023 01:09:43 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:43 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 1/7] vringh: fix a typo in comments for vringh_kiov
Date: Thu,  2 Feb 2023 18:09:28 +0900
Message-Id: <20230202090934.549556-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202090934.549556-1-mie@igel.co.jp>
References: <20230202090934.549556-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Probably it is a simple copy error from struct vring_iov.

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/linux/vringh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 212892cf9822..1991a02c6431 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -92,7 +92,7 @@ struct vringh_iov {
 };
 
 /**
- * struct vringh_iov - kvec mangler.
+ * struct vringh_kiov - kvec mangler.
  *
  * Mangles kvec in place, and restores it.
  * Remaining data is iov + i, of used - i elements.
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
