Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08683C52D11
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 17:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85ABB4088F;
	Thu, 26 Jan 2023 17:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85ABB4088F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=FBh887Jb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHNuOiB_JPeN; Thu, 26 Jan 2023 17:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D59874087E;
	Thu, 26 Jan 2023 17:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D59874087E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC2F7C0033;
	Thu, 26 Jan 2023 17:03:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1056C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 17:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADEE94087E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 17:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADEE94087E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nf8_W7pGBnQ9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 17:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4368140872
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4368140872
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 17:03:22 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 69A2021F7A;
 Thu, 26 Jan 2023 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674752597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eSWKf9uJrUZqhid1T1vG6ji700DgCjuCGV5m/wv4YN4=;
 b=FBh887JbLkjg9dCJJRwnY5u/KYg0Jgm/9oWUg/Zj7OuP6G7q0eTZxXoFoSmg9SVAKP558h
 IO/IdIBKVtEnHxvqF8ONuM+ejeJNb8+YV5O9lDvjXCpELqftBaEI2QZuZsbq4tU107l+W2
 F9ELxNsf8Nnic/OZAJzPIMohwZQHmY8=
Received: from suse.cz (unknown [10.100.208.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 476132C141;
 Thu, 26 Jan 2023 17:03:17 +0000 (UTC)
Date: Thu, 26 Jan 2023 18:03:16 +0100
To: "Seth Forshee (DigitalOcean)" <sforshee@digitalocean.com>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9KyVKQk3eH+RRse@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@kernel.org>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>
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
From: Petr Mladek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri 2023-01-20 16:12:20, Seth Forshee (DigitalOcean) wrote:
> We've fairly regularaly seen liveptches which cannot transition within kpatch's
> timeout period due to busy vhost worker kthreads.

I have missed this detail. Miroslav told me that we have solved
something similar some time ago, see
https://lore.kernel.org/all/20220507174628.2086373-1-song@kernel.org/

Honestly, kpatch's timeout 1 minute looks incredible low to me. Note
that the transition is tried only once per minute. It means that there
are "only" 60 attempts.

Just by chance, does it help you to increase the timeout, please?

This low timeout might be useful for testing. But in practice, it does
not matter when the transition is lasting one hour or even longer.
It takes much longer time to prepare the livepatch.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
