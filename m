Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1240AC77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 05:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 632B38434B;
	Fri,  2 Jun 2023 05:52:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 632B38434B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=ftfHeXNR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lih-_bQcllAj; Fri,  2 Jun 2023 05:52:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7AD284330;
	Fri,  2 Jun 2023 05:52:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7AD284330
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAEF5C007A;
	Fri,  2 Jun 2023 05:52:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A654C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EC9784330
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EC9784330
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gkub6eR6pgc6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:52:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4F7E83EBC
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F7E83EBC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 05:52:19 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b026657a6fso14925825ad.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685685139; x=1688277139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AE2xzqHFPvJyLtJ4dI+SdGtkCRUUUqd29Nrdavs8L6c=;
 b=ftfHeXNRAMYhQcolNfzeiI9JdhXWRWSgYhPaIr9WxLqd3yBpt0mr4nOoav09Gm8CW+
 cMa+fP6gJmjvjtJpLWBAS+j97NoaNa8uoNzg3fTEylxNElIUhWTwKBroyAk1SKUqW3jE
 IYecWesShL1NepJw6BYuWqk42/FrDtDowamdBxXFDmoz/kupL5dwT/qFn3ZstEqT6nvV
 tv4BTF/ol/x8nrnqZ5+jfEokGq13SpGDjX38N64yZbDEHm6BriF3H87RapLwcGqyyXyo
 QCrRUFeRbVxI5athO6QlqTk55KAGvWe3l8VwtEPtoC7FGDLqUe0yps0TXggyR2xEKG3+
 AjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685685139; x=1688277139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AE2xzqHFPvJyLtJ4dI+SdGtkCRUUUqd29Nrdavs8L6c=;
 b=QdleeBxq4wntqFV75kZhxxFldUXHg/xu/1eeJLu+APuq/1YTb9oiqLxWhCEobVXf9k
 8IogdZ/eKJGHoiY/3HLWPrPeDyDrvPCZyFI3lrjZVJMrwZOt3dm509i9PtVFdvL5kAhO
 +d8ftL/GPvjy6lvHs30CA10dVEy51GXf2TdR0XsdrjZE22t1ddLxjxid9oBAHYmuXQdW
 zINIhYixMaWHx3aVf/9VPFXF3OIMgHG7ZOleskwkeuBV4aGPaxnxxLK/lG2TUACA8VLQ
 CskrKKKtITkffG0aiUem6hv1xocgdF9W/3ADn539IYaoEoOFOrGrWqv8doMR4l5wSaaG
 eKNA==
X-Gm-Message-State: AC+VfDxFNIdYyTTy7cNkaIO938zU8kVCpuzox0ROM6HX0pYowSUQiNSj
 xvADC+sXgfhBOQPpNAke4lRAwA==
X-Google-Smtp-Source: ACHHUZ5hYoSyNP1eBDO5vLkT94KN924ewF5hYgSdmxaV6A36IdMl7n1rKeC9tzdFIwyz0Gag9pSUOQ==
X-Received: by 2002:a17:902:ec8e:b0:1b0:4b65:79db with SMTP id
 x14-20020a170902ec8e00b001b04b6579dbmr1669736plg.63.1685685138776; 
 Thu, 01 Jun 2023 22:52:18 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a170902d48b00b0019e60c645b1sm358789plg.305.2023.06.01.22.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 22:52:18 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v4 0/1] Introduce a vringh accessor for IO memory
Date: Fri,  2 Jun 2023 14:52:10 +0900
Message-Id: <20230602055211.309960-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Vringh is a host-side implementation of virtio rings, and supports the vring
located on three kinds of memories, userspace, kernel space and a space
translated iotlb.

This patch introduces a new accessor for the vring on IO memory regions. The
accessor is used by the proposed PCIe endpoint virtio-{net[1], console[2]}
function drivers, which emulate a virtio device and access the virtio ring on
PCIe host memory mapped to the local IO memory region.

- [1] PCIe endpoint virtio-net function driver
link: https://lore.kernel.org/linux-pci/20230203100418.2981144-1-mie@igel.co.jp/
- [2] PCIe endpoint virtio-console function driver
link: https://lore.kernel.org/linux-pci/20230427104428.862643-4-mie@igel.co.jp/

Changes from:

v3: https://lore.kernel.org/virtualization/20230425102250.3847395-1-mie@igel.co.jp/
- Remove a kconfig option that is for this support
- Add comments to exported functions
- Remove duplicated newlines

rfc v2: https://lore.kernel.org/virtualization/20230202090934.549556-8-mie@igel.co.jp/
- Focus on a adding io memory APIs
- Rebase on next-20230414

rfc v1: https://lore.kernel.org/virtualization/20221227022528.609839-1-mie@igel.co.jp/
- Initial patchset

Shunsuke Mie (1):
  vringh: IOMEM support

 drivers/vhost/vringh.c | 201 +++++++++++++++++++++++++++++++++++++++++
 include/linux/vringh.h |  32 +++++++
 2 files changed, 233 insertions(+)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
