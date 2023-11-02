Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CC1C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 13:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5543784F6F;
	Thu,  2 Nov 2023 13:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5543784F6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=STTY4pwN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18FHXVMitj9r; Thu,  2 Nov 2023 13:16:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 458EC84F60;
	Thu,  2 Nov 2023 13:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 458EC84F60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 206A3C0072;
	Thu,  2 Nov 2023 13:16:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 702BEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B0C041F43
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B0C041F43
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=STTY4pwN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BzkPIwHj7sTQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:16:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 131F641E8C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 13:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 131F641E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698931008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fTaJOMcX/m2U9bWMbervVcOi3b96Z0mEX8mhdx6J3a4=;
 b=STTY4pwNttsXIT2WEkQ1IU0Dr7V5Ml4dVMfmXhs8hHLOoNhZAyt3N0VJp/+N8APdvMXCjE
 iyCoqzpZeAJ9U2Iw4XQBatA4CRFL3yROtDxGEM1LdZnLJ+oCp63xuf7sV5YXnk+ZGhvidG
 bbJ7NtzqyLxXezf9wRBX4Tz/C6k7D3c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-myupHq9INQi9CyX9sXICyA-1; Thu, 02 Nov 2023 09:16:46 -0400
X-MC-Unique: myupHq9INQi9CyX9sXICyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084d0b171eso12499325e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Nov 2023 06:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931004; x=1699535804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTaJOMcX/m2U9bWMbervVcOi3b96Z0mEX8mhdx6J3a4=;
 b=L5Wn0zXlG+cIsmLuWEQT15G3pdcdNBBb5EZusvRBzK0al3Ufn4cfJPP+B8E9xtJ6Er
 WVTcppoqaLXOmHpjVVh7p88SD/qT5bi/jR1EN4DvYyGe+DViUk/pDYWZdnyt8DlPVPAh
 7sT0tJVBxKPESSkCAz0dBXGFTmv8Jlwh1cyYzI2pekfoOs9iIousAdLFA0yOjH9Q2wfh
 u9nWX3MTl4K848XdjIq8cXBOr7gcATOc87nAh0NxDyUM4DOKOEp72mZPgQGQRzCjCMMC
 jPT/qOlQEa0vRYhshfu/2TrtJH37i3ndPJJypEquN523sXS+1L/Oef4pVvWxGT/eqDzi
 k0WQ==
X-Gm-Message-State: AOJu0YzBFihY0s9UAu/La36Jx1w7Q15W2WO8pyQSc3UQJ+nF4e3+G8uZ
 rKytx+8DLzEqnsujBMcwZr/rIDCswIc+ghFUCmldWQUOnnXoQia/rC9bIuDAVLu+v8R6MfOrse9
 5C4lHJlKb1ucSuoVQ8gQlg7CCQZchQfJweY0M0cJBPg==
X-Received: by 2002:a05:600c:4e92:b0:406:51a0:17ea with SMTP id
 f18-20020a05600c4e9200b0040651a017eamr9900343wmq.10.1698931004649; 
 Thu, 02 Nov 2023 06:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaiGvYRPB3UU8Dnub6u0GQi1jlrdIYAhApAmi5nhz29fIPl/sa2bLHv0xaM+iBx8P/nk59HA==
X-Received: by 2002:a05:600c:4e92:b0:406:51a0:17ea with SMTP id
 f18-20020a05600c4e9200b0040651a017eamr9900315wmq.10.1698931004333; 
 Thu, 02 Nov 2023 06:16:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 bh27-20020a05600c3d1b00b004063d8b43e7sm2903119wmb.48.2023.11.02.06.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:16:43 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:16:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20231102091548-mutt-send-email-mst@kernel.org>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
 <20231101092521-mutt-send-email-mst@kernel.org>
 <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5d9ebbdb042845009b47e6a9ee149231@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

On Thu, Nov 02, 2023 at 01:04:07PM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, November 1, 2023 9:26 PM
> > To: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org; Marc Hartmayer <mhartmay@linux.ibm.com>
> > Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from irq
> > context
> > 
> > On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> > > On Sun, 24 Sep 2023 11:56:25 +0000
> > > "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> > >
> > > > Hi Halil,
> > > >
> > > > Commit 4058cf08945 introduced a check for detecting crypto
> > > > completion function called with enable BH, and indeed the
> > > > virtio-crypto driver didn't disable BH, which needs a patch to fix it.
> > > >
> > > > P.S.:
> > > > https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@baylibr
> > > > e.com/T/
> > > >
> > > > Regards,
> > > > -Gonglei
> > >
> > > Thanks Gonglei!
> > >
> > > Thanks! I would be glad to test that fix on s390x. Are you about to
> > > send one?
> > >
> > > Regards,
> > > Halil
> > 
> > 
> > Gonglei did you intend to send a fix?
> 
> Actually I sent a patch a month ago, pls see another thread.
> 
> 
> Regards,
> -Gonglei

And I think there was an issue with that patch that you
wanted to fix?
config changed callback got fixed but this still didn't.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
