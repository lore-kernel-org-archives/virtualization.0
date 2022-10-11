Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B3FC4332F
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 21:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AB5340C14;
	Tue, 11 Oct 2022 21:01:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AB5340C14
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eIiTrmNa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yxl_QtaV67Dh; Tue, 11 Oct 2022 21:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C0CF400B9;
	Tue, 11 Oct 2022 21:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C0CF400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06CF7C0033;
	Tue, 11 Oct 2022 21:01:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7205C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 21:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B1D240C12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 21:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B1D240C12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntOIzr7oX13g
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 21:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A14400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5A14400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 21:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665522097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+avVcnv70NWKcf9LkbwIbLGyy/FiaOAFyFBBxc5L0mg=;
 b=eIiTrmNa5FoN90OfuzbFbv+964pMis6M0nXe9i1W2LfiY/wTn+S2v77rAY/EM7cZq8h4lf
 gc9mSYykkbqQQHEbmlm6TBy0stJuH/pwzl5+S6tMdpQgY4T+0pLMlNIHKSm1fXQGrCvtRj
 oM6QxiMPoB3IPzDNIdj3bhvvRjo63Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-Hg17lL9kMQeuItOmXZhrXA-1; Tue, 11 Oct 2022 17:01:36 -0400
X-MC-Unique: Hg17lL9kMQeuItOmXZhrXA-1
Received: by mail-wr1-f70.google.com with SMTP id
 s4-20020adfbc04000000b0022e03fc10a9so4263023wrg.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 14:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+avVcnv70NWKcf9LkbwIbLGyy/FiaOAFyFBBxc5L0mg=;
 b=EuPc82bsxWTqe8mO1MHk7fEfyEaP2pZYqOiHo2yhTo6I+8BGS6PLmyV2sbYTaN6N2n
 gIUKR8VZUWwFfOrW7kjimh/1qkoaImgWMZ6BiJXXlmZfz5Ies4vXU9w7HqnAYXBnCoOj
 wyCIV7lvgUqtZaffkGjneJRpUUGAGzHYuMEkULOhgYNBqy1zb9LkqMdyutOL1nfXQEay
 LTjSRO/Bwn2JVnj4YAn/Ha4L8/1C2KEnVanZCTlY8lQpIkg+HVAfWNkSoh91v2wGU6Fk
 sajGWyBsT6Gti20KLeyYiz/5uDm/MmWJWUYwlPd9KOCQg9+UPu4bUcR/GAJQaFGLUXyN
 C9LQ==
X-Gm-Message-State: ACrzQf2Bb9uUDu4zv0lTStxDcR+lRiOyG931sfRf3uLgbVIBDyK6tqAE
 yc4jMzqsZhByjGnSoypTh+K4HMrATnYTcAPKDY3U7FgPTh14sHTZSkKkjAGQIeFJpw+ci+qbRb3
 8FAw5JWzXd2hRYt+rqZp1PV8hw1IlflzQCrA/3sjUbQ==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id
 u1-20020a5d6da1000000b00231c189e077mr1759309wrs.114.1665522093726; 
 Tue, 11 Oct 2022 14:01:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4G5KpCt5HabCJPqECVt2VlLGntyZA6wlIwgpZa4/dWB/N71V/3QuGifG/JsGyxjQryAPV/Ow==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id
 u1-20020a5d6da1000000b00231c189e077mr1759294wrs.114.1665522093426; 
 Tue, 11 Oct 2022 14:01:33 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 r16-20020adff710000000b0022afbd02c69sm11871911wrp.56.2022.10.11.14.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Oct 2022 14:01:32 -0700 (PDT)
Date: Tue, 11 Oct 2022 17:01:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221011170037-mutt-send-email-mst@kernel.org>
References: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221009191835.4036-1-mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Oct 10, 2022 at 01:12:20PM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID. Result is device marked broken incorrectly.  As
> VFs are present if and only if PF is present, just return the value for
> that device.
> 
> Reported-by: gongwei <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> Warning - compile tested only. gongwei could you help test and report
> please?


Just got a report in private email that it was tested and works well.
Will repost as non-RFC now.


>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..ba29b8e2f3c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
>  
> +	if (pdev->is_virtfn)
> +		return pci_device_is_present(pdev->physfn);
> +
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
>  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
