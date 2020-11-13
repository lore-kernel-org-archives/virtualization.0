Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D09C55ABD
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 16:14:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909DE208D5
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIIXLUQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909DE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4999887907;
	Fri, 13 Nov 2020 16:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bEA54vnTqyf; Fri, 13 Nov 2020 16:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C807987755;
	Fri, 13 Nov 2020 16:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB537C0891;
	Fri, 13 Nov 2020 16:14:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23764C0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1192B87816
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poZQTNLxTKfX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 07E1987755
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605284042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
 b=XIIXLUQ5JM70oiqp/33b/cFXqy8vCEy9+24k1oH3tmwuSht4nJqqsP7jC3Ah4BZvFVjZsg
 D5SDyaoQSg2o9YU1iKp7iqA9o1N7RiGIiXrm+HqS0w7BF+yRdVffKu2YfALEFf+qmVY/6y
 ro9g5nkOPYA629Rgcm/OYtV3jw0tAls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-pKaUzOdFMyScLpnGZcXY9w-1; Fri, 13 Nov 2020 11:14:00 -0500
X-MC-Unique: pKaUzOdFMyScLpnGZcXY9w-1
Received: by mail-wm1-f72.google.com with SMTP id k128so4176862wme.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=lPjThI4CN4zNtchIWv2ayPLPXQ5dzA6VBedvQBJvswQ=;
 b=MQfXEPUxHTgFYKHRUkqYY292+/6KhxCLvCSf5dfFyXtsXKeqf5ARvjdY02EdUnday+
 VxnCoEKfXJh0H7GaeWHS+/CDLNo3Rz0EG5Yz//E+hxNxWLZDD6V1Z5LfKBBvHDZHzDhS
 kKgK8iBAKQT+1JX0F7fn+uoBDkYA5Z55FtO0XtEVcAQ7fIYeAM6XmUYvWB3VewqpZCmb
 NybmX6LSLRc53YJfZbA9uiNcU6tDstSwF5V1behfnEw0a7gy0pCK9zRNkqFLjeWmJ+9D
 PRg9Ut898NHVT9jveZXG2V9tTJur3Hf54UVC22VupCbaCrhTb0/GCzeN/Q2ALp6U7BuW
 ODHg==
X-Gm-Message-State: AOAM5336kA6p8QUYgRqcI13wZKfnKOWAoTZU6Ory+y0ey2Q53FIJ9coq
 kIZtGNNv21x5QBuWEv8eTluy0kUglmeuDBjW8eicCKH9nFqqlvCRFE3qh6WO2D/kzNrFw77fft/
 bgFgBI7hvTMYuAWjQ2NZkS7YxL6I6e/6JpshNuDF+yw==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330865wmb.80.1605284031508;
 Fri, 13 Nov 2020 08:13:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEiuKnDYBv81x66rrPhoiQlzwCLdD8os2zSbokQH7OHbb6WTSUyo1RRJZXPMJ4FUH64NtzPg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr3330501wmb.80.1605284026289;
 Fri, 13 Nov 2020 08:13:46 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id u6sm10587225wmj.40.2020.11.13.08.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 08:13:45 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
In-Reply-To: <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
 <871rgyy3d1.fsf@vitty.brq.redhat.com>
 <20201113155111.fcruk7dlsp6ohoq5@liuwe-devbox-debian-v2>
Date: Fri, 13 Nov 2020 17:13:44 +0100
Message-ID: <87zh3lutdz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>,
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

> On Thu, Nov 12, 2020 at 04:57:46PM +0100, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
> [...]
>> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> > index 67f5d35a73d3..4e590a167160 100644
>> > --- a/arch/x86/include/asm/mshyperv.h
>> > +++ b/arch/x86/include/asm/mshyperv.h
>> > @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>> >  
>> >  extern u64 hv_current_partition_id;
>> >  
>> > +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>> > +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>> > +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>> 
>> You seem to be only doing EXPORT_SYMBOL_GPL() for
>> hv_call_deposit_pages() and hv_call_create_vp() but not for
>> hv_call_add_logical_proc() - is this intended? Also, I don't see
>> hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
>> arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?
>> 
>
> hv_call_deposit_pages and hv_call_create_vp will be needed by /dev/mshv,
> which can be built as a module.
>

I'd suggest to move EXPORT_SYMBOL_GPL() to the series adding '/dev/mshv'
then. Dangling exported symbols with no users tend to be removed. No
strong opinion, just a suggestion.

> hv_call_add_logical_proc is only needed by mshyperv.c and not exported
> in the first place.
>
> This code is fine.

Thanks for the confirmation!

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
