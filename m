Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88F1C43334
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52F9441B90;
	Thu, 30 Jun 2022 06:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52F9441B90
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e5yIFyez
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3gwPnAaCONb; Thu, 30 Jun 2022 06:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77733417D0;
	Thu, 30 Jun 2022 06:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77733417D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2EAC002D;
	Thu, 30 Jun 2022 06:15:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAEA9C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0AD741A59
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0AD741A59
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QMF9bFnqUuFC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A21F3417D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A21F3417D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656569748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIyFvGXQvIKAI2Jhy0fL/iiZlXHvPxpCNakI+DBgKxw=;
 b=e5yIFyez7RhUJhMW6FrKdmV+0XbKrmGO5vZoHMDVmY67l3B1TO9ItCIf1dISEDGPzuCGhw
 7RoijRFm4qDIAvMs+PKg2Bqr/dI1OrEL1dkWO8y/fGJ2CmHp0ADVWoDs3TlW5KnESsQ2Uq
 Qu1qY17MSZdMFIGrd5tXNR+Y/aNt3b8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-EOr9lYssP7uUMP08vQmx9w-1; Thu, 30 Jun 2022 02:15:46 -0400
X-MC-Unique: EOr9lYssP7uUMP08vQmx9w-1
Received: by mail-lf1-f69.google.com with SMTP id
 be18-20020a056512251200b0048120ff434dso4945650lfb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LIyFvGXQvIKAI2Jhy0fL/iiZlXHvPxpCNakI+DBgKxw=;
 b=DBAIjedxdWfzX2JXhSaYTJnvvRI/Iwh0EVbdl75xX5SKPyYV/JCQBdXxNaYuKu7nDa
 fZOWIMOXN7xl+MQQ7VEGFtgDUv5NWE6EMIyTDexgu0vSQqV/6SBoIPT64I9yYS1JKVq3
 C+RI/DUecobqr93LC8LuM4ORkLYGVFgxCazBDRjWbqIxzap6qmM9Yiy2ZoxJyswdbdna
 Fb+VSoANDWJd8PDMYrliZI2IvuT1OMv7Tv2F/R8ZLybrAvRUICz69GLZ+eqoa/ileWJH
 VlKBlsWQOqPirU5fWV/PRbVGuj8UKxKRUOECA4Zo3JR4HDeXpOLQe2f/FMNsA/XhGulb
 yZeg==
X-Gm-Message-State: AJIora+xulJStNZXvO9Wn2CSA5CmMYQZn0Row8QvNBF+hq+VTT4zJaA0
 BoeBICaQ3pS+pYb3m/ke+Dn9iyVWyUSn7a0R+WwhNjhcQyVMQyCNhuYTHAoFUrfTVRJ3LV7mdKb
 QgblJLRnhhtRMCTvfA3fUPgxZEPMxrzmj9CZQ8bEEddPSqyjl+vgAfak1Cg==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4399317lfa.124.1656569745186; 
 Wed, 29 Jun 2022 23:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9F/GK133FdytfbR7+VKwUYTi9oxNuF4wHt+M3JrgxraaO6yUp+b9CrmJzoGnM9JrETOQ19IVwMr6oaFTKAMk=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4399309lfa.124.1656569745030; Wed, 29
 Jun 2022 23:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com>
 <20220629195123.610eed9f@kernel.org>
 <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
In-Reply-To: <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:15:34 +0800
Message-ID: <CACGkMEuLnBR+e08juTO3mA9fj=r8-QL_iioP3-rjLH9L-fXhrQ@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-net: fix the race between refill work and close
To: Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>,
 mst <mst@redhat.com>
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

On Thu, Jun 30, 2022 at 2:07 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 30 Jun 2022 10:08:04 +0800 Jason Wang wrote:
> > > +static void enable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = true;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > > +static void disable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = false;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >                                   struct virtqueue *vq)
> > >  {
> > > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >       }
> > >
> > >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > -                     schedule_delayed_work(&vi->refill, 0);
> > > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > +                     spin_lock(&vi->refill_lock);
> > > +                     if (vi->refill_work_enabled)
> > > +                             schedule_delayed_work(&vi->refill, 0);
> > > +                     spin_unlock(&vi->refill_lock);
> >
> > Are you sure you can use the basic spin_lock() flavor in all cases?
> > Isn't the disable/enable called from a different context than this
> > thing here?
>
> This function will only be called in bh so it's safe.

Ok, so it looks like we should use the bh variant in close. Otherwise
we may have a deadlock. Will fix it.

Thanks

>
> >
> > The entire delayed work construct seems a little risky because the work
> > may go to sleep after disabling napi, causing large latency spikes.
>
> Yes, but it only happens on OOM.
>
> > I guess you must have a good reason no to simply reschedule the NAPI
> > and keep retrying with GFP_ATOMIC...
>
> Less pressure on the memory allocator on OOM probably, but it looks
> like an independent issue that might be optimized in the future.
>
> >
> > Please add the target tree name to the subject.
>
> Ok
>
> Thanks
>
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
