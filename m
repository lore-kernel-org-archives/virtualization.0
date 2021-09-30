Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F688C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EA061882
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 14:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15EA061882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D211F613FD;
	Thu, 30 Sep 2021 14:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9SRiz_icnyx; Thu, 30 Sep 2021 14:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC03613F3;
	Thu, 30 Sep 2021 14:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC74C000F;
	Thu, 30 Sep 2021 14:58:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 114B2C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED6F740346
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3acP2rDXmGWa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27676400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633013895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zptMMX+xorScj8oCKZfu7vNyw+QcA+InPw6+3Zh+fcA=;
 b=WdqNw6J0B+IZB9mZa9kbTLPEdzqL1iWo4eWniUwapPQ6/TYKAFM3hg9FA1wLqu6Pk1KDp+
 9dEkHghzE+s6jRWUKp1dMoBzano4jhv9IZD5bE82OwC6jtTWzi9BydfuD9cJWPrdzQa8iy
 xR5voX0Bf+4T/zpqW6PGgmEkp03H5ug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-hYLgZfinOuiZKQwWv7VL4w-1; Thu, 30 Sep 2021 10:58:14 -0400
X-MC-Unique: hYLgZfinOuiZKQwWv7VL4w-1
Received: by mail-wm1-f70.google.com with SMTP id
 n3-20020a7bcbc3000000b0030b68c4de38so2061738wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 07:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zptMMX+xorScj8oCKZfu7vNyw+QcA+InPw6+3Zh+fcA=;
 b=336D5KC39QNvwjsDMONMEWypsehsTtqjMrdWiwiWCcdz36aoXW12YS6u8SB1voypp/
 MAqo/FaKPRlM9k4QpLXN+dSkEPQp6ce4V/JjVDUBRlxvhSDY0Zz9OPwPKg7czgryagQl
 lxcOVzAG3V2yqaFqwjDj5Yj5nHDe4xQz247wLYR1VrrfCTQrZvqVy+4ihPKAFTd03rw3
 oIggl0n1M/3ILge1ngdIkAH6JYcLRqm4tmivUx45AZbK/SqVZo1bQM/CgMUUMnZgC5Ql
 ImuTAIbFvocCDLGWxkNrb1L1EvpU98CsHm/LihtWtKazwqy+gTZaLCCEplgVMqm+PdBi
 o7Wg==
X-Gm-Message-State: AOAM530ctY47oDtvTvnkxeylrgDzQKVc3S/NldRcYmHbeQYVoeo/pnDe
 4ukad4HyLvORaoe+b2saxNX9lht2EqKcoYkGFMjeSKVKjudrRP/6spDJYZW2CPJ41lxv9iERynz
 DmODMaeZ7q5pmVmSgVKWfjXkusPTaufCWqx2Vv7/Kjw==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr5645376wmc.75.1633013893040; 
 Thu, 30 Sep 2021 07:58:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaSf6qIxOAUaDvu9F6CRNxVN7kuMkgxNG2gPYtmYIu+P3izWa6fLM0ccmLZ3hvWl8yaURe3A==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr5645358wmc.75.1633013892858; 
 Thu, 30 Sep 2021 07:58:12 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
 by smtp.gmail.com with ESMTPSA id q18sm5031993wmc.7.2021.09.30.07.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 07:58:12 -0700 (PDT)
Date: Thu, 30 Sep 2021 10:58:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930104924-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
MIME-Version: 1.0
In-Reply-To: <20210930144305.GA464826@rowland.harvard.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-kernel@vger.kernel.org,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-usb@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> I don't see any point in talking about "untrusted drivers".  If a 
> driver isn't trusted then it doesn't belong in your kernel.  Period.  
> When you load a driver into your kernel, you are implicitly trusting 
> it (aside from limitations imposed by security modules).

Trusting it to do what? Historically a ton of drivers did not
validate input from devices they drive. Most still don't.

> The code 
> it contains, the module_init code in particular, runs with full 
> superuser permissions.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
