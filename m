Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECADC6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 427D141997;
	Thu, 22 Sep 2022 09:16:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 427D141997
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f8pMV8jV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6l6Dzf2mUsx; Thu, 22 Sep 2022 09:16:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7DC841992;
	Thu, 22 Sep 2022 09:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7DC841992
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E96EC0033;
	Thu, 22 Sep 2022 09:16:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E5C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B4D88329E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B4D88329E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f8pMV8jV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m7cVyYGKBBvV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9892A832AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9892A832AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663838172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhZLFn1R5tarTTTxU9XzOLKoFe4nPWuQCWD3fmeWO70=;
 b=f8pMV8jVk0Uc/2ouNkTQlliE/DmjjV92PiQRHYV4gRU0Qf9Hn2gYdOgHK+WpZDsOoSAdeQ
 Y4DWx0gzae8DZ7eUp5IpzU4numRrc3h9JHzVbfWe7HPDOqSOGf/oWAc65PpjWu01owXQMV
 97sBGm/7MRxJqCBr52Xj3ReahwNXOos=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-b9olB5wFOk2x0p0_BESpDw-1; Thu, 22 Sep 2022 05:16:10 -0400
X-MC-Unique: b9olB5wFOk2x0p0_BESpDw-1
Received: by mail-ed1-f71.google.com with SMTP id
 e15-20020a056402190f00b0044f41e776a0so6222073edz.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=PhZLFn1R5tarTTTxU9XzOLKoFe4nPWuQCWD3fmeWO70=;
 b=aBy3rn9jTAXrCpzCiy48IU8pfYmptSfru38Fhhyb+zn09/Bk0I5eVhFe7oX13Lp23L
 s3alQ2DdPkGSXV5wQepCusYKaPlSyyMUaveFpucEXbPq/tBCgdYucak/Sji2oQo96wcp
 5GEbpan9l1I8qUcI9wsTnS6aPGp4aoGcmb/n/w9MSCrSoVL6e3rwlPNM/Kc95Y8lVIPf
 JMlrXx/vexfAuFNOYPFI0hz7xVQuQd21u6i70PwoT2ukexMVaHJK4zahit0woh25x3Aq
 YILhxMKzIda08HkrGpW6B5RGC2nUUgDbMv+hpxvqyETQhQTHuqYxeQyHkZsJSNi1B3tz
 LdCA==
X-Gm-Message-State: ACrzQf0eWqhRCeVlj+EV82rrmQW/RazSHCe6VA4a/IgQisb3f7AYaDTm
 XtdKs6nGZTPxy1T76SKJ5fNrnNYQ/OiVBgiIZzd0zAQsnwHiuvyuV9Xtx5W3JBbB77zClZR0XaR
 uaKD0C0+blWILQszfjgF6oM2wmnXV7WAG+DKkuCvBdQ==
X-Received: by 2002:a05:6402:2547:b0:450:668c:9d93 with SMTP id
 l7-20020a056402254700b00450668c9d93mr2326116edb.92.1663838169836; 
 Thu, 22 Sep 2022 02:16:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5vmhrBTquuS4qjnEl33Y44GZJ0NDrRa7TS8jjlctqoihmeU+ZSkFouVEz2/vb+MFGYkN4DUw==
X-Received: by 2002:a05:6402:2547:b0:450:668c:9d93 with SMTP id
 l7-20020a056402254700b00450668c9d93mr2326091edb.92.1663838169658; 
 Thu, 22 Sep 2022 02:16:09 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 11-20020a170906300b00b0073d6093ac93sm2417360ejz.16.2022.09.22.02.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:16:09 -0700 (PDT)
Date: Thu, 22 Sep 2022 05:16:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junbo <junbo4242@gmail.com>
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220922051317-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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

On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> hi=A0Michael
> =

> in virtio-net.c
> =A0 =A0 /* Parameters for control virtqueue, if any */
> =A0 =A0 if (vi->has_cvq) {
> =A0 =A0 =A0 =A0 callbacks[total_vqs - 1] =3D NULL;
> =A0 =A0 =A0 =A0 names[total_vqs - 1] =3D "control";
> =A0 =A0 }
> =

> I think the Author who write the code maybe want to name the control queu=
e to
> 'virtioX-control',

That would be me I suspect ;)

> but it never worked, we can see the name still be
> 'virtioX-config' in /proc/interrupts,

Nope, what you see in /proc/interrupts are the interrupts, not the queue
name.

> for example=A0
> =A043: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0
> =A00 =A0 =A0 =A0 =A0 =A00 =A0 PCI-MSI-edge =A0 =A0 =A0virtio0-config
> =A044: =A0 =A0 =A0 =A0 64 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =
=A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0
> 1845 =A0 =A0 =A0 =A0 =A00 =A0 PCI-MSI-edge =A0 =A0 =A0virtio0-input.0
> =A045: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0=
 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0
> =A00 =A0 =A0 =A0 =A0 =A00 =A0 PCI-MSI-edge =A0 =A0 =A0virtio0-output.0
> =

> Because in function=A0vp_request_msix_vectors, it just allocate 'xxxx-con=
fig' to
> every virtio devices, even the virtio device do not need it.

Oh yes, we can fix that. The result will be this line disappearing for
devices without a config interrupt. Not for net though, that
generally uses a config interrupt for things like link
state detection.


> in /proc/
> interrupts, we can see that each virtio device's first interrupt always n=
amed
> 'virtioX-config'.
> =

> So I think it's better to not explicitly give the "control" here, it's
> useless...=A0=A0


it's used for debugging.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
