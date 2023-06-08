Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F96C7EE29
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 08:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AD6D6140C;
	Thu,  8 Jun 2023 08:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AD6D6140C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=egynQLeb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUz_T6yRkzhu; Thu,  8 Jun 2023 08:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F7F0613EF;
	Thu,  8 Jun 2023 08:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F7F0613EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2823BC0089;
	Thu,  8 Jun 2023 08:00:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DC0C0037
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E402C41F45
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E402C41F45
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=egynQLeb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vph9escj8myX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B38B841F43
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B38B841F43
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686211212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNDbmGsJ3mpkLEzox86FiotwEXbzoL7gRModpMEFp+s=;
 b=egynQLebi2sH3JBGuZpLXxM6hNkNgGa+JZL4uCkdVoY7PQ4zrq3VBbRlHs5sEFvOyMGHfF
 8JNhH9sXOkbZLJ6sDZ4fP0ebqSm5YQkcirWdvSBT6TX5LBYQqJJQ6g4R+4dmc8vbpHJogs
 89Ox/7EKDAzRf1z/PlQV+J/ucc8BNh0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-iwdOwffEN5uosLBEeEeBHA-1; Thu, 08 Jun 2023 04:00:11 -0400
X-MC-Unique: iwdOwffEN5uosLBEeEeBHA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-974566553ccso49643366b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 01:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686211210; x=1688803210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNDbmGsJ3mpkLEzox86FiotwEXbzoL7gRModpMEFp+s=;
 b=kqgxiUl0BgR7tM9TdCGgcPSXBcpBkUiX+sMBka0YhXIjJhX+5MmDABOTt651fhKiC8
 ypdO60kKsFGt25HqU7Vf+eW4nXdOquR7vMHUztvo6YnFd8CSONbEuYU2sHaFEGKZZQxD
 ZEhfsXPX3D5DxBzPgv87/0JS6qlZmLohxjjWuxcGQ59xLzV8VLq1wuof6m/S5Mgn9rIe
 2tlN2+xEoALLi7sij6vZajbr+X/LdDleLP9u35y9AKEh4WkusccaEC3sb8R+5irqbCaA
 DQp+CPlZDdGKTD13+WHtoozVZVgcq7KmTdt9rv2segHpooFxSxKp3XBu9/hueO6qy/hx
 w9AA==
X-Gm-Message-State: AC+VfDyFQMZCeC5WS2xNmBq3iNzq06n5lecJlBM6Eaopo7B00pLDJl0b
 Tv6LNX43xeA4lreToKBm3MpXzqnzdDHnU1l7dAajSncqY+OmOG5w9K29m/cHXQEqRux31TXxxy/
 se5+2O9u+wUMywN8kHTnTFRrgx8ofyHA9e/rTJRpwvw==
X-Received: by 2002:a17:907:e92:b0:978:9b09:ccaf with SMTP id
 ho18-20020a1709070e9200b009789b09ccafmr1684179ejc.14.1686211209895; 
 Thu, 08 Jun 2023 01:00:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iYx/Ymtxl9ZzpcCCqLWJ3wFdcVDKXynlxsTc5fgKIP2plln1Gn+TgS5Yvth3Zl/mptkx4nQ==
X-Received: by 2002:a17:907:e92:b0:978:9b09:ccaf with SMTP id
 ho18-20020a1709070e9200b009789b09ccafmr1684157ejc.14.1686211209532; 
 Thu, 08 Jun 2023 01:00:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it.
 [87.12.25.111]) by smtp.gmail.com with ESMTPSA id
 jt26-20020a170906dfda00b00978993e0d21sm351480ejc.78.2023.06.08.01.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 01:00:08 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:59:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
References: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 08, 2023 at 03:46:00PM +0800, Jason Wang wrote:

[...]

>> > > > > I have a question though, what if down the road there
>> > > > > is a new feature that needs more changes? It will be
>> > > > > broken too just like PACKED no?
>> > > > > Shouldn't vdpa have an allowlist of features it knows how
>> > > > > to support?
>> > > >
>> > > > It looks like we had it, but we took it out (by the way, we were
>> > > > enabling packed even though we didn't support it):
>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6234f80574d7569444d8718355fa2838e92b158b
>> > > >
>> > > > The only problem I see is that for each new feature we have to modify
>> > > > the kernel.
>> > > > Could we have new features that don't require handling by vhost-vdpa?
>> > > >
>> > > > Thanks,
>> > > > Stefano
>> > >
>> > > Jason what do you say to reverting this?
>> >
>> > I may miss something but I don't see any problem with vDPA core.
>> >
>> > It's the duty of the parents to advertise the features it has. For example,
>> >
>> > 1) If some kernel version that is packed is not supported via
>> > set_vq_state, parents should not advertise PACKED features in this
>> > case.
>> > 2) If the kernel has support packed set_vq_state(), but it's emulated
>> > cvq doesn't support, parents should not advertise PACKED as well
>> >
>> > If a parent violates the above 2, it looks like a bug of the parents.
>> >
>> > Thanks
>>
>> Yes but what about vhost_vdpa? Talking about that not the core.
>
>Not sure it's a good idea to workaround parent bugs via vhost-vDPA.

Sorry, I'm getting lost...
We were talking about the fact that vhost-vdpa doesn't handle
SET_VRING_BASE/GET_VRING_BASE ioctls well for packed virtqueue before
that series [1], no?

The parents seem okay, but maybe I missed a few things.

[1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/

>
>> Should that not have a whitelist of features
>> since it interprets ioctls differently depending on this?
>
>If there's a bug, it might only matter the following setup:
>
>SET_VRING_BASE/GET_VRING_BASE + VDUSE.
>
>This seems to be broken since VDUSE was introduced. If we really want
>to backport something, it could be a fix to filter out PACKED in
>VDUSE?

mmm it doesn't seem to be a problem in VDUSE, but in vhost-vdpa.
I think VDUSE works fine with packed virtqueue using virtio-vdpa
(I haven't tried), so why should we filter PACKED in VDUSE?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
