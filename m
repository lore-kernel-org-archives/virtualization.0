Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5818EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 566FD40223;
	Thu,  6 Jul 2023 16:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 566FD40223
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuyoa+Vz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ojhx-f0DMWpb; Thu,  6 Jul 2023 16:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6E6140236;
	Thu,  6 Jul 2023 16:55:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6E6140236
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 812EBC0071;
	Thu,  6 Jul 2023 16:55:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 010F7C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC32561026
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC32561026
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iuyoa+Vz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLslI4ldZY89
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B07D60FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B07D60FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOCS7eTE+RzvcUp/IElOID7dnpR7b6985yidue+c0zc=;
 b=iuyoa+VzxkfbfDABiSz96nQzeP4lfQlIMKpIiI9wB3FD/Dy7avmXZcFsgk3lS9ocwrmEIl
 u8Xs8ELENFEmcCnSD27ne6Hnlg79amfsegZS4xQHaZRRKx7gVBGybXEqI8OFq4hW8tPK2G
 ixodnlTQ81shOIVhDYb6FkrrOXTVgJU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-GgO65vJqNtOgn_pcgwRE0A-1; Thu, 06 Jul 2023 12:55:29 -0400
X-MC-Unique: GgO65vJqNtOgn_pcgwRE0A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993c2d9e4a0so32352366b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662528; x=1691254528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOCS7eTE+RzvcUp/IElOID7dnpR7b6985yidue+c0zc=;
 b=DOEPTQUnOV2Xx30xnHugpCblbru9P8sEwUmmNPRgdbl4jFEjMvn2fj/REazVAmC2un
 7oCjoNuxz/g89yCH/a9pNcNaCvU+L1UEVyDUjO7DgfDaRzxvhZ3owumWuhK8qw+wmUki
 8JxG6qRFCGgxXFowTDwKZx6TWLKCXBJTMEaSbIDqH/ZziWVaUIp7ThxhMo1mXYNmcJDS
 vIb2NCMVdFpQJcaSq+g8QxzlZtE+84xgeTutKjjiXtw1ytNU/1hcLOoUSlKYPak1gISX
 SlV5Vrslyqs/CwyvHhNm0h+Xtna2AV4PWl/rQspX+o55fs38Ll05zeSmMm11x2a5lXwQ
 OxBg==
X-Gm-Message-State: ABy/qLbnfYgNVoKjuhWWDAlVydCgz0T5g51IH3nEYkrk6IHYasd+Uvty
 cxQLaPU1W62ZBmCBq+EQWReGuuVbsh9L/mr4TdKOck/LvJmWQkk1RKQv63WjcrPBV/UshE/Npzv
 VgpKOWmiyqM4si+chcLyBf3MCfWZnvtXgeeRtjnming==
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id
 m25-20020a17090672d900b009786e73e837mr1868719ejl.4.1688662527916; 
 Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvgZQm6ryvcWo+UUSqeryd0MPNi4F0BgqwURSiTTNmtxQQXekVmYt8i1lFjJmIZa8T3HBYkg==
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id
 m25-20020a17090672d900b009786e73e837mr1868706ejl.4.1688662527647; 
 Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 u20-20020a17090617d400b009829d2e892csm1060449eje.15.2023.07.06.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 10/17] vhost/vsock: support MSG_ZEROCOPY for
 transport
Message-ID: <3y3emmciqa5ymphc3n5nw3infyiuty65ia7i4movyfmq7rodqb@cethro3rcyf6>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-11-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-11-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:40AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for vhost transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index cb00e0e059e4..3fd0ab0c0edc 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -398,6 +398,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
>@@ -431,6 +436,8 @@ static struct virtio_transport vhost_transport = {
> 		.seqpacket_allow          = vhost_transport_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
