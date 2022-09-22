Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4FAC6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 16:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6119741BA9;
	Thu, 22 Sep 2022 16:58:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6119741BA9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDbOMzQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mFgpZr_bnGF; Thu, 22 Sep 2022 16:58:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 967A241BA4;
	Thu, 22 Sep 2022 16:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 967A241BA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77269C0033;
	Thu, 22 Sep 2022 16:58:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBAC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5B29610EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5B29610EA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDbOMzQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JE8v1XICRIYY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8A796006A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8A796006A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663865929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtLr1E2LfM98pcT9bWZAtpb2IZ6WBGIn+oPzBWfHq0s=;
 b=jDbOMzQjNTZwACvM9L8W2I7q+jt3y9S0/b4FdI/hQLf/9IKhue7ZVAE0q3HH4MBXk+tfaz
 Tc1SV5P7Ws/yKnPuaEzI9QIdlVjubdy+MW/goVNaGhXT5zTSdiGduinoS6LRT+EygSLUeW
 T8a398mvT7jqJ/y/0bgCUr+sJVUHzhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-r6G6eUfBOBmkMmj1YhZwjQ-1; Thu, 22 Sep 2022 12:58:48 -0400
X-MC-Unique: r6G6eUfBOBmkMmj1YhZwjQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay21-20020a05600c1e1500b003b45fd14b53so2798670wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=HtLr1E2LfM98pcT9bWZAtpb2IZ6WBGIn+oPzBWfHq0s=;
 b=o76EjVLwAoJU7cBCVDa1afZLCfKhONNAC9+m+QQcSIKEWFjYz2d0xCF8iqgX2Fr/qT
 NkSCio+OOe6lJwD+zOdZ4llcAYphc5GzFfdh1uB3/XTIfq38DHJIK0we0VxK6C1WpD4G
 6OGIiGb/srqWTk9g9KX5r7c6AMIKuzGmxS3Z7itMk1SMgzIVDkqG3DaIKYzF11BOW7ef
 cK/Mboh2IOSpTNdYXkzDXwQsS761tOr42vJkFAPvyEd/umoK9TsjdkjpSgvnTCJFQaBc
 E8sq1rZrzBkO2aeGvv8n17Yluozc4cWKgevVQIGzrTsgSKU+W66UTxT61ApyeGw6PC36
 XxIA==
X-Gm-Message-State: ACrzQf3Foux9UfvXxXifDh5fm6o4u/5RhQESz4PL51qh1eL38mPBalT+
 C17laC6nu4mVIImDWNzh4DAcDU0fmGGQi5U8o2FLdWxHHKtnq2u3dOp4nbrlNfZvtke9Y/6S2sS
 dK+/K1e2xkUJM0xpBXVBU6X7aR6gDESIqqfoH7GprNQ==
X-Received: by 2002:a5d:540d:0:b0:22a:4069:1e3e with SMTP id
 g13-20020a5d540d000000b0022a40691e3emr2721909wrv.239.1663865927245; 
 Thu, 22 Sep 2022 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5nkBZdrfgBPYHMwVajRNvFWeRMq/bUVE568C3Wsik9tbtPjF6zTDe7sokOLblQSOQTVIE4+w==
X-Received: by 2002:a5d:540d:0:b0:22a:4069:1e3e with SMTP id
 g13-20020a5d540d000000b0022a40691e3emr2721898wrv.239.1663865927021; 
 Thu, 22 Sep 2022 09:58:47 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 e6-20020adfdbc6000000b00228dc37ce2asm5289670wrj.57.2022.09.22.09.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 09:58:46 -0700 (PDT)
Date: Thu, 22 Sep 2022 12:58:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <20220922125744-mutt-send-email-mst@kernel.org>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <Yyin8zSKJb3GPFno@fedora>
 <CAJs=3_ASjr0DF9MTvS=P-ZeJpC4nAH+2vkTjWROzQbS+mvLU4Q@mail.gmail.com>
 <YyoCXOwRE7NLxTTH@fedora>
MIME-Version: 1.0
In-Reply-To: <YyoCXOwRE7NLxTTH@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
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

On Tue, Sep 20, 2022 at 02:11:40PM -0400, Stefan Hajnoczi wrote:
> On Mon, Sep 19, 2022 at 09:09:05PM +0300, Alvaro Karsz wrote:
> > Thanks for the reply.
> > 
> > > This can be simplified with min_not_zero().
> > 
> > Ok, I will do it in the next version.
> > 
> > > It's worth including a comment here that the discard and secure erase
> > > limits are combined because the Linux block layer only has one limit
> > > value. If the block layer supported independent limit values we wouldn't
> > > need to do this.
> > 
> > Ok.
> > 
> > I'll send a new version once we agree on the max_secure_erase_seg = 0 scenario.
> > Do you have an opinion on that?
> > Do you think that using sg_elems as the number of secure erase/discard
> > segments when the value in the virtio config is 0 is good enough?
> > 
> 
> Okay, I have replied in the max_secure_erase_seg sub-thread. I think
> probing the device should fail if the value is 0. There are no existing
> non-compliant devices that we need to be compatible with - let's
> encourage device implementors to report usable max_secure_erase_seg
> values.
> 
> Stefan

I agree, but do we have to fail probe? Are there security concerns
if secure erase functionality is just disabled in this case?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
