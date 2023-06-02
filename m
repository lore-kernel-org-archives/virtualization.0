Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB54C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 12:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C73161612;
	Fri,  2 Jun 2023 12:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C73161612
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQGtFKsT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wU7gmKuY0JnX; Fri,  2 Jun 2023 12:22:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C72FB60B13;
	Fri,  2 Jun 2023 12:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C72FB60B13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA889C007A;
	Fri,  2 Jun 2023 12:22:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02537C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF26C60C19
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:22:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF26C60C19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A99LJeSoCrfV
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:22:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF6E760B13
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF6E760B13
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vBvgCtxHsbJ1Cr9b4OonBjoLy8BFVsx+2Nwqjtkw0Ms=;
 b=UQGtFKsTB1aNjumTRsZZjGz/pe6R9TDz+HBdjhWH23ZHesSjdnm0ToxLMBBgvLaxYK7GDl
 eSOMFDRP0j+oSYPDMqOLA0r+oLd5p9jeNDagwnxxb5PJWcr1jxqElGEMGZD4sSbgngW1S4
 3sDLwUWikQgJ5odjnlpt9sJAhiDHA6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-OUYhFbijPGyYGTYKiIqXOg-1; Fri, 02 Jun 2023 08:22:14 -0400
X-MC-Unique: OUYhFbijPGyYGTYKiIqXOg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30c3ad3238bso938530f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708533; x=1688300533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBvgCtxHsbJ1Cr9b4OonBjoLy8BFVsx+2Nwqjtkw0Ms=;
 b=T/CjUnih9SRc7SYoXnof3WXZWyQ7zoua/WR9bedcHXyv5C0jQrODB4/1dKfQQKTjbX
 0RRMGydG5qz+gPJyhvZNFEMSje4jZQ224gDjZAH9SQdZic7o3oGviLeTF2a/5qaUxPvD
 ZpzTVLyEA5nCU0uQ9U+ymI0STODoKZI30FcP4eyOTYc9jFjqscbE7XCMyvIRHEzYvAgy
 CALpnLSfiBElY4BZBQFkK2efW0ffA8IKF0AX0JIuSdnV7rRvnvHQOejYTA4sYkCkZ5DK
 g8fWMGn/xXYycrTi9npPt9KUXqIGrDwjDf3MXen0FE7bjMkYd6hies5GBjKQn2sTy5+1
 baAQ==
X-Gm-Message-State: AC+VfDy+tPtxRxL3nBibBG+tRXAPnpBDEL5IGviUeqMnR2BS47OZZzeb
 V6xn2RrOWnAlLBZrCSJZNEh+6j8IBdpKh5SbovChdpg3FR/7IXOr8wcrFYFaOJBxqTl7bGSd+nK
 3S976WN4IQr8BbguEgvlz0IVza7NajcbTLVpou/voNNz1INoVCA==
X-Received: by 2002:adf:ef10:0:b0:2f9:ee8c:a2fa with SMTP id
 e16-20020adfef10000000b002f9ee8ca2famr4087014wro.64.1685708533199; 
 Fri, 02 Jun 2023 05:22:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MDaHEtxqpwsTKdGSzsPERDeFOi2h+3ppUuLsHerDgKOTaRKriWNuTZfEcPdh8Q2J80CuRzg==
X-Received: by 2002:adf:ef10:0:b0:2f9:ee8c:a2fa with SMTP id
 e16-20020adfef10000000b002f9ee8ca2famr4087004wro.64.1685708532907; 
 Fri, 02 Jun 2023 05:22:12 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 w1-20020a5d6081000000b0030adc30e9f1sm1541714wrt.68.2023.06.02.05.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:22:12 -0700 (PDT)
Date: Fri, 2 Jun 2023 08:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: vhost stable branch
Message-ID: <20230602082154-mutt-send-email-mst@kernel.org>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
 <20230523041714-mutt-send-email-mst@kernel.org>
 <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
 <20230523074357-mutt-send-email-mst@kernel.org>
 <b8172a255a7a48524c3454676e11d2e8e1386634.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <b8172a255a7a48524c3454676e11d2e8e1386634.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, May 30, 2023 at 10:19:18AM +0000, Dragos Tatulea wrote:
> On Tue, 2023-05-23 at 07:45 -0400, Michael S. Tsirkin wrote:
> > On Tue, May 23, 2023 at 08:38:47AM +0000, Dragos Tatulea wrote:
> > > On Tue, 2023-05-23 at 04:18 -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> > > > > Hi,
> > > > > 
> > > > > I am looking for the stable branch for vdpa fixes in the vhost tree [1].
> > > > > There
> > > > > are 3 branches that seem identical: linux-next, test and vhost. linux-
> > > > > next
> > > > > seems
> > > > > to be -next branch. Which one would be the stable branch?
> > > > > 
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > 
> > > > I don't publish one until I am ready to send patches to Linus.
> > > > Which should be today or tomorrow.
> > > > 
> > > Understood. Is it the same with patches for -next? Are they published only
> > > once
> > > the patches are sent to Linus?
> > > 
> > > Thanks,
> > > Dragos
> > > 
> > 
> > A bit different. I start worrying about next when I'm done with stable.
> > Also my next branch rebases frequently, I also drop and squash patches,
> > rewrite commit log etc.
> > 
> Is the linux-next branch in the referenced tree [1] the next branch or is it
> hosted somewhere else? I am asking because I haven't seen any rebases in the
> last 4+ weeks in the referenced location. I want to make sure that I'm looking
> in the right location.
> 
> Thanks,
> Dragos
> 

pushed to next now.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
