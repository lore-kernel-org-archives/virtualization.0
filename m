Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272DC7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 848FD42537;
	Fri,  9 Jun 2023 16:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 848FD42537
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbM3DnDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJZYxRDwJD6O; Fri,  9 Jun 2023 16:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF793424FD;
	Fri,  9 Jun 2023 16:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF793424FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA4E0C0037;
	Fri,  9 Jun 2023 16:07:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 564DAC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 206F4419FF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 206F4419FF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbM3DnDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKcCy7CtwDGK
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:07:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 716D84031C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 716D84031C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
 b=QbM3DnDtsNEL4itqphSo4APNr++sTFu4lgwFqEuD6IEfXDatMqhjuydMi7m/z/P+UiaU7N
 3Arx9TVn8Fx1GO8PgES9mjD7MCbpuE8S1PY2euIdtxQ16HD2w6kojqZSchmWDK1+h0gEpo
 7fnblLSuTsf0DQicZoyY+s4LpCdHhYo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Hkz94D3pOS-NkOFWkJ9C2Q-1; Fri, 09 Jun 2023 12:07:03 -0400
X-MC-Unique: Hkz94D3pOS-NkOFWkJ9C2Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e55b42af1so1030283f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326822; x=1688918822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5J35VrNmjkpODYInc7dhrWj/0vYQzkKJNessU6AYz9Y=;
 b=GFZPLCrNTiJX7dOO0rDi2qXA+e3dtyjwrdjDSChxsqYxggNwGu0sMYNkAJgxcEQis4
 7BRNdO61LlaY9VW+BEp5zV4yra3FLb6LQ1Mxnnw6Z7t/c5SIyLOUDVTdmAjRAKnMvQnk
 OOO0ek2yyko098gB0MCy/WZb9GTAXBHHe5Hi+bIrGkQqh3myOhE+Wfd/3m5N8Rg+mGXq
 EsoZDCmNPYxjZUWN2X+PlcDlBaNn/d70hs0MoLk4m4KZ3moQ/qzASAiF3aPU/yIqexCw
 cKnhyj+Na8TG3PISJq48YyvTnX6rNkZzt8JY+f50f1BdjeJl764lHeF94xKHKVRDTeIG
 tBXw==
X-Gm-Message-State: AC+VfDwLKnf0p6XBf0Rap6QNOsaTyn19Kem9pgw6+VD33hbsBdcdBr0a
 NcOnxLtSB+xwww3S762Kt3gjjALjsymnB00I4Czfk8phoe6hJmgo9w6aFgEpqyAUiCGytmAFHzG
 hEpkbcAdXsCiytbiPkbtevlNfzg+FFSKt+oq3N1gScQ==
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id
 g13-20020adff3cd000000b0030e3e9e207bmr1298059wrp.32.1686326821880; 
 Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DeQtK3V76CSYnkOLZjiyDe1V9OpmIcOUfGabiu2EYTXXG/qEevQqBoZxHqU1eCbAno6PjKA==
X-Received: by 2002:adf:f3cd:0:b0:30e:3e9e:207b with SMTP id
 g13-20020adff3cd000000b0030e3e9e207bmr1298046wrp.32.1686326821563; 
 Fri, 09 Jun 2023 09:07:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a5d6e8f000000b0030e6096afb6sm4894148wrz.12.2023.06.09.09.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:07:00 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:06:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Roberts, Martin" <martin.roberts@intel.com>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230609120622-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20230609054122-mutt-send-email-mst@kernel.org>
 <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5354B884C2C89BB6AF1092B48351A@BN9PR11MB5354.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 lkp <lkp@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Suwan Kim <suwan.kim027@gmail.com>
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

On Fri, Jun 09, 2023 at 09:49:18AM +0000, Roberts, Martin wrote:
> OK, I didn't realise you had updated the patch; I only looked at the first one.  I think you did the same as me, just changed vbr->status to virtblk_vbr_status(vbr), in virtblk_poll().

Yes exactly, though testing exactly what's on list is always a good
idea, just to avoid confusion.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
