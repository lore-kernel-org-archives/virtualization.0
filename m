Return-Path: <SRS0=p0Ab=DK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA0C41604
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 18:43:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BA420709
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzL8+jxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BA420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD4888689D;
	Sat,  3 Oct 2020 18:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aizgMWHhaFFw; Sat,  3 Oct 2020 18:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E0ABD867F0;
	Sat,  3 Oct 2020 18:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C14D9C0889;
	Sat,  3 Oct 2020 18:43:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D695C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 18:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 055DD87006
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 18:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UC30FtfSdxRK
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 18:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15C4286FFC
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601750601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
 b=NzL8+jxeAT74Xoye5npss0OvEUdXZQIqDGyUesVHTbcMOakxAgGGW0EhLyybungMtHp5r9
 n9aO2gLq03wr+xNYAtifB7yTHUJFgmCtRiL94hZqJOldVnZMFhIg0NIys/VRfJKKkGhCcA
 2urgq237/GVFZlc/1+JvIyldM5ZApXw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Fy0mNGIQMcK5nh6gAGB6qQ-1; Sat, 03 Oct 2020 14:43:19 -0400
X-MC-Unique: Fy0mNGIQMcK5nh6gAGB6qQ-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1091089wrt.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Oct 2020 11:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HWM0RfrM0HZAs25gIGx3NLfFo36RAwB9ram8EBWXtH0=;
 b=FognKfJxBMBU6+Qr3tz+pBAz44focnV+vdl0G1R7nEVeZCYTNLElR0TrGnZYNdpGy5
 DEWmAIiuiXU23GkW1E/FO0bQXcGK+S6GRJ1/mknoXAXE9ClOXCLfwtUWpPDTs/meA0wN
 3kfDNuMvD66+E38PwIZ9zPBYYr80s4+cXWwf9dWCyHZs9BzhmeUxGGh995TP+h0zboWn
 B343N8PD7Zx5DXDlo7VCACbTA/tSnDDWIwVqL5jLU6sFFKVYtpBihfzXL1W8fVNT2nRv
 H3yefxhZmiRlPHBLzWBVc5JE9bqmTcLZG7CudgcM7AFnkok2NMIyXrRoqVUQZUfIWHK9
 vc2Q==
X-Gm-Message-State: AOAM530daeaQWUikBrNBckAgHJI0x2KPrI4/5CVHltCZa8EmmG+vZPhQ
 oqLQzMPiUjt9W91Q/YkixIQP7sXYM3Ag9ynXIp42ihyWfehGCqwN+MBU4Uz+VHAlO9qSpws7KTr
 K07tb/nLDuESxqnm3nZ2vaFKrI/Gq/fflsvTRy98iBw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744702wrn.40.1601750598391; 
 Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy038Yccnpob9//W8sOr1lm3wbsl6dgaQoAhcFw98vUjFVu1T3n44Gs2WlgxSmLiPyyNgs9bw==
X-Received: by 2002:adf:e852:: with SMTP id d18mr9744690wrn.40.1601750598224; 
 Sat, 03 Oct 2020 11:43:18 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z127sm6091271wmc.2.2020.10.03.11.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 11:43:17 -0700 (PDT)
Date: Sat, 3 Oct 2020 14:43:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [Linux-kernel-mentees][PATCH 0/2] reorder members of structures
 in virtio_net for optimization
Message-ID: <20201003144300-mutt-send-email-mst@kernel.org>
References: <20200930051722.389587-1-anant.thazhemadam@gmail.com>
 <20201002.190638.1090456279017490485.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20201002.190638.1090456279017490485.davem@davemloft.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: anant.thazhemadam@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
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

On Fri, Oct 02, 2020 at 07:06:38PM -0700, David Miller wrote:
> From: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Date: Wed, 30 Sep 2020 10:47:20 +0530
> 
> > The structures virtnet_info and receive_queue have byte holes in 
> > middle, and their members could do with some rearranging 
> > (order-of-declaration wise) in order to overcome this.
> > 
> > Rearranging the members helps in:
> >   * elimination the byte holes in the middle of the structures
> >   * reduce the size of the structure (virtnet_info)
> >   * have more members stored in one cache line (as opposed to 
> >     unnecessarily crossing the cacheline boundary and spanning
> >     different cachelines)
> > 
> > The analysis was performed using pahole.
> > 
> > These patches may be applied in any order.
> 
> What effects do these changes have on performance?
> 
> The cache locality for various TX and RX paths could be effected.
> 
> I'm not applying these patches without some data on the performance
> impact.
> 
> Thank you.

Agree wholeheartedly.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
