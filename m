Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3DC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 18:45:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAC064DE1
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 18:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAC064DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19085871A7;
	Thu,  4 Feb 2021 18:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q42uwFNmL5I9; Thu,  4 Feb 2021 18:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A7AB187245;
	Thu,  4 Feb 2021 18:45:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90053C0174;
	Thu,  4 Feb 2021 18:45:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15FA6C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E404887246
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g6vqx3o2XtCx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:45:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5733A871A7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 18:45:38 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id e70so4380641ote.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 10:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xnuUw1FLcM4+2rBIDsM0pF6wdlTJf4QW7NKIBa7PlDU=;
 b=qsKUixjknaCSCrZOWHkAgZwhrnIFXoYrB8g8HgTi+bYV26Ek9MMsXdnC8BQa9adsg2
 yx5Vj7soMUSvdlYO1MpThSCSI81n+wotlFDIaPXU3+aiAntFs9K1T7zYpUojy6eTQl7x
 0TNcehD/XSPq5avtvcBBsZjB8YrdYK6DEYRHONTyvJl9HWjc1awDl5kqr/RRyWGcGT0Y
 YkE1vWQ0Pvl8kKbBtOsPkmAho4qm/gpDtvzwGWZBgGdh8dbQ+2HiGJiKHOgaPdZVLIH8
 Opdrbecb5/p1QLJ8BF36qLWmh5c13grDj4WQ3VpeFMrOd0AE3hgCQSmcrajI/5jQZgr1
 I7OQ==
X-Gm-Message-State: AOAM532u7uCWmkOcaW8m7q+NinU7itKhOft6Z3ptQ2fR5x4I9yHImpyZ
 KQbI1ZYmdcwdvYrjh7KpgyYp4oj3oGRTVaixnhc=
X-Google-Smtp-Source: ABdhPJwK95CDaaKkEZNHkySmn2WdN+iBqCzuyanMrOGG8WbGe+I9XJxDm16VMC5E8ME5QFhIbip3DGg0SxLQwDn8Ov0=
X-Received: by 2002:a05:6830:2313:: with SMTP id
 u19mr554329ote.321.1612464336202; 
 Thu, 04 Feb 2021 10:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-9-wei.liu@kernel.org>
 <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
In-Reply-To: <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Feb 2021 19:45:25 +0100
Message-ID: <CAJZ5v0gJD1B92FsSo9xMrdFWYEh5DHqAQQ4TiFbHV=a2XpBEbg@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 "open list:ACPI COMPONENT ARCHITECTURE \(ACPICA\)"
 <linux-acpi@vger.kernel.org>,
 "open list:ACPI COMPONENT ARCHITECTURE \(ACPICA\)" <devel@acpica.org>,
 Erik Kaneda <erik.kaneda@intel.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Robert Moore <robert.moore@intel.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>, Len Brown <lenb@kernel.org>
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

On Thu, Feb 4, 2021 at 7:41 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Wed, Feb 03, 2021 at 03:04:27PM +0000, Wei Liu wrote:
> > There is already a stub function for pxm_to_node but conversion to the
> > other direction is missing.
> >
> > It will be used by Microsoft Hypervisor code later.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>
> Hi ACPI maintainers, if you're happy with this patch I can take it via
> the hyperv-next tree, given the issue is discovered when pxm_to_node is
> called in our code.

Yes, you can.

Thanks!

>
> > ---
> > v6: new
> > ---
> >  include/acpi/acpi_numa.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index a4c6ef809e27..40a91ce87e04 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
> >  {
> >       return 0;
> >  }
> > +static inline int node_to_pxm(int node)
> > +{
> > +     return 0;
> > +}
> >  #endif                               /* CONFIG_ACPI_NUMA */
> >
> >  #ifdef CONFIG_ACPI_HMAT
> > --
> > 2.20.1
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
