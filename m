Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F38C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:56:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF96B64DBD
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 13:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF96B64DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8867286A87;
	Tue, 16 Feb 2021 13:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6P0qduch2+P; Tue, 16 Feb 2021 13:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C39058699F;
	Tue, 16 Feb 2021 13:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED17C0893;
	Tue, 16 Feb 2021 13:56:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 920D3C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 799E485247
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vewL3ApqWAYP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:56:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4F11E85070
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613483787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0W8giq2Q1DKeMph1DuXghSpcsbMciexD+BiqrMJ7xtw=;
 b=ZM641a+m0vIukgAuageb//ObWIFCm7kRIBczIiHQ9cth5aPBpPJda024t+TxjQ7zqVwlBg
 b5zUIL3C50mGFpA+uhOCGp/+f1ZZi0E/Xp3UPA3PhUC29pi61pDPQX7cglqCKJ1PBOhH5S
 1IoGyD9axnCO1+Qga7xEs+uuyZRcM5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-ww75vVB4OHGNkwD0Oe2TIQ-1; Tue, 16 Feb 2021 08:55:14 -0500
X-MC-Unique: ww75vVB4OHGNkwD0Oe2TIQ-1
Received: by mail-wm1-f71.google.com with SMTP id p8so10830446wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 05:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0W8giq2Q1DKeMph1DuXghSpcsbMciexD+BiqrMJ7xtw=;
 b=gX0gZp+PRch/5xA/EuXsryeOYWEMsvBykgewudKYZT15HX+s34IzTZDkhmxq3H7UDt
 D5B8Pys6TcjArQy34ohMM8c1DwVad3/uHA+ZLOGMuEuX9LG6w5/8wojcXxs/d8X0nv+n
 f23tpfsUUfKJQ5ryWQtCV2k7+ZeTxQ4wd/Np+iNu+FdL7rJfTLaAKMzV+4DLYMsjNhoO
 +e0iywmnoWWbEoAeNwBpdIGWFJMbg2CipiDb1cpVxPL0v7+f2nOcqMU8iUrWtwhWB/3t
 aWk36QYgmhd2g2KIVwMNv/UPedoWl8qULo8Q71NPwsJ4cvA/kiCCjQVyeLdT/k8gZvf4
 p5WA==
X-Gm-Message-State: AOAM533yvGbiUDSpu2/9X5Wg2AKGxqziRFv29D9QEat5OOf2kyr7fBPT
 2E82LhbGVaR4doUCnGkeTy901yl41XWOJIYh8Oww/sEsiUCLz2fF94HOgCCdA1rxX1LuXASbjzQ
 ICl6/t83QP0+mA9L9By0yt6iEj5/ypqjBBPNV2fE7Hw==
X-Received: by 2002:adf:f389:: with SMTP id m9mr24534252wro.406.1613483713537; 
 Tue, 16 Feb 2021 05:55:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTlzjWj7/PtXUmKJvMwpggEpwB25ri5EWofa4TwaZHgxK4n/IjY5wK5PIXju4uJwrrjZ3U4Q==
X-Received: by 2002:adf:f389:: with SMTP id m9mr24534210wro.406.1613483713029; 
 Tue, 16 Feb 2021 05:55:13 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id u10sm3565308wmj.40.2021.02.16.05.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 05:55:12 -0800 (PST)
Date: Tue, 16 Feb 2021 14:55:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <20210216135509.46cstmwwobizrjfo@steredhat>
References: <20210211162519.215418-1-sgarzare@redhat.com>
 <YCqF891BLn5zsUwd@kroah.com>
 <20210215150321.anwcogkifg6sefp6@steredhat>
 <YCqSCg4gugL/bX8f@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YCqSCg4gugL/bX8f@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 15, 2021 at 04:23:54PM +0100, Greg KH wrote:
>On Mon, Feb 15, 2021 at 04:03:21PM +0100, Stefano Garzarella wrote:
>> On Mon, Feb 15, 2021 at 03:32:19PM +0100, Greg KH wrote:
>> > On Thu, Feb 11, 2021 at 05:25:19PM +0100, Stefano Garzarella wrote:
>> > > Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.
>> >
>> > No, this really is not that commit, so please do not say it is.
>>
>> Oops, sorry.
>>
>> >
>> > > Before this patch, if 'offset + len' was equal to
>> > > sizeof(struct virtio_net_config), the entire buffer wasn't filled,
>> > > returning incorrect values to the caller.
>> > >
>> > > Since 'vdpasim->config' type is 'struct virtio_net_config', we can
>> > > safely copy its content under this condition.
>> > >
>> > > Commit 65b709586e22 ("vdpa_sim: add get_config callback in
>> > > vdpasim_dev_attr") unintentionally solved it upstream while
>> > > refactoring vdpa_sim.c to support multiple devices. But we don't want
>> > > to backport it to stable branches as it contains many changes.
>> > >
>> > > Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> > > Cc: <stable@vger.kernel.org> # 5.10.x
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > index 6a90fdb9cbfc..8ca178d7b02f 100644
>> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > @@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>> > >  {
>> > >  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>> > >
>> > > -	if (offset + len < sizeof(struct virtio_net_config))
>> > > +	if (offset + len <= sizeof(struct virtio_net_config))
>> > >  		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>> > >  }
>> >
>> > I'll be glad to take a one-off patch, but why can't we take the real
>> > upstream patch?  That is always the better long-term solution, right?
>>
>> Because that patch depends on the following patches merged in v5.11-rc1
>> while refactoring vdpa_sim:
>>   f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
>>   cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
>>   a13b5918fdd0 vdpa_sim: add work_fn in vdpasim_dev_attr
>>   011c35bac5ef vdpa_sim: add supported_features field in vdpasim_dev_attr
>>   2f8f46188805 vdpa_sim: add device id field in vdpasim_dev_attr
>>   6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
>>   36a9c3063025 vdpa_sim: rename vdpasim_config_ops variables
>>   423248d60d2b vdpa_sim: remove hard-coded virtq count
>>
>> Maybe we can skip some of them, but IMHO should be less risky to apply only
>> this change.
>>
>> If you want I can try to figure out the minimum sub-set of patches needed
>> for 65b709586e22 ("vdpa_sim: add get_config callback in vdpasim_dev_attr").
>
>The minimum is always nice :)
>

The minimum set, including the patch that fixes the issue, is the 
following:

   65b709586e22 vdpa_sim: add get_config callback in vdpasim_dev_attr
   f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
   cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
   6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
   423248d60d2b vdpa_sim: remove hard-coded virtq count

The patches apply fairly cleanly. There are a few contextual differences 
due to the lack of the other patches:

   $ git backport-diff -u master -r linux-5.10.y..HEAD
   Key:
   [----] : patches are identical
   [####] : number of functional differences between upstream/downstream patch
   [down] : patch is downstream-only
   The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

   001/5:[----] [--] 'vdpa_sim: remove hard-coded virtq count'
   002/5:[----] [-C] 'vdpa_sim: add struct vdpasim_dev_attr for device attributes'
   003/5:[----] [--] 'vdpa_sim: store parsed MAC address in a buffer'
   004/5:[----] [-C] 'vdpa_sim: make 'config' generic and usable for any device type'
   005/5:[----] [-C] 'vdpa_sim: add get_config callback in vdpasim_dev_attr'

>If it's just too much churn for no good reason, then yes, the one-line
>change above will be ok, but you need to document the heck out of why
>this is not upstream and that it is a one-off thing.
>

Shortly I'll send the series to stable@vger.kernel.org so you can judge 
if it's okay or better to resend this patch with a better description.

Thanks
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
