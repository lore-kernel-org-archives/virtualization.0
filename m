Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA46C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:33:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E661157
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D27E661157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95ADD40555;
	Wed, 15 Sep 2021 06:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8C8dmwsNXKxX; Wed, 15 Sep 2021 06:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0272940553;
	Wed, 15 Sep 2021 06:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5CB2C0011;
	Wed, 15 Sep 2021 06:33:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32F1EC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EEAE40553
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qc88lZSZpdOD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:33:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65A814052D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631687629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syP9u21I0X13+NfaoXP/B0PHgpOt46v9RYaImlgDpiM=;
 b=crQnyZXy48areDFvC/CHzOq49P4MGB4vzEPSLh/Xlh6zC3oLcQ2XaNRM+bTYrY097f1ff9
 2Ho+2An6hNMnr66PuuNrOzngyfyR0PC5OPev4r3OUJhK5C9uOv/e3WkqQ5ZjhKAat+LkLF
 MGI4ehlSsmFOEm+sbwR6mt9o+Lrr1UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-A7VfICycPX-ZylX37M_ICg-1; Wed, 15 Sep 2021 02:33:48 -0400
X-MC-Unique: A7VfICycPX-ZylX37M_ICg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18771B18BC6;
 Wed, 15 Sep 2021 06:33:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8843E10016F5;
 Wed, 15 Sep 2021 06:33:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0F6A518003BF; Wed, 15 Sep 2021 08:33:45 +0200 (CEST)
Date: Wed, 15 Sep 2021 08:33:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Subject: Re: [PATCH 1/2] drm/qxl: User page size macro for qxl release bo
Message-ID: <20210915063345.yvzulffu6ekycz6p@sirius.home.kraxel.org>
References: <20210914062352.6102-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914062352.6102-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Tue, Sep 14, 2021 at 02:23:51AM -0400, bibo mao wrote:
> Some architectures have different default page size, this patch
> replaces hardcoded 4096 with PAGE_SIZE macro, since cmd bo size
> is page aligned.
> 
> Signed-off-by: bibo mao <maobibo@loongson.cn>

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
