Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93CC7EE29
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 13:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED3718227E;
	Mon, 22 May 2023 13:14:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED3718227E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iS0U34WW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kFY7Pu2zrfa; Mon, 22 May 2023 13:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 858D182266;
	Mon, 22 May 2023 13:14:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 858D182266
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 695B0C0035;
	Mon, 22 May 2023 13:14:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FAD5C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D2B941875
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D2B941875
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iS0U34WW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07ciYh0_AP6h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D35441864
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D35441864
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684761257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJa+GKU9edCanEPVCfWeFwI5Lsvvl9efoskVffi2Y6Y=;
 b=iS0U34WWfa8H6G849ziV6YgYZmC1dPfnmLW5wK+Ul8Ypz1X/uXtCa6Fz3mIKCjMVqJSbsh
 122NZtQFxlLx7PSpKcVzRNvz8dzYw/8Hnh1CV3nogjqaBdXwoTtfeoTuOZryWQfAZZ2mo9
 GDIDGk3u6v6xBXkezGskzTNOt6EgZq4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-DQ9PCLdCNdyTrKjd0AyNjA-1; Mon, 22 May 2023 09:14:14 -0400
X-MC-Unique: DQ9PCLdCNdyTrKjd0AyNjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB7E3C11A24;
 Mon, 22 May 2023 13:14:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53260401026;
 Mon, 22 May 2023 13:14:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D7FEB1800606; Mon, 22 May 2023 15:14:10 +0200 (CEST)
Date: Mon, 22 May 2023 15:14:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v5 09/44] drm: handle HAS_IOPORT dependencies
Message-ID: <vng4tcbkdieuvlmiu36drat5t3lwzufthylcgv3qzfrodphhq3@sjxcuan5q6h6>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-10-schnelle@linux.ibm.com>
 <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2043cea3-7553-ee9d-4aaa-6f1d22ac4d87@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>, linux-arch@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Alan Stern <stern@rowland.harvard.edu>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>, Niklas Schnelle <schnelle@linux.ibm.com>,
 spice-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Daniel Vetter <daniel@ffwll.ch>
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

  Hi,

> > There is also a direct and hard coded use in cirrus.c which according to
> > the comment is only necessary during resume.  Let's just skip this as
> > for example s390 which doesn't have I/O port support also doesen't
> > support suspend/resume.
> 
> I think we should consider making cirrus depend on HAS_IOPORT. The driver is
> only for qemu's cirrus emulation, which IIRC can only be enabled for i586.

Agree.  cirrus is x86 only (both i386 / x86_64 though).  Just require
HAS_IOPORT and be done with it.

> And it has all been deprecated long ago.

The fact that cirrus used to be the qemu default for many years is
pretty much the only reason it is still somewhat relevant today ...

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
