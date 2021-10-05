Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADEC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22176126A
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E22176126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5895402F1;
	Tue,  5 Oct 2021 07:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUsOKXu7Z251; Tue,  5 Oct 2021 07:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1058A4001F;
	Tue,  5 Oct 2021 07:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFD08C000F;
	Tue,  5 Oct 2021 07:53:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91B60C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D3DB60726
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJIfl9DbL261
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:53:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B78FD606E2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633420405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MQQUBfg6gmlUyb1M/tqnYV/yKo2UEgU362rTr4iyf0=;
 b=Ok8U0jtjgABcQ70MT4j4FTcoaGz7gLGiJ4KXKtoQ8HadDtvTGsP8gYHBY+NIxv6wuz4gAQ
 7ffxu2NETNii6Vo3DWRgfOB14ZpKvXCExUsYxWlnCLEnK0sxBd2J8/SQaAA6IxtuwmBXiG
 eRvYWJxu3Rte8v5zVZHoi/DBNdA5wlI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-Ckkd8TZeNEyY3OnDYoKfAA-1; Tue, 05 Oct 2021 03:53:22 -0400
X-MC-Unique: Ckkd8TZeNEyY3OnDYoKfAA-1
Received: by mail-ed1-f72.google.com with SMTP id
 c8-20020a50d648000000b003daa53c7518so19514249edj.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8MQQUBfg6gmlUyb1M/tqnYV/yKo2UEgU362rTr4iyf0=;
 b=bnty20XSBmVbZ5DAIO998tShUUN9/Mp1xNMrpG7uYCKx0p12tyRu8wVaDJf7LCpgU8
 qyV81FeLL+Bn3zv448ern4/nYQg1Q16enrp1nNimGbp/qoE8E3jkhVpwzS6mqqSi51aA
 6sZKlJqo+wLmWQbM4Rh8x4AI/yJnUpIq7QBDK00C20z7K9Dbf9rlA8DITzpSYDszH8X3
 pHZUBOaqNTz3mVGZ+0SDfAAL4jeDjRDswn+/06S3m4UQLAzxfLJMrerwy3BhJbjuZhIU
 nCmxhgn+ZVfuxNmqWbVXilw+FzjhM44DmjN5GvmxXNbr+REAwCtCKhlZtYT23kyZuOeo
 WcmQ==
X-Gm-Message-State: AOAM530nutN89/ijLW+bic/qLnQg8hX3Pn6sg3ZPmZ3RlXpUSg4GMmQS
 FYvMw/Au3I6lRkgle+Fpcvw0fIQ7Z60KzrI+EIqX4T+5e98PzNUHvSU09A2ndamzsxKeBef/hDj
 n5KzuYn3rvDfl7299fvcikDXbvPhRvOXiSk5pjS+36A==
X-Received: by 2002:a05:6402:35cb:: with SMTP id
 z11mr14610268edc.252.1633420401453; 
 Tue, 05 Oct 2021 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOHxXYAke10DbjPKeGoglSdZPOuPMBgTSaN3r5HKwcc031+p/zWsEEMu11Yvb7QTyz4BzKrw==
X-Received: by 2002:a05:6402:35cb:: with SMTP id
 z11mr14610244edc.252.1633420401312; 
 Tue, 05 Oct 2021 00:53:21 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id u6sm8260227edt.30.2021.10.05.00.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 00:53:20 -0700 (PDT)
Date: Tue, 5 Oct 2021 03:53:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005035014-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <20211005092539.145c9cc4.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211005092539.145c9cc4.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Tue, Oct 05, 2021 at 09:25:39AM +0200, Halil Pasic wrote:
> On Mon, 4 Oct 2021 09:11:04 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> > > >> {
> > > >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> > > >>     return virtio_is_big_endian(vdev);
> > > >> #elif defined(TARGET_WORDS_BIGENDIAN)
> > > >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > > >>         return false;
> > > >>     }
> > > >>     return true;
> > > >> #else
> > > >>     return false;
> > > >> #endif
> > > >> }
> > > >>   
> > > >
> > > > ok so that's a QEMU bug. Any virtio 1.0 and up
> > > > compatible device must use LE.
> > > > It can also present a legacy config space where the
> > > > endian depends on the guest.  
> > > 
> > > So, how is the virtio core supposed to determine this? A
> > > transport-specific callback?  
> > 
> > I'd say a field in VirtIODevice is easiest.
> 
> Wouldn't a call from transport code into virtio core
> be more handy? What I have in mind is stuff like vhost-user and vdpa. My
> understanding is, that for vhost setups where the config is outside qemu,
> we probably need a new  command that tells the vhost backend what
> endiannes to use for config. I don't think we can use
> VHOST_USER_SET_VRING_ENDIAN because  that one is on a virtqueue basis
> according to the doc. So for vhost-user and similar we would fire that
> command and probably also set the filed, while for devices for which
> control plane is handled by QEMU we would just set the field.
> 
> Does that sound about right?

I'm fine either way, but when would you invoke this?
With my idea backends can check the field when get_config
is invoked.

As for using this in VHOST, can we maybe re-use SET_FEATURES?

Kind of hacky but nice in that it will actually make existing backends
work...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
