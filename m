Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B88C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 14:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0078E81BE3;
	Tue,  7 Nov 2023 14:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0078E81BE3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZV6LE5NH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id um9TECAeJeX7; Tue,  7 Nov 2023 14:55:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6633E81BB0;
	Tue,  7 Nov 2023 14:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6633E81BB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46F93C0071;
	Tue,  7 Nov 2023 14:55:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC973C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C209941715
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C209941715
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZV6LE5NH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRZW6PAa6qZC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:55:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B60B41714
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 14:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B60B41714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699368933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
 b=ZV6LE5NHF6XtyNq14cz4dk5vsdwQ32V/IxZxWN1akxO3F/tr16wDwinbgWQZ7zWJYeZ05m
 19k9fQY9B9n+jHlWHPX2VJuT66wccK/nKjRz8iPtOy+wx2ntP1WG0TRQ87+cYxznvofgth
 h/eO5bQ7zQb1MK43QgTooAoWrVIFBk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-9NQtaDlDP0q8ierohG2M0Q-1; Tue, 07 Nov 2023 09:55:32 -0500
X-MC-Unique: 9NQtaDlDP0q8ierohG2M0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4092164ee4eso36260925e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 06:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368931; x=1699973731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
 b=BHAg5H1ATwXHUkesSdWn69OaFRN/1KSef10Jxtnw5wPuvJEAdPGsFql3WUewAJAU/E
 6HxP9t9iINtSDZyh+aQ/AGWC6ke9vvbA+mIuASCEWN84/GEeLMXB3ktFh2+5pIYPy2La
 zAG7cntpTadFG0VlNP2sFl4J734s9Ep0lpcbkUGJoOEOPnHq868YJkDcFCPMokKbDPcD
 CMp2Ts5AE6pLWtC+QuyxWGh8G4tWOizFpZrYxctmX9R/DnMpZUXRUA2FEG+J1Q0hDJGJ
 ZQuD171aMtRHGCbLHrNom6ibr0CimiKPM1y2LosKVfpY8nm5McPTFR44qVeVcspXfEba
 B2iQ==
X-Gm-Message-State: AOJu0YxsbeaXWZ5A96uiPeluOoWUeWrYhG5w8for4EMlWyqmfUUF1nbh
 76ONbJtNkxyc6JuzXKdK7aWljyUTH0QAOsd1qfLmeiidxl/yrufLZ/PwD5YSytNdsinBsqRjQIT
 XmgoxmZ1LMd7wMcSnhe20PuG7lpkHjHYz8//cMitXlQ==
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id
 p7-20020a05600c468700b00401bcd94871mr2498497wmo.21.1699368930996; 
 Tue, 07 Nov 2023 06:55:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzbMM8W1j1GgoDZM90c2d8/HJ8vQIG2CKZzYqMIhxHMdsZxgqX9hfyV1Tq0rIL8huNSNR6FA==
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id
 p7-20020a05600c468700b00401bcd94871mr2498480wmo.21.1699368930620; 
 Tue, 07 Nov 2023 06:55:30 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a056000010500b00327bf4f2f14sm2556719wrx.88.2023.11.07.06.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:55:29 -0800 (PST)
Date: Tue, 7 Nov 2023 09:55:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107094818-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231107124902.GJ4488@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, Cindy Lu <lulu@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community.

Just to add an example why I think this "internal review" is a bad idea
I seem to recall that someone internal to nvidia at some point
attempted to implement this already. The only output from that
work we have is that "it's tough" - no pointers to what's tough,
no code to study even as a bad path to follow.
And while Red Hat might be big, the virt team is rather smaller.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
