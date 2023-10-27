Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA8C25B47
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 18:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F00BA4F149;
	Fri, 27 Oct 2023 18:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F00BA4F149
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L9S64whj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4aq10zj372J; Fri, 27 Oct 2023 18:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 725D64F123;
	Fri, 27 Oct 2023 18:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 725D64F123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB9AC0071;
	Fri, 27 Oct 2023 18:28:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA37C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1171D40A8A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1171D40A8A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=L9S64whj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8DEvo6y5KLex
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:30 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0970940004
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0970940004
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 04CB1B82CFA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DCDC433C7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1698431306;
 bh=WIQHTuAwMRPzUGQS5kvrKRDlGiOJbdW0NtcR24FbqhM=;
 h=Date:From:To:Subject:From;
 b=L9S64whjUAfx5+qT78WWNrxRq58BUcZveL5SG0FfX7NiWcZbdDB+D6+QkhozR+NaQ
 BPQdfJVD7BDiTDaXQKd9+rriY6teBc7heSznbRJbpaH0t9MU167ePj8AIg5kLgWgQa
 Sj3M8+wPeydoRr+BR9FauxweoDvRs6ZKFo18zZB4=
Date: Fri, 27 Oct 2023 14:28:25 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: virtualization@lists.linux-foundation.org
Subject: Moving this list to lists.linux.dev
Message-ID: <20231027-unyielding-futuristic-lizard-d22a58@meerkat>
MIME-Version: 1.0
Content-Disposition: inline
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

Hello, everyone:

The mailman-2 system running lists.linux-foundation.org is overdue to be
retired, so we are working on finding better homes for the few remaining lists
that are still using it.

I propose migrating this list to lists.linux.dev, which is already hosting
many Linux development lists. The upcoming merge window should be a good time
to do it, as it usually results in lower mailing list traffic.

Here's how the process would go:

1. Set up virtualization@lists.linux.dev
2. Move all subscribers from the old list to the new

On the chosen flag day:

3. Remove all subscribers on the old list and add the new list address as
   the only subscriber.
4. Submit a patch to MAINTAINERS so all instances of
   virtualization@lists.linux-foundation.org are replaced with
   virtualization@lists.linux.dev

At some point a few weeks later:

5. Close the old list and add an auto-responder with instructions where all
   mail should be sent instead.

Does that work for everyone?

-K
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
