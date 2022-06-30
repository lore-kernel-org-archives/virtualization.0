Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493BACCA47B
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD0CB40880;
	Thu, 30 Jun 2022 06:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD0CB40880
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULQ5ywfF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XFisw6GuBELA; Thu, 30 Jun 2022 06:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 005674030B;
	Thu, 30 Jun 2022 06:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 005674030B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9DA3C002D;
	Thu, 30 Jun 2022 06:08:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079C7C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C72944034D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C72944034D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AsmhBHxSDNML
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC9484030B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC9484030B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656569286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Huizft4b5megN+LHZsenyqxTACpN6BbdhFtJNkNbRWk=;
 b=ULQ5ywfFTUzIvoIFPgtncGNOkVtm/Q1vt2mn8hfdfuom3C97CkWLqdxJ1iFBq3JnWKyAXc
 ebQCgCUiG5eCmy3pCFdkqQz6ectBdrfCHYtYMahH8+txRkUeo1i5HYk4laEe8N5zMf/cdk
 PwntlEb7nlof567bojQjN9JsrFAEQwc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-s_V_3lYlP6KJyrLcPFin0w-1; Thu, 30 Jun 2022 02:08:02 -0400
X-MC-Unique: s_V_3lYlP6KJyrLcPFin0w-1
Received: by mail-lj1-f200.google.com with SMTP id
 x7-20020a05651c024700b002594efe50f0so2854155ljn.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Huizft4b5megN+LHZsenyqxTACpN6BbdhFtJNkNbRWk=;
 b=ApeY2HDbTARHezg5V4vEEqItWzq/PRaUwAc3N1+ZX2qsUhUvTRjYgeSyMzer8v7KYT
 d18uPfcYlB/AtQKj+t5SEzoxQx2ZCvdPqVpcu4b+tnJyT85Q7ySOtGFm5PuPC0rqaBbo
 QluLr9PItaBFqiK39Nq489/C8UpRI5CkVqEFSfRWwXIfidymwSxV3208q13xKk5g+hSu
 cxpC/soreBdu/voaOLCjtXKpK034UxIqKMqBHf2W3/SwLLj12WrozX/Anz5ZWS4PlwPa
 9j3uuEbDuPY0VdjoO6TD7mCt6GFmoIpV+3H7ZaZ/V5ExYpRt+5ZZdSApE/n0IHZMDDki
 LaXg==
X-Gm-Message-State: AJIora84VtFkzRI2eiUJTtQv50C2nAoDkvPDIcjSBQFX2b0585LSklzX
 Y8iJ45PqYh3+0ytQEESKFkqKQeuNF4vB1V94ahrL+fJ6RGR84TMCesNv3xH/bf7ctN9dpmLjIR+
 NizvnjnNr02kSy3wRCzxaeSGzakflFF1800fl549OgY9XByLoH/e2ljRrjQ==
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr4454353lfk.575.1656569281371; 
 Wed, 29 Jun 2022 23:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSvw4QQdRBK/4iZ/CcyTLMfOSwTOHod2+FXhilsKg5Tz+kGG+P8P47yjnOyH8kpypV5rbVce7k78pE5S9GJ6I=
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr4454336lfk.575.1656569281122; Wed, 29
 Jun 2022 23:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com>
 <20220629195123.610eed9f@kernel.org>
In-Reply-To: <20220629195123.610eed9f@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:07:50 +0800
Message-ID: <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 30 Jun 2022 10:08:04 +0800 Jason Wang wrote:
> > +static void enable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = true;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> > +static void disable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = false;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                   struct virtqueue *vq)
> >  {
> > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >       }
> >
> >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > -                     schedule_delayed_work(&vi->refill, 0);
> > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > +                     spin_lock(&vi->refill_lock);
> > +                     if (vi->refill_work_enabled)
> > +                             schedule_delayed_work(&vi->refill, 0);
> > +                     spin_unlock(&vi->refill_lock);
>
> Are you sure you can use the basic spin_lock() flavor in all cases?
> Isn't the disable/enable called from a different context than this
> thing here?

This function will only be called in bh so it's safe.

>
> The entire delayed work construct seems a little risky because the work
> may go to sleep after disabling napi, causing large latency spikes.

Yes, but it only happens on OOM.

> I guess you must have a good reason no to simply reschedule the NAPI
> and keep retrying with GFP_ATOMIC...

Less pressure on the memory allocator on OOM probably, but it looks
like an independent issue that might be optimized in the future.

>
> Please add the target tree name to the subject.

Ok

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
