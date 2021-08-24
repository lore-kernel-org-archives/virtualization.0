Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF8C432BE
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AF161360
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1AF161360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A5EE6080D;
	Tue, 24 Aug 2021 09:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aSwXCvtaz8y; Tue, 24 Aug 2021 09:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05EA760679;
	Tue, 24 Aug 2021 09:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C77C4C0010;
	Tue, 24 Aug 2021 09:12:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97A9AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 746BA607FA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFECvifxVeZK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:12:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD890607EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629796334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
 b=WI2iedHH2taVyY9wcfzewtSOD8fH6gtPdVkEhIS0OU+P7OJH7AjJ3dC9KM971MIfxF4LS1
 yU6OLaD8EOL1y0NvqAo4OI3M2vPI+YkvuOTGVunaQJrPomhcU+0W2qwQtSp8/Vm+AtryWR
 vedIYfj39pCbQa8av+nQmHX7C1zPCsY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-2Z5YQc7IMd6xnWwnmEZvRg-1; Tue, 24 Aug 2021 05:12:11 -0400
X-MC-Unique: 2Z5YQc7IMd6xnWwnmEZvRg-1
Received: by mail-ed1-f69.google.com with SMTP id
 z4-20020a05640240c4b02903be90a10a52so10201088edb.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UO2zBbBs1G6uT3R3xch5pdAd9JzMFmQCenqYTZnnAws=;
 b=I6Ia47pGZu4QN/rJKAGqB5DToFzH2QeqXG1rNGoHLunwXO3J9hGGkYxow8Vjfr58JA
 vadV4wmKeEWZS2jrchfrVXLqehOTymNndi+XNdMCFRDljjkhPC7de9+DbX9W4txWv0rP
 tuuRvSTBf7JmFQdnbbxDeUlm9WB6NPgIISAFQjpoSbohc4q4XDdduSMbEuKVDs/7VTTH
 uSY4EEXQeUQF/AtqTuiMoz8BtcSCo9BIWyoRBURmtBEHeGKPLJg4numlk+ZUpwZ1UVkZ
 eazzm03K23PGq41fPWzWOFovAbN/cblGfIG/U5Cc5DeWSLdspBP0du1eSKwjZI4ponSS
 BmSw==
X-Gm-Message-State: AOAM532opaw6N2co5wQv//cfQgBnyc8aUdsFC5GVZeWZAAnU4rW67oo1
 yDi7w2AORQDHrkWI4tg8sbjgJconnXwhdlWQfGk4c+LKZgqWSRC9BQOvY0HrLua3cfCPA+XivKL
 g5tdjCgNCwgH2xhkNcCRhM66z6stXIvAkZhtoz9ZYtg==
X-Received: by 2002:a17:906:544f:: with SMTP id
 d15mr39905077ejp.520.1629796330484; 
 Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3bMICaqu3WLm0C02mi3EAPqHyfBIAeSrxUN0aqhXmoBEhQ7Pz6k5PO9S6BLCHr/N7T4Bnvg==
X-Received: by 2002:a17:906:544f:: with SMTP id
 d15mr39905053ejp.520.1629796330344; 
 Tue, 24 Aug 2021 02:12:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
 by smtp.gmail.com with ESMTPSA id b18sm2737239ejl.90.2021.08.24.02.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 02:12:09 -0700 (PDT)
Date: Tue, 24 Aug 2021 05:12:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210824050842-mutt-send-email-mst@kernel.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
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

On Mon, Aug 23, 2021 at 05:30:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> > > Add a new variant of pci_iomap for mapping all PCI resources
> > > of a devices as shared memory with a hypervisor in a confidential
> > > guest.
> > > 
> > > Signed-off-by: Andi Kleen<ak@linux.intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
> 
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

I can't say this answers the question at all. PCI devices are part of
the VMM and so un-trusted. In particular PCI devices do not have
the key to decrypt memory. Therefore as far as I can see PCI resources
should not be encrypted.  I conclude they all should be marked
shared.

If I'm wrong can you please give an example of a PCI resource
that is encrypted?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
