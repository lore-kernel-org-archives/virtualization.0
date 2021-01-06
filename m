Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C743C433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81CE2310C
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81CE2310C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2583E22882;
	Wed,  6 Jan 2021 10:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVpxtXMs2sXD; Wed,  6 Jan 2021 10:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9E5C9204A8;
	Wed,  6 Jan 2021 10:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E974C088B;
	Wed,  6 Jan 2021 10:03:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D48C1C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 10:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C4C388702B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 10:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObPx-jjzgV4b
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 10:03:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D94187004
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 10:03:19 +0000 (UTC)
Received: from zn.tnic (p200300ec2f09690020b9eee96d74c6dd.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f09:6900:20b9:eee9:6d74:c6dd])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE4281EC04F0;
 Wed,  6 Jan 2021 11:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1609927395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=iAfpaZseU8rtBfSQH6eBi47GvS0K9Dab1MU6EmvLzI4=;
 b=czQrmcoO22O7xdC9bFE4W9lPaNRZpf1Z2jpKUXdHJyQbbVDKBJGpJS1to4FH6VjI/6Qy6+
 56XCeScS3+yGMxXTpDcmKoGK4EgczE77stbxqRnJWO446dmnV5ONxt9cP+fdM67fBlkYrQ
 aVVK2zT/Xvgpdhch6r6/CPCc140lQtU=
Date: Wed, 6 Jan 2021 11:03:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to
 use static_call()
Message-ID: <20210106100313.GB5729@zn.tnic>
References: <20201217093133.1507-1-jgross@suse.com>
 <20201217093133.1507-7-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201217093133.1507-7-jgross@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-hyperv@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, "VMware, Inc." <pv-drivers@vmware.com>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 xen-devel@lists.xenproject.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
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

On Thu, Dec 17, 2020 at 10:31:24AM +0100, Juergen Gross wrote:
> The time pvops functions are the only ones left which might be
> used in 32-bit mode and which return a 64-bit value.
> 
> Switch them to use the static_call() mechanism instead of pvops, as
> this allows quite some simplification of the pvops implementation.
> 
> Due to include hell this requires to split out the time interfaces
> into a new header file.

I guess you can add Peter's patch to your set, no?

https://lkml.kernel.org/r/20201110005609.40989-3-frederic@kernel.org

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
