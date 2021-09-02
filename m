Return-Path: <SRS0=fDOL=NY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1515C432BE
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 15:16:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB05610A2
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 15:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CB05610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E1B74076D;
	Thu,  2 Sep 2021 15:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QpQf0b83HgK3; Thu,  2 Sep 2021 15:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E307E40768;
	Thu,  2 Sep 2021 15:16:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA601C0010;
	Thu,  2 Sep 2021 15:16:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14867C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01F4140768
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I_tE9aDhM5pd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40F2740749
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630595789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+xP+wLYOPrkRCNRBb2x5tHhjBwlMaOVmyphk+jfNrg=;
 b=GZQ2YH3vtgEXTQ7m+yUY4cxfKGg7DYtYs/dcanDeNFeFuw0uLFeRTmMGFpiWoM93atErsO
 52s0+vGXkW8Jzj2eUYVo3hWkPdUsgb39/2tnTZlt4twfLEVH7QM+BAx50UTKfchdA8g82k
 Fr9cwPwgVO2wi1f5iR1N85NN0KTatEs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-SxfHZRLmO2qnE8cILPj6lA-1; Thu, 02 Sep 2021 11:16:28 -0400
X-MC-Unique: SxfHZRLmO2qnE8cILPj6lA-1
Received: by mail-ej1-f72.google.com with SMTP id
 x21-20020a170906135500b005d8d4900c5eso1094923ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Sep 2021 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P+xP+wLYOPrkRCNRBb2x5tHhjBwlMaOVmyphk+jfNrg=;
 b=j6gs71hFSpaiooGwuZSjXKq4WalUzw0TCbpSDWPPWIngx/v7q5zLTL74ftwMSAoPYL
 jRTwQmKazwYZnrI/3BqBVwjoJ6vmGYqMgx7FNX7O0MZoG6hyZxgjLdTEOE200UAc73Mr
 ntLLW339wCQ2W+/XdQxmf+ml4z7oid+nZSZGl/OqwQGPQkt8PgnXGjx0KAtTpfBnYyhc
 RmT37OII9HqO+ow3eFWD5Q13qk3aC2+awXGiHLCZH/FZ0o13b8Ct6dxbXw0ClmH9/7eU
 JGxpFTK+vAklWNxBGc5LLSIJ1tNEn14IEG384r14bxjKS645rO/YI3z7FVLxulGR/K9D
 cETw==
X-Gm-Message-State: AOAM531MMlQty1Wi4iRK1v9gMha9iojR5I0mqAPfSRp48IArVaef5EgM
 FenSkPb0DVlV5E1SjumWKx9P2RoGEz2qCEZkZvhLxSCiNp3yTrkb2f/Nys1/d1bZhdmncWXdbRy
 Dp6Uf5+vCzdS7LmQvWB/sVDqJ/kGohnvNwHGYxOgPRQ==
X-Received: by 2002:a05:6402:2909:: with SMTP id
 ee9mr3940287edb.377.1630595787552; 
 Thu, 02 Sep 2021 08:16:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvdswIUfKGCpx598o8TrM8YiJqz9vjAp7AEL9/nn4zRuT+kpCK9mYHSHPKCJI7JCs7p2TIFQ==
X-Received: by 2002:a05:6402:2909:: with SMTP id
 ee9mr3940266edb.377.1630595787408; 
 Thu, 02 Sep 2021 08:16:27 -0700 (PDT)
Received: from redhat.com ([2.55.140.175])
 by smtp.gmail.com with ESMTPSA id bx11sm1366868ejb.107.2021.09.02.08.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 08:16:26 -0700 (PDT)
Date: Thu, 2 Sep 2021 11:16:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junji Wei <weijunji@bytedance.com>
Subject: Re: [RFC 5/5] hw/virtio-rdma: VirtIO rdma device
Message-ID: <20210902111601-mutt-send-email-mst@kernel.org>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210902130625.25277-6-weijunji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210902130625.25277-6-weijunji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, xieyongji@bytedance.com, linux-rdma@vger.kernel.org,
 cohuck@redhat.com, yuval.shaia.ml@gmail.com,
 virtualization@lists.linux-foundation.org, jgg@ziepe.ca, dledford@redhat.com,
 chaiwen.cc@bytedance.com
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

On Thu, Sep 02, 2021 at 09:06:25PM +0800, Junji Wei wrote:
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index b052355ac7..4c2151bffb 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -48,5 +48,6 @@
>  #define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_RDMA         30 /* virtio rdma */

You can start by registering this with the virtio TC.

>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
