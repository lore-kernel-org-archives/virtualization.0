Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EC8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 11:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77A4040943;
	Wed, 29 Jun 2022 11:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77A4040943
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nokr6IMB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Eb0AZvvzgr3; Wed, 29 Jun 2022 11:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB06340906;
	Wed, 29 Jun 2022 11:29:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB06340906
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83309C0039;
	Wed, 29 Jun 2022 11:29:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A91B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 11:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73E72612CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 11:29:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73E72612CB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nokr6IMB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKzVHZ9YXZQR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 11:29:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66287612CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66287612CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656502139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZiMXL+ilFja5jXawjmm60mxTjlG0pAnot2u6S8oxJQ0=;
 b=Nokr6IMBbNyXU9fUgK3q/bmNRyqAi94KUZomW0Q3/bA5zfAPObN0oUTXSBwCmWweQ7y3PY
 gZRao1YglD6jmCufFQN1vLGDvSsYRWThQl4fEv3nHzBSUu0ncJ0i9VkEoYPYmAzbdxsbpE
 gbdWi6wetW0rbW3liOR1HeQ9z9aQ2Ws=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-LD0DNNXYN3C4Ktm6ZsOHOQ-1; Wed, 29 Jun 2022 07:28:58 -0400
X-MC-Unique: LD0DNNXYN3C4Ktm6ZsOHOQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 s1-20020a5d69c1000000b0021b9f3abfebso2335198wrw.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 04:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZiMXL+ilFja5jXawjmm60mxTjlG0pAnot2u6S8oxJQ0=;
 b=OdJfeyEWXlel09UjDcgYB4jUodBso+y5jP14XSCeUQduwCNxNNguJ+IFtx0LXvQxEf
 VV4Gqqm9QoIaiTXgizWHvJE7z6q5vz/xK1CskRpGRSB3mkbGHRlL4rcu/RnDGYysedcH
 W7c94yOP/VAx7wSyXr7YZOOAnR2uXPVxUOdKs69+1VXfVP4FlMa39ZCJnN2vfRzqt3M4
 +kXlCy8iKbG7NEp6dhm4yhHI/UxHzqSCtippGGFPYJrwUirXOI4UQRa3fJeiSE6j1PJA
 PqPUAzoUVIwAD1i/v2LaifvxvQjRCN+UicvhP1yqnJz4V0ULUZKC2dv8+TaUX8h9iKxV
 Xl4Q==
X-Gm-Message-State: AJIora9uRWvn7fbKpB++4ELrP3egI0PRqGWP+K1oRezmGW0r2So8T6Xg
 q9S1WGe5wLLDTs8U5T3hiQumNtQ8jQYI2/QtEHZ3aGckuN/Cu75UmjSHk1Blc0BcuzQUr0KpM9X
 OYQrgs3/DceQK9RHj6EWWYzZWua3NnKKW8qQbKYeE5g==
X-Received: by 2002:adf:d841:0:b0:21d:2d0d:e704 with SMTP id
 k1-20020adfd841000000b0021d2d0de704mr1882265wrl.77.1656502137609; 
 Wed, 29 Jun 2022 04:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tZP/KbIe69IZVjJQlbxE5EU9PxxeyQN8aoggsXmiyfSbUGRB0Oc3AxcelAzcQjUt6MTEdKFA==
X-Received: by 2002:adf:d841:0:b0:21d:2d0d:e704 with SMTP id
 k1-20020adfd841000000b0021d2d0de704mr1882246wrl.77.1656502137405; 
 Wed, 29 Jun 2022 04:28:57 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 q11-20020adfea0b000000b0020fff0ea0a3sm16108515wrm.116.2022.06.29.04.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 04:28:56 -0700 (PDT)
Date: Wed, 29 Jun 2022 07:28:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 5/6] vduse: Support registering userspace memory for IOTLB
Message-ID: <20220629072825-mutt-send-email-mst@kernel.org>
References: <20220629082541.118-1-xieyongji@bytedance.com>
 <20220629082541.118-6-xieyongji@bytedance.com>
 <20220629043539-mutt-send-email-mst@kernel.org>
 <CACycT3sAcH-b40hORjSOQb67jZ0Fd-fxdzmZNwt=4iZdX6gLeA@mail.gmail.com>
 <20220629055241-mutt-send-email-mst@kernel.org>
 <CACycT3vaNLYRid5SsT11LuVCaGXbBfV=q7c7SUp1+r9BcRpwkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vaNLYRid5SsT11LuVCaGXbBfV=q7c7SUp1+r9BcRpwkw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jun 29, 2022 at 06:19:31PM +0800, Yongji Xie wrote:
> > No i mean you decrement the lock twice. Question is can two bounce
> > buffers share a page?
> >
> 
> I think we can't. I will find a way to prevent it.
> 
> Thanks,
> Yongji

I guess it doesn't matter much then.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
