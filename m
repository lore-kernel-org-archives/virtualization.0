Return-Path: <SRS0=0f46=CZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1922C433E2
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 16:10:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF112222C
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd2PvsDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF112222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4D08B29C87;
	Wed, 16 Sep 2020 16:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LuQ-8NTlkz3j; Wed, 16 Sep 2020 16:10:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B192420512;
	Wed, 16 Sep 2020 16:10:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96560C0859;
	Wed, 16 Sep 2020 16:10:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7382EC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6704127A5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFRHrtrqSpDh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:10:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 23E7720512
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600272633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZI8lYi1OnkVKApFKCxg3mkSWXhff04EIiDJ1538o1/E=;
 b=Hd2PvsDyfZlaKt81V1VR0Mm3loKSnygQDWVzKj4FkPESTM4dfMLPsGMwUiAF6wnShsFbxL
 LgaoSl0HCWbsqjHaO1e8WRUa99INOrZ02RADEXRhn8PINiTj8tN2HSSY0Y2YZN5Lkc46lx
 lTidncm1EyCOIYNcEZ3b6+D+g6SfxFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-uXhucB7mPUGFFVlYFlCI6A-1; Wed, 16 Sep 2020 12:10:30 -0400
X-MC-Unique: uXhucB7mPUGFFVlYFlCI6A-1
Received: by mail-wr1-f71.google.com with SMTP id d9so2732603wrv.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ZI8lYi1OnkVKApFKCxg3mkSWXhff04EIiDJ1538o1/E=;
 b=lCRbj0LKjaCezsQ5U7VZ6YTG9Yw84aU4UmKs441v0T1GYoyUy1At20x5POzwSq8pJz
 vH+95u8IHmct4H+YaYQwPFyOFG5spYzFcdcwBapsO1MMfiVbscugg6BDC4FUH93vKnXK
 /dQ/vaM9b3I1CX1ZtIIk2RSS8K/VjpqtvqJVrCAfZ6/73i2ipfu9mmOYSTyI1zKoWCR/
 jVLZNorFcbz5R7UoO5eFN6g78Vm0kjhq0+h4J3wB21CHeOsOmenr4+eNjozzle0CMm0T
 JMtnnDVTIP9zomLIwIxt85L6d3+PKG6ANTJIiiw1SDL/howNayeJQ7huPKSuFfsooqg1
 aOqA==
X-Gm-Message-State: AOAM533RwkC5r3bLLPwGUu22HlDpK9yUNUJEfjZiUuYHBwmJ62C2p6Ym
 x+XhhCPj1YGDf27g8uU9jj38y29/mBiCTPZKJtgsfaP8xmbNOigWRjtX2UPt/X1HU5YrucB+tRA
 f+L8XSaXc3fWi6Qv4qyuE6Z2cnVPTMeqS3cMjoUmMvw==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr26503587wrn.238.1600272629015; 
 Wed, 16 Sep 2020 09:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4gkeEWQ6yHkbBOZuacUwDzTM6N52gpGFRvDHDpxtVhNLQe2bjA37+/5JF9PlTOObWYT9BrQ==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr26503567wrn.238.1600272628809; 
 Wed, 16 Sep 2020 09:10:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id f126sm6261892wmf.13.2020.09.16.09.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 09:10:28 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH RFC v1 06/18] x86/hyperv: allocate output arg pages if
 required
In-Reply-To: <20200916154200.7nf74vjmqu3f6sfq@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-7-wei.liu@kernel.org>
 <871rj3l4yt.fsf@vitty.brq.redhat.com>
 <20200915124318.z6tisek5y4d7e254@liuwe-devbox-debian-v2>
 <20200916154200.7nf74vjmqu3f6sfq@liuwe-devbox-debian-v2>
Date: Wed, 16 Sep 2020 18:10:26 +0200
Message-ID: <87zh5phfd9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
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

> On Tue, Sep 15, 2020 at 12:43:18PM +0000, Wei Liu wrote:
>> On Tue, Sep 15, 2020 at 12:16:58PM +0200, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> > 
>> > > When Linux runs as the root partition, it will need to make hypercalls
>> > > which return data from the hypervisor.
>> > >
>> > > Allocate pages for storing results when Linux runs as the root
>> > > partition.
>> > >
>> > > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> > > ---
>> > >  arch/x86/hyperv/hv_init.c       | 45 +++++++++++++++++++++++++++++----
>> > >  arch/x86/include/asm/mshyperv.h |  1 +
>> > >  2 files changed, 41 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > > index cac8e4c56261..ebba4be4185d 100644
>> > > --- a/arch/x86/hyperv/hv_init.c
>> > > +++ b/arch/x86/hyperv/hv_init.c
>> > > @@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>> > >  void  __percpu **hyperv_pcpu_input_arg;
>> > >  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>> > >  
>> > > +void  __percpu **hyperv_pcpu_output_arg;
>> > > +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>> > > +
>> > >  u32 hv_max_vp_index;
>> > >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>> > >  
>> > > @@ -75,14 +78,29 @@ static int hv_cpu_init(unsigned int cpu)
>> > >  	u64 msr_vp_index;
>> > >  	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
>> > >  	void **input_arg;
>> > > -	struct page *pg;
>> > > +	struct page *input_pg;
>> > >  
>> > >  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>> > >  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>> > > -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>> > > -	if (unlikely(!pg))
>> > > +	input_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
>> > > +	if (unlikely(!input_pg))
>> > >  		return -ENOMEM;
>> > > -	*input_arg = page_address(pg);
>> > > +	*input_arg = page_address(input_pg);
>> > > +
>> > > +	if (hv_root_partition) {
>> > > +		struct page *output_pg;
>> > > +		void **output_arg;
>> > > +
>> > > +		output_pg = alloc_page(irqs_disabled() ? GFP_ATOMIC :
>> > >  	GFP_KERNEL);
>> > 
>> > To simplify the code, can we just rename 'input_arg' to 'hypercall_args'
>> > and do alloc_pages(rqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, 1) to
>> > allocate two pages above?
>> 
>> It should be doable, but I need to code it up and test it to be 100%
>> sure.
>> 
>
> I switch to alloc_pages to allocate an order of 2 page if necessary, but
> I keep input_arg and output_arg separate because I want to avoid code
> churn in other places.
>

My idea was that we're free to choose how to use these pages, e.g. with
two pages allocated we can now do a hypercall which takes two pages of
input and produces no output other than the return value. This doesn't
contradict your suggestion to keep input_arg/output_arg as these are
just pointers to the continuous space, we can still do the trick.

I don't feel strong about this and you probably have more patches in
your stash, no need for massive re-work I believe. 

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
