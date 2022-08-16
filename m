Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138FDC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 11:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 991648280E;
	Tue, 16 Aug 2022 11:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 991648280E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hC4ZP5dz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1KQhguIXoZyN; Tue, 16 Aug 2022 11:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BD988276B;
	Tue, 16 Aug 2022 11:59:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BD988276B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04127C0032;
	Tue, 16 Aug 2022 11:59:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F039C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B646827A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B646827A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZVZL8go5oE8A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:59:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E712E8276B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E712E8276B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660651148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OM6pUdSUUp6QPniDZ8MIJNl18lOkrh4q0f0+qUywOA=;
 b=hC4ZP5dz33zAk0vcThqpiN8AHIOq8RNfTDrWvXHo+bsIYzpuB0P7pWwp8oaQwJB+SBsvqH
 xL/Np3OGDxe1CVrtmUpzkv3gsgBFNroGWzNsnSyLv5CTATNHm9QB0AVRnfJquz3fc8g9+H
 SuZ/wxI47V1Wyp55UGLpciDjEy+mYgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-6oD5nFMGNHajGhx5dpfKqw-1; Tue, 16 Aug 2022 07:59:07 -0400
X-MC-Unique: 6oD5nFMGNHajGhx5dpfKqw-1
Received: by mail-wm1-f69.google.com with SMTP id
 c17-20020a7bc011000000b003a2bfaf8d3dso4852643wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 04:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=2OM6pUdSUUp6QPniDZ8MIJNl18lOkrh4q0f0+qUywOA=;
 b=RCVDVhJ/pnmljy93u6wns8/JsIsL+5fe3t29o0weMHszdUCI9SQBWQlImFCWp+c+bt
 YjBayu06scBmon1bhv8jRhFVvMg2pIbPHCu7WVncjQv9I+x9va14IxRwixGouySAnboo
 iXZMeq3F+HxqYFnymOhm53aDfCHbFs7rZ1sCjP/s1/euxwPedGH+ONMNqz8DLYo4/Kfe
 Qb2F+qSJ31H3AUloWQTu/Ul970MR5L9llMDiaIMvpBIhXyRciSzeP/HR7JDP3FeJ/oWU
 cDzMIKOQPggb54rjasfRUDyFxTl95dtJ49liDlSDs5hJbMCMjvtlg+fbUItXfn0OyMBv
 xl8w==
X-Gm-Message-State: ACgBeo1it7d5mAZnKbNcdsTUiHoDNk+pXg7MQFzw5gIw6nhaMfULQVeQ
 qkX4bxBlBCyLXmfzMqxYxlSnEy4GTikrnaIY6RQXII9KDWctR0vfg7MJDwme+keyvaRe5jCKOTC
 0eGyvNGSMSO69kSnTdc8D3972GzEHMeQQ+cVbj/XkuQ==
X-Received: by 2002:a5d:5a92:0:b0:223:7af9:be0e with SMTP id
 bp18-20020a5d5a92000000b002237af9be0emr11660950wrb.259.1660651146722; 
 Tue, 16 Aug 2022 04:59:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6gxmknxx5ktbLZ9nqQFAUQ5Ixbwsmqbq3QmSTvmQpe59XkmCj2Yi45lr2XbiDdb/WnChWSyg==
X-Received: by 2002:a5d:5a92:0:b0:223:7af9:be0e with SMTP id
 bp18-20020a5d5a92000000b002237af9be0emr11660939wrb.259.1660651146484; 
 Tue, 16 Aug 2022 04:59:06 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 n1-20020adffe01000000b0021b956da1dcsm9790573wrr.113.2022.08.16.04.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 04:59:05 -0700 (PDT)
Date: Tue, 16 Aug 2022 07:59:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] vduse:  Remove include of rwlock.h
Message-ID: <20220816075831-mutt-send-email-mst@kernel.org>
References: <20220816074816.173227-1-bigeasy@linutronix.de>
 <20220816042557-mutt-send-email-mst@kernel.org>
 <YvtWdVtH4Y0MuG7k@linutronix.de>
 <20220816043636-mutt-send-email-mst@kernel.org>
 <Yvt1R37f9QCLV0/F@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <Yvt1R37f9QCLV0/F@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xie Yongji <xieyongji@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Aug 16, 2022 at 12:45:27PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-16 04:39:29 [-0400], Michael S. Tsirkin wrote:
> > rwlock: detect use outside of spinlock.h
> > 
> > current ifndef does not really prevent including rwlock.h
> > directly.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Actually, yes, this should do the job and render the checkpatch.pl
> patch, I sent earlier, obsolete.
> 
> Sebastian

Feel free to include in a series.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
