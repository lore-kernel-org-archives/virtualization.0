Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13985C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 09:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE3794151E;
	Tue, 21 Jun 2022 09:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE3794151E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MuLSNFge
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNgpXEVqtq9N; Tue, 21 Jun 2022 09:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C981414C7;
	Tue, 21 Jun 2022 09:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C981414C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9BC8C007A;
	Tue, 21 Jun 2022 09:34:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5408FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E70360D5E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E70360D5E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MuLSNFge
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wr5o0M5Gt5o
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:34:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34D43606A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34D43606A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655804079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rdnHvjh3c/TdBfAELRt/q8PZAC75UkXxMtsykTE+gc0=;
 b=MuLSNFgeQRBT49H4t8jiiIu3sv6M+QIAALsDOGdwQJalZK8PSGmR95HmMEZZFJyCFI0IOZ
 FEhxHNReS/hl4D9WzCt4rQWinsFfAqUzfvmXMFCAD5wOYRQDuaRzmh+3Fx+Q1KWLUg4duy
 nK3pq1q8ACzdvpqpD6m0v8UmP93Gl1Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-59i4UVC-MUeP6KyEeSigDQ-1; Tue, 21 Jun 2022 05:34:38 -0400
X-MC-Unique: 59i4UVC-MUeP6KyEeSigDQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 c12-20020a2ebf0c000000b00258e5e6e125so1664550ljr.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rdnHvjh3c/TdBfAELRt/q8PZAC75UkXxMtsykTE+gc0=;
 b=6TYjs4MrLQZVZsZoIrq6aH7hFnmnrYuM72CIUGgPQhEV87d+FjiqyNoXAIW6hMwxK8
 9KUo16wImZ5xMVYdqbjYSE1M+n71JWfSff0bqWKsyDltTrfxG87a+xPccu+W0gdDrMlp
 MWzHCj+5q9YMiXyY8m3NdUKQZ00svnvS2WuuTydHCk7AdR9Pvgaxp1OGAEqoN+u8YZOl
 KSEgfXsksIgmvDDpyRLTrw+MSUtbyvU3kXDYa3IARpJT9NyX0Iu2QI/aPOk8E5LChcOM
 MQeLWzMh0llbeSV26784PtUUX8RDelhCJ0KaYdyoTFWDjzIHK+QvQISJD8/DgcJEQ4Qh
 ULQQ==
X-Gm-Message-State: AJIora+weZKGwMf8GjwWbHEbqC1aXeqWX3FVD/RoBcG3KVu0AphowG9K
 IyTlDsIkVyg5YhV1TpGsIy15oXQr0LEffyJbQJI46lEAI7qkE7qhVYC/T0R5XZEjcssTuikfbqR
 OJ/XVpLGd5mVhkYHXAespEKGsglXL8dOuYrKESc16AyN/lRqT4QHqXA+oiw==
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr16283822lfb.238.1655804076822; 
 Tue, 21 Jun 2022 02:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvc4aS+o6BmysM9ZX2dC3UwcA6yK8pDUkRVJNA80xsBX7M610OWX2btmXntFaxgbxW5Bsc8Klk4dlvEGmCDTk=
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr16283813lfb.238.1655804076551; Tue, 21
 Jun 2022 02:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <64c567bc77c4fbe7bfe37467cc1c89d24a45c37a.camel@decadent.org.uk>
 <402bb9b5-7d6e-ed69-8b66-3ebefd80ff15@redhat.com>
In-Reply-To: <402bb9b5-7d6e-ed69-8b66-3ebefd80ff15@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jun 2022 17:34:25 +0800
Message-ID: <CACGkMEs45CCniTjbxr3OThdbG=Q4nGrm_11LLDfR4rRLetSx0A@mail.gmail.com>
Subject: Re: virtio_balloon regression in 5.19-rc3
To: David Hildenbrand <david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: debian-kernel@lists.debian.org, Ben Hutchings <ben@decadent.org.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Jun 21, 2022 at 5:24 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.22 20:49, Ben Hutchings wrote:
> > I've tested a 5.19-rc3 kernel on top of QEMU/KVM with machine type
> > pc-q35-5.2.  It has a virtio balloon device defined in libvirt as:
> >
> >     <memballoon model="virtio">
> >       <address type="pci" domain="0x0000" bus="0x05" slot="0x00" function="0x0"/>
> >     </memballoon>
> >
> > but the virtio_balloon driver fails to bind to it:
> >
> >     virtio_balloon virtio4: init_vqs: add stat_vq failed
> >     virtio_balloon: probe of virtio4 failed with error -5
> >
>
> Hmm, I don't see any recent changes to drivers/virtio/virtio_balloon.c
>
> virtqueue_add_outbuf() fails with -EIO if I'm not wrong. That's the
> first call of virtqueue_add_outbuf() when virtio_balloon initializes.
>
>
> Maybe something in generic virtio code changed?

Yes, we introduced the IRQ hardening. That could be the root cause and
we've received lots of reports so we decide to disable it by default.

Ben, could you please try this patch: (and make sure
CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set)

https://lore.kernel.org/lkml/20220620024158.2505-1-jasowang@redhat.com/T/

Thanks

>
> --
> Thanks,
>
> David / dhildenb
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
