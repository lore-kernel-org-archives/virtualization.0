Return-Path: <SRS0=WgBq=B3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2803C433DF
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 10:19:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAAE2078A
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 10:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXNqC8Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAAE2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C3F686BE1;
	Mon, 17 Aug 2020 10:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqgbfaC8GN3m; Mon, 17 Aug 2020 10:19:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A18F86B43;
	Mon, 17 Aug 2020 10:19:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61FA0C088B;
	Mon, 17 Aug 2020 10:19:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB208C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 10:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C764386B48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 10:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JDQ4kYfBSiMF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 10:19:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EC04C86AE5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597659571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGbJwI3itELdK2Hji+iycRZOmACsuMM37BEJjNDZq9g=;
 b=WXNqC8BkD1hU8+pAUAECJNd58GlEfYSrvbt8c4xqJ/RPLw+Op5AxxUnFJuXP3edUSMpTCk
 ctzg4M4erjhT5anmJbKPqMbEhoAmRh6Bqj0bikObno32KbVPj8v81EPzTUbhSJXmJPTT79
 JqKeMW/3uu5Pj8G8OXC8lE0tm6kpQ1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-te4cdZJ8MhaRjjpNLyRBsQ-1; Mon, 17 Aug 2020 06:19:29 -0400
X-MC-Unique: te4cdZJ8MhaRjjpNLyRBsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8918F425E8;
 Mon, 17 Aug 2020 10:19:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDE07DFC0;
 Mon, 17 Aug 2020 10:19:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 251C29D8F; Mon, 17 Aug 2020 12:19:25 +0200 (CEST)
Date: Mon, 17 Aug 2020 12:19:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
 David Airlie <airlied@linux.ie>, Chia-I Wu <olvaffe@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix unblank
Message-ID: <20200817101925.ljpfgz336zxegsup@sirius.home.kraxel.org>
References: <20200807105429.24208-1-kraxel@redhat.com>
 <20200807130956.GE2352366@phenom.ffwll.local>
 <20200817090342.bemmtkvz4seayp2i@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817090342.bemmtkvz4seayp2i@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Mon, Aug 17, 2020 at 11:03:42AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> > > @@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
> > >  	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> > >  
> > >  	output->enabled = true;
> > > +	output->need_update = true;
> 
> > > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > > @@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
> > >  	    plane->state->src_w != old_state->src_w ||
> > >  	    plane->state->src_h != old_state->src_h ||
> > >  	    plane->state->src_x != old_state->src_x ||
> > > -	    plane->state->src_y != old_state->src_y) {
> > > +	    plane->state->src_y != old_state->src_y ||
> > > +	    output->need_update) {
> > 
> > Uh instead of hand-rolling what's essentially a drm_crtc_needs_modeset
> > check, why not use that one? atomic helpers try to keep the usual suspects
> > for state transitions already handy, to avoid every driver rolling their
> > own. Or do I miss something here?
> 
> Well, the virtio-gpu virtual hardware can't do plane updates and crtc
> updates independant from each other.  So the crtc callbacks handle
> disable only (we don't need a fb for that) and leave the enable to the
> plane update.
> 
> I suspect calling drm_atomic_crtc_needs_modeset() in plane update isn't
> going to fly ...

Digged a bit more, seems crtc_state->*_changed is cleared after modeset
so the following plane update wouldn't see it.  Which I think means
there is no way around tracking that in need_update.

output->enabled is probably not needed though, seems I can replace that
by either output->crtc.state->enable or ->active.  Not fully sure which
one, probably ->active.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
