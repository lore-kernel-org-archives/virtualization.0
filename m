Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7ABC433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 15:27:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3208764DE9
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 15:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3208764DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9580687492;
	Fri, 29 Jan 2021 15:27:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZSjCpLAosqi; Fri, 29 Jan 2021 15:27:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E002B87393;
	Fri, 29 Jan 2021 15:27:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE638C08A1;
	Fri, 29 Jan 2021 15:27:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51018C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 325EA86ED8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrribMq6pXmK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:27:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 599EE86F97
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611934024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gmYZJnt6+FQ+vixTPJYqqggz2v8d7EI8kyfQM2zcWk=;
 b=ZISPp1OGJwclDazlTg7J6U7RQR2682NteNGyP+N/2yzs+LFEOnU+M5I1wSp4Q2W2HhpKfr
 qnWkq7x1uJt6oKGm6Lk7CTAn5X/XdGXty5Yg9buURCLvKFiioz0bGGQfrEKix6CbgJ3RHx
 2rtZkqpGhIAThYkF/4hhR0pqbGAFtIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-htJgi-tENhCntlbhboRSFw-1; Fri, 29 Jan 2021 10:27:02 -0500
X-MC-Unique: htJgi-tENhCntlbhboRSFw-1
Received: by mail-wr1-f69.google.com with SMTP id x7so5416995wrp.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7gmYZJnt6+FQ+vixTPJYqqggz2v8d7EI8kyfQM2zcWk=;
 b=piR6Q5oZK1bJ20t9IRthaKVhFUK0aJwy1cTmG9An4hGfdl41A7d74YWttPXXR7oFOb
 /Dn0DGWERBbg8m/en8X+Yi3l9q72L4IQKRLTF4DLXMdFx7kthqqzktYocSKwezr7YtzX
 loNiP0Yu9/djyN4aKPYDqffLozEbe0qUl6seSFdxjmOr6ayyIbvP8Ye8+zQMp2W2T0Mb
 9YyaK8UUFn8X7njVE9DiugaoaoSlJvX3Ik4OAlKxMDd3lr+Qa79bfU+ixzzbqKHELKyn
 UpwKJ/j8OJvB7TB5Ew5eXbydVW10NqKsORyKB3Nw/HRtpojuU11C0Lamveh2gQjlmcXD
 Gjpg==
X-Gm-Message-State: AOAM532YxbSbP7siX+uze6mtGK4iRI8gZt3i/klUDyyNdwAgcYS6wJMA
 fM0Aa3twLIvN8DP4ogPGmtXCZOw5PNV0Ac/ZgZI5MbPZeu00/K1FDg/0ipGWkONFmjLQvRLgNp3
 RX3Kvwb8NcSzYlZszHm9WRPkU4NlN8hXlDsVGYYybzQ==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr5278215wrt.204.1611934021093; 
 Fri, 29 Jan 2021 07:27:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXvTNrHcuGstuQWeIO9pqiN618MZnOR+rYl0V3o+NvjG8o4EgDv5va9k4irO+Ix2dFjIsWgA==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr5278206wrt.204.1611934020959; 
 Fri, 29 Jan 2021 07:27:00 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id x11sm10147364wmi.4.2021.01.29.07.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 07:26:59 -0800 (PST)
Date: Fri, 29 Jan 2021 10:26:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Subject: Re: [PATCH RESEND v3] virtio-input: add multi-touch support
Message-ID: <20210129102647-mutt-send-email-mst@kernel.org>
References: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
 <20210129120654.16180-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20210129120654.16180-1-vasyl.vavrychuk@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: rydberg@bitmath.org, mathias.crombez@faurecia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-input@vger.kernel.org
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

On Fri, Jan 29, 2021 at 02:06:54PM +0200, Vasyl Vavrychuk wrote:
> Hi, All,
> 
> There has been no reply to this patch.
> 
> Is there anything I can do?
> 
> Thanks,
> Vasyl

Gerd any input on this?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
