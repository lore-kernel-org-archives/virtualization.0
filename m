Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69825C19F2A
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 13:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0EB082AC8;
	Sun,  7 Aug 2022 13:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0EB082AC8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3wQz7IE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISYct8BYsy31; Sun,  7 Aug 2022 13:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7317582A7F;
	Sun,  7 Aug 2022 13:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7317582A7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB6BC0033;
	Sun,  7 Aug 2022 13:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92FE4C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D45340475
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:35:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D45340475
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3wQz7IE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8IdltHfsrXWj
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B17A400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B17A400B9
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659879315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUQoZ+Z3T3noJLGRnWhyvuGBcgQof1Le7Re/cjImcLw=;
 b=O3wQz7IEr8AyBH53UrbV+N8ZjvDixx5BvWma5nwK5jFNyc7Mc/+WbYJC/u6g19I1FCDPPu
 1EnEv2RqHwnL7sHpkr8VZd50AGh6QIK83NDRu22IxoS77aXwmPGtD37tczYgibRgcTCwOc
 OIeR7hJ/tKGRSXFZm0XazeaxtRD0f/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-fkJuVQQiOQuQ2-1wBWR7IA-1; Sun, 07 Aug 2022 09:35:14 -0400
X-MC-Unique: fkJuVQQiOQuQ2-1wBWR7IA-1
Received: by mail-wm1-f72.google.com with SMTP id
 v64-20020a1cac43000000b003a4bea31b4dso6958288wme.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Aug 2022 06:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=kUQoZ+Z3T3noJLGRnWhyvuGBcgQof1Le7Re/cjImcLw=;
 b=XmLS6+vZF1CfTP5oANoNsmv7u2Ww9rkxdbq/BLU+GZ5EcVeKrbTL+S5d57oyLbfSDS
 v0GG7Xuq1KzPxce/uv+rNqKLvbZsQd/LJvqougVg37GhINWnONokfcO13mApFUB5jGgK
 fBl7Rp6TozNj6AmWly/ZD6iyvq9D5zL1vATmLfHq+P7hJTL3cfG9iVsBw4PatFoQpUvW
 TMEveFPITzgZgxQQAM/DDwlc831NRNz6Jqev3X3ZsGOMJ7BehwpxK7Xa1Gk/m4sIqTZl
 Bx8ZrvnSoe7i/DYa91L+HIhtj2HyycFaA21PIjOuwfcG3GtDH/O3KD0PbVBoLdYTTB1x
 qNpQ==
X-Gm-Message-State: ACgBeo2w6woJbHIPWJjvxKKNbyaYnFqr559jZfEcHJJavO/aiS0zSioe
 W7/WMTqxqqKt1zGXReEr2VxysL22eDrCN042l0GfvAhHWCeqrOKjxsFf0OFONtJI+XgpJN3xmad
 ilrcjo02MATSFZnu2dkIDQ6WnK4hHWrUIqn+SCrXlCA==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id
 r7-20020a05600c35c700b003a32612f823mr9706775wmq.33.1659879313165; 
 Sun, 07 Aug 2022 06:35:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6b3gJMHnoTNtj37IngASsHIWEjuA+66KHlhEYj9gzwpL5gbhYjiJ9U3VuycAq+eyh6uwiMbA==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id
 r7-20020a05600c35c700b003a32612f823mr9706761wmq.33.1659879312980; 
 Sun, 07 Aug 2022 06:35:12 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 y12-20020adfdf0c000000b0021f138e07acsm8993628wrl.35.2022.08.07.06.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Aug 2022 06:35:12 -0700 (PDT)
Date: Sun, 7 Aug 2022 09:35:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220807092733-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
 <Yu9hHef3VawCbJT9@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Yu9hHef3VawCbJT9@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 Linus Torvalds <torvalds@linux-foundation.org>, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 ascull@google.com, stefanha@redhat.com, maz@kernel.org,
 Will Deacon <will@kernel.org>
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

On Sat, Aug 06, 2022 at 11:52:13PM -0700, Christoph Hellwig wrote:
> It really is vhost that seems to abuse it so that if the guest
> claims it can handle VIRTIO_F_ACCESS_PLATFORM (which every modern
> guest should) it enables magic behavior, which I don't think is what
> the virtio spec intended.

Well the magic behavour happens to be used by QEMU to
implement a virtual IOMMU. And when you have a virtual
IOMMU you generally want VIRTIO_F_ACCESS_PLATFORM.
This is how it came to be reused for that.

And since QEMU never passed guest features to vhost
unfiltered we never saw the issue even with old QEMU
versions on new kernels.

It seems natural to pass features unfiltered and we never even said
userspace should not do it, so it's quite understandable that this is
what corsvm did.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
