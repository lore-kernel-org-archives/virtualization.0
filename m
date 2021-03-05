Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B8C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 09:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA664F45
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 09:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA664F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDA346FB57;
	Fri,  5 Mar 2021 09:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hl_e8M9T0k2r; Fri,  5 Mar 2021 09:18:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F566F5A8;
	Fri,  5 Mar 2021 09:18:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 691F6C000A;
	Fri,  5 Mar 2021 09:18:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8BF0C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D753443095
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nJ_XfBLkYQXp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:18:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 567EA432E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614935925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cAq6+R4omWqyip9PJ9aVfNyoU1PYQDYL/jyjusPSWNI=;
 b=FMDit5NAERBPb/b+4RxbczaS8A12LHEI7xx0k0DZZMeiEX0Mzp12kR1kIXo3N7Tc05n1TH
 frpWmYE1kwDO3nrF47yK3yLyvLOT3LIqseM0L62jzS94QggS7siUpP+DvW2avVpoSCUGKP
 K2Z+enLxgOGkeWhgq/c7TtY18sgaszI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-vAI-CrYlPFKRRaATMiX-jA-1; Fri, 05 Mar 2021 04:18:41 -0500
X-MC-Unique: vAI-CrYlPFKRRaATMiX-jA-1
Received: by mail-ed1-f72.google.com with SMTP id t27so644044edi.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Mar 2021 01:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=cAq6+R4omWqyip9PJ9aVfNyoU1PYQDYL/jyjusPSWNI=;
 b=jQtfQvRHrWsR7/u4UwMeLCDN6Ru1N+McurTwWhUwdgDhsUKh+Cs5S7cQM9SEy/LlVq
 DbPTdSB/WlyVzfgqbi537KdgvHoS0mOnedan6BJrQjTEGps1YxTaRLyCxCKq4oiZwx2i
 kZL7P97whr8K40k+hLXjFUNmEsRSAQKjZ2YsR3PL6M1r9Gqgl3sWceIwpngHfv8bavTj
 M4ifPa9z62zvzbL+FL6uqzqdx6AT/+T6IahHm8Yc+dbE7smLIGBIa9EZ9sD7KTcWX4IU
 Ti9wuJ9akloEyQXsGVuawoUxwglVhotEY3xUpOCZhpnYuFVBlUeyHx1czzatjxAQgat1
 dtpQ==
X-Gm-Message-State: AOAM5317iDOkq7B2Q9wAZmemV41jIoGC4NAAh3G+fdgMafLrNmJtcJCA
 VLGF8wJJL8DK7pAzF3uVQMJ+ChAuBJV7ZivnJDcD9C2RrxzsZwTvpo6A5qKCN4gKyZ8Y81/92xE
 w7eBMzRlTy+r5bxmsrCGmtep289Nne/C9gCE0VI/QKQ==
X-Received: by 2002:a05:6402:b48:: with SMTP id
 bx8mr8583608edb.162.1614935920336; 
 Fri, 05 Mar 2021 01:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXVfX0PnPVQKsPe9R9YUW7n4rJt0Uylzj8NB5VS7T55LlPe5QcWAL5+fw4IFfKrx7bsdqrHg==
X-Received: by 2002:a05:6402:b48:: with SMTP id
 bx8mr8583591edb.162.1614935920177; 
 Fri, 05 Mar 2021 01:18:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id t17sm1220844edr.36.2021.03.05.01.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 01:18:39 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
Date: Fri, 05 Mar 2021 10:18:38 +0100
Message-ID: <87eeguc61d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.liu@kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 sunilmut@microsoft.com, virtualization@lists.linux-foundation.org,
 viremana@linux.microsoft.com, ligrassi@microsoft.com
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

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
>> 
...
>>> +
>>> +3.1 MSHV_REQUEST_VERSION
>>> +------------------------
>>> +:Type: /dev/mshv ioctl
>>> +:Parameters: pointer to a u32
>>> +:Returns: 0 on success
>>> +
>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
>>> +establish the interface version with the kernel module.
>>> +
>>> +The caller should pass the MSHV_VERSION as an argument.
>>> +
>>> +The kernel module will check which interface versions it supports and return 0
>>> +if one of them matches.
>>> +
>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
>>> +it is open - this ioctl can only be called once per open.
>>> +
>> 
>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
>> instead.
>> 
>
> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
> When we add new features/ioctls beyond the core we can use an extension/capability
> approach like KVM.
>

Driver versions is a very bad idea from distribution/stable kernel point
of view as it presumes that the history is linear. It is not.

Imagine you have the following history upstream:

MSHV_REQUEST_VERSION = 1
<100 commits with features/fixes>
MSHV_REQUEST_VERSION = 2
<another 100 commits with features/fixes>
MSHV_REQUEST_VERSION = 2

Now I'm a linux distribution / stable kernel maintainer. My kernel is at
MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
history now looks like

MSHV_REQUEST_VERSION = 1
<5 commits from between VER=1 and VER=2>
   Which version should I declare here???? 
<5 commits from between VER=2 and VER=3>
   Which version should I declare here???? 

If I keep VER=1 then userspace will think that I don't have any extra
features added and just won't use them. If I change VER to 2/3, it'll
think I have *all* features from between these versions.

The only reasonable way to manage this is to attach a "capability" to
every ABI change and expose this capability *in the same commit which
introduces the change to the ABI*. This way userspace will now exactly
which ioctls are available and what are their interfaces.

Also, trying to define "core set" is hard but you don't really need
to.

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
