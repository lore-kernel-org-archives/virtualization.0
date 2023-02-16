Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61062C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 12:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D774941809;
	Thu, 16 Feb 2023 12:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D774941809
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jI+rY8Xr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4DOH2yi_ZxJo; Thu, 16 Feb 2023 12:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2097E41805;
	Thu, 16 Feb 2023 12:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2097E41805
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEE1C0032;
	Thu, 16 Feb 2023 12:34:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B26C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDB7F8133A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDB7F8133A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jI+rY8Xr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wp7jg1MBODLv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 154D3812FD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 154D3812FD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676550842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnEebGiYieEAIpFBvmp4/is8Uz9olTVE3UjL/CK2+0c=;
 b=jI+rY8XrRSGfOnCn/NWY06zQRZQGdpfx1jRxVVDM2Oafu7xCdMlDYHIywNfQ9vl58vNBCj
 Jlvhr+PZZ+ygXqIiDoizaMgVT78hwdX1hbf6lEjje4pUikfiEkCjPZllOKO8sQepUodobn
 fwZeJvwGcWkVZJ56QUzxsn17cMsGR28=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-DwHJZwFJOP6nRvS9orhqng-1; Thu, 16 Feb 2023 07:33:57 -0500
X-MC-Unique: DwHJZwFJOP6nRvS9orhqng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D348D1C0A58E;
 Thu, 16 Feb 2023 12:33:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 996B0C15BA0;
 Thu, 16 Feb 2023 12:33:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 413FF1800097; Thu, 16 Feb 2023 13:33:55 +0100 (CET)
Date: Thu, 16 Feb 2023 13:33:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Message-ID: <20230216123355.rhleh7ba2h6mzgvm@sirius.home.kraxel.org>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
 <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
MIME-Version: 1.0
In-Reply-To: <306e110d-4d1f-cb9c-6f9b-c8a5ddd48a61@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, daniel@ffwll.ch, airlied@redhat.com,
 sam@ravnborg.org
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

On Thu, Feb 16, 2023 at 01:03:02PM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for taking a look at the patches.
> 
> Am 16.02.23 um 12:33 schrieb Gerd Hoffmann:
> > On Wed, Feb 15, 2023 at 05:15:17PM +0100, Thomas Zimmermann wrote:
> > > Set the VGA bit for unblanking with macro constants instead of magic
> > > values. No functional changes.
> > 
> > blank/unblank should work simliar to bochs (see commit 250e743915d4),
> > that is maybe a nice thing to add of you modernize the driver anyway.
> Yeah, it's the VGA PAS field. [1] But is it really called blanking? PAS
> controls palette access, but blanking is sounds more like DPMS.

Yes, strictly speaking it is not the same thing. DPMS blank will send
the monitor into suspend mode which this does not.  On virtual hardware
there isn't much of a difference though ;)

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
