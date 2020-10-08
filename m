Return-Path: <SRS0=zhq/=DP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EA3C43457
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:32:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A716D205CB
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJy2StpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A716D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 13EAE871F1;
	Thu,  8 Oct 2020 20:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYeRR1sf8S-e; Thu,  8 Oct 2020 20:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3D2587023;
	Thu,  8 Oct 2020 20:32:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC94C07FF;
	Thu,  8 Oct 2020 20:32:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2515C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF1B0871F0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xOQdMQmTRXj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 527E087023
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602189152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpdXmRvgARTnY1If9z6ashQTu7MgRoRzw2/k90YmvbQ=;
 b=NJy2StpKyDQLlHkBZ2gT/KV2Qgk5q7sQXxpsl538I7a5xsY4GxxIbC19w8bbFIDPlLNNJh
 jWB/4K5FGGhMUd8y2gGHCivILJ96Ph3q6Dd7X1YZyIXKDfbNQRpUEli3pwwtOmrJvq+W2D
 5IPIvJ83q935Ia5tLTNv46OLFYib2zk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-j8X4UE1mPRyOTIkpEpAa-A-1; Thu, 08 Oct 2020 16:32:30 -0400
X-MC-Unique: j8X4UE1mPRyOTIkpEpAa-A-1
Received: by mail-wr1-f69.google.com with SMTP id l15so4331828wro.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Oct 2020 13:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tpdXmRvgARTnY1If9z6ashQTu7MgRoRzw2/k90YmvbQ=;
 b=XtgkcVUxw5BGLy13Plp1RlIRlyuuvqy11li5+AaZdSRpZr8p/NS4ZuvhO1xuR5yRNF
 1zvAJGIreYY/qGVfwTEwxDgouP+xxHX4M9OGevLlfEPodcv7Oa+6rqhA61Jl5jhFwHJD
 Qi4L5uCsZjYhUxZiClzjWzDZwFlvf/QTuxsKviDkJiVd0dk/fdayknBXdbXp+2APL2sZ
 xGISjdzhj+jhs8E9ZZWCDkQbFNZDpQO9fM8+bTkJAwZ9vz3YkjpQhsN9W5XlzfIhl6SP
 GdL3RLYGey8lbCiSvCWI6AG4WK2md+o1zWZ8Btjw2HapHzvwrHROh94cNXIi6tMsrVzf
 kG/Q==
X-Gm-Message-State: AOAM533d6oon8281YpXZyo7d4cbCOm+mI1qt2OVKmDPyTdqUAo88jDrE
 ENIMsPsS+24RwAVu23qWbo5fWzJiGxd6CuBLtWkhK9sr2OM6Jy1xuVAqZaljIBuuliOFgAD/JBt
 iH0+R1cmk/5wDj9l9OOMqSDsEas88k2NlW6wTKqe+0g==
X-Received: by 2002:a1c:6457:: with SMTP id y84mr10281551wmb.36.1602189149157; 
 Thu, 08 Oct 2020 13:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQUG0KijlK+QL7Ax8XS9d5dAD0ojfOCzcq6UzOONYpRTIZTzyZtNzvqD6dDng76NlJsz1nrg==
X-Received: by 2002:a1c:6457:: with SMTP id y84mr10281528wmb.36.1602189148924; 
 Thu, 08 Oct 2020 13:32:28 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id o14sm8603590wmc.36.2020.10.08.13.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:32:28 -0700 (PDT)
Date: Thu, 8 Oct 2020 22:32:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vringh: fix __vringh_iov() when riov and wiov are
 different
Message-ID: <20201008203225.7ndzfnpyxxntthtj@steredhat>
References: <20201008161311.114398-1-sgarzare@redhat.com>
 <20201008160035-mutt-send-email-mst@kernel.org>
 <20201008202436.r33jqbbttqynfvhe@steredhat>
 <20201008162813-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201008162813-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Oct 08, 2020 at 04:28:40PM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2020 at 10:24:36PM +0200, Stefano Garzarella wrote:
> > On Thu, Oct 08, 2020 at 04:00:51PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Oct 08, 2020 at 06:13:11PM +0200, Stefano Garzarella wrote:
> > > > If riov and wiov are both defined and they point to different
> > > > objects, only riov is initialized. If the wiov is not initialized
> > > > by the caller, the function fails returning -EINVAL and printing
> > > > "Readable desc 0x... after writable" error message.
> > > > 
> > > > Let's replace the 'else if' clause with 'if' to initialize both
> > > > riov and wiov if they are not NULL.
> > > > 
> > > > As checkpatch pointed out, we also avoid crashing the kernel
> > > > when riov and wiov are both NULL, replacing BUG() with WARN_ON()
> > > > and returning -EINVAL.
> > > > 
> > > > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > Can you add more detail please? when does this trigger?
> > 
> > I'm developing vdpa_sim_blk and I'm using vringh_getdesc_iotlb()
> > to get readable and writable buffers.
> > 
> > With virtio-blk devices a descriptors has both readable and writable
> > buffers (eg. virtio_blk_outhdr in the readable buffer and status as last byte
> > of writable buffer).
> > So, I'm calling vringh_getdesc_iotlb() one time to get both type of buffer
> > and put them in 2 iovecs:
> > 
> > 	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> > 				   &vq->head, GFP_ATOMIC);
> > 
> > With this patch applied it works well, without the function fails
> > returning -EINVAL and printing "Readable desc 0x... after writable".
> > 
> > Am I using vringh_getdesc_iotlb() in the wrong way?
> > 
> > Thanks,
> > Stefano
> > 
> 
> 
> I think it's ok, this info just needs to be in the commit log ...

Sure, I'll send a v2 adding this info.
Sorry for not adding it earlier!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
