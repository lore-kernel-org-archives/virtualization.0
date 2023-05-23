Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74762C7EE2A
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 11:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2FD740147;
	Tue, 23 May 2023 11:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2FD740147
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UlMT56qa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Shc39r8m8Pif; Tue, 23 May 2023 11:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0C6940020;
	Tue, 23 May 2023 11:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0C6940020
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DD27C0036;
	Tue, 23 May 2023 11:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 822A6C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 11:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6330860773
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 11:46:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6330860773
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UlMT56qa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZCOhS2-f-Rk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 11:46:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59CEB606F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59CEB606F2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684842365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/EnuD76Zvl+FSCx85Tmm4NxzXtL6c93wpa8Mlq54TGs=;
 b=UlMT56qaM/om65hLIa99lUwTgnRrEffjsM3LTMAlC+pHu9EK9NmyaDtHRRc/JHHrjScd5o
 jgAatUxNCwJXBVCMsjp6R1ilBV+ZK03xcLnSV7B1n0Xf1Bn6XXcIw4E206coRW7CtxHnew
 U8vKqBGjZ8gkxq9qRgoqciG5ntVGecA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-0CIaxW-QMBucTi3iatjIxw-1; Tue, 23 May 2023 07:46:03 -0400
X-MC-Unique: 0CIaxW-QMBucTi3iatjIxw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so24948925e9.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 04:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842362; x=1687434362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EnuD76Zvl+FSCx85Tmm4NxzXtL6c93wpa8Mlq54TGs=;
 b=iKgTdO75hKRxBtIeA0n+Yor6bDT/o5mABsVyUtj5cPze5LPhNkCGDx1mERD7jPBgpP
 /V6NrGTKiFQQVxz3w4lZMapayVqkUjxsYQ4sk4Z0dtBNquZGSSYzUAmEBbQ2JS0M6UbL
 h+Ga9wVtCrBdKflC/Hu7nRcKjv+/DWUygPvAO9uXYkcdmdzNpMyUW3Oy12vhrWzUpOTs
 1wXbeBxWlsqL25VMaWxuwh+n75qXuc9ejFt5bcNhszkIQ8IIpXZSG/bsMyMBiORcn0mT
 pGtnd+ftVTNpS6l7rYPIxdj6sltffwcwn+QHMsG+KoknRS4Un5WND4gVv4OdJMERLdIe
 9nxw==
X-Gm-Message-State: AC+VfDzcmQvq1GsEXwxqSAAJ6FwvZlIIPmU0M7Wf7v0ShLFnDdPDFTFB
 GyKPep/JzwOKOkrx92gF5wfDOp8RLhaL2WiNXn4ikMfD611CC6suWFRJGpERKiAOwLN2FwuiBO8
 snYgHt6V4QBtT7YrNuIf9tGWqQiDeGUFUjDxLqf5L+Q==
X-Received: by 2002:a7b:cc15:0:b0:3f4:2452:966a with SMTP id
 f21-20020a7bcc15000000b003f42452966amr9547125wmh.27.1684842362275; 
 Tue, 23 May 2023 04:46:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7H+oYajmu8Ua/IPqNMy/7BfHsC+fJUJ2xnuZM5O+4xU6iEW3stEaRpHV8B/LMvvvF+RmLESg==
X-Received: by 2002:a7b:cc15:0:b0:3f4:2452:966a with SMTP id
 f21-20020a7bcc15000000b003f42452966amr9547113wmh.27.1684842361908; 
 Tue, 23 May 2023 04:46:01 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 o3-20020a1c7503000000b003f09d7b6e20sm11579731wmc.2.2023.05.23.04.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 04:46:01 -0700 (PDT)
Date: Tue, 23 May 2023 07:45:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: vhost stable branch
Message-ID: <20230523074357-mutt-send-email-mst@kernel.org>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
 <20230523041714-mutt-send-email-mst@kernel.org>
 <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
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

On Tue, May 23, 2023 at 08:38:47AM +0000, Dragos Tatulea wrote:
> On Tue, 2023-05-23 at 04:18 -0400, Michael S. Tsirkin wrote:
> > On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> > > Hi,
> > > 
> > > I am looking for the stable branch for vdpa fixes in the vhost tree [1].
> > > There
> > > are 3 branches that seem identical: linux-next, test and vhost. linux-next
> > > seems
> > > to be -next branch. Which one would be the stable branch?
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > > 
> > > Thanks,
> > > Dragos
> > 
> > I don't publish one until I am ready to send patches to Linus.
> > Which should be today or tomorrow.
> > 
> Understood. Is it the same with patches for -next? Are they published only once
> the patches are sent to Linus?
> 
> Thanks,
> Dragos
> 

A bit different. I start worrying about next when I'm done with stable.
Also my next branch rebases frequently, I also drop and squash patches,
rewrite commit log etc.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
