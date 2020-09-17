Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A7C43461
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 11:06:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAAA2076D
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 11:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ameBUrkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAAA2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BD0187894;
	Thu, 17 Sep 2020 11:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyvZ5pagYtP1; Thu, 17 Sep 2020 11:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 122D687746;
	Thu, 17 Sep 2020 11:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00187C0888;
	Thu, 17 Sep 2020 11:06:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E76DDC0859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C9C252E0DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iv7NuWcadyqr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:06:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 211B02E16C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600340773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
 b=ameBUrkMJuXjX/ikvkGV/98IpSuBYbgXsoMkmgLdPfqR0a86Wo3maXBJB9ONpZQAPKVBVw
 m3021tjrP4DmpA/MpD+8MvLNQec6UYDQ6xYzfEYmOYkz7+0t8GVqktfLpGHDsYsMObl9Bw
 +BK7joHlHPhaL/b+eitFLv+ocFLsilw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248--vmdk9N_P2K4lpXPCL22XA-1; Thu, 17 Sep 2020 07:06:09 -0400
X-MC-Unique: -vmdk9N_P2K4lpXPCL22XA-1
Received: by mail-wm1-f71.google.com with SMTP id t8so418126wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 04:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
 b=ky+5PWpW8Ghg32Rw453rABiphmXOXjFe4Edm7f4+567m9UxK2D9MJqqsae4xTeq8Js
 GTETbtqUOyiHF1g9gtoQYEnNNlb4Kj3uAP5Lek3bw0/zAOwUnhW5LOZ9GY282S9ZcSy+
 a3fvdUGmnFCQsXnCdM3sbJ/YSHZzayY3oRITbNb57JqxCa2xKE34T6epQCt4FOoynkXf
 OAICqenoVdk7MFOAsXkpizdjVUIFyImR/Ih0lWWeKrnrIqb5vQhdYk45f7ZmwwPcIErR
 hKS+OuAru/8g3MuJ/J27q51pRwL1d7/ZduqMIXsS9DK+tT4984WUD6xpG0G1irLcmBCl
 Oxjg==
X-Gm-Message-State: AOAM5305ozMDBr2UBufqRi+gLLp87hRspemoWxSrMYkDyFky6FNTyWcP
 dqwpCpyblAED2/+D6cbsL5zZmduEzYePlhUNpJQd7DmlQ25um9dVIh30rgnAhlMM4gNyiUBNQ4R
 CPMA488MGhavWNB2oO9zgFTsK8WrYEDt6vYJrXPOhnw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966918wma.141.1600340768655; 
 Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfvk8nBFDHZbY4h5lzElLZko5UHfTtrciX4WBrNYMfc9yO+qi5h6FrEF/dqbAWoZhK7788tg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966887wma.141.1600340768444; 
 Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id v4sm10412112wml.46.2020.09.17.04.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 04:06:07 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH RFC v1 08/18] x86/hyperv: handling
 hypercall page setup for root
In-Reply-To: <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
 <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
 <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
Date: Thu, 17 Sep 2020 13:06:06 +0200
Message-ID: <87o8m4hdcx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nuno Das Neves <Nuno.Das@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

Sunil Muthuswamy <sunilmut@microsoft.com> writes:

>> 
>> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> >
>> > > When Linux is running as the root partition, the hypercall page will
>> > > have already been setup by Hyper-V. Copy the content over to the
>> > > allocated page.
>> >
>> > And we can't setup a new hypercall page by writing something different
>> > to HV_X64_MSR_HYPERCALL, right?
>> >
>> 
>> My understanding is that we can't, but Sunil can maybe correct me.
>
> That is correct. For root partition, the hypervisor has already allocated the
> hypercall page. The root is required to query the page, map it in its address
> space and wrmsr to enable it. It cannot change the location of the page. For
> guest, it can allocate and assign the hypercall page. This is covered a bit in the
> hypervisor TLFS (section 3.13 in TLFS v6), for the guest side. The root side is 
> not covered there, yet.

Ok, so it is guaranteed that root partition doesn't have this page in
its address space yet, otherwise it could've been used for something
else (in case it's just normal memory from its PoV).

Please add a comment about this as it is not really obvious.

Thanks,

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
