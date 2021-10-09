Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D59C433EF
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 01:45:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CDF60FE8
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 01:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6CDF60FE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8A4E83A5D;
	Sat,  9 Oct 2021 01:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZw2TB5R0_gZ; Sat,  9 Oct 2021 01:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBAFF83A5E;
	Sat,  9 Oct 2021 01:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92557C0011;
	Sat,  9 Oct 2021 01:45:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9665FC000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 01:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AE7D40690
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 01:45:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7OgarrD3Nt1T
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 01:45:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C6D4068F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 01:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=8Yhlfpn88xGUZ0D2UsU9ZR1KIwe5CGURq7DLgR1hrBY=; b=1Z6zSdy4U1cnEgkDHFifc+XY8Y
 GlewY7KjyFBbKH64naXeI41ZeCK2wzbxmLYn8tQReOLUCKAfWokngJdgXzG2kZqfZuukHe0LzGSem
 /fWn4TtGInc4xujKU9lhTWQmbcOyZPdRobBXzgyYqQiz2V+LCqXMtthT6T+ZQAyQo3oPf9aPdoOkJ
 XKCfcDJy3GwQcs5wemBALdUGapmhhOQ0Ws+MHquNKSKXMDSnM/RxQhR8WlIXhEXmTBWm/wLd+hHF0
 AGJlpBT1b3CurBjVkXBwVF3uizzCjn8R7aZLHlbBj649FMdFXEGzDXcQrpB78Kj/tCgGw8zSXNsVA
 Vnnceg4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ1QW-004Rhr-Nh; Sat, 09 Oct 2021 01:45:28 +0000
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 James E J Bottomley <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, "David S . Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b4c3e3e-09e4-3bf8-6e23-77892fb6df02@infradead.org>
Date: Fri, 8 Oct 2021 18:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 linux-alpha@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Peter H Anvin <hpa@zytor.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 10/8/21 5:37 PM, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..0af19cb1a28c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2076,6 +2076,18 @@
>   			1 - Bypass the IOMMU for DMA.
>   			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>   
> +	ioremap_force_shared= [X86_64, CCG]
> +			Force the kernel to use shared memory mappings which do
> +			not use ioremap_host_shared/pcimap_host_shared to opt-in
> +			to shared mappings with the host. This feature is mainly
> +			used by a confidential guest when enabling new drivers
> +			without proper shared memory related changes. Please note
> +			that this option might also allow other non explicitly
> +			enabled drivers to interact with the host in confidential
> +			guest, which could cause other security risks. This option
> +			will also cause BIOS data structures to be shared with the
> +			host, which might open security holes.

Hi,
This cmdline option text should have a little bit more info. Just as an
example/template:

	acpi_apic_instance=	[ACPI, IOAPIC]
			Format: <int>
			2: use 2nd APIC table, if available
			1,0: use 1st APIC table
			default: 0

So what is expected after the "=" sign?...

thanks.
-- 
~Randy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
