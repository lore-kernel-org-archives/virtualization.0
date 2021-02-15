Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F1C433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 15:24:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13C064DA8
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 15:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13C064DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68A0E86746;
	Mon, 15 Feb 2021 15:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lW84QQlxe+xv; Mon, 15 Feb 2021 15:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66863810EE;
	Mon, 15 Feb 2021 15:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 582D1C0174;
	Mon, 15 Feb 2021 15:24:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DF14C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B0BD83F2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:23:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0UsLdWDBksi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:23:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF83383F20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 15:23:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF1AA64DA3;
 Mon, 15 Feb 2021 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1613402637;
 bh=D5A20jsw271QhgK0FxaYxiq0qi2ogTSlmiy9YeXbzJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A8kdKYnh9/BOzdQTjXtAoWAqZ4yiDv5yLJWvyK0N/AtjOs2t08Ft/ju6dfmTD2WAp
 2xxCSr7rejhF6MlFr4/iqkfvgBEXd2ikD2uxB8WQxEPlVurR/V97hob4adjQr0svNQ
 jfF0+EwMvwXkeLIsXGbn+z9UPUUhMv9VTGFUdjZw=
Date: Mon, 15 Feb 2021 16:23:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <YCqSCg4gugL/bX8f@kroah.com>
References: <20210211162519.215418-1-sgarzare@redhat.com>
 <YCqF891BLn5zsUwd@kroah.com>
 <20210215150321.anwcogkifg6sefp6@steredhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210215150321.anwcogkifg6sefp6@steredhat>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Feb 15, 2021 at 04:03:21PM +0100, Stefano Garzarella wrote:
> On Mon, Feb 15, 2021 at 03:32:19PM +0100, Greg KH wrote:
> > On Thu, Feb 11, 2021 at 05:25:19PM +0100, Stefano Garzarella wrote:
> > > Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.
> > 
> > No, this really is not that commit, so please do not say it is.
> 
> Oops, sorry.
> 
> > 
> > > Before this patch, if 'offset + len' was equal to
> > > sizeof(struct virtio_net_config), the entire buffer wasn't filled,
> > > returning incorrect values to the caller.
> > > 
> > > Since 'vdpasim->config' type is 'struct virtio_net_config', we can
> > > safely copy its content under this condition.
> > > 
> > > Commit 65b709586e22 ("vdpa_sim: add get_config callback in
> > > vdpasim_dev_attr") unintentionally solved it upstream while
> > > refactoring vdpa_sim.c to support multiple devices. But we don't want
> > > to backport it to stable branches as it contains many changes.
> > > 
> > > Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> > > Cc: <stable@vger.kernel.org> # 5.10.x
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > index 6a90fdb9cbfc..8ca178d7b02f 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > @@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
> > >  {
> > >  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > 
> > > -	if (offset + len < sizeof(struct virtio_net_config))
> > > +	if (offset + len <= sizeof(struct virtio_net_config))
> > >  		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
> > >  }
> > 
> > I'll be glad to take a one-off patch, but why can't we take the real
> > upstream patch?  That is always the better long-term solution, right?
> 
> Because that patch depends on the following patches merged in v5.11-rc1
> while refactoring vdpa_sim:
>   f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
>   cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
>   a13b5918fdd0 vdpa_sim: add work_fn in vdpasim_dev_attr
>   011c35bac5ef vdpa_sim: add supported_features field in vdpasim_dev_attr
>   2f8f46188805 vdpa_sim: add device id field in vdpasim_dev_attr
>   6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
>   36a9c3063025 vdpa_sim: rename vdpasim_config_ops variables
>   423248d60d2b vdpa_sim: remove hard-coded virtq count
> 
> Maybe we can skip some of them, but IMHO should be less risky to apply only
> this change.
> 
> If you want I can try to figure out the minimum sub-set of patches needed
> for 65b709586e22 ("vdpa_sim: add get_config callback in vdpasim_dev_attr").

The minimum is always nice :)

If it's just too much churn for no good reason, then yes, the one-line
change above will be ok, but you need to document the heck out of why
this is not upstream and that it is a one-off thing.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
