Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15A1C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Jun 2022 05:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 805146080A;
	Fri, 10 Jun 2022 05:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vxMsw6uuflJU; Fri, 10 Jun 2022 05:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E5AB60FAE;
	Fri, 10 Jun 2022 05:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE5BC0039;
	Fri, 10 Jun 2022 05:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 962AEC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84722402A8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jYnCvfWL2ujF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA75340195
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654839885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShE1FlsmSfqxYvr7PfIooFDqvA9+xWO6036Ml2D5cEU=;
 b=QeXbnUzRGBBRuFEPYp6L46BUvSxvkUiRMIh1lJjAPlbcrlC78auJ4c6nO1X0fMp93qbMRM
 Hs1M9iR8XMfSHzNjNHlvkNtpZHDJfbg6BlDJaqka4+iArQy5NCXsss5ezcc+Fk9MPs7X0k
 QauBrz0sRwyniTlAsRh8BtY59hGo9VI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-tbxvzeNRMdKQb49fH8v7KA-1; Fri, 10 Jun 2022 01:44:42 -0400
X-MC-Unique: tbxvzeNRMdKQb49fH8v7KA-1
Received: by mail-wm1-f70.google.com with SMTP id
 k15-20020a7bc40f000000b0039c4b7f7d09so769803wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 22:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ShE1FlsmSfqxYvr7PfIooFDqvA9+xWO6036Ml2D5cEU=;
 b=TzmaA6Si1VL7Jh7bd4LLiiPrQjiMAbFAGpt7YwIepajqfJUjvZRWYwb7xmEMMftj0V
 kt7EzWxctV0lJh8+NUi5y1lMM1yddoC1nmoiMUVvOTh79jl94KCfmzoCLHy+I/qLz9M/
 ndykJ79sGuIBJb8cyOONHrfdacRb5EfoJx+4g44wkEzeumsEowPOtWKyc3xSN+sFBBgT
 I8SGJth+3C5Va92an1FGZKqsdqWR00pVFkNnWH2BnI+jHGFeUx5UYRCrxk2KtkhpelAB
 96YMZtMCLnbODYnN9gwGApcoU7Y4Ke7+8TQMP4VYHu0acnbSMh4iUAstHrsQ3Igugtv0
 miBg==
X-Gm-Message-State: AOAM532gLGsLcjPi4S8HqZS2LFS15nj5z4e0SepPKSzC0zjK0w5DUAGc
 G/pDYrFm3Djj5McZgBpNzpA6NHj11m9kak+QdvKng9DDcqYyv29YJGvwTGS0mExqy6f1zdubey3
 3Xn5ssEowkJlfsaRjSRWI0iiMhSICF/PglZVj0cLfFA==
X-Received: by 2002:a5d:4d01:0:b0:219:e782:786e with SMTP id
 z1-20020a5d4d01000000b00219e782786emr1109612wrt.29.1654839881185; 
 Thu, 09 Jun 2022 22:44:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEmWQHVgI7mLEv3SkzwqsG0Oxbqj8p8QyhoSd4ME6IUhU+HW5jSNN0aKke5wjImdfMPeuohQ==
X-Received: by 2002:a5d:4d01:0:b0:219:e782:786e with SMTP id
 z1-20020a5d4d01000000b00219e782786emr1109594wrt.29.1654839880990; 
 Thu, 09 Jun 2022 22:44:40 -0700 (PDT)
Received: from redhat.com ([212.116.178.142]) by smtp.gmail.com with ESMTPSA id
 q9-20020a5d6589000000b00219e758ff4fsm666864wru.59.2022.06.09.22.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 22:44:39 -0700 (PDT)
Date: Fri, 10 Jun 2022 01:44:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Minghao Xue <quic_mingxue@quicinc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220610014330-mutt-send-email-mst@kernel.org>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
 <20220329074610.GA20342@mingxue-gv.qualcomm.com>
 <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
 <20220519071958.GA24236@mingxue-gv.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <20220519071958.GA24236@mingxue-gv.qualcomm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jean-philippe@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, quic_ztu@quicinc.com
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

On Thu, May 19, 2022 at 03:23:02PM +0800, Minghao Xue wrote:
> On Tue, Mar 29, 2022 at 09:59:31AM +0200, Krzysztof Kozlowski wrote:
> > On 29/03/2022 09:46, Minghao Xue wrote:
> > > On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
> > >> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> > >>> Some systems want to set the interrupt of virtio_mmio device
> > >>> as a wakeup source. On such systems, we'll use the existence
> > >>> of the "wakeup-source" property as a signal of requirement.
> > >>>
> > >>> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> > >>
> > >> I don't have enough of a clue about dt to review this.
> > >> Pls get some acks from people with DT expertise.
> > >>
> > > Hi Michael,
> > > I had a discussion with Krzysztof on the first version of patch. And we've
> > > got aligned. 
> > > 
> > 
> > I thought I reviewed this and provided an ack, but apparently I did not.
> > Sorry for late response.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Best regards,
> > Krzysztof
> 
> Hi Michael and Jason,
> As this patch has been reviewed by Krzysztof. Would you help upstream
> these two patches? And is there any progress on it?
> 
> Regards,
> Minghao

Hi!
Sorry about the delay - the issue with the patchset is it was not
threaded correctly and so can not get handled properly by
automated scripts. Can you please repost threading properly,
preferably with a cover letter?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
