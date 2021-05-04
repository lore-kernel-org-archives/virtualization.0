Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D22C433ED
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB8661176
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB8661176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A87A060C1C;
	Tue,  4 May 2021 15:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NisWl0BmHbdU; Tue,  4 May 2021 15:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56B4560674;
	Tue,  4 May 2021 15:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA46C000D;
	Tue,  4 May 2021 15:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14110C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E22AE8439E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3to5bjXgXG7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95B218437B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620143771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qvy2NxACpq19DOAfcjLvwkpBiC7L46GX+xjidme4oJU=;
 b=P3j31falJ2JfBwoxrZYwDWwFHVc9RUXfi9qCXJMJ7XB1LBz8MKsnSCytQvWLIifFO8tyJN
 015tt38CX0y0T8EVYceipywlkXOZ+d2v1vdMSJk6kaKj4t6zc50vpIaM3QH3jHTmgwUD6H
 Z9miJKPT0GS+dValC5O8j6B7jGOazTI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-WVnqdQMvOpWsQ96-Dvkdaw-1; Tue, 04 May 2021 11:56:09 -0400
X-MC-Unique: WVnqdQMvOpWsQ96-Dvkdaw-1
Received: by mail-ej1-f69.google.com with SMTP id
 r18-20020a1709069592b029039256602ce8so3306409ejx.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 08:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qvy2NxACpq19DOAfcjLvwkpBiC7L46GX+xjidme4oJU=;
 b=jwf7UVa7wuI4hBGSJvSUXRxBEI7wetFTvBPZOtcXWH2tG8AfLhoHFLqTHXHPmAqe7M
 4xI5P+zoNuUXwSSQW0laKlv1KH/WrXD5VZm1tod/HyW+SVG7dcFl/PEcBohNYzcpz1RO
 jiFllkIIVFOMx74+lDe5UBldI3gCfHyGABYERnVE4ibVQ0blyfPzkf6Dook9XUlZOMoI
 j64jMvRHGY2sd/KJyCvAkmOJsEbdSELraIYGJzWbXNyjwH3Ge5tWOa8MbNNJxzGMpYIF
 UkWAAOZObb8tTSoyn7tg2IWZ1ocgHtbOwI1OsLgAg41AoXHwn5yA9yMXS7etZs+MTzSH
 iSLg==
X-Gm-Message-State: AOAM533WdUdLD2D6FDzda2JbsOSENcb/026PzTDOybCvqZLyE3TTe2HH
 vkwNdpvoRltKZIqeUTFLLPPfA56bDg481iqyxHLcthuImEpVGAEdZrufIjPwjxxPknLi5NL+RPn
 cVw3B1iM3InU4mW4YZEbdq16MNdyRN05evkuskuKDUA==
X-Received: by 2002:a17:906:48d2:: with SMTP id
 d18mr22918687ejt.9.1620143768469; 
 Tue, 04 May 2021 08:56:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIQAoW+b1Hr27OCbdqM8lBhpEx28lo0Dt6YjGp85ljdSReIgB8+1WGRaxAdhL7quji+5bW8g==
X-Received: by 2002:a17:906:48d2:: with SMTP id
 d18mr22918677ejt.9.1620143768325; 
 Tue, 04 May 2021 08:56:08 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i8sm14426799edu.64.2021.05.04.08.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 08:56:08 -0700 (PDT)
Date: Tue, 4 May 2021 17:56:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH RFC 00/14] vhost: multiple worker support
Message-ID: <20210504155606.mlkg7ydwbli56xqu@steredhat>
References: <20210428223714.110486-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210428223714.110486-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

Hi Mike,

On Wed, Apr 28, 2021 at 05:36:59PM -0500, Mike Christie wrote:
>The following patches apply over mst's vhost branch and were tested
>againt that branch and also mkp's 5.13 branch which has some vhost-scsi
>changes.
>
>These patches allow us to support multiple vhost workers per device. I
>ended up just doing Stefan's original idea where userspace has the
>kernel create a worker and we pass back the pid. This has the benefit
>over the workqueue and userspace thread approach where we only have
>one'ish code path in the kernel.
>
>The kernel patches here allow us to then do N workers device and also
>share workers across devices.

I took a first look and left a few comments.

In general it looks good to me, I'm just worried if it's okay to use the 
kthread pid directly or it's better to use an internal id.

For example I think if this can be affected by the pid namespaces or 
some security issues.
I admit I don't know much about this topic, so this might be silly.

>
>I included a patch for qemu so you can get an idea of how it works.
>
>TODO:
>-----
>- polling
>- Allow sharing workers across devices. Kernel support is added and I
>hacked up userspace to test, but I'm still working on a sane way to
>manage it in userspace.
>- Bind to specific CPUs. Commands like "virsh emulatorpin" work with
>these patches and allow us to set the group of vhost threads to different
>CPUs. But we can also set a specific vq's worker to run on a CPU.
>- I'm handling old kernel by just checking for EPERM. Does this require
>a feature?

Do you mean when the new ioctls are not available? We do not return 
ENOIOCTLCMD?

In this case I think is fine to check the return value.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
