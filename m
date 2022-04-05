Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD11C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A51C94099B;
	Tue,  5 Apr 2022 05:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3fhjuxsc3h7; Tue,  5 Apr 2022 05:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01F3140999;
	Tue,  5 Apr 2022 05:20:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4AB0C002C;
	Tue,  5 Apr 2022 05:20:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CD6DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 05:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18F0E8264A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 05:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2DigtRh5bze
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 05:20:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A335982572
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649136049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXNd3S63I+/DnvIHKzVjn0CsQfzi1GKX7Atsgl6DyUY=;
 b=Aj8viwLBQejEOhZ4x+8nLx/BkAe0HyKtHO8v1WZ6hPVfiGO728bj6zCLDd7rTgjnEL+LQ1
 9sZqfcLgTBmClRPjoxGsIHjH5cTIUKis1GwX7yHp3cCPpzh+zKSYelCUW4q6bYMXIxviso
 GUDg2k8vi8e1A4j0g1KYoVWtcuQhT2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-L5jtFu4QNo2j80x4PFINcQ-1; Tue, 05 Apr 2022 01:20:47 -0400
X-MC-Unique: L5jtFu4QNo2j80x4PFINcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i184-20020a1c3bc1000000b0038e4c5968b5so784075wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 22:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hXNd3S63I+/DnvIHKzVjn0CsQfzi1GKX7Atsgl6DyUY=;
 b=lOBZQ6XQtVGFBbTAduRoRwzW/0OPd3/haIdk6V2zBSiw+PShcmDWm+TAeM3q/TFiJG
 LMzucXzycKzl4Tv3ZpDutEFTBopQGFKSCnKq2m9ETIX4azTHTuB4zXVH9h5rJNcnj3ur
 xtgvim1He7GqZGy3Bgl4OLXaZ0P2Tr96Hr8ohu+q8vUseI1HJsmQR/KBSAtId8XFtI+n
 6OQLAHmzUnD91hWsNCOMFBubNTVIJ2ZZa/yRZ4ySY7SgKLQkwxnnDVDVa6plCWcSgZm1
 4EcDF+JFIUWjZv7u8XLlePeKvI6TeUintfj5OpDZPD0ogjLxEC0fnGw9v4fPhnxZkfsQ
 LvtQ==
X-Gm-Message-State: AOAM531NphO0cBaGj+5yP0UKxvygsvIDyuD7csTH3bRkbn4VqYb6S8NQ
 jn8gY0VyF6+Vce9m0hbDB6jQtOHWFSl0wbEbtEujelYy7THQbiXofBH7HyG2JBo4aecfxluNB/X
 ucL22UZk2elrgxZl9tyjjlWj31LRuSVVJesVVZg15HA==
X-Received: by 2002:a7b:cb87:0:b0:38e:7464:f796 with SMTP id
 m7-20020a7bcb87000000b0038e7464f796mr1343550wmi.133.1649136046819; 
 Mon, 04 Apr 2022 22:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5pSIpqXDbMjBhGhF2Ym8NkkUzOiS8ugQkJZJSUEkD8mJRZ/i+6rvspLskok00+YPdm3I8bA==
X-Received: by 2002:a7b:cb87:0:b0:38e:7464:f796 with SMTP id
 m7-20020a7bcb87000000b0038e7464f796mr1343528wmi.133.1649136046521; 
 Mon, 04 Apr 2022 22:20:46 -0700 (PDT)
Received: from redhat.com ([2.52.17.211]) by smtp.gmail.com with ESMTPSA id
 d14-20020a056000186e00b0020405198faasm12295878wri.52.2022.04.04.22.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 22:20:45 -0700 (PDT)
Date: Tue, 5 Apr 2022 01:20:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220405012015-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87h778g8nn.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 helei.sig11@bytedance.com
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

On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> >> Hi, Michael & Lei
> >> 
> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> >> for a revoting procedure?
> >
> > You can but not it probably will be deferred to 1.3. OK with you?
> >
> >> Also cc Cornelia Huck.
> 
> [Apologies, I'm horribly behind on my email backlog, and on virtio
> things in general :(]
> 
> The akcipher update had been deferred for 1.2, so I think it will be 1.3
> material. However, I just noticed while browsing the fine lwn.net merge
> window summary that this seems to have been merged already. That
> situation is less than ideal, although I don't expect any really bad
> problems, given that there had not been any negative feedback for the
> spec proposal that I remember.

Let's open a 1.3 branch? What do you think?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
