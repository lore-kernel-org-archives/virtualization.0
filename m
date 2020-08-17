Return-Path: <SRS0=WgBq=B3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C3C433DF
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 11:12:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E3120674
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx0ZAwV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E3120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E482868F5;
	Mon, 17 Aug 2020 11:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUXN1K9iooi0; Mon, 17 Aug 2020 11:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E17E686722;
	Mon, 17 Aug 2020 11:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3B56C07FF;
	Mon, 17 Aug 2020 11:12:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A198AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 11:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9058787E8E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 11:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwzYanw+C3OO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 11:12:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E38987D73
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597662766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ojqM6VDGywhYof5vQ0rOPdeZdR7vkZBO7fWbPCxSWII=;
 b=hx0ZAwV4IFOKqDWxw1eHkIK3xpRVRXBKhQMtLyXHWesIO3+dg+cuxmzfughVkoBHsCmZug
 4r3AZBy7BmHWDX3T0OTU8UV6lKf4/cedR2qm9HGzl03Abw8ZCSVUQXyJbNhqamwr6kYUK5
 4Pwppw6zB2DnRsMtOWSbcnr7QfaEdUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-AxrCrgTLPfKBA1qS5-fhAQ-1; Mon, 17 Aug 2020 07:12:44 -0400
X-MC-Unique: AxrCrgTLPfKBA1qS5-fhAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 184321DDE5;
 Mon, 17 Aug 2020 11:12:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91FD01002393;
 Mon, 17 Aug 2020 11:12:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6A0F29D8F; Mon, 17 Aug 2020 13:12:34 +0200 (CEST)
Date: Mon, 17 Aug 2020 13:12:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev] Re: [PATCH v5 0/3] Support virtio cross-device
 resources
Message-ID: <20200817111234.i7pqtnnk2ciw4rqb@sirius.home.kraxel.org>
References: <20200609012518.198908-1-stevensd@chromium.org>
 <20200609055021-mutt-send-email-mst@kernel.org>
 <CAD=HUj7wJfoKj_K44Cs9eEmh=OQHZ1+qz7ZHxoscHjYgOMXvZQ@mail.gmail.com>
 <20200817105008.mi3ukh6kxgi37gjs@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817105008.mi3ukh6kxgi37gjs@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: virtio-dev@lists.oasis-open.org, Thomas Zimmermann <tzimmermann@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

On Mon, Aug 17, 2020 at 12:50:08PM +0200, Gerd Hoffmann wrote:
> On Tue, Jun 23, 2020 at 10:31:28AM +0900, David Stevens wrote:
> > Unless there are any remaining objections to these patches, what are
> > the next steps towards getting these merged? Sorry, I'm not familiar
> > with the workflow for contributing patches to Linux.
> 
> Sorry, just have been busy and not paying as much attention to drm
> patches as usual.  Playing catch-up now.  Queued for drm-misc-next,
> unless something goes wrong in my testing the patches should land
> in linux-next soon and be merged upstream in the next merge window.

Oh, spoke too soon.  scripts/checkpatch.pl has a bunch of codestyle
warnings.  Can you fix them and resend?

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
