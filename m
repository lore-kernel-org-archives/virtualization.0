Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42DDECAAA1
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 10:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47AD6404B5;
	Tue,  6 Sep 2022 10:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47AD6404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QVZ8h51N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J91P175GiPuU; Tue,  6 Sep 2022 10:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D99B4049B;
	Tue,  6 Sep 2022 10:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D99B4049B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62485C0032;
	Tue,  6 Sep 2022 10:56:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A545C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6184660A7B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6184660A7B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QVZ8h51N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vCvANo-LK9O3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:56:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6704060A6A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6704060A6A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662461758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWFTmiu/F1naD+YA2QN797Qhc0+oXAueZY77zxu/bOc=;
 b=QVZ8h51NbyTAvjP+pcO9unP7jHRZbmRO64CIAwq+ZW3DNlMYvPhgotf/q8xyXdnuZi2sMw
 tc+0NLEi08mFhbJSVCuldqY1734qSgg//XnuHzXYdgmeOuPR/vRsr1d0mDG/yFQr8J51En
 oBTr3fkfN1Xdf2zx6Lklat9jnx+OLzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-oMAvFQcmOTa8cQOMbcFhvg-1; Tue, 06 Sep 2022 06:55:57 -0400
X-MC-Unique: oMAvFQcmOTa8cQOMbcFhvg-1
Received: by mail-wm1-f69.google.com with SMTP id
 r83-20020a1c4456000000b003a7b679981cso8620423wma.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 03:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=TWFTmiu/F1naD+YA2QN797Qhc0+oXAueZY77zxu/bOc=;
 b=oDMJG4FMUe5S8JqcgGfrxC1E6vFT1+2pWO0oDFlRKon7olMrmXVmtubdFIHK3rTTMj
 HIxZ2D+WKqI30Zw13+oXHOzfSPJU0jkFBy6ecRmT3ywMoOdTi03MZssZUBSbDbpn4p7w
 o6Q60ec1n9cg534yebMEm51Ic7f2YJcGo+i5LTRIoQ4DODl07+5sLil0aMBirm/G01HY
 9ItvgYtbt44FH7BHYrrvZjMa3B4hDmaOTOBfwGPMxIl35oPvEFUNiRMvDfB1r9cG3BLT
 Uic4ocYqXdjAhIg6ufpMxeGj98/ZWZqZdQ5rnBu4an8UjHQKPtyRJgQpOR9sjOkQJkA0
 UbZA==
X-Gm-Message-State: ACgBeo13NoyjiOMWCn8U/hrvSNZ7S4EkshPNAUyPYixVTlgD+ep0vK/f
 H9eCx90Rl5eo6xBI2WlRqNOIIUtEl/RvEXMBCb91ABO6VLI9e0b2ldbQDf084YzbY4pL1Qs9vP7
 CdrdUbKTOmCP4zTArd60Q2Ecg87W0350kzCzPtTj5TA==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id
 i1-20020a05600c354100b003a628e4c458mr13486807wmq.188.1662461756597; 
 Tue, 06 Sep 2022 03:55:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TTTKsUXeNjIwHC9u3J8/4vqYFGhNuEr/0Tvd/A8eYqEBmE6zDfGSyJavnhzHHsWabol3izA==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id
 i1-20020a05600c354100b003a628e4c458mr13486792wmq.188.1662461756355; 
 Tue, 06 Sep 2022 03:55:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it.
 [146.241.112.72]) by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm8611142wrn.38.2022.09.06.03.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 03:55:55 -0700 (PDT)
Message-ID: <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 06 Sep 2022 12:55:54 +0200
In-Reply-To: <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, davem <davem@davemloft.net>
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

On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > Adding cond_resched() to the command waiting loop for a better
> > > co-operation with the scheduler. This allows to give CPU a breath to
> > > run other task(workqueue) instead of busy looping when preemption is
> > > not allowed.
> > > 
> > > What's more important. This is a must for some vDPA parent to work
> > > since control virtqueue is emulated via a workqueue for those parents.
> > > 
> > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > 
> > That's a weird commit to fix. so it fixes the simulator?
> 
> Yes, since the simulator is using a workqueue to handle control virtueue.

Uhmm... touching a driver for a simulator's sake looks a little weird. 

Additionally, if the bug is vdpasim, I think it's better to try to
solve it there, if possible.

Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
neither needs a process context, so perhaps you could rework it to run
the work_fn() directly from vdpasim_kick_vq(), at least for the control
virtqueue?

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
