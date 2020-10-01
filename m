Return-Path: <SRS0=/j96=DI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA1C4727F
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 14:33:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28A8207FB
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 14:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A8207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 68D1086A22;
	Thu,  1 Oct 2020 14:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrO3VMpir9cH; Thu,  1 Oct 2020 14:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D113E86A0E;
	Thu,  1 Oct 2020 14:33:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A51DDC0889;
	Thu,  1 Oct 2020 14:33:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB15CC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 14:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8FBE520347
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 14:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dOCZgbNWKoQf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 14:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 by silver.osuosl.org (Postfix) with ESMTPS id B1FBD20343
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 14:33:29 +0000 (UTC)
Received: by mail-oo1-f67.google.com with SMTP id w25so1514694oos.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Oct 2020 07:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NklUCDIMExUICy4FN/gh63Vm3SmGzKI/5Dwr1ozJ1xo=;
 b=qao6aC3eqsY/bu7jqJBnXPVozgc1kdg7hOnWp6EuLUlt1I2kLy4EYxFXyq9js1fPWX
 ZrnP91tTklzlzHHX5fk4C1V7a+QpWRK5USgrLwSKLfCi3MDeuJw1LS7kNxMQfXEL7p6S
 EeHRxNbLRUJ2xxtOuseCurdtwh9+yQ05VoHD2qjGO0HUTxIsrYn6zd5hbAOZT74uqHyY
 DEJAD7R7463iHth4d9ycWkTK7nNUOToUvq+O0VLpf68yUXXl9ynPQNkcB4xy0+9uWhKQ
 AaFAYpeKVuPcn+jcppOwuI09uEH9vALOvK28EcHu1yZ9rHvHPldGSdPm+tZ9YwsRYAIi
 ZRMQ==
X-Gm-Message-State: AOAM533iu60feg66bO46qERphWTXWbU/Jl6+LRBllOrgIVCFr1ekJfAN
 SoDo5oYm3X+8bMIfMotsHA==
X-Google-Smtp-Source: ABdhPJwtom5klA/Ap8NrMcL34dnJEga9NT+pmkNy471CG5ehIqBT2YW5RiioY1ZL73r4Gt8Hdb3wCQ==
X-Received: by 2002:a4a:95f1:: with SMTP id p46mr5633028ooi.93.1601562808922; 
 Thu, 01 Oct 2020 07:33:28 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g7sm1204483otk.56.2020.10.01.07.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:33:28 -0700 (PDT)
Received: (nullmailer pid 695955 invoked by uid 1000);
 Thu, 01 Oct 2020 14:33:22 -0000
Date: Thu, 1 Oct 2020 09:33:22 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH RFC v1 12/18] asm-generic/hyperv: update hv_interrupt_entry
Message-ID: <20201001143322.GA695896@bogus>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-4-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914115928.83184-4-wei.liu@kernel.org>
Cc: linux-arch@vger.kernel.org,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On Mon, 14 Sep 2020 11:59:21 +0000, Wei Liu wrote:
> We will soon use the same structure to handle IO-APIC interrupts as
> well. Introduce an enum to identify the source and a data structure for
> IO-APIC RTE.
> 
> While at it, update pci-hyperv.c to use the enum.
> 
> No functional change.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c |  2 +-
>  include/asm-generic/hyperv-tlfs.h   | 36 +++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
