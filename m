Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18299C19F2A
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 07:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80CD840179;
	Wed,  3 Aug 2022 07:57:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80CD840179
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SB11r0es
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxYWsqJUG7g7; Wed,  3 Aug 2022 07:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 572C040101;
	Wed,  3 Aug 2022 07:57:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 572C040101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A881C0032;
	Wed,  3 Aug 2022 07:57:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E32CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7319340179
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:57:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7319340179
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTw2gcG3HCzN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC97C40101
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC97C40101
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659513472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OEFsmwkVi669wYEes65YKb6PZlH2lsPyfB4kF4NfeRE=;
 b=SB11r0esg2I1kBfoMmi21ky6EgdVjKDlN60KqLmSKi8pMO1TQePkpuRBCAloHykH3yCNOe
 vr2qxQPcvp9YkYzkev2HS0v8rSXXsdbO8dO0zGKl4VRwWjiSyZLIvzD1IE2XZTIv8rMczh
 xVgtSFbeV3DhCB7CVHSBR77j+KahWZo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-NJpjw06iN42VglBctljqfQ-1; Wed, 03 Aug 2022 03:57:50 -0400
X-MC-Unique: NJpjw06iN42VglBctljqfQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 z1-20020a0565120c0100b0048ab2910b13so4823491lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 00:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OEFsmwkVi669wYEes65YKb6PZlH2lsPyfB4kF4NfeRE=;
 b=sktM1OG9iKZFdhCE8+/Oie9zPeIocnD182oPC0GHpPWEJ9T3MidSeRZniDhJ9xHbf7
 bCe4ZeT1RDoKF1PEhPmNY8EKdN/DHqvQQAzg76JN9CRnOe8MHBAVOouSGtw5Mqpj5ojK
 ZwTvlYtQnculg4QNX4JfyCwsLsThjp/llnPmhVIatWVI3O2t9vaWKbb7gyloZWhnh0jd
 GT7m/k48MzsjTcWJgl9cPSMPtX3xJm1A6NE8YOe9A8+0sb0Z7gPxIs0lDGlE4u6gEvO5
 R8kz1wgF7mGoYZBwY6C8MiSJA3bIKgkyj6Jf4A0FY/tK8yex+2u1MFJ0HSuOFc755WM2
 vrZA==
X-Gm-Message-State: ACgBeo3uR5/Pq4PYEUubEIK1RCVvvGoOFkte118+LKK8Giyk50coofw3
 2ZlM9yzpq1ThLSDiSEm8q/v71G3a9K7Zfkn7et9/GBr5h+ch8ZkpKQkTGu8cyU9yVAy0HOxQpNl
 fV0ycDpih7sanpVAvFWbe9qB51q4ClUL1pU+W5/AJyCEg+Uq1HTVGCYNJ/g==
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr4033034lfl.641.1659513468242; 
 Wed, 03 Aug 2022 00:57:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR600ldUB8qbBwa7CANdnj6UO9/ZbaTlVrEpGYh1sEEV3xqsMglefFL6pbFFalSJdNMSIfi9UKtLwl2x+Q35u4E=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr4033015lfl.641.1659513467888; Wed, 03
 Aug 2022 00:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <165719918216.28149.7678451615870416505.stgit@palantir17.mph.net>
 <20220707155500.GA305857@bhelgaas> <Yswn7p+OWODbT7AR@gmail.com>
 <20220711114806.2724b349@kernel.org> <Ys6E4fvoufokIFqk@gmail.com>
 <20220713114804.11c7517e@kernel.org> <Ys/+vCNAfh/AKuJv@gmail.com>
 <20220714090500.356846ea@kernel.org>
In-Reply-To: <20220714090500.356846ea@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Aug 2022 15:57:34 +0800
Message-ID: <CACGkMEt1qLsSf2Stn1YveW-HaDByiYFdCTzdsKESypKNbF=eTg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] sfc: Add EF100 BAR config support
To: Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 ecree.xilinx@gmail.com, Eric Dumazet <edumazet@google.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Martin Habets <habetsm.xilinx@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

On Fri, Jul 15, 2022 at 12:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 14 Jul 2022 12:32:12 +0100 Martin Habets wrote:
> > > Okay. Indeed, we could easily bolt something onto devlink, I'd think
> > > but I don't know the space enough to push for one solution over
> > > another.
> > >
> > > Please try to document the problem and the solution... somewhere, tho.
> > > Otherwise the chances that the next vendor with this problem follows
> > > the same approach fall from low to none.
> >
> > Yeah, good point. The obvious thing would be to create a
> >  Documentation/networking/device_drivers/ethernet/sfc/sfc/rst
> > Is that generic enough for other vendors to find out, or there a better place?
>
> Documentation/vdpa.rst ? I don't see any kernel level notes on
> implementing vDPA perhaps virt folks can suggest something.

Not sure, since it's not a vDPA general thing but a vendor/parent
specific thing.

Or maybe Documentation/vdpa/sfc ?

Thanks

> I don't think people would be looking into driver-specific docs
> when trying to implement an interface, so sfc is not a great option
> IMHO.
>
> > I can do a follow-up patch for this.
>
> Let's make it part of the same series.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
