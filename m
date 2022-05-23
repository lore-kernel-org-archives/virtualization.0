Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F22C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 09:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73F9610B3;
	Mon, 23 May 2022 09:43:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kfj2jCODPOm; Mon, 23 May 2022 09:43:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4192A60807;
	Mon, 23 May 2022 09:43:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25ED8C0032;
	Mon, 23 May 2022 09:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74EABC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 09:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62A3D410C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 09:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_EAHc76m9rb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 09:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49E43410B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653299019;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zHdaX4lkGani+Ef/QKOcwQCasmJossQLNme43RH2O2E=;
 b=ER3mBGEeMVJgUk0DyllilbwQb4VDrWjJTmfTVXtH9OJ/owuCcG502JtlBmGEXS/E0e0tcx
 SJEoWdHiqntvVrmHsOucFvKUrXWSjqq51Z/t7RgLE0yGwqPm58HmFwNLIihesCAz9JKg2u
 y4tw6nOOXBBjp8E6fVNPLw0oJDBxJdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-DkwGMmLoPDWOy0-HAxylew-1; Mon, 23 May 2022 05:43:35 -0400
X-MC-Unique: DkwGMmLoPDWOy0-HAxylew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77D8085A5B9;
 Mon, 23 May 2022 09:43:35 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06B592026D6A;
 Mon, 23 May 2022 09:43:33 +0000 (UTC)
Date: Mon, 23 May 2022 10:43:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v6 5/9] crypto: Implement RSA algorithm by hogweed
Message-ID: <YotXQz6rydXN+AtH@redhat.com>
References: <20220514005504.1042884-1-pizhenwei@bytedance.com>
 <20220514005504.1042884-6-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220514005504.1042884-6-pizhenwei@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, May 14, 2022 at 08:55:00AM +0800, zhenwei pi wrote:
> From: Lei He <helei.sig11@bytedance.com>
> 
> Implement RSA algorithm by hogweed from nettle. Thus QEMU supports
> a 'real' RSA backend to handle request from guest side. It's
> important to test RSA offload case without OS & hardware requirement.
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  crypto/akcipher-nettle.c.inc | 451 +++++++++++++++++++++++++++++++++++
>  crypto/akcipher.c            |   4 +
>  crypto/meson.build           |   4 +
>  crypto/rsakey-builtin.c.inc  | 200 ++++++++++++++++
>  crypto/rsakey-nettle.c.inc   | 158 ++++++++++++
>  crypto/rsakey.c              |  44 ++++
>  crypto/rsakey.h              |  94 ++++++++
>  meson.build                  |  11 +
>  8 files changed, 966 insertions(+)
>  create mode 100644 crypto/akcipher-nettle.c.inc
>  create mode 100644 crypto/rsakey-builtin.c.inc
>  create mode 100644 crypto/rsakey-nettle.c.inc
>  create mode 100644 crypto/rsakey.c
>  create mode 100644 crypto/rsakey.h


> diff --git a/crypto/rsakey.h b/crypto/rsakey.h
> new file mode 100644
> index 0000000000..17bb22333d
> --- /dev/null
> +++ b/crypto/rsakey.h
> @@ -0,0 +1,94 @@
> +
> +#ifndef QCRYPTO_RSAKEY_H
> +#define QCRYPTO_RSAKEY_H
> +
> +#include <nettle/bignum.h>

This should be removed -it isn't needed and breaks build on
without-nettle build configurations.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
