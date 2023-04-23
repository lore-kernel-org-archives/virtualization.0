Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7823C6FD18
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 20:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1148060D4F;
	Sun, 23 Apr 2023 20:17:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1148060D4F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2kfi5no
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJjPhDUFR0ls; Sun, 23 Apr 2023 20:17:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 64B0D60AD5;
	Sun, 23 Apr 2023 20:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64B0D60AD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1FBC0036;
	Sun, 23 Apr 2023 20:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22E5CC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA8BB4033F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA8BB4033F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2kfi5no
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0r_xXEKtvym5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:17:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A224F40223
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A224F40223
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682281066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b5ejvIIx/RJ7eYanc2DeN6LKkOul5lY8GnPOGLq5m+0=;
 b=I2kfi5no1NW1osPlzvKoxOfF5QBJcSbByHTvYp37/4RheMO7Bq/bM58ATJbpz/0CM/ebYN
 EWiGTE1svcyIDjnat0ajKBEG5Miq/kwCwvICv8G2WIDbMXAOcXEfjg35gQgr2E68bL41/n
 QyjOzX4tvrhqNEvChWYgSdLU11VEq0s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-donFwjTEM1ymA3Y4aCS2sg-1; Sun, 23 Apr 2023 16:17:42 -0400
X-MC-Unique: donFwjTEM1ymA3Y4aCS2sg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f168827701so13167225e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 13:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682281059; x=1684873059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5ejvIIx/RJ7eYanc2DeN6LKkOul5lY8GnPOGLq5m+0=;
 b=kRdcvH/O0R9YB7EQsy5hj0XNSlVlmBbHxCmCDGZPZoXsaaWaT+Y6hazWRLZXfskRUM
 nYjode4lEvCAWNNVWQTDLgkCutj3udGWbSVaeodV9QBpKke1QvkHPMc9ihwSyaCaogrl
 4ptc8TB0ztAnAYJi/TxUHhwSzCJfoL0LXrATLceyXJcUn2D8leogfH/lFXYv+jUQirGc
 yO2h5skx+bZdypweh6fABqSp32zPG3qllnFmB6VFc6ZlKlZflhk11VwfLD1+UYN1dAzl
 frmqC8lbyjyUqRhmsF/L/2gPLhmrJHc9NKMTf39G7W6iKswcnKIJkmydVAFMg+NVTam6
 RkFQ==
X-Gm-Message-State: AAQBX9clauf3X36hr7r4y8kwpaz0qi10SYI30cLVYGTDnM9D0ZdvNQXU
 tZUUbEpaoVNNF0WR8KqqFUgo7yu6+UZDBn/rlbaFaCe4a2itwLZODpx13ZSNpMWQJ8LElmpxaXj
 3lM14bHkID25E7EajhBdCUN3y5Mo7N/jBW9O4yIYlwg==
X-Received: by 2002:a7b:c008:0:b0:3f1:7440:f21d with SMTP id
 c8-20020a7bc008000000b003f17440f21dmr5959099wmb.33.1682281059806; 
 Sun, 23 Apr 2023 13:17:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZVUD7fuAvXZZNUn5Xb6tdyv5ONlZ2mzUgnHxdl0RaH2ytQnY0R7FH9hzI+EcGWub/tnAP+6A==
X-Received: by 2002:a7b:c008:0:b0:3f1:7440:f21d with SMTP id
 c8-20020a7bc008000000b003f17440f21dmr5959093wmb.33.1682281059474; 
 Sun, 23 Apr 2023 13:17:39 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 p1-20020a5d48c1000000b002f27dd92643sm2357771wrs.99.2023.04.23.13.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 13:17:38 -0700 (PDT)
Date: Sun, 23 Apr 2023 16:17:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230423161644-mutt-send-email-mst@kernel.org>
References: <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Sun, Apr 23, 2023 at 12:28:49PM +0000, Alvaro Karsz wrote:
> 
> > > > The rest of stuff can probably just be moved to after find_vqs without
> > > > much pain.
> > > >
> > > Actually, I think that with a little bit of pain :)
> > > If we use small vrings and a GRO feature bit is set, Linux will need to allocate 64KB of continuous memory for every receive descriptor..
> > 
> > Oh right. Hmm. Well this is same as big packets though, isn't it?
> > 
> 
> Well, when VIRTIO_NET_F_MRG_RXBUF is not negotiated and one of the GRO features is, the receive buffers are page size buffers chained together to form a 64K buffer.
> In this case, do all the chained descriptors actually point to a single block of continuous memory, or is it possible for the descriptors to point to pages spread all over?
> 
> > 
> > > Instead of failing probe if GRO/CVQ are set, can we just reset the device if we discover small vrings and start over?
> > > Can we remember that this device uses small vrings, and then just avoid negotiating the features that we cannot support?
> > 
> > 
> > We technically can of course. I am just not sure supporting CVQ with just 1 s/g entry will
> > ever be viable.
> 
> Even if we won't support 1 s/g entry, do we want to fail probe in such cases?
> We could just disable the CVQ feature (with reset, as suggested before).
> I'm not saying that we should, just raising the option.
> 

OK I'm convinced, reset and re-negotiate seems cleaner.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
