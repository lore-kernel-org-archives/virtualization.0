Return-Path: <SRS0=oZaN=JI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5ECC433ED
	for <virtualization@archiver.kernel.org>; Sun, 11 Apr 2021 20:49:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979D96102A
	for <virtualization@archiver.kernel.org>; Sun, 11 Apr 2021 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979D96102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B373403A2;
	Sun, 11 Apr 2021 20:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNiPu0WgMf1S; Sun, 11 Apr 2021 20:49:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D128A40197;
	Sun, 11 Apr 2021 20:49:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9962DC000B;
	Sun, 11 Apr 2021 20:49:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D636C000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 20:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C92240370
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 20:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZPgYAfgGsAV
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 20:49:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6438C40197
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618174140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WgCMOQWQVsoo18S8HwQ+Un6/4nDLRTxeG+tZrHLLzJw=;
 b=bdYSWC3XE+cTZlbNJ5prS7TWyaTetI1UTadbwdB3OZ8Bms/mP2E7+2Qfq4OlGxDaDwHByl
 LrpVwOvWlCOqryAbtUmYpyO0ENdagHyCutOo3jEtCtalbpuijVoGgerbf0ORsIaJ98PpXF
 xuPKlL5VInMRM+8sB4eGbYT8QrHq56s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-NyEq_QLAM6CAyLhA_JnHpA-1; Sun, 11 Apr 2021 16:48:58 -0400
X-MC-Unique: NyEq_QLAM6CAyLhA_JnHpA-1
Received: by mail-wm1-f70.google.com with SMTP id
 j187-20020a1c23c40000b0290127873d3384so818971wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 13:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WgCMOQWQVsoo18S8HwQ+Un6/4nDLRTxeG+tZrHLLzJw=;
 b=EKEEc3FTop848hKAsmTEd4h77On6KUqhkWp90h+lTrnJsF/6hYpoRT20PCKcBhAHMS
 zk2DuOO5xqMKTeNCDl/hmnpmCvDJC2Jo1D3ifRmZYPczLvOnC2ejZInFqBdGD86AloDr
 UakIkZu2Zv1GbAh1R9aJokueONPYMeH1CfQDPlAvZdXBB/LVg2imNCAkcBt6BpDxTOwo
 tRXy5O400A94GyWwLnruSrhpoOEgxFkIJwW2+iwpShGeKlUFOyC/VRKPNY8DrKlgf6fQ
 aDDznHtbNyIpFywnRiLkwJ2pj9FJ6gr1UfCwuCNwcC9mtrInWRz7nRNKUeR41UJyNK1z
 8H3A==
X-Gm-Message-State: AOAM5315vlIFTwWKepskRTxxgigFDNgogFgJSPyJtBkMbUrjnjzWpo8w
 Mt7Z8uHkI5EBzQQdZGp50GzxXr3IPFIxRuWo/F0NC0H9PwBGB+WHORBlADIL+dGbbti3O2qfgjJ
 HeHoUENMjr84qSNaG8XoXRu2U09/vie4ao5WFp5wY2A==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr12219250wrp.266.1618174137329; 
 Sun, 11 Apr 2021 13:48:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ8f1z7+lBgJ+qTQWMzJhdvfvlDPXwnCbDDkLtc7bGWr9KZU5tbgznyW47X/5g4qaJepDMnQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr12219231wrp.266.1618174137201; 
 Sun, 11 Apr 2021 13:48:57 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id a8sm15566507wrh.91.2021.04.11.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 13:48:56 -0700 (PDT)
Date: Sun, 11 Apr 2021 16:48:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [PATCH v6 03/10] vhost-vdpa: protect concurrent access to
 vhost device iotlb
Message-ID: <20210411164827-mutt-send-email-mst@kernel.org>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-4-xieyongji@bytedance.com>
 <20210409121512-mutt-send-email-mst@kernel.org>
 <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3tPWwpGBNEqiL4NPrwGZhmUtAVHUZMOdbSHzjhN-ytg_A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Sun, Apr 11, 2021 at 01:36:18PM +0800, Yongji Xie wrote:
> On Sat, Apr 10, 2021 at 12:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 04:05:12PM +0800, Xie Yongji wrote:
> > > Use vhost_dev->mutex to protect vhost device iotlb from
> > > concurrent access.
> > >
> > > Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> > I could not figure out whether there's a bug there now.
> > If yes when is the concurrent access triggered?
> >
> 
> When userspace sends the VHOST_IOTLB_MSG_V2 message concurrently?
> 
> vhost_vdpa_chr_write_iter -> vhost_chr_write_iter ->
> vhost_vdpa_process_iotlb_msg()
> 
> Thanks,
> Yongji

And then what happens currently?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
