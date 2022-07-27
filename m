Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1153DC19F2B
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 12:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A984960BE9;
	Wed, 27 Jul 2022 12:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A984960BE9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lkakvun1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFJs7XBmZq8Y; Wed, 27 Jul 2022 12:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FEDB60BEC;
	Wed, 27 Jul 2022 12:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FEDB60BEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2626C0033;
	Wed, 27 Jul 2022 12:30:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBD9AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8638E81BD6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:29:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8638E81BD6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lkakvun1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4uzv9yf5CxWv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3069B81BC2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3069B81BC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658924996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxBuSirLSlmCaBjX7uKmZi3DKKvsk0CPMisH3i3PiEM=;
 b=Lkakvun1qpweTuNHK6RPZOedtFYlgl2IV45eNeBnQqFXsfVq9IU/QpUSxF4M3XY3YM4dDo
 iqafHn4v+M6J9MpPZmSbKhI+ohgfOi25ViY73of4brZaoPRKigzTln5Zy1zkSuIp/O9Tyj
 /bCDBWMrYGI2JMeq/AXM9yZLua7iTnM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-WCENyJ92NjysmsTYvMyyuA-1; Wed, 27 Jul 2022 08:29:55 -0400
X-MC-Unique: WCENyJ92NjysmsTYvMyyuA-1
Received: by mail-lj1-f200.google.com with SMTP id
 bx35-20020a05651c19a300b0025e0c4331c6so2108989ljb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AxBuSirLSlmCaBjX7uKmZi3DKKvsk0CPMisH3i3PiEM=;
 b=zYbVMyIap68Ooia07/2iaAC6InBs3Cg447pYVQ8aHK+MXZE0+0Y6nEDRU44X8Qyhhl
 HweJiklI/4FCUp2q4lf53eehbHS2O+RVaVDr3RfMgFJdYoD3xpoHZjR+bF6D00y+nwa2
 L3lxdcNC8weaAHSuBYIXYsSFULkf9kdnZ9QkUb0EREF+gklJKIz3cEPgoHsw+456JumR
 o8Vtw6QQj5mvTvlKRcHD103C6Un1Xls6WJ8UI5/eo9WBTkbOFGJdPlQWd5VwDX3n9zoR
 JXtgS9s5zKKo4EqOQZJUU97OIv+A31OFiTF/2K7xrx0KZT4D7xXX0WhyHPzQG9l3m4tU
 HRKg==
X-Gm-Message-State: AJIora/BlDeELoVWEJ41hRhWSYa7uci4G+Qn8dl55kpkgYRjz9kfBeql
 iDoERLhq/TBbqzbBQuhiHQQQmZZC6aISbKnj8bsV/dyQRAomIkeESyqnoq919+LARdbFzBdp7MZ
 5CNtmIf1ojjMyl/fTt7iGdjuWuaNQF2MUFga3xktD7uotCuJ5yrwsl3xMjA==
X-Received: by 2002:a05:6512:31ca:b0:48a:2e3:db41 with SMTP id
 j10-20020a05651231ca00b0048a02e3db41mr7946391lfe.285.1658924994158; 
 Wed, 27 Jul 2022 05:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usleWIBkFGXVgg8pf87FeBHyq3CnAy0dTxHgebzQtlLd72pXddpA1ORMMZjBTZ4Ut4Od8ZGxlwfL8cz5Y/fek=
X-Received: by 2002:a05:6512:31ca:b0:48a:2e3:db41 with SMTP id
 j10-20020a05651231ca00b0048a02e3db41mr7946372lfe.285.1658924993965; Wed, 27
 Jul 2022 05:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <355f4bb6-82e7-2400-83e9-c704a7ef92f3@sberdevices.ru>
 <20220727122241.mrafnepbelcboo5i@sgarzare-redhat>
In-Reply-To: <20220727122241.mrafnepbelcboo5i@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 27 Jul 2022 14:29:42 +0200
Message-ID: <CAGxU2F7uw8fo4bn7t+3L2-irvxtCY+KchzPSXayimZZjdM1sdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] vmci/vsock: use 'target' in notify_poll_in,
 callback
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Bryan Tan <bryantan@vmware.com>,
 Rajesh Jalisatgi <rjalisatgi@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jul 27, 2022 at 2:22 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> @Jorgen can you take a look at this series, especially this patch?

Jorgen's email bounced back, so I'm CCing VMCI maintainers.

Bryan, Rajesh, Vishnu, can you take a look?

Thanks,
Stefano

>
> Maybe we need to update the comments in the else branch, something like
> s/there is nothing/there is not enough data
>
> Thanks,
> Stefano
>
> On Mon, Jul 25, 2022 at 08:01:01AM +0000, Arseniy Krasnov wrote:
> >This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
> >syscall,but in some cases,it is incorrectly to set it, when socket has
> >at least 1 bytes of available data. Use 'target' which is already exists
> >and equal to sk_rcvlowat in this case.
> >
> >Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >---
> > net/vmw_vsock/vmci_transport_notify.c        | 2 +-
> > net/vmw_vsock/vmci_transport_notify_qstate.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
> >index d69fc4b595ad..1684b85b0660 100644
> >--- a/net/vmw_vsock/vmci_transport_notify.c
> >+++ b/net/vmw_vsock/vmci_transport_notify.c
> >@@ -340,7 +340,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> > {
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >
> >-      if (vsock_stream_has_data(vsk)) {
> >+      if (vsock_stream_has_data(vsk) >= target) {
> >               *data_ready_now = true;
> >       } else {
> >               /* We can't read right now because there is nothing in the
> >diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
> >index 0f36d7c45db3..a40407872b53 100644
> >--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
> >+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
> >@@ -161,7 +161,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> > {
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >
> >-      if (vsock_stream_has_data(vsk)) {
> >+      if (vsock_stream_has_data(vsk) >= target) {
> >               *data_ready_now = true;
> >       } else {
> >               /* We can't read right now because there is nothing in the
> >--
> >2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
