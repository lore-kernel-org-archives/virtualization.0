Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A2EE7AD77
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 16:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A02240C0C;
	Tue,  3 Oct 2023 16:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A02240C0C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NOoo/6fJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3c4Gr2nlHdg3; Tue,  3 Oct 2023 16:26:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7976F40182;
	Tue,  3 Oct 2023 16:26:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7976F40182
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50C33C0071;
	Tue,  3 Oct 2023 16:26:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54148C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C0A640182
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C0A640182
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IYns4_XVI4g
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:26:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE31B40C0C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE31B40C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696350401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
 b=NOoo/6fJ3170rXdairdt6Xromr2o9TLpP4aTj7JqNwwWw3Lh6bsORkUlz6M5vYu2KT7SVh
 qUhcC1vML/Vu1vDFsxJ7b98afZ8swHtE53l/MS/7bG+ZELVRnBcIz0UkAZftMZKqCaUcFS
 Orc9Ya4C0HVtBKegcHBF63XXPU697jU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-pv7yY1N1M72syjB4Vm6Trg-1; Tue, 03 Oct 2023 12:26:40 -0400
X-MC-Unique: pv7yY1N1M72syjB4Vm6Trg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41957273209so12846031cf.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 09:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350400; x=1696955200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
 b=ND2Ii11obN9uU8JR1UktRY1vfXkhGZYhF5p6s75LPxQB2QRhoJekt4q49zHCcTWn3N
 mCKuaUPpdKdsi3fMfpzmNGupRN90STdxWLo9XNwUl5wTQx3HBOX1QwjJ95kwCk5RLTCm
 jcuANVByk5BYnxKSc/RWKmC6twObaEECscGSH2PZUIFSmLeTY6OumqU0C1XIHCqOyirc
 Uw7Ok2zh7VMM7VwVxNbJVuw6sI6yc1vXhAdOg9xahES41f1VghATH+P7bv/1nWrVjIAP
 +T70zvgmMqBbrSW1bBtT0n0OuDJvLjjILbqPBOvuBgYycOF6FW5uWi/eYJdpGzRXYAS3
 xtMg==
X-Gm-Message-State: AOJu0Yy/EXOKkBE7AjLtF3zJEBQSyIPtkYI5Ubpf3KUDssi7AnwPZhgs
 wqtwbvxjJpeWsWywkE5N5yy5DbbUVKJ5UsVYXwMFIpUCr3vVlyVR5JtJYtsGCBIZn1kDwdpQfP8
 HdQCbC33H4ktYYWt3TZx29CZdxp/nsfkCnuPiLpNGVQ==
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id
 h11-20020ac8584b000000b004121e0a772amr15546007qth.17.1696350399947; 
 Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFht7odWq29a5TBcW7tc++EJIJSk2vinTPEHJlpdDK6A2y2BG7b5sXjcJoBiiC5Txm/f/rEtA==
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id
 h11-20020ac8584b000000b004121e0a772amr15545983qth.17.1696350399671; 
 Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 e13-20020ac8130d000000b004196a813639sm557692qtj.17.2023.10.03.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:26:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <4nwo6nd2ihjqsoqnjdjhuucqyc4fhfhxk52q6ulrs6sd2fmf7z@24hi65hbpl4i>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Arseniy,

On Sun, Oct 01, 2023 at 12:02:56AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=236f3873b517acfaf949c23bb2d5dec13bfd2da2
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

Thanks for this new version.
I started to include vsock_uring_test in my test suite and tests are
going well.

I reviewed code patches, I still need to review the tests.
I'll do that by the end of the week, but they looks good!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
