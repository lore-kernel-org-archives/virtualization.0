Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E4EC77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 18:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F74A60EF2;
	Thu, 20 Apr 2023 18:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F74A60EF2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMf3EHo9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ep6QuyC5xoy; Thu, 20 Apr 2023 18:39:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E70C560B51;
	Thu, 20 Apr 2023 18:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E70C560B51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4149C007A;
	Thu, 20 Apr 2023 18:39:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A05C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 18:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02ECA414C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 18:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02ECA414C0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMf3EHo9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEdcwEB1coE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 18:39:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92A7B4149D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92A7B4149D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682015964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXtC/sVk1W7H+fsLDKJXUd2xWw5ZJzD/Qr53ie94Xh4=;
 b=CMf3EHo9Pk8KqTVpEr/O3D3gs1gy4goyMyNFi56W9QXA4dkPXudxDquJFetqPYM0bpK8ej
 jLyOU5p7dGM2SDRhb0HO1KIeGz3Xx9vVdlMyISE3bKAa2SBysWAAnME/EIkO2pIhYgUBWk
 NWVAtr3wt6TVyWJFIcIrHatNVA2tSBg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-m5O8XqUyMMmxRr4_zHADGA-1; Thu, 20 Apr 2023 14:39:23 -0400
X-MC-Unique: m5O8XqUyMMmxRr4_zHADGA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-5ef5fbe2cfaso879756d6.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 11:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682015963; x=1684607963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXtC/sVk1W7H+fsLDKJXUd2xWw5ZJzD/Qr53ie94Xh4=;
 b=jNXULBl6XeVlhYv4jlSwi5RdKuxj2HUai+Zs9V9QcuQonVvl9W/k75HC0fiVngOIrH
 3Vo0LSeC/TpsjmaJeYEzOuxjk60OBBchloudlL55WPC8lHIzLRcewyH8viscKPpv8Huw
 LNqMzATnlTwHyTxju03ZNSpBIAZHradh9eu8305KvWFMYujyIJdCIN53EqAzrjpS5jWS
 zJz0Zmha+msLRkTbmRMOV4CGyYTW59cILzO8moZMLPOYWP/veN4d8ehLM37pAOwd3Q9i
 KwyyPmGCS9uTiw5e7IiV0BL45Pt/rCUVLaZOOgBDh0AJfMgNP9pLRaFwLCOVVeTe6CDO
 JoNw==
X-Gm-Message-State: AAQBX9dAsgJ1asqfUSg7QnOm+VNbNXTruhQQP4Zw0NYND5d5j7m2PAdc
 M8vWr/claguVV8SPxNrnYAj3kohtGzE6QD1OfwyW5IKIwUmjTJTAGEmuSA+ULhHVesuugCuRY6p
 wE/2WH9OGvxQpXkCdVKJvhO2xoIISuWM9EDbTk7F/PQ==
X-Received: by 2002:a05:6214:5195:b0:5aa:14b8:e935 with SMTP id
 kl21-20020a056214519500b005aa14b8e935mr3573725qvb.2.1682015963037; 
 Thu, 20 Apr 2023 11:39:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350aKi5xgA2plkiWriD1Mvo1IbP57XENG4+e0T19/igecmwtmBejG9uHeDR/BWWRWuuq3iyfbAA==
X-Received: by 2002:a05:6214:5195:b0:5aa:14b8:e935 with SMTP id
 kl21-20020a056214519500b005aa14b8e935mr3573691qvb.2.1682015962750; 
 Thu, 20 Apr 2023 11:39:22 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca.
 [70.52.229.124]) by smtp.gmail.com with ESMTPSA id
 g19-20020a0caad3000000b005dd8b93457csm570316qvb.20.2023.04.20.11.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 11:39:21 -0700 (PDT)
Date: Thu, 20 Apr 2023 14:39:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
Message-ID: <ZEGG2GJw2DQk689j@x1n>
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, Maxime Coquelin <maxime.coquelin@redhat.com>,
 eperezma@redhat.com, david.marchand@redhat.com
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

On Thu, Apr 20, 2023 at 12:34:06PM +0800, Jason Wang wrote:
> > 3. Coredump:
> >   In order to be able to perform post-mortem analysis, DPDK
> >   Vhost library marks pages used for vrings and descriptors
> >   buffers as MADV_DODUMP using madvise(). However with
> >   VDUSE it fails with -EINVAL. My understanding is that we
> >   set VM_DONTEXPAND flag to the VMAs and madvise's
> >   MADV_DODUMP fails if it is present. I'm not sure to
> >   understand why madvise would prevent MADV_DODUMP if
> >   VM_DONTEXPAND is set. Any thoughts?
> 
> Adding Peter who may know the answer.

I don't.. but I had a quick look, it seems that VM_DONTEXPAND was kind of
reused (and I'm not sure whether it's an abuse or not so far..) to
represent device driver pages since removal of VM_RESERVED:

https://lore.kernel.org/all/20120731103457.20182.88454.stgit@zurg/
https://lore.kernel.org/all/20120731103503.20182.94365.stgit@zurg/

But I think that change at least breaks hugetlb once so there's the
explicit hugetlb check to recover that behavior back:

https://lore.kernel.org/all/20180930054629.29150-1-daniel@linux.ibm.com/

Thanks,

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
