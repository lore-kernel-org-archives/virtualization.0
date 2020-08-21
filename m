Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5CBC433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 07:02:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2091920738
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJzbMLf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2091920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8714386CA6;
	Fri, 21 Aug 2020 07:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pl8FJT343zID; Fri, 21 Aug 2020 07:01:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 79FEE86C69;
	Fri, 21 Aug 2020 07:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55FB4C0889;
	Fri, 21 Aug 2020 07:01:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7643C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 07:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFAD487B41
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 07:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5bJmrL4IKpA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 07:01:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 869618791E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597993315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yIGSYjFFLTVb50eqymJwc16CIZ3D03wNNhMqT2v4fFo=;
 b=dJzbMLf6JSbI03dJs5zPtqRKpaYnFnnn0M4/n6yA8MIgj4GLCSpO3rK+5kFmzSVioRXwvD
 rsbQ9cpCf7OFI1aV9Q1Rc1fXFnZQKw7uSL6nGuci7j6YF2wjgKeqvZUO4Vv66VUTWLkG2w
 MtpLw5Ngo6ZE11mYk1atQPNobHSF/EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-bmWLZW8UPxSpNitocniUOw-1; Fri, 21 Aug 2020 03:01:45 -0400
X-MC-Unique: bmWLZW8UPxSpNitocniUOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14FD1084C91;
 Fri, 21 Aug 2020 07:01:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 489C95DA7E;
 Fri, 21 Aug 2020 07:01:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 36D4E241; Fri, 21 Aug 2020 09:01:42 +0200 (CEST)
Date: Fri, 21 Aug 2020 09:01:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
Message-ID: <20200821070142.iwobpibai6aavpl6@sirius.home.kraxel.org>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <20200709123339.547390-2-daniel.vetter@ffwll.ch>
 <5cb80369-75a5-fc83-4683-3a6fc2814104@kernel.org>
 <20200819132408.jnqjhdgd4jbnarhh@sirius.home.kraxel.org>
 <8a80b434-c8ed-daa3-753b-dd2ec89b9067@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a80b434-c8ed-daa3-753b-dd2ec89b9067@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@intel.com>
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

On Thu, Aug 20, 2020 at 08:32:51AM +0200, Jiri Slaby wrote:
> On 19. 08. 20, 15:24, Gerd Hoffmann wrote:
> > On Wed, Aug 19, 2020 at 02:43:28PM +0200, Jiri Slaby wrote:
> >> On 09. 07. 20, 14:33, Daniel Vetter wrote:
> >>> Exactly matches the one in the helpers.
> >>
> >> It's not that exact. The order of modeset_enables and planes is
> >> different. And this causes a regression -- no fb in qemu.
> > 
> > Does https://patchwork.freedesktop.org/patch/385980/ help?
> 
> Yes, it does.

Any chance you can send a tested-by & acked-by for the series so I can
get it merged?

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
