Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB2EC43214
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 13:43:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF3560FC2
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 13:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FF3560FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E83C583AB9;
	Mon,  2 Aug 2021 13:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5RQQjtFmAcp; Mon,  2 Aug 2021 13:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 90EA983AC2;
	Mon,  2 Aug 2021 13:43:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 628C9C0010;
	Mon,  2 Aug 2021 13:43:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B099FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A006B40338
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyOSoz_REid6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC65F40337
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627911781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLB5Wppyf3HhgKlJbKvVGRoxW2c24dGzTvH4Hy2jF/Y=;
 b=C2dbVH+Lhs+mCnaFimGQfOuTjJAYXUB4EP0h5v8ubalBaeqqluItAB3KlhrLT3W+IoWVC/
 JDdeHe0wKEH7UGLudkEQv7ONe0MgnFNMcjZJZBS+cdV7o0b12eg+ObiJJwG/qiIpdCH+U4
 Oe6jDVh6Ct5BOHTp41LbmgAEuVadI/0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-e3-qIWnMNvaLjcN600ScDQ-1; Mon, 02 Aug 2021 09:43:00 -0400
X-MC-Unique: e3-qIWnMNvaLjcN600ScDQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 z20-20020a1709069454b0290595651dca8eso2324089ejx.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 06:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SLB5Wppyf3HhgKlJbKvVGRoxW2c24dGzTvH4Hy2jF/Y=;
 b=uYwilEiE5oS7ElyUGYm3TBp1yzb3JBmf71zD9JsSX/a1x0HT+WO/gJOuEhpoA/yq8R
 5PcdwWk7TohnRem8RSqXLu8z/0Tijl/fJSg060GSC/Dji72QU1KbHyCftWgJzmv6Sx/7
 uP2ULexe03Q/jJbyqKlZbcvOAP/ujCH17Ero0W8/CuupI6ye+zKmvSs5uKJSgGrB9N7j
 oSQ3676ECltmhTRVT1mQ3X3fhhsfrx36NzKClZCMf1kxSO879YwdvB/dYmEUi71McCjq
 7bPOEQFVMi+3EgZRJLk3hORXZ4R3i30i9yFhN9Dee1HtLqplVJDVrkFkhL0WefadNS2M
 eaqg==
X-Gm-Message-State: AOAM532cBRYcyXQBLwrFLtUJlS8XhxEtiLZo1Lyu0K+4LgKgl1GsUndK
 wJQN+IW+S3c8MP5UAHGCAWRTIwy4Kv84iTZWlusFkzx+hPDTghwJco4xLM8DlO89KuT371xwnVd
 0NP9xC32UyTmlsHhCRwy9OE6ffVynLJD7q8lDG/uooQ==
X-Received: by 2002:a17:906:b351:: with SMTP id
 cd17mr15955958ejb.36.1627911779588; 
 Mon, 02 Aug 2021 06:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw42KADDqSCxnBjQagyeBWMBJYH2GNJQ+isAlFVy8Aq7jtoj+DcyNpXJj2+GajVJYGf0thj9g==
X-Received: by 2002:a17:906:b351:: with SMTP id
 cd17mr15955937ejb.36.1627911779411; 
 Mon, 02 Aug 2021 06:42:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id oz31sm4545973ejb.54.2021.08.02.06.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 06:42:59 -0700 (PDT)
Date: Mon, 2 Aug 2021 15:42:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: fuguancheng <fuguancheng@bytedance.com>
Subject: Re: [PATCH 0/4] Add multi-cid support for vsock driver
Message-ID: <20210802134251.hgg2wnepia4cjwnv@steredhat>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210802120720.547894-1-fuguancheng@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 colin.king@canonical.com, kuba@kernel.org, arseny.krasnov@kaspersky.com,
 davem@davemloft.net
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

On Mon, Aug 02, 2021 at 08:07:16PM +0800, fuguancheng wrote:
>This patchset enables the user to specify additional CIDS for host and
>guest when booting up the guest machine. The guest's additional CIDS cannot
>be repeated, and can be used to communicate with the host. The user can
>also choose to specify a set of additional host cids, which can be
>used to communicate with the guest who specify them. The original
>CID(VHOST_DEFAULT_CID) is still available for host. The guest cid field is
>deleted.
>
>To ensure that multiple guest CID maps to the same vhost_vsock struct,
>a struct called vhost_vsock_ref is added.  The function of vhost_vsock_ref
>is simply used to allow multiple guest CIDS map to the
>same vhost_vsock struct.
>
>If not specified, the host and guest will now use the first CID specified
>in the array for connect operation. If the host or guest wants to use
>one specific CID, the bind operation can be performed before the connect
>operation so that the vsock_auto_bind operation can be avoided.
>
>Hypervisors such as qemu needs to be modified to use this feature. The
>required changes including at least the following:
>1. Invoke the modified ioctl call with the request code
>VHOST_VSOCK_SET_GUEST_CID. Also see struct multi_cid_message for
>arguments used in this ioctl call.
>2. Write new arguments to the emulated device config space.
>3. Modify the layout of the data written to the device config space.
>See struct virtio_vsock_config for reference.

Can you please describe a use case?

vsock was created to be zero configuration, we're complicating enough 
here, we should have a particular reason.

Also I gave a quick view and it seems to me that you change 
virtio_vsock_config, are you sure it works if one of the two peers 
doesn't support multiple CIDs?

Maybe we'd need a new feature bit, and we'd definitely need to discuss 
specification changes with virtio-comment@lists.oasis-open.org first.

How does the guest or host applications know which CIDs are assigned to 
them?

Please use the RFC tag if the patches are not in good shape.
Patches seem hard to review, please avoid adding code that is removed 
later (e.g.  multi_cid_message), and try not to break the backward 
compatibility.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
