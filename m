Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E64C32773
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 12:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E660840A81;
	Tue, 16 Aug 2022 12:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E660840A81
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i92FOHFV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTIAdqgn-Vxw; Tue, 16 Aug 2022 12:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5984340A63;
	Tue, 16 Aug 2022 12:00:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5984340A63
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30F95C0078;
	Tue, 16 Aug 2022 12:00:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06840C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F8ED40B3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F8ED40B3C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yWMq3s9GgBEK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:00:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E40A440A81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E40A440A81
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660651218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pwz8sbWeHrkfuw7TlrsGXqGQd9GZSL1nvueVrYuNuZ0=;
 b=i92FOHFVbf9bU9evkFdsmwSNSBf6HWh9IEQMDNtx7Cy2RwialXFTcaak8fl8Zi6oQfZphC
 Gs9HEVI36fq29EFPDuIqQL70q09fn9vJC/O+B3Qs7UkKjT177RljsHzkfa+nVsgKwcy9dO
 vWH5/qAfO8RvmxEMcjhgKEx3tq0Z/Zo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-0-tlVozgO4qcDP28VNwGBg-1; Tue, 16 Aug 2022 08:00:17 -0400
X-MC-Unique: 0-tlVozgO4qcDP28VNwGBg-1
Received: by mail-wm1-f70.google.com with SMTP id
 a17-20020a05600c349100b003a545125f6eso10125377wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Pwz8sbWeHrkfuw7TlrsGXqGQd9GZSL1nvueVrYuNuZ0=;
 b=ajgL2pffZcOkzNdP8uVECI3A2QOMFqZ8auUUE8l135jReRGv3If/t+uFfGtNRjLe0e
 4ZMwhsjBUga1+ICl3Kdgalud1OnV2LM5K2K+2wPl1Gx9BpTLMy2ZXn+eXou4F0ftG5eb
 r5gTRY5HMMZvID0L4TVG9hG1m/HdUS7L3Cw1flhu55u6pDyeyd8WLJYQbA2IUUv2Rql5
 MhcE5yX9xgcPHyu8m9eP82495nGrH8ijE6pnNASarw1iF6X5dBytV5RhWumZ33MUSAxF
 Zjp9ncBuSrkvH81CZbttVtJ/+5+ZXAY28m9C1MMh7IsLTtF/oSP8gEed0MPHP8OFVA5P
 vQxg==
X-Gm-Message-State: ACgBeo36HHHAl4sRQNuU3s+5udu54v6nNhhYPAmyo3xVd2x+KaRAz6Df
 HMrffVtgWv8V4lXyBypvZsYug5qQV74U/tXSXTxkN625P0TRMJORTAcIOmBpZC6ue2lNy/ghM8W
 pPcYj5v48cIsCSLoxCJGgw8y/pltgtwzMEmOXp9Tt3Q==
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id
 l8-20020a05600002a800b0022068934ff6mr11805878wry.170.1660651216641; 
 Tue, 16 Aug 2022 05:00:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+lxy72X0p8q1N/VA1caBeK9MeCyZ3upRXQRZYRJDWig+QRJxJ+nox5XWYdcFyrgUtFuIZyQ==
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id
 l8-20020a05600002a800b0022068934ff6mr11805859wry.170.1660651216420; 
 Tue, 16 Aug 2022 05:00:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 cl5-20020a5d5f05000000b00224f7c1328dsm8312482wrb.67.2022.08.16.05.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 05:00:15 -0700 (PDT)
Date: Tue, 16 Aug 2022 08:00:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <20220816075953-mutt-send-email-mst@kernel.org>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
 <YvtoDxvefWUJBfAS@kroah.com>
 <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
 <YvuF8CsP0M1TAK1a@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YvuF8CsP0M1TAK1a@kroah.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Nadav Amit <namit@vmware.com>, Nicholas Piggin <npiggin@gmail.com>,
 kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Aug 16, 2022 at 01:56:32PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 02:47:22PM +0300, Alexander Atanasov wrote:
> > Hello,
> > 
> > On 16.08.22 12:49, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> > 
> > > >   rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)
> > > 
> > > Why rename the .h file?  It still handles the "balloon compaction"
> > > logic.
> > 
> > File contains code that is common to balloon drivers,
> > compaction is only part of it. Series add more code to it.
> > Since it was suggested to use it for such common code.
> > I find that common becomes a better name for it so the rename.
> > I can drop the rename easy on next iteration if you suggest to.
> 
> "balloon_common.h" is very vague, you should only need one balloon.h
> file in the include/linux/ directory, right, so of course it is "common"
> :)
> 
> thanks,
> 
> greg "naming is hard" k-h

Yea, just call it balloon.h and balloon.c then.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
