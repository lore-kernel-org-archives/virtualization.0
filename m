Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9212CCA47B
	for <virtualization@archiver.kernel.org>; Mon, 11 Jul 2022 06:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B2B460E9D;
	Mon, 11 Jul 2022 06:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B2B460E9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZHkVAr4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVb97fAVtqDo; Mon, 11 Jul 2022 06:02:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DB0860E9C;
	Mon, 11 Jul 2022 06:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DB0860E9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7886EC0035;
	Mon, 11 Jul 2022 06:02:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2209C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 06:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5FE482CCA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 06:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5FE482CCA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZHkVAr4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1VR6WqS3QWA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 06:02:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 239DA82CC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 239DA82CC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jul 2022 06:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657519364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPpLorO2rdtW+7ERxebnrugmQ1/TNad30addhYPoqwM=;
 b=ZZHkVAr4QWRSkMKQ1c/iChpmlTX/Qw9df8Esrh6a9r6pyv39SERB49flZM/60kv8ynF4lM
 a585AaKinh34yIUKg5eOmdydsXtM/V/X7B/Wp13U7ETZDKIAwUu2dzI7OQrFFarpQbHpO2
 pRvfRJSRjdcKZ6taXBlXn4kAKAmRB9Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-ec8mEdDDN_asOsDuPW3JHQ-1; Mon, 11 Jul 2022 02:02:40 -0400
X-MC-Unique: ec8mEdDDN_asOsDuPW3JHQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 h21-20020a2e9ed5000000b0025d516572f4so633103ljk.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Jul 2022 23:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cPpLorO2rdtW+7ERxebnrugmQ1/TNad30addhYPoqwM=;
 b=APsvCPIy9RHEkJ7xhLoK0K9m0k0XOsG1c80AEbok0kEYIwOIyow5IjSCUaNmYtegcz
 i9zzLHbvYiVpXYTykrC1JYMg1egHqpABxoMujmKqDO1jflLmGdfPtqCPT72cNdRx7APg
 YQuM4uLul06hE+X+WrUicBWTJPl89J4hjeimg9IBXqSZVXH0XUiyQpt31I1X97hcTBng
 VyEQt3K5gyDUcxBath56PzfpjTtMS5i6bnERcw1Ibz3fLF7ZmH4qmWCkJqzr9GK5FIsb
 fRHJIwexJwbRx7Q3IJDau+fv0xW6XaFaIaw4Z63iUBOev0VrEWqpe+tjEszVLIe47p1z
 gxNA==
X-Gm-Message-State: AJIora/gqHAGBDUIovyY+wb539s/9BfkrUqt2NmqMHVck5HACjUardoE
 PWqwcMEP6+TMh7qGfnV2jgxkz6HxbXMkJGtmJ85kxj8Cyzl46G30fZk/niQeYASwXCq0VV7Xe//
 56fvUIE7GPhWkpsufH28K2hWs1VoS0tmMbtLzbq+NzsKmVXWzUp1sVZDZEg==
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr9288691ljk.130.1657519359302; 
 Sun, 10 Jul 2022 23:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vEQf80zZEme7a96P6lbGDOU+FIN1C2Bhdeho5yTVrdDF55JmNzKCj7M+hCoNmNGuKg9g45YqTOTNelpJflbX4=
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr9288677ljk.130.1657519359122; Sun, 10
 Jul 2022 23:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
 <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
 <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
In-Reply-To: <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Jul 2022 14:02:27 +0800
Message-ID: <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To: Yongji Xie <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
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

On Fri, Jul 8, 2022 at 5:53 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Jul 8, 2022 at 4:38 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > > > registering and de-registering userspace memory for IOTLB
> > > > > as bounce buffer in virtio-vdpa case.
> > > > >
> > > > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > > > information such as bounce buffer size. Then user can use
> > > > > those information on VDUSE_IOTLB_REG_UMEM and
> > > > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > > > userspace memory for IOTLB.
> > > > >
> > > > > During registering and de-registering, the DMA data in use
> > > > > would be copied from kernel bounce pages to userspace bounce
> > > > > pages and back.
> > > > >
> > > > > With this feature, some existing application such as SPDK
> > > > > and DPDK can leverage the datapath of VDUSE directly and
> > > > > efficiently as discussed before [1][2]. They can register
> > > > > some preallocated hugepages to VDUSE to avoid an extra
> > > > > memcpy from bounce-buffer to hugepages.
> > > >
> > > > This is really interesting.
> > > >
> > > > But a small concern on uAPI is that this seems to expose the VDUSE
> > > > internal implementation (bounce buffer) to userspace. We tried hard to
> > > > hide it via the GET_FD before. Anyway can we keep it?
> > > >
> > >
> > > Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> > > field to indicate whether a IOVA region supports userspace memory
> > > registration. Then userspace can use
> > > VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> > > userspace memory for this IOVA region.
> >
> > Looks better.
> >
>
> OK.
>
> > > Any suggestions?
> >
> > I wonder what's the value of keeping the compatibility with the kernel
> > mmaped bounce buffer. It means we need to take extra care on e.g data
> > copying when reg/reg user space memory.
> >
>
> I'm not sure I get your point on the compatibility with the kernel
> bounce buffer. Do you mean they use the same iova region?

Yes.

>
> The userspace daemon might crash or reboot. In those cases, we still
> need a kernel buffer to store/recover the data.

Yes, this should be a good point.

>
> > Can we simply allow the third kind of fd that only works for umem registration?
> >
>
> Do you mean using another iova region for umem?

I meant having a new kind of fd that only allows umem registration.

>I think we don't need
> a fd in umem case since the userspace daemon can access the memory
> directly without using mmap() to map it into the address space in
> advance.

Ok, I will have a look at the code and get back.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
