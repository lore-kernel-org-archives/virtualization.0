Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2066CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 02:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CA6F607DD;
	Thu, 25 Nov 2021 02:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AnHQ2ncazUvQ; Thu, 25 Nov 2021 02:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CD82607D6;
	Thu, 25 Nov 2021 02:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8A7BC0038;
	Thu, 25 Nov 2021 02:28:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 420CCC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 02:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C5CD607DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 02:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HF9aelOFL9b1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 02:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48151607D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637807289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u113tr+XHgf/tPsn5GKDgoAmZjL+yOW8H+2x+NeaHKE=;
 b=IgJzVhOTDBQOgQuWrnIsmpAwpIeh7ETXO4Oc2vitNjbk+Ix3Aw0hAff5DAT9CV/5MLPmBO
 9BO3nNiUSzo8T/pgv6+AaX3pE8fwvCLLmve4u80hMkw/tBsfYxf1FDfXFgshmuER7/gVzO
 giA433S1wXhmSxSHScnPlJ8E6OnCzdg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-ItOHr6gtOh6igcsiXaTIOQ-1; Wed, 24 Nov 2021 21:28:07 -0500
X-MC-Unique: ItOHr6gtOh6igcsiXaTIOQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 bi30-20020a0565120e9e00b00415d0e471e0so2357831lfb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 18:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u113tr+XHgf/tPsn5GKDgoAmZjL+yOW8H+2x+NeaHKE=;
 b=DBH4sa+zV02eBuB48Nz8uwPFCGtLYDVpiift69Y8tNM+RMf1Y+JgfXVvtHJad0u54n
 TG8IpQkaKuyGyMdYyKVhwA92sJEvl7J9Cd/lrAXzrWktWh5CuUgfMEBm0LZj5NRZX7ns
 gN0o0mbX+lmiOMQIMItaz7JFoyX2I/rpJdz9uHvQLKz4VH2wFTNXLKlfqmtky5FPJJ1A
 lEd1UdOXjA/Rcw+aV5NJTMOwzGMVQN9fN0qI0HwxEoJON1v2WVxsPjN6n91n2PqAdFdI
 7bV7gNgoQl005HfnTV9oYf++0lSvA6nDfrJMZ43TFFP+Ea4uLd7iEJNjlEf6noNs/Bwb
 S6jA==
X-Gm-Message-State: AOAM530f9J7hyKberTV3SQYMG2ZW4V+4nC2eSgtqzPUXD7Nw6TngmUhT
 zJQiUurKaCpS1XyY4AIpiRaM0PlhF6FUKEkSveIAKaAKl/5Ckv9rfylSqw7yDJ08i3XzXJEbpyH
 kHIkp27X0iEMCcD9XEFV4vAGO+bSdzH+W+tKUfKiJnmaklpx1OVUsiGhe6w==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr20862648lfv.629.1637807286056; 
 Wed, 24 Nov 2021 18:28:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK6BuAse/hOVXKz3JLz0KL4b+eODJeYiAN6J8Ec/Tf+RixyxmjYUlG288A643B1Puvy2YR2z6eJwsu+kIw4bA=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr20862602lfv.629.1637807285742; 
 Wed, 24 Nov 2021 18:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
 <20211124123328.5ed9ce78.pasic@linux.ibm.com>
In-Reply-To: <20211124123328.5ed9ce78.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 10:27:54 +0800
Message-ID: <CACGkMEu1ZsUFt4_-R74+6JtqCr+swBzYVnQU3E+XympEcTv_CA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>, mcgrof@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Wed, Nov 24, 2021 at 7:33 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 24 Nov 2021 10:33:28 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > > breaking things by default, a warning might be a better choice for a
> > > > > couple of cycles.
> > >
> > > Ok, considering we saw the issues with balloons I think I can post a
> > > patch to use warn instead. I wonder if we need to taint the kernel in
> > > this case.
> >
> > Rethink this, consider we still have some time, I tend to convert the
> > drivers to validate the length by themselves. Does this make sense?
>
> I do find value in doing the validation in a single place for every
> driver. This is really a common concern. But I think, not breaking
> what used to work before is a good idea. So I would opt for producing
> a warning, but otherwise preserving old behavior unless there is an
> explicit opt-in for something more strict.

Yes, I totally agree with you after more thought and discussion.

>
> BTW AFAIU if we detect a problem here, there are basically two
> cases:
> (1) Either the device is over-reporting what it has written, or
> (2) we have a memory corruption in the guest because the device has
> written beyond the end of the provided buffer. This can be because
>   (2.1) the driver provided a smaller buffer than mandated by the spec,
>   or
>   (2.2) the device is broken.
>
> Case (1) is relatively harmless, and I believe a warning for it is more
> than appropriate. Whoever sees the warning should push for a fixed device
> if possible.

Yes.

>
> Case (2) is nasty. What would be the sanest course of action if we were
> reasonably sure we have have case (2.2)?

I think that's why a per driver validation is more preferable. The
driver can choose the comfortable action, e.g for networking it may
just drop the packets.

>
> Maybe we can detect case (2) with a canary. I.e. artificially extend
> the buffer with an extra descriptor that has a poisoned buffer, and
> check if the value of that poisoned buffer is different than poison. I'm
> not sure it is worth the effort though in production.

This might work but it might cause performance overhead. I still think
doing the validation per driver is better, the driver can choose to
fix the used length and taint the kernel anyway.

Thanks

>
> Regards,
> Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
