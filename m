Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF5AC38145
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 08:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA1F5417B8;
	Tue,  6 Sep 2022 08:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA1F5417B8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9Da8FSo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAJ__LX9zm0C; Tue,  6 Sep 2022 08:45:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38C77417B6;
	Tue,  6 Sep 2022 08:45:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38C77417B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F354FC0032;
	Tue,  6 Sep 2022 08:45:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89662C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 08:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B25D417B7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 08:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B25D417B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Fi7GcDbXaor
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 08:45:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB110417B6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB110417B6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662453937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+CgvAd98u77997qA9EulLbAkvKOkOqUmsYi/uHKf50=;
 b=L9Da8FSok9qsFIJSrcjDJe76BDS1NYP+s1QmZx95CvJKPs+2nvl7pe+87g13DqvlYFmWGg
 qHU/6Lleo2eLuTezcJ6sXhsFWd7KA7Ruuwk5+TdtolEAb5bFHvY04L6CUa/CNZOC5txFAr
 xczMHHK94kyfnXK7hrFfLDN24Wkldc0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-kod-150kOnqtAjcLZoWIWg-1; Tue, 06 Sep 2022 04:45:36 -0400
X-MC-Unique: kod-150kOnqtAjcLZoWIWg-1
Received: by mail-qv1-f72.google.com with SMTP id
 mv10-20020a056214338a00b004a175a165e0so4035902qvb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 01:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=S+CgvAd98u77997qA9EulLbAkvKOkOqUmsYi/uHKf50=;
 b=XKB8QG0PKjdg4M9P1DeFrTp/AaUKf8glYiSrgNgargs9kJjXclkfyxfs4rBiDDvpqg
 U/XFc9rMQm04Y98xKZUgoK6a0ntt8T4O+DC768YGhBOuxRdAC9fFHmq2O4a4NKLnRAoz
 qhmx6x60+ZMrZj+idtqhuqKqMFEbA2WenwET2x2FsUdVNsgglKXbWzWTf4QdGf9qwrCU
 BOaB8FAx4DYSxOpbcbt0Xxz8HgX0VXIZ6gL4sZjkOwDIo4EKHHrJLXD3aGoclfgko23c
 EHekrl9JmFsiIFSn+bJFWzLmsCv4VW5/iA0qRhIQSCShkw9CG4J30oS5k8IufijRT7TN
 V03w==
X-Gm-Message-State: ACgBeo1VBztR+IfNBjwXmPBSlNsVBzT1lJ4S5YsYQ7gbylyJWxcc0LHD
 jqCJpkpk++aQOO7wjQMbEjj0WpjDQ9MwxGjloN3OBTpYVK8BAQ48ihwE8ZFhYNlvIPJiYirEw9K
 3EPyGE8/XHXluv+tTZ2E6+X4vDbBEWKbgiOmB5KooIw==
X-Received: by 2002:a05:6214:1d2a:b0:4a0:78a1:3b2 with SMTP id
 f10-20020a0562141d2a00b004a078a103b2mr10125898qvd.24.1662453935767; 
 Tue, 06 Sep 2022 01:45:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6exkdF0IAZ+8vKtpu5164C5FcNuILyzsIlbKtvLfHVPEW4yVqCfRfPTRgq2CvJqB7kcZJTGA==
X-Received: by 2002:a05:6214:1d2a:b0:4a0:78a1:3b2 with SMTP id
 f10-20020a0562141d2a00b004a078a103b2mr10125887qvd.24.1662453935558; 
 Tue, 06 Sep 2022 01:45:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 fp5-20020a05622a508500b0031e9ab4e4cesm8906971qtb.26.2022.09.06.01.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 01:45:34 -0700 (PDT)
Date: Tue, 6 Sep 2022 10:45:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
Message-ID: <20220906084525.4b3xzemvjf5vy6xo@sgarzare-redhat>
References: <20220817221956.1149183-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Aug 17, 2022 at 06:19:56PM -0400, Stefan Hajnoczi wrote:
>The vDPA driver framework is largely undocumented. Add a basic page that
>describes what vDPA is, where to get more information, and how to use
>the simulator for testing.
>
>In the future it would be nice to add an overview of the driver API as
>well as comprehensive doc comments.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> Documentation/driver-api/index.rst |  1 +
> Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+)
> create mode 100644 Documentation/driver-api/vdpa.rst

Thank you for this work!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
