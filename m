Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1AC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 09:14:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2170B64E2F
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 09:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2170B64E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4EF2855C6;
	Wed, 10 Feb 2021 09:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8u_4w8AKaiEZ; Wed, 10 Feb 2021 09:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E0A085585;
	Wed, 10 Feb 2021 09:14:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7B16C0891;
	Wed, 10 Feb 2021 09:14:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E22E1C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C70B98559B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HW3kRkdMHkdb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E9AE085585
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612948470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DTTShUwVJ0CrEkc+tYcazKGDX2AZYCkEtJJC3BlqDjo=;
 b=VM9NpJLSNyhSccz7er5P0aa5Bjk13+UsVXSFuOiC1rStb5OBipEfGSt1NCNciS2dij1OUw
 qx5p1Jcha2uo3TvijTitUD8+p6OXRS6mQIBWNB45OCg49PjtYmUvgHKUKi0hWHgtHr+Ker
 JkDQw9HvooVT7xdHuTLKTiXzeUmAhyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-SwYDUANcOVOSaUmW3Y0QXg-1; Wed, 10 Feb 2021 04:14:27 -0500
X-MC-Unique: SwYDUANcOVOSaUmW3Y0QXg-1
Received: by mail-wr1-f72.google.com with SMTP id d7so1369675wri.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 01:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTTShUwVJ0CrEkc+tYcazKGDX2AZYCkEtJJC3BlqDjo=;
 b=FiMnYlLEJXVhtb9jXkUnvXXACUermfloZMnNcO7LDTeRQBFXjBxF35J33vaDFYHEAq
 OoORisSMQZrOdsQlufMPBOAgCx/ZBONPDgdj3txcaU/nPzJ4JMuYgXmsx4aLHMeAXHEW
 AROXw3tEFGPHhJ7dezb8Xvzu7jrRS0pfg9VQtajKIZvGD8pN7IpUM9h+n47vL35JQG97
 iKr2igtY1o8XuVfB8xr9vtVYcm7A4ZWgPwMaDE30wPdbCLPJMKkDX2yayCzYiY3P+cXy
 VJZmRFCkLEBfPLyNQvZEcWG7794V1Q4XTXf2m1BJWh1kNRp7YUiHgRtg61y9eLTg6eNk
 9JBw==
X-Gm-Message-State: AOAM5323W+57V3tdM72RSx1+1kYjcXGCIl8TVaSJ6rmhNTA2P3elatJu
 5/+3eOER53etkNRlHCcXZaTLxz4mZcVPBA+l0FynJ/fpUPZFiLx0oiq5Rq78US1yOugoFc5jWWm
 DTVkmnQf6r8cMb29OKptnjw8xUtWB75Ssh0zxNo7vnw==
X-Received: by 2002:adf:f905:: with SMTP id b5mr2415511wrr.129.1612948465660; 
 Wed, 10 Feb 2021 01:14:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVKNmX7F7uxfESFV+eOczVcXshzHHqofRNkNcRtOMdL/1msWkrIn0DfFr8uZOjZfXmBf8p7g==
X-Received: by 2002:adf:f905:: with SMTP id b5mr2415495wrr.129.1612948465499; 
 Wed, 10 Feb 2021 01:14:25 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id l83sm1814553wmf.4.2021.02.10.01.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 01:14:24 -0800 (PST)
Date: Wed, 10 Feb 2021 04:14:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210210040802-mutt-send-email-mst@kernel.org>
References: <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
 <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
 <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
 <CA+FuTScVOuoHKtrdrRFswjA3Zq1-7sgMVhnP2iMB5sYFFS8NFg@mail.gmail.com>
 <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
 <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
 <00de1b0f-f2aa-de54-9c7e-472643400417@redhat.com>
 <CAF=yD-K9xTBStGR5BEiS6WZd=znqM_ENcj9_nb=rrpcMORqE8g@mail.gmail.com>
 <CAEA6p_Bi1OMTas0W4VuxAMz8Frf+vBNc8c7xCDUxb_uwUy8Zgw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEA6p_Bi1OMTas0W4VuxAMz8Frf+vBNc8c7xCDUxb_uwUy8Zgw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
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

On Tue, Feb 09, 2021 at 10:00:22AM -0800, Wei Wang wrote:
> On Tue, Feb 9, 2021 at 6:58 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > >>> I have no preference. Just curious, especially if it complicates the patch.
> > > >>>
> > > >> My understanding is that. It's probably ok for net. But we probably need
> > > >> to document the assumptions to make sure it was not abused in other drivers.
> > > >>
> > > >> Introduce new parameters for find_vqs() can help to eliminate the subtle
> > > >> stuffs but I agree it looks like a overkill.
> > > >>
> > > >> (Btw, I forget the numbers but wonder how much difference if we simple
> > > >> remove the free_old_xmits() from the rx NAPI path?)
> > > > The committed patchset did not record those numbers, but I found them
> > > > in an earlier iteration:
> > > >
> > > >    [PATCH net-next 0/3] virtio-net tx napi
> > > >    https://lists.openwall.net/netdev/2017/04/02/55
> > > >
> > > > It did seem to significantly reduce compute cycles ("Gcyc") at the
> > > > time. For instance:
> > > >
> > > >      TCP_RR Latency (us):
> > > >      1x:
> > > >        p50              24       24       21
> > > >        p99              27       27       27
> > > >        Gcycles         299      432      308
> > > >
> > > > I'm concerned that removing it now may cause a regression report in a
> > > > few months. That is higher risk than the spurious interrupt warning
> > > > that was only reported after years of use.
> > >
> > >
> > > Right.
> > >
> > > So if Michael is fine with this approach, I'm ok with it. But we
> > > probably need to a TODO to invent the interrupt handlers that can be
> > > used for more than one virtqueues. When MSI-X is enabled, the interrupt
> > > handler (vring_interrup()) assumes the interrupt is used by a single
> > > virtqueue.
> >
> > Thanks.
> >
> > The approach to schedule tx-napi from virtnet_poll_cleantx instead of
> > cleaning directly in this rx-napi function was not effective at
> > suppressing the warning, I understand.
> 
> Correct. I tried the approach to schedule tx napi instead of directly
> do free_old_xmit_skbs() in virtnet_poll_cleantx(). But the warning
> still happens.

Two questions here: is the device using packed or split vqs?
And is event index enabled?

I think one issue is that at the moment with split and event index we
don't actually disable events at all.

static void virtqueue_disable_cb_split(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);

        if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
                vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
                if (!vq->event)
                        vq->split.vring.avail->flags =
                                cpu_to_virtio16(_vq->vdev,
                                                vq->split.avail_flags_shadow);
        }
}

Can you try your napi patch + disable event index?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
