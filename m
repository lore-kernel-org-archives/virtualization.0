Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F98FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:21:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A9361A0C
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 15:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26A9361A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6505613FD;
	Thu, 30 Sep 2021 15:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oeE5lwY0U2OX; Thu, 30 Sep 2021 15:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A236961400;
	Thu, 30 Sep 2021 15:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84441C0011;
	Thu, 30 Sep 2021 15:21:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 806D7C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BF5461400
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KnV0_9VnOCSO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:21:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC52B61403
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633015264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0abga0D1u/IdQg9y3krLjrNSALXarJfiwXawsFlevdE=;
 b=YKvgW0DWUCMgYS+Gr1kmGd05vFueryaRhz3gUj5F7LhyGxGn3sMV6+7ki6FWmmnp5L+Eqs
 c7KZe82vNubLo/Cinxbuv0kwLva4j3qdlTxgICKA7VN3vPkKuoU5ItMiEqae41xH11FvyN
 1rcfDb1F5DPJkkT2RJxmzhme7YPT6k8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-C9vXXB_zMUW_w05H9fDkSw-1; Thu, 30 Sep 2021 11:21:03 -0400
X-MC-Unique: C9vXXB_zMUW_w05H9fDkSw-1
Received: by mail-wm1-f70.google.com with SMTP id
 10-20020a05600c240a00b0030d403f24e2so337790wmp.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0abga0D1u/IdQg9y3krLjrNSALXarJfiwXawsFlevdE=;
 b=PmQWutetEIBWGd8dJ8QaQXeGMgH9q9JaPh8WU5N0d4wZ0zqLtr71tIq5iCgQV/cPz2
 7rIyxFVi9+6vJWBbYX/WvZs+dNGdF6iCIYC8KAF9tiKV0GxLUZiwUZQS+h6HaAL7nMUa
 nlq3L2oG9B4qngqNwCXLr7aWOeZA8p+M8RjThjzZaIqOtx1pL2UmTmjItFv05bUZObPS
 A7Ux3AzNskCmL/ouwtcwZQkHNBWSQAU8VHI2qf9iSPwk1rTYF18/A/HA47hcGetKxj6a
 8t4fuoiqFpjuhwqBO4GeqqGcjVo2Sg8AJ3/Uokys7zfoJ1zBn+Tp7x0hBA16OAVBEEmL
 1fCg==
X-Gm-Message-State: AOAM531ytzfGrmysQ0//3CsADWki9L2PM5S+Lz2dL+/MfMZjyjWlnGkb
 VeU3cDLcDKjcX2CfMHwGM7bJxItE9GJ6eSH065ynJOMzSEZzhU8qVoS+hu1JnQBZT6yBQgxbLkq
 cUg52Yd8h2kkYL0wO7Tfls8GQH2blh0CKumdE/jBMtQ==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr6750082wra.321.1633015261058; 
 Thu, 30 Sep 2021 08:21:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyixcUuc+JnWbDfw8P1vGJjmgwF6F7FsHdgfu/4LhDBVO7PYY7/qogrpldeQ6XDAuFJuHmFBA==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr6749726wra.321.1633015257068; 
 Thu, 30 Sep 2021 08:20:57 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id z79sm3332530wmc.17.2021.09.30.08.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 08:20:56 -0700 (PDT)
Date: Thu, 30 Sep 2021 11:20:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20210930112029-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>, Andi Kleen <ak@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Sep 30, 2021 at 08:18:18AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/30/21 6:36 AM, Dan Williams wrote:
> > > And in particular, not all virtio drivers are hardened -
> > > I think at this point blk and scsi drivers have been hardened - so
> > > treating them all the same looks wrong.
> > My understanding was that they have been audited, Sathya?
> 
> Yes, AFAIK, it has been audited. Andi also submitted some patches
> related to it. Andi, can you confirm.
> 
> We also authorize the virtio at PCI ID level. And currently we allow
> console, block and net virtio PCI devices.
> 
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_NET) },
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_BLOCK) },
> { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, VIRTIO_TRANS_ID_CONSOLE) },

Presumably modern IDs should be allowed too?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
