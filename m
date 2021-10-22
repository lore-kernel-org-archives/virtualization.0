Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB54C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:49:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1362E610EA
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1362E610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA38360669;
	Fri, 22 Oct 2021 09:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhxACFpcLf_1; Fri, 22 Oct 2021 09:49:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8CC2F60665;
	Fri, 22 Oct 2021 09:49:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C70C001F;
	Fri, 22 Oct 2021 09:49:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72968C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EC3460669
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGhFxP9TKQKk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:49:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63D7160665
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634896182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8GQKppheBF6fDbGjh9hPnqTzIvDSzCMC2uK5p0nE1Jk=;
 b=gq5LwWQFHBaY2sClr6FAcaA3pmiS8tMRCpT3iRsq5l2EQjtqX1irQbCdzpvcrMAr0qHI9Y
 KIUNoJKzQb+5jnq29kuDar0S7B+vJ0w0oxG/+hAANrV7gVbJ01ETb0ynrzCoh6d2Wjm+dd
 5cW7bKuqs0zgkcUBKBJI1TTJtM6BBuU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-Ed4GG_wTOUOONCTR79GFRQ-1; Fri, 22 Oct 2021 05:49:41 -0400
X-MC-Unique: Ed4GG_wTOUOONCTR79GFRQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 g2-20020a5d5402000000b00166f9cfa67aso775091wrv.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8GQKppheBF6fDbGjh9hPnqTzIvDSzCMC2uK5p0nE1Jk=;
 b=UWgvio3crV6zSUuR/Z164z5tiDKNjsa0lW/kL+tVEsJHgRde6Lm6/pD/79DjqsLo/O
 IAUCiBdo4jl3+0yL/ghqH8hchwk1I2RgDUp+JFXWZufBaVUPzzZsbrd7daEu6010I9BL
 5yzQrC5TK+MHaTSBIMezT4EahN25HwzB70NWNWUV9WJk2kX/B3B1ns4ATO8rpJTBEkS9
 U1pzVedJmpyiF4aeQDpG1iCo21IsZTwgw0brj5lvmJvP2pbPt3uXJCtuMhCxCRwzEYSj
 upXwBD0Of06wX0zdqc7ENaU2FfIHpOv27t3qF4iYdXWBUArcaRNluMjlf0vEFBle6z66
 aCyg==
X-Gm-Message-State: AOAM532Ut6TG1mKZILZESEij9EReT93Pgocl7X7IrLmmOmyPOv9Rde0u
 WtE3/S9DVvXjDJ22LA3BcUtWc3gClMxsbYOQEQmVIdb1xxf4kcD3bVoppkj6FLF/B6B+8IelUyX
 ds/IlSuyKIEKtO9FsgwSRz1GoWHuL3QJSxkIy9rohVg==
X-Received: by 2002:a05:6000:1885:: with SMTP id
 a5mr14156237wri.57.1634896179876; 
 Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydGc0dTBclPLb5hwyVCsVnp0bj4JEx8cjQdxlE6fuA1aB91KuOmS/N126HwQ7g8P66GvYmRg==
X-Received: by 2002:a05:6000:1885:: with SMTP id
 a5mr14156214wri.57.1634896179741; 
 Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id k8sm10435791wms.41.2021.10.22.02.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:49:39 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:49:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH V3 00/11] vhost: multiple worker support
Message-ID: <20211022054830-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <14dc15ba-5888-a43d-6a9a-8b5165620d57@oracle.com>
MIME-Version: 1.0
In-Reply-To: <14dc15ba-5888-a43d-6a9a-8b5165620d57@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Fri, Oct 22, 2021 at 01:02:19AM -0500, michael.christie@oracle.com wrote:
> On 10/22/21 12:18 AM, Mike Christie wrote:
> > Results:
> > --------
> > 
> > fio jobs        1       2       4       8       12      16
> > ----------------------------------------------------------
> > 1 worker        84k    492k    510k    -       -       -
> 
> That should be 184k above.

Nice. I'd like to merge this but blocked because of a dependency
(since we can't allow userspace to create threads without any limit).

> > worker per vq   184k   380k    744k    1422k   2256k   2434k

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
