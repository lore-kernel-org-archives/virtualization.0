Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59BC4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 14:52:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFF7610E8
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EFF7610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F40C80DC1;
	Wed, 25 Aug 2021 14:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTcWkODhjKQz; Wed, 25 Aug 2021 14:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4DE380DD4;
	Wed, 25 Aug 2021 14:52:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87448C0010;
	Wed, 25 Aug 2021 14:52:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 921A2C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 14:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87A14613B8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 14:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rpPs4jlfJg-k
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 14:52:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05297613B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 14:52:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36A4E610CD;
 Wed, 25 Aug 2021 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629903156;
 bh=JavDwpgii8kF2lXyvHOwR8IF/SUWfOr82rbSiTe1nco=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=etlal+X6PK/iyyE+nCKJqe8xvh6sOY35Jz8lqksr6gEQVCToh4OokpBhqzSLN+EQd
 CbpLIssWEQtnZPMe70kfBxZJeme2Vw5EfXhChn/2RVE74/XOQ0ogJdDJbJSxQ6B6tW
 NpWtwQV/bKLoQqX4+aw+rClsxeZQuTcMptgtwqLJE9cPhKmxBAMOvE9u1TAbpbyusm
 2r/bieajK+y11XHoHy7rRrWGS+kpuVvgAm5FMOgzMz/YOJ/ryEgttZaNO+A2gFqSgV
 gSDOXXqDHEGwZCzB6XgcGfNipfy8ECvl8ldyO/Fs4RX/PiHXnplmt9Ddb5SbfOzVkW
 H7gyI/GMyzCTg==
Date: Wed, 25 Aug 2021 09:52:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210825145235.GA3565590@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bb8c6f96-2597-bb80-bd08-7958405e1bf5@linux.intel.com>
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Rajat Jain <rajatja@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Tue, Aug 24, 2021 at 01:50:00PM -0700, Andi Kleen wrote:
> 
> On 8/24/2021 1:31 PM, Bjorn Helgaas wrote:
> > On Tue, Aug 24, 2021 at 01:14:02PM -0700, Andi Kleen wrote:
> > > On 8/24/2021 11:55 AM, Bjorn Helgaas wrote:
> > > > [+cc Rajat; I still don't know what "shared memory with a hypervisor
> > > > in a confidential guest" means,
> > > A confidential guest is a guest which uses memory encryption to isolate
> > > itself from the host. It doesn't trust the host. But it still needs to
> > > communicate with the host for IO, so it has some special memory areas that
> > > are explicitly marked shared. These are used to do IO with the host. All
> > > their usage needs to be carefully hardened to avoid any security attacks on
> > > the guest, that's why we want to limit this interaction only to a small set
> > > of hardened drivers. For MMIO, the set is currently only virtio and MSI-X.
> > Good material for the commit log next time around.  Thanks!
> 
> This is all in the patch intro too, which should make it into the merge
> commits.

It's good if the cover letter makes into the merge commit log.

It's probably just because my git foo is lacking, but merge commit
logs don't seem as discoverable as the actual patch commit logs.  Five
years from now, if I want to learn about pci_iomap_shared() history, I
would "git log -p lib/pci_iomap.c" and search for it.  But I don't
think I would see the merge commit then.

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
