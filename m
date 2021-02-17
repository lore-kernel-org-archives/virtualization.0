Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD02C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EC964D9F
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EC964D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1AA398723B;
	Wed, 17 Feb 2021 11:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJ+XB7ZQd1-l; Wed, 17 Feb 2021 11:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7FCC687232;
	Wed, 17 Feb 2021 11:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6E8C0893;
	Wed, 17 Feb 2021 11:10:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4D1FC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 11:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8ED0685FDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 11:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjjYoRx5N3DV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 11:10:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8788F85CA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613560223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gH/ZfysJ+cKK0O84K0Huj64i5TKxRldUz8hhIaqDtck=;
 b=BEg602184ke2DRVTk6pfd7nmWnXNVX1l79eOl1lJkGfy0fNjPXpJwCFQ4temjBIASuFmX0
 g+rU/Y8jIo7gXV8HP0GuCBxfd2cmKrV4XWUTKB0ImfqBd6DrmFMDb7W/gcj2a1T3pRVQfA
 7zJ4D6lPLRLEdaOk3u7vAyPi1pYZUMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-5SV6zbMOOuyg4mKsz_q-Gw-1; Wed, 17 Feb 2021 06:10:19 -0500
X-MC-Unique: 5SV6zbMOOuyg4mKsz_q-Gw-1
Received: by mail-wr1-f71.google.com with SMTP id p18so14435816wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 03:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gH/ZfysJ+cKK0O84K0Huj64i5TKxRldUz8hhIaqDtck=;
 b=eEHWoTOgHHzhzH2dMZqI3g2nK+dHTnrzsP7gKjBahHpErHiBNOvP5xn2RkBdvNM+qS
 CfuRNTDvw6USIwJcl3+Uigrx3s+qfBk2LQ1fpW38OMPqpfTmdgjroAdhf/wWDPKPBXZw
 Bt82i0dESSdNr44gO9+bEPgoG7OumP04mQQTMR/Ou2epUWXKPTQIoUc8qmFWPANWoNNM
 ZP5dcXo957uF02dSkyzy9aU7ZsE/WWpy/NSr3HQiXXQ+fss5cU7UemIwtAWaEIJmAnu3
 prS344yHZxQ6jmsj2b9MnzhivLTj8sf8Twus7oGWFh7i3Zbz1gkvaKnXXQ8vI+8QePOr
 4/hw==
X-Gm-Message-State: AOAM533d5oX/6zYFng/dOQO1uznsE1CVnT+FPpMLA8VTEFGPYavDj9op
 f+G6d3vqgLemFbj2GPkIPyUxwm10RXbrBYXe0uY3zjwcDmQQ6AJnVnM7oviUrDNzYFKhFu96Lin
 4NwHQjCciwJOFtZ0rD9F6UnkcUljWLj6YEVN1FGVJxA==
X-Received: by 2002:adf:d4d0:: with SMTP id w16mr28770627wrk.262.1613560217900; 
 Wed, 17 Feb 2021 03:10:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8L9KQriiFtFtaFd14UEU5a9b2J9JRYjL6sr4KhAwRLuLnWVWCrBmMOV5ispESWTbSp7mKUQ==
X-Received: by 2002:adf:d4d0:: with SMTP id w16mr28770606wrk.262.1613560217719; 
 Wed, 17 Feb 2021 03:10:17 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s13sm2349146wmh.34.2021.02.17.03.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 03:10:17 -0800 (PST)
Date: Wed, 17 Feb 2021 12:10:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH for 5.10 v2 0/5] vdpa_sim: fix param validation in
 vdpasim_get_config()
Message-ID: <20210217111015.ngetgbz5icfhyaza@steredhat>
References: <20210216142439.258713-1-sgarzare@redhat.com>
 <YCz27cywSabiGgDz@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YCz27cywSabiGgDz@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Feb 17, 2021 at 11:58:53AM +0100, Greg KH wrote:
>On Tue, Feb 16, 2021 at 03:24:34PM +0100, Stefano Garzarella wrote:
>> v1: https://lore.kernel.org/stable/20210211162519.215418-1-sgarzare@redhat.com/
>>
>> v2:
>> - backport the upstream patch and related patches needed
>>
>> Commit 65b709586e22 ("vdpa_sim: add get_config callback in
>> vdpasim_dev_attr") unintentionally solved an issue in vdpasim_get_config()
>> upstream while refactoring vdpa_sim.c to support multiple devices.
>>
>> Before that patch, if 'offset + len' was equal to
>> sizeof(struct virtio_net_config), the entire buffer wasn't filled,
>> returning incorrect values to the caller.
>>
>> Since 'vdpasim->config' type is 'struct virtio_net_config', we can
>> safely copy its content under this condition.
>>
>> The minimum set of patches to backport the patch that fixes the issue, is the
>> following:
>>
>>    423248d60d2b vdpa_sim: remove hard-coded virtq count
>>    6c6e28fe4579 vdpa_sim: add struct vdpasim_dev_attr for device attributes
>>    cf1a3b35382c vdpa_sim: store parsed MAC address in a buffer
>>    f37cbbc65178 vdpa_sim: make 'config' generic and usable for any device type
>>    65b709586e22 vdpa_sim: add get_config callback in vdpasim_dev_attr
>>
>> The patches apply fairly cleanly. There are a few contextual differences
>> due to the lack of the other patches:
>>
>>    $ git backport-diff -u master -r linux-5.10.y..HEAD
>
>Cool, where is 'backport-diff' from?

It was developed by Jeff Cody and I find it very useful when doing or 
reviewing backports :-)

It's available here:
https://github.com/codyprime/git-scripts/blob/master/git-backport-diff

>
>>    Key:
>>    [----] : patches are identical
>>    [####] : number of functional differences between upstream/downstream patch
>>    [down] : patch is downstream-only
>>    The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>
>>    001/5:[----] [--] 'vdpa_sim: remove hard-coded virtq count'
>>    002/5:[----] [-C] 'vdpa_sim: add struct vdpasim_dev_attr for device attributes'
>>    003/5:[----] [--] 'vdpa_sim: store parsed MAC address in a buffer'
>>    004/5:[----] [-C] 'vdpa_sim: make 'config' generic and usable for any device type'
>>    005/5:[----] [-C] 'vdpa_sim: add get_config callback in vdpasim_dev_attr'
>
>Now all applied, thanks.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
