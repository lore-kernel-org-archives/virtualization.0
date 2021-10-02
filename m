Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32695C4332F
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 11:04:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC11A61A8F
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 11:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC11A61A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 792E340474;
	Sat,  2 Oct 2021 11:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2beSMtcJmnGf; Sat,  2 Oct 2021 11:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6E6F4015E;
	Sat,  2 Oct 2021 11:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FEB1C000F;
	Sat,  2 Oct 2021 11:04:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A994C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 054D560658
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id quYpa1vopprG
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 432B060655
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633172677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qto351718/L5ukhIDEPhUdB+4/jOc5k7bmVTjbBmGFU=;
 b=KjolU/u3sKdQGelrWSAOoZE3gu59MY8UOjHHIc0xhzOh4i4LvHzDav+Y3VuWSDlWc636Lr
 c5FAFgPBGFWoKiLrDXqavkCFwGh2tW3WzdHhpitN5n4CWWKc3TlbtL7L8NokA9f1XxukmL
 2gu5cScDnfna3qA35LDEeYD5pjZh02s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-0MNjTIHyN9OR6n4MkgrSkw-1; Sat, 02 Oct 2021 07:04:36 -0400
X-MC-Unique: 0MNjTIHyN9OR6n4MkgrSkw-1
Received: by mail-ed1-f71.google.com with SMTP id
 z62-20020a509e44000000b003da839b9821so12691380ede.15
 for <virtualization@lists.linux-foundation.org>;
 Sat, 02 Oct 2021 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qto351718/L5ukhIDEPhUdB+4/jOc5k7bmVTjbBmGFU=;
 b=vq5H82El9dhxduPdTLkVM1/dVfWebWpNj+ZNEU1nhxHOK41g7jKdmb8ZVCpWR5pTAE
 zAL80RGuvepjxRJN9qjqvJbvBuiOWg244hPjYJ+R0qV7VKq1TuUfeIe57TFDqEONeIMe
 j1sgGVSulmD4WAloYblf2+8Zo1WZPoOa7bOM2uolUe8VrQVuXJf/pSEqB5U9dzNr7+nm
 oN//t4XN8RjF5CIGDjFnHd1n6Koag6L96HcKcHcDqeLFkMQTjnfgR1c9Rzdc1ZkyOSFF
 NtMbrVPfLHEv27xUWpnoyucaUbmoACp6D2P7WR3lVnfBQ4plCM1pyGIAp/TzSt84axiN
 jAjw==
X-Gm-Message-State: AOAM532wVb1eYUiavtyfWqWXe+fl34lVGCGVdbRxRd5Q9v1wgviAwU9X
 yuHdtX12Uz6EZaKpb1G4PT3gaVO7owsFElydJ2pbrym9/IK4HAVknj+uZERwOR3HC3pLHHfJa6i
 ooQX0Ra/tdd3Oig9vVNGihJAvNf5TdOuro2iksgcRJA==
X-Received: by 2002:a17:906:8288:: with SMTP id
 h8mr3663359ejx.87.1633172675243; 
 Sat, 02 Oct 2021 04:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDPoSoXkmNQqJE5Pt6aHzQGKWg+96z9iORt+sMWaffH4hD3Mut3sIH6/2W8YSAjIBpj8fcaA==
X-Received: by 2002:a17:906:8288:: with SMTP id
 h8mr3663331ejx.87.1633172675106; 
 Sat, 02 Oct 2021 04:04:35 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id e3sm3959222ejr.118.2021.10.02.04.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 04:04:34 -0700 (PDT)
Date: Sat, 2 Oct 2021 07:04:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20211002070218-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 USB list <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Reshetova,
 Elena" <elena.reshetova@intel.com>
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

On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> >   Do you have a list of specific drivers and kernel options that you
> > feel you now "trust"?
> 
> For TDX it's currently only virtio net/block/console
> 
> But we expect this list to grow slightly over time, but not at a high rate
> (so hopefully <10)

Well there are already >10 virtio drivers and I think it's reasonable
that all of these will be used with encrypted guests. The list will
grow.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
