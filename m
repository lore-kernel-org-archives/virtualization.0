Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786D0C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:21:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3313760EB5
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3313760EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAFD2401CD;
	Mon,  2 Aug 2021 20:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgVrWmaVqVnX; Mon,  2 Aug 2021 20:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9225A40184;
	Mon,  2 Aug 2021 20:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6B7C001A;
	Mon,  2 Aug 2021 20:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA09CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8DC3405F0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fvr9VTWSxXVL
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:21:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84C98405EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627935706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZJ2bhBWwA0LZ+VBVsgySygKSYSWVNXAFAku40qnCTw=;
 b=TSMkvdt4shB6KZDXbcp/BXP1odrk/5Bjy9DMAxIecnRrDRnT6sMgZjCEHnUfgTEak/AhRd
 7S1EQuOrHT19Hu86mxEa44P6YT7kzn6pOJlSp5kmFVEx1NjkNfT1Wav5VbwhhGptfPQ97p
 qZiVQ0+VlCgfp0HiN32PErTbs8rP1Hg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-uqoEeu1HNwCg_eyPyq92PA-1; Mon, 02 Aug 2021 16:21:43 -0400
X-MC-Unique: uqoEeu1HNwCg_eyPyq92PA-1
Received: by mail-ed1-f69.google.com with SMTP id
 d12-20020a50fe8c0000b02903a4b519b413so9369900edt.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 13:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nZJ2bhBWwA0LZ+VBVsgySygKSYSWVNXAFAku40qnCTw=;
 b=Uve3jfOHGon7h5GzLgsHTElAN024AjKA+rRku0mK3ytNKa46Gtyc1yDB3AciZGW5ui
 ZdjzIoN8T8aFs71OjFGYaIEw5shYZvIRVa6aCQVKEuiEKN8I2VJ2pkA3KM40TH4q/ZQX
 XgYCa0TLuOGhNKNKhpJfXKF8w+P7ibreaAtE1oD4WyI6qtkI1d1ywlHMq18AvVsvN0Dq
 cyYRanERSRLy8sg4N7RIWebsGehYNAnFAkvFFrYSVJwfbqwHPAiqr41XM8nvXZ/HtYN3
 LrjXyA/R1WQzwt6sp9lYnIdONXJvSg5o3qTu7PJtjxQsF/XPhU9YCx3aT5pod7izDbk8
 TdaA==
X-Gm-Message-State: AOAM531A89pZdt0+OOKiLieBkpYzB8U2Il33uDZlxb9QDhYjJNWpoIiQ
 a4NHYkP7WavrAN/z/RUcdVhCtGdCsbu/YksWGb60a3xGoG+w/25qg76mIdFDS31JrxRo0X57Vio
 GZEpMVuNM8/Lic2UyWscZkbZ3Mg8ZwUrm1Mv3V9UeOA==
X-Received: by 2002:a05:6402:514e:: with SMTP id
 n14mr21858775edd.129.1627935702056; 
 Mon, 02 Aug 2021 13:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLxuoBXOKeZ2Gk3OBbPWhzbkg9zy7nptJari08wguyDBRuf7wpsWw8MvrrZcTEuWohqALx5A==
X-Received: by 2002:a05:6402:514e:: with SMTP id
 n14mr21858756edd.129.1627935701885; 
 Mon, 02 Aug 2021 13:21:41 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id k20sm5085851ejr.93.2021.08.02.13.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 13:21:41 -0700 (PDT)
Date: Mon, 2 Aug 2021 16:21:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: fuguancheng <fuguancheng@bytedance.com>
Subject: Re: [PATCH 0/4] Add multi-cid support for vsock driver
Message-ID: <20210802162038-mutt-send-email-mst@kernel.org>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210802120720.547894-1-fuguancheng@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, colin.king@canonical.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, davem@davemloft.net
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

On Mon, Aug 02, 2021 at 08:07:16PM +0800, fuguancheng wrote:
> This patchset enables the user to specify additional CIDS for host and
> guest when booting up the guest machine. The guest's additional CIDS cannot
> be repeated, and can be used to communicate with the host. The user can
> also choose to specify a set of additional host cids, which can be
> used to communicate with the guest who specify them. The original
> CID(VHOST_DEFAULT_CID) is still available for host. The guest cid field is
> deleted.
> 
> To ensure that multiple guest CID maps to the same vhost_vsock struct,
> a struct called vhost_vsock_ref is added.  The function of vhost_vsock_ref
> is simply used to allow multiple guest CIDS map to the
> same vhost_vsock struct.
> 
> If not specified, the host and guest will now use the first CID specified
> in the array for connect operation. If the host or guest wants to use
> one specific CID, the bind operation can be performed before the connect
> operation so that the vsock_auto_bind operation can be avoided.
> 
> Hypervisors such as qemu needs to be modified to use this feature. The
> required changes including at least the following:
> 1. Invoke the modified ioctl call with the request code
> VHOST_VSOCK_SET_GUEST_CID. Also see struct multi_cid_message for
> arguments used in this ioctl call.
> 2. Write new arguments to the emulated device config space.
> 3. Modify the layout of the data written to the device config space.
> See struct virtio_vsock_config for reference.
> 
> I have tested this setup with iperf3.  The communication between host
> and guest using original CID or additional CIDS worked normally.
> Not tested in extreme conditions where memory is insufficient.
> 
> Linux kernel newbies here, any suggestions are welcomed.
> Thanks in advance!

Could you supply a bit info about the motivation for this feature?
I wonder whether it's be better to have multiple VQs
instead of tweaking the CID in the message header.


> fuguancheng (4):
>   VSOCK DRIVER: Add multi-cid support for guest
>   VSOCK DRIVER: support communication using additional guest cid
>   VSOCK DRIVER: support specifying additional cids for host
>   VSOCK DRIVER: support communication using host additional cids
> 
>  drivers/vhost/vsock.c                   | 338 ++++++++++++++++++++++++++++----
>  include/net/af_vsock.h                  |   5 +
>  include/uapi/linux/vhost.h              |   9 +
>  include/uapi/linux/virtio_vsock.h       |   8 +-
>  net/vmw_vsock/af_vsock.c                |  28 ++-
>  net/vmw_vsock/virtio_transport.c        | 129 +++++++++++-
>  net/vmw_vsock/virtio_transport_common.c |   5 +-
>  net/vmw_vsock/vsock_loopback.c          |   8 +
>  8 files changed, 471 insertions(+), 59 deletions(-)
> 
> -- 
> 2.11.0
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
