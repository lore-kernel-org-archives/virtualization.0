Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E0FC77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 11:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B7C541CBA;
	Mon, 17 Apr 2023 11:57:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B7C541CBA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IGlbjPdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hkF4TECV-RC; Mon, 17 Apr 2023 11:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B50F341CCF;
	Mon, 17 Apr 2023 11:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B50F341CCF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63918C0036;
	Mon, 17 Apr 2023 11:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32115C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0657041CCE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0657041CCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vraypNDWxWj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 506A341CBA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 506A341CBA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681732651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2LRp3zjh0DOhKKwcTJt+220dZY+oP35RdJVHgXAQvQE=;
 b=IGlbjPdIMms8idUX6sCSakk1K3yx+NrTySHVk5PAlBULytFe/syVXasmQV9LrVVQWJo+0n
 gIDRnadaSCpdNMy+UiCww+3uBjrAFcvHP+j6TT3d0bC+p0eyeijgo4cqNA5gMTYBe17yOR
 2exsOLZ70iH5798n8bshstXVXQyoZPA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aZPWdtG9OziCiY61dQMNdw-1; Mon, 17 Apr 2023 07:57:29 -0400
X-MC-Unique: aZPWdtG9OziCiY61dQMNdw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-506b0b75731so239418a12.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 04:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681732649; x=1684324649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LRp3zjh0DOhKKwcTJt+220dZY+oP35RdJVHgXAQvQE=;
 b=DTnkYwHL1Ji/2ruc/bKsFgjZ0Di1SGP2GW11xiA1QVNKEekf/W4CIwJjJ4JCiPhqKc
 QWuVizM3xiMEYr/QkmyH6w/a/gF0DPKp8A458XNjz2QUayi9FE/N7uf/N9OeOt6bV3Yi
 Qfg+GOqnMEJhhWcMlIrzfgnFWfkV5nH/Jr4CDRiKc4/irLcPoNrkRTd+JTNu7ldhI82V
 eiEMgdiucEiZdVIyqdOVl4DB6RMs1WbpMuaX6fokmVygY0TTLo6zDeW2shp9DjlC3CWy
 I8PMi/MyOE1fE7ud9VmC/UCeL+dD/rhA6m6JB624EREm7Sqy4srnKqT+VJ6SOpFz6kzF
 dBLA==
X-Gm-Message-State: AAQBX9ciq2+/dSdv0KhSFQ/hyPwDTaPChMoAJoQCa5NguHsbnoPvt4tm
 Qa4Xh2wmcR/Q0ci1Fv1C4Pcp6ogMEgLl9+Zye/TdpNLHw8nvsRe6/35uhng8gsQmQHdOj0k9PYV
 e+h7NDoP5A7HLnsCqCieVlg0P0/PVjcWDua29IAX6Og==
X-Received: by 2002:a05:6402:1154:b0:506:83f7:157b with SMTP id
 g20-20020a056402115400b0050683f7157bmr10206152edw.10.1681732648814; 
 Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350aNKgY4zPoooD46Q25GLFK8yAqcM6inydsLa/BdAONuep0Wjoauz5/ie895Qh5ZYK7I0H0Nfg==
X-Received: by 2002:a05:6402:1154:b0:506:83f7:157b with SMTP id
 g20-20020a056402115400b0050683f7157bmr10206139edw.10.1681732648606; 
 Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 n23-20020a056402061700b005068f46064asm3426009edv.33.2023.04.17.04.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
Date: Mon, 17 Apr 2023 07:57:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417075645-mutt-send-email-mst@kernel.org>
References: <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Mon, Apr 17, 2023 at 11:51:22AM +0000, Alvaro Karsz wrote:
> > > I see your point.
> > > Regardless, we'll need to fail probe in some cases.
> > > ring size of 1 for example (if I'm not mistaken)
> > 
> > Hmm. We can make it work if we increase hard header size, then
> > there will always be room for vnet header.
> > 
> > > control vq even needs a bigger ring.
> > 
> > Why does it?
> 
> At the moment, most of the commands chain 3 descriptors:
> 1 - class + command
> 2 - command specific
> 3 - ack
> 
> We could merge 1 and 2 into a single one, both are read only for the device, so I take it back, it won't need a bigger ring.
> But it will need 2 descriptors at least(1 read only for the device and 1 write only for the device), so we still need to fail probe sometimes.
> 

Yes that makes sense, it's architetural. We can disable ctrl vq though.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
