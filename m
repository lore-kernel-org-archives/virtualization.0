Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A3FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 02:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94B5A80E26;
	Tue, 23 Nov 2021 02:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aV5bpwadkVLJ; Tue, 23 Nov 2021 02:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 323CE80E1C;
	Tue, 23 Nov 2021 02:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00EA5C002E;
	Tue, 23 Nov 2021 02:25:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90A4FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A10680E26
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ifqOGt6-7x5M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A823480E1C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637634336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DJKXXo5huA3qTYjotBCmHop1H83ADBgZQCZurCS2VDU=;
 b=iYqNtm5+27yKbWeOknChBh5NOCWKHrm3MZ4sQ85MZLt5LnaGAuS9s0FTTKcFt7y8fxDfQz
 7BANAmGiz1g8uQzzhuGsFHbTqzdOLoC30xlwohhvyOPttc0kHFFBfCvy+ZzX2zt7IdkJk0
 nQrNjIPEhLsZviHHskjIx4Rly2zCZo4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-R6jgBTkkMoSC95vOhBgzzQ-1; Mon, 22 Nov 2021 21:25:33 -0500
X-MC-Unique: R6jgBTkkMoSC95vOhBgzzQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 y40-20020a0565123f2800b003fded085638so13374593lfa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 18:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DJKXXo5huA3qTYjotBCmHop1H83ADBgZQCZurCS2VDU=;
 b=u14saZrRR4+QqtAaW1YFJk6SjVFwgB1/NcdbMdUAeBUVpsrqx1rdaOh8GD6ntoHsDn
 z62iZ4BAkVJMP10NRefk8L6D0NbGBt9WEarxb/748h5zjWqzcQMoNPw40jterIKTU6Od
 ifCkN7q6xULij5AucmYb4dE0sn2AsdK+JyPAt3mWGm/RdOA0wMRtAv4m8dPmmqhGB5E8
 jVdgMmO+Jwv+4/8t3/o/r3jBjIrbBIOOzIIme/9u+kMMm45vME83Wt7EmVniM/7U89pF
 anRq9omf0/FB4IGWk7gsBdz96iOWsMVHFr1oarvcWxPo8DCqs4fp2uZJgRoHP5riWhEw
 yzig==
X-Gm-Message-State: AOAM532ZRCQE/MEZy0ehQ9VrDw1U8vDEyFYcP2ugV/awpcqbTX4PJb0i
 5EdFDiMHNuE/i0v56gk5HiPTxAZn0LNOWPlziQkPxRodu20NGI+5otDGBecXj9+l/I7jEwxuDEv
 TS3q7+X35ev5ezfXwrfv/Fcqn59qlKe27dKXVC4xOvHATAZ8wArGtrAFUzg==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr1184067lfr.348.1637634331797; 
 Mon, 22 Nov 2021 18:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhbzfSpkWV2xGy6ErJZl4ZYscE/G0X2n8DtA51zeavG44zfVZ65TNtG3E6AVCF6h+nqefVVGDXVmsuTXxrt4w=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr1184043lfr.348.1637634331603; 
 Mon, 22 Nov 2021 18:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
In-Reply-To: <20211122212352.4a76232d.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 10:25:20 +0800
Message-ID: <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 22 Nov 2021 14:25:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > I think the fixes are:
> >
> > 1) fixing the vhost vsock
> > 2) use suppress_used_validation=true to let vsock driver to validate
> > the in buffer length
> > 3) probably a new feature so the driver can only enable the validation
> > when the feature is enabled.
>
> I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> feature. Frankly the set of such bugs is device implementation
> specific and it makes little sense to specify a feature bit
> that says the device implementation claims to adhere to some
> aspect of the specification. Also what would be the semantic
> of not negotiating F_DEV_Y_FIXED_BUG_X?

Yes, I agree. Rethink of the feature bit, it seems unnecessary,
especially considering the driver should not care about the used
length for tx.

>
> On the other hand I see no other way to keep the validation
> permanently enabled for fixed implementations, and get around the problem
> with broken implementations. So we could have something like
> VHOST_USED_LEN_STRICT.

It's more about a choice of the driver's knowledge. For vsock TX it
should be fine. If we introduce a parameter and disable it by default,
it won't be very useful.

>
> Maybe, we can also think of 'warn and don't alter behavior' instead of
> 'warn' and alter behavior. Or maybe even not having such checks on in
> production, but only when testing.

I think there's an agreement that virtio drivers need more hardening,
that's why a lot of patches were merged. Especially considering the
new requirements came from confidential computing, smart NIC and
VDUSE. For virtio drivers, enabling the validation may help to

1) protect the driver from the buggy and malicious device
2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
3) force the have a smart driver that can do the validation itself
then we can finally remove the validation in the core

So I'd like to keep it enabled.

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
