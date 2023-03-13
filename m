Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A3C6FD19
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 08:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B8DD4029A;
	Mon, 13 Mar 2023 08:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B8DD4029A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LFRAC1GE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FG3sXpwy00GA; Mon, 13 Mar 2023 08:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BBDF401EE;
	Mon, 13 Mar 2023 08:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BBDF401EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B391C0035;
	Mon, 13 Mar 2023 08:52:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED477C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 08:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D542840441
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 08:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D542840441
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LFRAC1GE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9QqL9kUW6W8C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 08:52:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EDD74012F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EDD74012F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678697544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rn0ZDN/u4ONTQp/tmI2ypE9T4TH7mmvAAf+chBeDHxQ=;
 b=LFRAC1GE3817jBqsaGnziGmINzNe00lI9T9qcZNFvH/bzQJeTMouMPvLZ0NTxEmk8LW2HL
 YlnOInaNcVKsX9kohXPcacUJNtbzIHSGBGeGCr06BUktdI2A71Ht+ArQrLeP9i+v7G+2/P
 oLs+O2ofNOhX/hExbjWluPNZZBhhaoc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-j-eQXjg8ORK0ti-wx5PCJA-1; Mon, 13 Mar 2023 04:52:21 -0400
X-MC-Unique: j-eQXjg8ORK0ti-wx5PCJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71414800050;
 Mon, 13 Mar 2023 08:52:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3214D202701E;
 Mon, 13 Mar 2023 08:52:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 191791801CF6; Mon, 13 Mar 2023 09:52:20 +0100 (CET)
Date: Mon, 13 Mar 2023 09:52:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
Message-ID: <20230313085220.fwvcul7sz7ycxtm4@sirius.home.kraxel.org>
References: <20230310125943.912514-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310125943.912514-1-javierm@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Bilal Elmoussaoui <belmouss@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org,
 Christian Hergert <chergert@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Albert Esteve <aesteve@redhat.com>
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

On Fri, Mar 10, 2023 at 01:59:42PM +0100, Javier Martinez Canillas wrote:
> Christian Hergert reports that the driver doesn't enable the property and
> that leads to always doing a full plane update, even when the driver does
> support damage clipping for the primary plane.
> 
> Don't enable it for the cursor plane, because its .atomic_update callback
> doesn't handle damage clips.
> 
> Reported-by: Christian Hergert <chergert@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
