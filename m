Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197A3C43334
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96C9882C8E;
	Tue, 28 Jun 2022 06:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96C9882C8E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hxjd+hvm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Ege27jOEzDx; Tue, 28 Jun 2022 06:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08B9A82FC9;
	Tue, 28 Jun 2022 06:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08B9A82FC9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1112C0039;
	Tue, 28 Jun 2022 06:44:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DEDEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4620241521
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4620241521
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hxjd+hvm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59a7bqhxoEDc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:44:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 511384151D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 511384151D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656398690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
 b=Hxjd+hvmkirlB6mjmzt3xJJubHNfx/OZu08dS7EYyrWNukPdYO1ISXQJ2NTGiYkOWXxTF6
 oeXzh36D86aXoJq36ZapMm2Hkw8WRnTigkNT79saeIj11z/lBx+OAIoWrvZdiVAVCo3CiP
 FD5kuSSuGKAmuX4Hl96/CbiknII2kfQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-u7KXXIEqMuSTIuaKtSKg_A-1; Tue, 28 Jun 2022 02:44:46 -0400
X-MC-Unique: u7KXXIEqMuSTIuaKtSKg_A-1
Received: by mail-wr1-f70.google.com with SMTP id
 o1-20020adfba01000000b0021b90bd28d2so1506173wrg.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hKKhmAVY6ZLU32yFo246MjjcA6QB3q+Asrc/tb9AagA=;
 b=rpKsoa/1OIAXsYOFlsCHbPffMxLsjJFGUSLleb6NmU/mY/WJSrFUqcstFGsMLvXOwq
 CPizT75J/9BRUAEuZgv6dvwku/xRtfh7RzJj/1eiqh3re7l8cVSjf9QfsaAm1b+2beYa
 JUl2QQNeDrwXBpHO0HG6fKBsN0CQTpwFSvk9x++e4FsWbKRiwLC8LNA9F10CGdpAT8kF
 cxebeXwKfL0pkr7/HDRQ+/zboCAk42TLc5QjysOAzniq3o39Zh70Z+PE1OUlMg7Luxe5
 jTppwQerlj25N9BfWVR6ESP1wna16YfZ03StseoDSqkaFVM3w4RVeEs1fVeP0S/A3WrP
 LQPA==
X-Gm-Message-State: AJIora8BSkcvovun4/c5YmSMkNsIq9mcDmpTakSI4TkCn2ZXcV8T2/2r
 KD+6oHT8NkgO/ECmVweARGa2cK9znjsrNEN/Du+C/7eCLIF6pM4DIcOly4OieU/dK1atAM09OUR
 NXLFZSPPlfskI/C98XrSCuUjbipVc7nMyrzCOkgIG5g==
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id
 f16-20020a05600c4e9000b0039c7ec6c7d2mr19756871wmq.140.1656398685545; 
 Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIze8DJsIvzB3CNFTFD7nxCkijrxeoiA7/FaJ3ir6OLO+Z+2vAtNLsCgnTCLoOO1PL/wj22A==
X-Received: by 2002:a05:600c:4e90:b0:39c:7ec6:c7d2 with SMTP id
 f16-20020a05600c4e9000b0039c7ec6c7d2mr19756849wmq.140.1656398685292; 
 Mon, 27 Jun 2022 23:44:45 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b003a04962ad3esm9243219wms.31.2022.06.27.23.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 23:44:44 -0700 (PDT)
Date: Tue, 28 Jun 2022 02:44:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220628023832-mutt-send-email-mst@kernel.org>
References: <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <20220628022035-mutt-send-email-mst@kernel.org>
 <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt=go5qAH+P0to6yyE2dPhyfFmOQP0jfuj=57PmD7Y3zg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Ben Hutchings <ben@decadent.org.uk>
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

On Tue, Jun 28, 2022 at 02:32:19PM +0800, Jason Wang wrote:
> > Question is are there drivers which kick before they are ready
> > to handle callbacks?
> 
> Let me try to have a look at all the drivers to answer this.

One thing to note is that I consider hardening probe and
hardening remove separate features. I think that at this point
for secured guests it is prudent to outright block device
removal - we have been finding races in removal for years.
Note sure there's a flag for that but it's probably not too hard to add
e.g. to pci core.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
