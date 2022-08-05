Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC665C00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 16:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2051541D99;
	Fri,  5 Aug 2022 16:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2051541D99
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=asfYgS+L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dA7D0QOFNuBo; Fri,  5 Aug 2022 16:05:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A72641D8B;
	Fri,  5 Aug 2022 16:05:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A72641D8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADECBC0033;
	Fri,  5 Aug 2022 16:05:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBDDC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 16:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49B3D60B34
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 16:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49B3D60B34
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=asfYgS+L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-gEJI6SfuGJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 16:05:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53A21605BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53A21605BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659715540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KO2+Lhn1y2XnVi7bI4Cc5ciAkJZHya2Xso0bWfCh5JA=;
 b=asfYgS+LNK+c7OobwJ43vYVFp1dTTK4pR7dzyZvc5SkdUhABvQscgEH5YtMCiEMp/3DW/O
 z8zEYNgwtr/W9HFj1mtwbh7JdJOpDCBl+PY8UA0+PDuWYXXUjTJXRauU6jt9eM+ZF2ohhs
 gm00aj/bRF/E24eduiU3/MWU/L2bjp4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-YhJWEeMgMXCvfiktBjeQYA-1; Fri, 05 Aug 2022 12:05:39 -0400
X-MC-Unique: YhJWEeMgMXCvfiktBjeQYA-1
Received: by mail-qk1-f200.google.com with SMTP id
 n15-20020a05620a294f00b006b5768a0ed0so2281822qkp.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Aug 2022 09:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=KO2+Lhn1y2XnVi7bI4Cc5ciAkJZHya2Xso0bWfCh5JA=;
 b=MbpLMuQ1oLN2b9kqp0qHBvc+mBBGGO8VBojPtr1lzrUQQdgj7Dn5C9EbmV/wW2iPuc
 0nPJlfDUInB1q0Nu4AB8T22KwDblUvHkApS11w/1b0Uhr/fCsY4rk/izzuhCu28TCRVn
 Y+ujkKEleAIASqNfwHgKi0XC+ORxnQpDvcshU7I567IsLxw1brHsbsvOXCbRQwmZsaBH
 NUs+4rod7yMntz213p03qx8pcIWGgPvxzYUO8Uu0d+nJmTyTTyjky183MUMiMTU/bAtI
 12799zGXUtX8RgwYUa5BzVrgO2o84IG6+14kObuwIkM/Te+rru1qUZLSv3PLIU7ls/G5
 vBJA==
X-Gm-Message-State: ACgBeo1gE/b8VeIBQlHKC/uusPsOAivGwh39epOX1i7o46FIWgYwv9kw
 9wmez1AALFf97VESIXGfl4DWJ4j/2/EFOe7QNOGUlhWvN4lF5oWTBERh2jKWJ+Xxx2aOKutxF3p
 mNesYtJsO0ikOC8erZMV2gdoxbVvq1N8OPSLzqKKRDQ==
X-Received: by 2002:ad4:5ce3:0:b0:474:71c0:adf3 with SMTP id
 iv3-20020ad45ce3000000b0047471c0adf3mr6391531qvb.47.1659715538468; 
 Fri, 05 Aug 2022 09:05:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6V/dJ4FYdWc2pXQmkRsGFLohJ8WPMbtbN/X/1uVIpxzDhT0pzdU07XUiuvIlyTbScoDMAaoA==
X-Received: by 2002:ad4:5ce3:0:b0:474:71c0:adf3 with SMTP id
 iv3-20020ad45ce3000000b0047471c0adf3mr6391470qvb.47.1659715538111; 
 Fri, 05 Aug 2022 09:05:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 z9-20020a05622a028900b003422c7ccbc5sm2577102qtw.59.2022.08.05.09.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Aug 2022 09:05:37 -0700 (PDT)
Date: Fri, 5 Aug 2022 18:05:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220805160528.4jzyrjppdftrvdr5@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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
sorry but I didn't have time to review this series. I will definitely do 
it next Monday!

Have a nice weekend,
Stefano

On Wed, Aug 03, 2022 at 01:48:06PM +0000, Arseniy Krasnov wrote:
>Hello,
>
>This patchset includes some updates for SO_RCVLOWAT:
>
>1) af_vsock:
>   During my experiments with zerocopy receive, i found, that in some
>   cases, poll() implementation violates POSIX: when socket has non-
>   default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>   POLLRDNORM bits in 'revents' even number of bytes available to read
>   on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>   POLLIN flag and then tries to read data(for example using  'read()'
>   call), but read call will be blocked, because  SO_RCVLOWAT logic is
>   supported in dequeue loop in af_vsock.c. But the same time,  POSIX
>   requires that:
>
>   "POLLIN     Data other than high-priority data may be read without
>               blocking.
>    POLLRDNORM Normal data may be read without blocking."
>
>   See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>
>   So, we have, that poll() syscall returns POLLIN, but read call will
>   be blocked.
>
>   Also in man page socket(7) i found that:
>
>   "Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>   socket as readable only if at least SO_RCVLOWAT bytes are available."
>
>   I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>   uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>   this case for TCP socket, it works as POSIX required.
>
>   I've added some fixes to af_vsock.c and virtio_transport_common.c,
>   test is also implemented.
>
>2) virtio/vsock:
>   It adds some optimization to wake ups, when new data arrived. Now,
>   SO_RCVLOWAT is considered before wake up sleepers who wait new data.
>   There is no sense, to kick waiter, when number of available bytes
>   in socket's queue < SO_RCVLOWAT, because if we wake up reader in
>   this case, it will wait for SO_RCVLOWAT data anyway during dequeue,
>   or in poll() case, POLLIN/POLLRDNORM bits won't be set, so such
>   exit from poll() will be "spurious". This logic is also used in TCP
>   sockets.
>
>3) vmci/vsock:
>   Same as 2), but i'm not sure about this changes. Will be very good,
>   to get comments from someone who knows this code.
>
>4) Hyper-V:
>   As Dexuan Cui mentioned, for Hyper-V transport it is difficult to
>   support SO_RCVLOWAT, so he suggested to disable this feature for
>   Hyper-V.
>
>Thank You
>
>Arseniy Krasnov(9):
> vsock: SO_RCVLOWAT transport set callback
> hv_sock: disable SO_RCVLOWAT support
> virtio/vsock: use 'target' in notify_poll_in callback
> vmci/vsock: use 'target' in notify_poll_in callback
> vsock: pass sock_rcvlowat to notify_poll_in as target
> vsock: add API call for data ready
> virtio/vsock: check SO_RCVLOWAT before wake up reader
> vmci/vsock: check SO_RCVLOWAT before wake up reader
> vsock_test: POLLIN + SO_RCVLOWAT test
>
> include/net/af_vsock.h                       |   2 +
> net/vmw_vsock/af_vsock.c                     |  38 +++++++++-
> net/vmw_vsock/hyperv_transport.c             |   7 ++
> net/vmw_vsock/virtio_transport_common.c      |   7 +-
> net/vmw_vsock/vmci_transport_notify.c        |  10 +--
> net/vmw_vsock/vmci_transport_notify_qstate.c |  12 +--
> tools/testing/vsock/vsock_test.c             | 107 +++++++++++++++++++++++++++
> 7 files changed, 166 insertions(+), 17 deletions(-)
>
> Changelog:
>
> v1 -> v2:
> 1) Patches for VMCI transport(same as for virtio-vsock).
> 2) Patches for Hyper-V transport(disabling SO_RCVLOWAT setting).
> 3) Waiting logic in test was updated(sleep() -> poll()).
>
> v2 -> v3:
> 1) Patches were reordered.
> 2) Commit message updated in 0005.
> 3) Check 'transport' pointer in 0001 for NULL.
> 4) Check 'value' in 0001 for > buffer_size.
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
