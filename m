Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0238DC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 14:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917B7608FC
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 14:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917B7608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52BB540F1B;
	Wed,  7 Apr 2021 14:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id opixySIiLiZD; Wed,  7 Apr 2021 14:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F4640F12;
	Wed,  7 Apr 2021 14:03:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91577C000C;
	Wed,  7 Apr 2021 14:03:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3600C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 14:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6788405E5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 14:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IrlJ7jChPfT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 14:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FD59405DC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617804180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uu7DUKi3aMdx30NPxijI78spi2F+sW6pd08YQfEqN7g=;
 b=jNU9sqeveZMj2pGlqMQfeNHlmZuXWU/1I1cuB4e6Fi+A//bM0k52Sd1Ful7/Z6snpF4vOx
 Hdl51QU0gcaoRls6vBLha6xDOgQegDpYXfKbUFQesqWQXKNo+ods20/ZeTYpf0jkjYe5eD
 oraTyLG2/42sf+tQ576XSQy8ZX1RXao=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-jYZlySR7P1iQCognP6H7wg-1; Wed, 07 Apr 2021 10:02:58 -0400
X-MC-Unique: jYZlySR7P1iQCognP6H7wg-1
Received: by mail-ej1-f70.google.com with SMTP id dv7so3956420ejb.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Uu7DUKi3aMdx30NPxijI78spi2F+sW6pd08YQfEqN7g=;
 b=GsHSV51bUow+XZHVfkoc55qEj+mxdk+K80shJyAeqGpjYGY0r9FTTX/mDtkpbYsqfJ
 ldmMlxWGwbEpzzgYtYJmwMtnaUeGgxZX96FoY7+nKPlW1IUpRnh4dD4i+PxtgAfTvqNK
 EXKP4l57xUgWrZAWhlW8ZNe7lNV0IW5AVx3516oGVCx2k1tufvEopCCIBKrziBUw2CXK
 CoZpWJ89jkBufucZUW9ZBzleBqylvjkMZNtUNkg0iVltqlCng7kBsZbR1Y3XarNwc96h
 JYjsusL4ypcZg6aS5nWtms7XRh7CkZGjMqTBbDjwjiOuq4sZKNoYzhuQugAv7Z1oDy6/
 ENfQ==
X-Gm-Message-State: AOAM530dFruxYB41cB1qVUSL7QFawaI7BkHvjnBR3KP62V45xPGpKljK
 fDgTvTKMMhhfuwhLboft46lO/DVhFtrpLi0U7Y5AB6UvbVGdMP5g/hkAycuE+5Hk06ebRagFcWD
 ENYVaiIjFdCrnDuIiz/FoejH6IVPqVCj37yD/7pPbow==
X-Received: by 2002:a05:6402:42d1:: with SMTP id
 i17mr4441842edc.131.1617804177637; 
 Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRY/y/lnspEMRzFi+bpSAp/LmL7KtYGcLjTCU76MWEezzicC4MAIKqO/OW+TvYrU+991QDMw==
X-Received: by 2002:a05:6402:42d1:: with SMTP id
 i17mr4441825edc.131.1617804177514; 
 Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id x17sm12637723ejd.68.2021.04.07.07.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 07:02:57 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
In-Reply-To: <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
 <87eefmczo2.fsf@vitty.brq.redhat.com>
 <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
Date: Wed, 07 Apr 2021 16:02:56 +0200
Message-ID: <875z0ychv3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikelley@microsoft.com, wei.liu@kernel.org,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>, sunilmut@microsoft.com,
 virtualization@lists.linux-foundation.org, viremana@linux.microsoft.com,
 ligrassi@microsoft.com
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

> On Wed, Apr 07, 2021 at 09:38:21AM +0200, Vitaly Kuznetsov wrote:
>
>> One more though: it is probably a good idea to introduce selftests for
>> /dev/mshv (similar to KVM's selftests in
>> /tools/testing/selftests/kvm). Selftests don't really need a stable ABI
>> as they live in the same linux.git and can be updated in the same patch
>> series which changes /dev/mshv behavior. Selftests are very useful for
>> checking there are no regressions, especially in the situation when
>> there's no publicly available userspace for /dev/mshv.
>
> I think this can wait until we merge the first implementation in tree.
> There are still a lot of moving parts. Our (currently limited) internal
> test cases need more cleaning up before they are ready. I certainly
> don't want to distract Nuno from getting the foundation right.
>

I'm absolutely fine with this approach, selftests are a nice add-on, not
a requirement for the initial implementation. Also, to make them more
useful to mere mortals, a doc on how to run Linux as root Hyper-V
partition would come handy)

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
