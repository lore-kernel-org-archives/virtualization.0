Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A863CCA473
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 01:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8164641C07;
	Wed, 22 Jun 2022 01:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8164641C07
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qb/3BPtZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_XIceR6Ys5M; Wed, 22 Jun 2022 01:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E4A541C03;
	Wed, 22 Jun 2022 01:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E4A541C03
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9EAC0039;
	Wed, 22 Jun 2022 01:18:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E922C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 550E241C06
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:18:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 550E241C06
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiPryRFnL71n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:17:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0ED7B41C03
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0ED7B41C03
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655860677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuuPsrvpildfWMsTFBzbFCeyycT4LB8kmzw//Wg2WxM=;
 b=Qb/3BPtZIGsVHmjkts8gnMMnCq/X1ipaGxVuE0KMzg/T0modeFuGSXQ9OHBKEud8jLfjT3
 1wW+T2a+E2G37mGU+fn/DG/ir9+a+Une+qqnaCBXMyrj1NQsk1Rc+JA0AhM2tqR3c4nW8n
 ckr4gcCUo9rdkNqxSwQRFH8qFsXgzGQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-DvTGvdeEMUKLlE7HyQRYKQ-1; Tue, 21 Jun 2022 21:17:56 -0400
X-MC-Unique: DvTGvdeEMUKLlE7HyQRYKQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 bp15-20020a056512158f00b0047f603e5f92so4648793lfb.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 18:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wuuPsrvpildfWMsTFBzbFCeyycT4LB8kmzw//Wg2WxM=;
 b=YctyJmR4K2ab54C8ICTHyn6xSU/tjh/MjGgm8Q05HBIwGFxqIZXjiIpTNobPsqaIIU
 37o+PzFM2HAIcQSzzqVGRVTVBjXkNHCWfArpveoFu1SX/sudXA0n4vqT0kUWf950ScNm
 uD7KnKbZEA/80peZMxMLgII58WeYzboLtf424ivvoq0DTDSD/tWCpisQgH/QJ1elg28t
 PLsiMqufCqGKfQeajE0ZXjjTjg0bH1oZeA6V04t3y/lnxvENRYjG1NoYKj+5Bs1KnMIB
 uqJWlorMuMtUhTIQ0YfwNVA2jCS0HsXIsU9mIyrPntIJPqrT3MfY/ZVkT62UL+AjTPKU
 GSHA==
X-Gm-Message-State: AJIora/bPUNlt1B7oSpJmWGspWxNjAnjNL710e+eHlWc271BBcVlmdgo
 e5qvOMxUlKWAljuq/bQVoujHeSUBVDPvpKiy6Hx81YKTPxNB+InEE5hgSS+shAFmO6BXWciPo23
 9axA88AWUtMUn1xUUgZgj6/i2a8H/xfs+NSbCMWuh6EwX3v3hvvv0Sv3ObQ==
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr446424ljg.323.1655860675147; 
 Tue, 21 Jun 2022 18:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQNlmQ8fPIImazbU50qDI+J7JfZUZ94bHEMA0uqALx+tS95NtR1kJrk5qBRHT/YHfDAiJWdNBd86xhIi+W7kQ=
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr446411ljg.323.1655860674845; Tue, 21
 Jun 2022 18:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220620024158.2505-1-jasowang@redhat.com>
 <87y1xq8jgw.fsf@redhat.com>
 <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com>
 <87sfny8hj8.fsf@redhat.com>
In-Reply-To: <87sfny8hj8.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jun 2022 09:17:37 +0800
Message-ID: <CACGkMEsg9791gQAtsz6fCM_=9_VmbqY=FehoTnpyiaJ7mCosDA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio: disable notification hardening by default
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
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

On Tue, Jun 21, 2022 at 5:58 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, Jun 21 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, Jun 21, 2022 at 5:16 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> The ifdeffery looks a big ugly, but I don't have a better idea.
> >
> > I guess you meant the ccw part, I leave the spinlock here in V1, but
> > Michael prefers to have that.
>
> Not doing the locking dance is good; I think the #ifdefs all over are a
> bit ugly, but as I said, I can't think of a good, less-ugly way...

Probably, but this is the way that is used by other subsystems. E.g
CONFIG_HARDEN_USERCOPY etc.

>
> > In the future, we may consider removing that, one possible way is to
> > have a per driver boolean for the hardening.
>
> As in "we've reviewed and tested this driver, so let's turn it on for
> every device bound to it"?

Right.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
