Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C0C433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 18:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C35D614F9;
	Thu, 26 May 2022 18:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3-G9EgT3K6g; Thu, 26 May 2022 18:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F315D6104B;
	Thu, 26 May 2022 18:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B287EC0039;
	Thu, 26 May 2022 18:37:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C99D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 18:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC9DD41736
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 18:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imwCzPgBojQX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 18:37:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60EE141BA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653590243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZXZyOBj9K/G+WFDwIrle6dO9n3UzwXZHEEzIr/nzYk=;
 b=EcN/9lvQ2vCfiG/e2xYWoODYOQEkXUaYtUvRX8268CA1WFkXVfs8Auaql9IoYONSvGMBJ2
 6mBRqFgpr/pG17PrvReBn5zLlg5IX/OcoO4i8GXSCQbuDVXT7FP6pM8DtGv6bu6c+vKTFY
 TgD6/kjuAvbgplcnNHYCZRAbPn5ChMU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-jom_IQKTMs6WSrDlkzj7RQ-1; Thu, 26 May 2022 14:37:22 -0400
X-MC-Unique: jom_IQKTMs6WSrDlkzj7RQ-1
Received: by mail-io1-f69.google.com with SMTP id
 z22-20020a5e8616000000b0066576918849so1501192ioj.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 11:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iZXZyOBj9K/G+WFDwIrle6dO9n3UzwXZHEEzIr/nzYk=;
 b=fjv+1RuTV9b5CvvyGgAWPTZvUC51vewwjAlZCfUuUPMNuNJLTBAPa1X/F2BJj0UQLk
 sIR9E/0+ZbtaRSWb75bwwnRBoP9kMFg3FwijNj/t1n3w0pNmicGH7HnGnUSuzpqc8CT8
 aPYiM2NkmjzVB+3iRFaVvq7067QEU8YmgmMS10J62pXzECZv0MqkUeWNrJvIzlK7V5ye
 n0RVtgo4tUtmfEIeSQaTe8dJiB9eAraXSckk1KtWm7h3jWGHwjH4Tysl324XYFcMgCbB
 CBARI+ykuzC0KhjxRvLjMXogj4lhSgQ7bQFEr1OkDn97MCZmuBiXJqVxXCIVgO5rvw3m
 yhTA==
X-Gm-Message-State: AOAM530M3+RZw5pvX55WLqd0ITOAWAHISA+yCTQXhYEIXFUSBfe8i8IS
 otAeU7eRrOuvNZPB2UuIIewRzMm1ioqn/tBXJm8PDONF38qnWpIgXhzblVOmhSRAvt2LFtvL3qF
 JHK8Ad3CNEu/h3AZUOIWXRFxmjGNe/JG06+rtiqqN4Q==
X-Received: by 2002:a05:6638:4901:b0:32f:d52c:924c with SMTP id
 cx1-20020a056638490100b0032fd52c924cmr6248115jab.8.1653590241277; 
 Thu, 26 May 2022 11:37:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpP2TSvS6e9NpQEMUP3qCECYxWtAnkzb4ugRqwUnJ/Y/Oan//xTqCMVr3HgbEkayorckxxRg==
X-Received: by 2002:a05:6638:4901:b0:32f:d52c:924c with SMTP id
 cx1-20020a056638490100b0032fd52c924cmr6248102jab.8.1653590241044; 
 Thu, 26 May 2022 11:37:21 -0700 (PDT)
Received: from xz-m1.local
 (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
 by smtp.gmail.com with ESMTPSA id
 x89-20020a0294e2000000b0032e43cb7344sm575684jah.146.2022.05.26.11.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 11:37:20 -0700 (PDT)
Date: Thu, 26 May 2022 14:37:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Jue Wang <juew@google.com>
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Message-ID: <Yo/I3oLkd9OU0ice@xz-m1.local>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?=
 <naoya.horiguchi@nec.com>, LKML <linux-kernel@vger.kernel.org>,
 pizhenwei@bytedance.com, qemu-devel@nongnu.org, Linux MM <linux-mm@kvack.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
> The hypervisor _must_ emulate poisons identified in guest physical
> address space (could be transported from the source VM), this is to
> prevent silent data corruption in the guest. With a paravirtual
> approach like this patch series, the hypervisor can clear some of the
> poisoned HVAs knowing for certain that the guest OS has isolated the
> poisoned page. I wonder how much value it provides to the guest if the
> guest and workload are _not_ in a pressing need for the extra KB/MB
> worth of memory.

I'm curious the same on how unpoisoning could help here.  The reasoning
behind would be great material to be mentioned in the next cover letter.

Shouldn't we consider migrating serious workloads off the host already
where there's a sign of more severe hardware issues, instead?

Thanks,

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
