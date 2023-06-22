Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55679EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 15:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F071940643;
	Thu, 22 Jun 2023 15:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F071940643
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1YGZTQ2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 62cbVFZKcpK5; Thu, 22 Jun 2023 15:29:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6921540296;
	Thu, 22 Jun 2023 15:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6921540296
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA0BC0037;
	Thu, 22 Jun 2023 15:29:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79DC8C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5443F60E22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:29:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5443F60E22
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1YGZTQ2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbnhmBb8eFwQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:29:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D49960B3A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D49960B3A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687447756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
 b=g1YGZTQ2bnNNl4LPtYawqVPnuAHdN1imsIRwdbnaqfFhej4JTVY55fLjXxDyGSlfszihG+
 AIVBvc2ASAr4d7rDkRN/pKwKUZppdS5GvLUv5JVz/u9SAZ996K7x8eRa2gCn6TLbSbLJVD
 s+uSt6Ro4Z+IFYeRusJ+44cwQsHYui8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-hOjT8RLfObaO4Gg387AUOQ-1; Thu, 22 Jun 2023 11:29:15 -0400
X-MC-Unique: hOjT8RLfObaO4Gg387AUOQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31273e0507dso2042929f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687447753; x=1690039753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
 b=G4g9fm/g4x4x10WHWYStt7CzJDvbJoibShdLZXrUbdUPfLFalYT8dZOUXtjmiM4qdB
 XcfQbwOePKZyROZ+m4+kgNymougXSCK7CJIKNIPRW/zzr6+JXwyn70I6gDQdcLb/WdTi
 YEqd6tmHc/WjZ6eYAy8I25tLpUdE3e++zNgpBq+aRf9hW9LmcInjnnfGF/J+0UQ2mU+j
 3FtNiKAjO4J2+LVbXRQdTGw1QoRUXu1MeKLATXjZT7NDqCrHbFJoSEIgX1uDBbGDSt3Y
 OiFzqf06wa51VBzOeEK1AD2jlo8bTcGj3MZlw38Y6oBN6AAVF/fgw4FZIdnmMNW3vDJI
 aV6g==
X-Gm-Message-State: AC+VfDzxCIVxZQPGmJ/5ZPMCkgYKKI0rlo2aFA3Zm+G4ryrLf2bSJrNM
 /FnpXpY+xpmUbm2AF/zxbmhGVdN8Bw07FNIyXydFDjKwoJtKOwrNxFoZ2sDueS0aClTzPeVBsSV
 17P2TiQ7PHia/O22WoTdqzfsx15wu4kMnyH1i6oozvA==
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id
 v5-20020a5d4a45000000b0030fb9a292c5mr16230756wrs.49.1687447752863; 
 Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wJek32JccOCrkY+bAzshAWmkfVijJZJwTebxPvorEXZQJ+vqataOybeRtTQvOfMVty8q+6Q==
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id
 v5-20020a5d4a45000000b0030fb9a292c5mr16230739wrs.49.1687447752542; 
 Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b00307acec258esm7389420wro.3.2023.06.22.08.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:29:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 5/8] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <med476cdkdhkylddqa5wbhjpgyw2yiqfthvup2kics3zbb5vpb@ovzg57adewfw>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, Jiang Wang <jiang.wang@bytedance.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
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

On Sat, Jun 10, 2023 at 12:58:32AM +0000, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)

LGTM, but I'll give the R-b when we merge the virtio-spec.

Stefano

>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..9c25f267bbc0 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>
>-- 
>2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
