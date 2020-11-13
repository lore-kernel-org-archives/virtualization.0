Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0DBC388F7
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 16:16:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196D12078D
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 16:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkSY0DTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196D12078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7FEAD2E248;
	Fri, 13 Nov 2020 16:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SG9miA6sb0zM; Fri, 13 Nov 2020 16:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 80094204C7;
	Fri, 13 Nov 2020 16:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C10CC0891;
	Fri, 13 Nov 2020 16:16:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E72CFC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D60DC87511
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Of6ijtXkjw2v
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3F5618750B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605284188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jyN+DRRhVWX4G1okBIOdr3MH4mQtZ4BI+4XoCFZkPBY=;
 b=DkSY0DTSRvCu9IEGbFLizm3K3eX+8p/hlAzzpVZB1Tif0/nmhsnTN3bvZRcbJcPChsXv/B
 QCD9EsXKVMLG5jV7yPi2VVHFO7SdbNRVsHzdNhRyO9dszKd7sy2yb+9I2Kw1JIw232dFrX
 XfmqR2KfZpvPROxFY4M3xkusL23sJyg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-1ctz9mpKM6Gu0zbJn7EplA-1; Fri, 13 Nov 2020 11:16:26 -0500
X-MC-Unique: 1ctz9mpKM6Gu0zbJn7EplA-1
Received: by mail-wm1-f70.google.com with SMTP id y1so4185471wma.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=jyN+DRRhVWX4G1okBIOdr3MH4mQtZ4BI+4XoCFZkPBY=;
 b=Jk9BwR7/UZlSFVzztLoYMNfEZQZqEQZGdT1+ASwABxeEASVsHyQ5PV01k2j9JbfyqA
 F+C/OYVPdmhTYIbUpHDpoyrCLV2zIhwUc7ROMQSX5hDxZ1tIe7GlsTMYtk4RzQXSX2qf
 t9TNKIkb/Ap2wsG76SQDoQHFjtDPZG+CJrTbT/+Ec2OvWeqR0tAmGHCnd4lPIEkAV0SK
 aZjx1tpmRpjg4lnlCRHQ02v53762Q0BN8TEbGv+lXd8om2CnhrDnKBfAg12h4JJFhmzk
 HF4uua19RcouGT5BTiVvC7F34N43mV0IAUEYObzxobLHJYJJz35gutzFjvUIW/rZywj0
 5BIg==
X-Gm-Message-State: AOAM533cDDTEvCIV8Ubt84BGNqhBCw2ZELmT6ctKb+Aprsi+p9sw6BYy
 UwlRYbshd9kTc4wwQvNv+N/G66c3rZ/N0Z4aRIeZpvzsogv73JwWkKSWEzuJCLU4kpWvj/nheHb
 9doVplGjCBeiwKSc08Nb7TAtOva/nflx2ZUsEcOGOoQ==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr3226444wmi.122.1605284179617; 
 Fri, 13 Nov 2020 08:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6qc4C468qlMkz/BkAoW2zg7V66Dzr5nIEzyPk8ex6nToKTomKk7QfUb8pi/ZNVqMxbgaPow==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr3226167wmi.122.1605284175430; 
 Fri, 13 Nov 2020 08:16:15 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id a131sm10530265wmh.30.2020.11.13.08.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 08:16:14 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
In-Reply-To: <20201113160907.rwgpge3zo53fcgvo@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
 <874kluy3o2.fsf@vitty.brq.redhat.com>
 <20201113153333.yt54enp5dbqjj5nu@liuwe-devbox-debian-v2>
 <20201113160907.rwgpge3zo53fcgvo@liuwe-devbox-debian-v2>
Date: Fri, 13 Nov 2020 17:16:13 +0100
Message-ID: <87wnyput9u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, "maintainer:X86
 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Lillian Grassin-Drake <ligrassi@microsoft.com>
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

Wei Liu <wei.liu@kernel.org> writes:

> On Fri, Nov 13, 2020 at 03:33:33PM +0000, Wei Liu wrote:
>> On Thu, Nov 12, 2020 at 04:51:09PM +0100, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> > 
>> > > When Linux is running as the root partition, the hypercall page will
>> > > have already been setup by Hyper-V. Copy the content over to the
>> > > allocated page.
>> > >
>> > > The suspend, resume and cleanup paths remain untouched because they are
>> > > not supported in this setup yet.
>> > 
>> > What about adding BUG_ONs there then?
>> 
>> I generally avoid cluttering code if I'm sure it definitely does not
>> work.
>> 
>> In any case, adding BUG_ONs is not the right answer. Both hv_suspend and
>> hv_resume can return an error code. I would rather just do
>> 
>>    if (hv_root_partition)
>>        return -EPERM;
>> 
>> in both places.
>
> Correction: hv_resume is void, so I won't add that code snippet. But we
> should still be fine because hv_suspend will have already failed in the
> first place.
>

Works for me. I just very much prefer to get reports like "system
doesn't go to sleep" instead of "something crashes when I put my system
to sleep")

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
