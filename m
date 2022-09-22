Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB138C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ADED610C1;
	Thu, 22 Sep 2022 09:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ADED610C1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKVjnzlZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hygf5PI3xDa4; Thu, 22 Sep 2022 09:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CE5E61044;
	Thu, 22 Sep 2022 09:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CE5E61044
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB066C0033;
	Thu, 22 Sep 2022 09:17:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4607C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91FBD4018E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91FBD4018E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DKVjnzlZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SbaEi5vicMPs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E56744017A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E56744017A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663838232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
 b=DKVjnzlZfOb81wGQocK21JQ62mnQ9O1s5wVy8SDc74LAsiCZnb7r1mo8+l/HZEoVIRCqcV
 PG23ce3qguBgY4EXNlgMIw2QaYve7taUd1+tE3XMu2oiYBvGXPjxWzj6nUZnJRqNILes0y
 Rrwcb+uiVxZOIDahBZTzz/F+x1B7eic=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-y5ksud7SOlCZO3yBS6t_JA-1; Thu, 22 Sep 2022 05:17:09 -0400
X-MC-Unique: y5ksud7SOlCZO3yBS6t_JA-1
Received: by mail-ed1-f71.google.com with SMTP id
 m3-20020a056402430300b004512f6268dbso6323816edc.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
 b=Q18VaXemKs5yF5WMYyZ7SCMtPYyAYtkXSkILQGbk5/k1PPVZnpQJU56eQIsP0NW959
 ffbY23u2K58EjwPUD7j1tPZ/MF6YW83VvPnTzTXDIGoRb1OiG1k3kF+NYV7lNJezOp8m
 W0ftiNrQjcL+UCDpJ+ri9WsUHeVPj/KqEQz7SYisia24Lw5AJPCzC/nCjBm2tz4/v70o
 DZlN+wxjkz4U8iF6PuSf+leCimufkr8YS94anf7VKg8JUi/KUetXW8clQU2SZOjzfaP3
 cyGdZwf+QOGagIO6+vUgjb8kq7aWolzYLBhJ1QhIJrxlY7inmShHtGXSDoxngN8JOTpe
 cWnA==
X-Gm-Message-State: ACrzQf1gOs3/PS6P3UyNMyaBq3HofsNn6G+A20a6e77/X1b4iOEE9cNx
 vScERr7S8kddy6n/vE+2Q7XJT1wsLsfGns+a8jjuEJ9PHslQMDAAqpI/S1dkZOE1/GVNrHrlTeh
 +2TNeghS+DtAt9hllz/y4GQiO6ikX2TRYU6EvFTUsGw==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id
 gn7-20020a1709070d0700b0072eec79ad0fmr2019349ejc.296.1663838228507; 
 Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6aWYk2gLkly55RZes2gWKaV2mpYmlQSmVpIR2XSzCn6t3IkeaTpYNPXd0NwzuX13AYtWwYqg==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id
 gn7-20020a1709070d0700b0072eec79ad0fmr2019336ejc.296.1663838228336; 
 Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 d14-20020a170906304e00b0073bf84be798sm2374187ejd.142.2022.09.22.02.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:17:07 -0700 (PDT)
Date: Thu, 22 Sep 2022 05:17:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220922051613-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
 <20220918081713-mutt-send-email-mst@kernel.org>
 <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Junbo <junbo4242@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Sep 22, 2022 at 11:10:37AM +0200, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> > > hi=A0Michael
> > > =

> > > in virtio-net.c
> > > =A0 =A0 /* Parameters for control virtqueue, if any */
> > > =A0 =A0 if (vi->has_cvq) {
> > > =A0 =A0 =A0 =A0 callbacks[total_vqs - 1] =3D NULL;
> > > =A0 =A0 =A0 =A0 names[total_vqs - 1] =3D "control";
> > > =A0 =A0 }
> > > =

> > > I think the Author who write the code
> > =

> > wait, that was not you?
> =

> I believe 'the Author' refers to the author of the current code, not to
> the author of the patch.

Oh I see. Responded.

> @Junbo: the control queue is created only if the VIRTIO_NET_F_CTRL_VQ
> feature is set, please check that in your setup.
> =

> Thanks
> =

> Paolo


-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
