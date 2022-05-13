Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC90BC433EF
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 14:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CE3E409C0;
	Fri, 13 May 2022 14:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3aIWNb3Xidbr; Fri, 13 May 2022 14:07:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDC584098F;
	Fri, 13 May 2022 14:07:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C397C0039;
	Fri, 13 May 2022 14:07:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61D38C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 14:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A3838293F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 14:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3msMD1volKij
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 14:07:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3967828DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 14:07:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D635562111;
 Fri, 13 May 2022 14:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE8C34100;
 Fri, 13 May 2022 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652450845;
 bh=JHGmg8HELW1l/NvkzMwcz7ZBqd9Xb6Lnpfs7ZKtiCY4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Zrk377rYFyGd1DKEgPcrB9U2j9iCZcIVPSjX3G4yXLEfiYpGZy5dx2KMZOtOZ0yNr
 NCoJXvvNbST2JWJjySL0hS2bH2g4g0XE7V+Gm1NKCEdd9QvmqMast/6QrQI/KEDfMi
 WorsvflMykUMERYcoyJYSOpC8+l5LMCOzs2YBBRmSJoUTzGKf0scl5FddkBQWOaIhT
 GwnqFB1VZwZplQZt3NTcK3a/KMcSRjIo0CKbfTxNhXSfdEwnYuPerD7pwFFJGJFJA3
 hyQLhJjridnveTZ/DfiPT9rpVPxjE9kNvIpfOa4uQeptvK60qVAzKlySyll0t2HMRY
 5It/PFzyhHP4Q==
Date: Fri, 13 May 2022 09:07:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
Message-ID: <20220513140723.GA947754@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f34130034637278c9999cf6d430be558cb0c2318.camel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
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

On Thu, May 12, 2022 at 04:56:42PM +0200, Niklas Schnelle wrote:
> On Thu, 2022-05-05 at 10:38 +0200, Niklas Schnelle wrote:
> > While determining the next PCI function is factored out of
> > pci_scan_slot() into next_fn() the former still handles the first
> > function as a special case. This duplicates the code from the scan loop.
> > 
> > Furthermore the non ARI branch of next_fn() is generally hard to
> > understand and especially the check for multifunction devices is hidden
> > in the handling of NULL devices for non-contiguous multifunction. It
> > also signals that no further functions need to be scanned by returning
> > 0 via wraparound and this is a valid function number.
> > 
> > Improve upon this by transforming the conditions in next_fn() to be
> > easier to understand.
> > 
> > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > next function we can then handle the initial function inside the loop
> > and deduplicate the shared handling. This also makes it more explicit
> > that only function 0 must exist.
> > 
> > No functional change is intended.
> > 
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> 
> Friendly ping :-)

Thanks and sorry for the delay.  I'm off today for my daughter's
wedding reception but will get back to it next week.  Just to expose
some of my thought process (and not to request more work from you!)
I've been wondering whether b1bd58e448f2 ("PCI: Consolidate
"next-function" functions") is really causing us more trouble than
it's worth.  In some ways that makes the single next-function harder
to read.  But I guess the hypervisor special case is not exactly a
"next-function" thing -- it's a "keep scanning even if there's no fn
0" thing.

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
