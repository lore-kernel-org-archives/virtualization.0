Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C2C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A9D040902;
	Mon, 19 Dec 2022 10:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A9D040902
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtpCmquH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JRmssh7DC_Pa; Mon, 19 Dec 2022 10:54:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D32334087C;
	Mon, 19 Dec 2022 10:54:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D32334087C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78D20C0098;
	Mon, 19 Dec 2022 10:54:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D02B0C0094
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93D9181364
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:54:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93D9181364
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtpCmquH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kNuMaPW72VHU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:54:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97A0881340
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97A0881340
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671447243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Imi5FC0W/XbmzN8grqrA4Ol4u2Qy0loJjbLQN73juI=;
 b=WtpCmquH0TQnR/DJRSno5SdWqrVm6ufRTIwesTkuBAXVLIiMFXwVc+7ZH1F+eJ7ZG2hO4b
 tru5BGyhyDtHsuzzt3YnEgwPrkRaj++CDt4iVfi211uVVUSxYTy78J7ZUothuADTa/zE3V
 IQQt8WriLGNwm4PmGgupiIjrhMPPKsg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-LtudjUicMxW3HKIji5TZDw-1; Mon, 19 Dec 2022 05:54:01 -0500
X-MC-Unique: LtudjUicMxW3HKIji5TZDw-1
Received: by mail-qk1-f197.google.com with SMTP id
 br6-20020a05620a460600b007021e1a5c48so7013681qkb.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Imi5FC0W/XbmzN8grqrA4Ol4u2Qy0loJjbLQN73juI=;
 b=LfRw/wXXiXT0WneHgmBTLretcdCGoJSXIioKA0aRDY29NytKhPNmI9vubzuUmtRKUW
 TFilGHKFU3tzi41F9gMbQISl/vcKeGYJ2TuPBn+PXuLSr8TW/b+1BFV3r2VqHHcOz0eR
 VRO4LTOBcK1fuFLoJB5yu8mqKJWeQhotzV3fj1IW7VJVA0sgE8rmOlRrZ/ZSBKdP7O68
 OBTO5on20w7xEaRHTXbpGl1ZtOunTQ48KMrJp5DSth7HywmMYVm4g6RACqKGwcY5nl2o
 YlA/1+54+FYAAOtHY8TjMLe1im+KgR3/BRCeJKjY8Ok90CLLs3L83rjFYHPpDv8tEvpS
 sy0g==
X-Gm-Message-State: ANoB5pn3TBOTAFa45SDv+GpSBEEGxWcqVIeMw4XyrJ2CvnWRX0hE7GwG
 udYQgn4VZ+6m9ZfU4rtjsefnFuSik5WUl9S1iSyZvmLOoZL5cqh2AG6xZrcyyKZe3wPo9HxZQCz
 +tw/ChegnHIRB6wGN7jOQ3KNmlsyqaW8aJZHijTKr6A==
X-Received: by 2002:a05:622a:4892:b0:3a6:8a50:b0ce with SMTP id
 fc18-20020a05622a489200b003a68a50b0cemr65550584qtb.45.1671447240695; 
 Mon, 19 Dec 2022 02:54:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YwmDLlT/UzEDpwaDhnaCwbhcpgiN5ZDlP6ShyWxPIs1qJtENH5qo8kIuUPWHaLgIDUTN2Fw==
X-Received: by 2002:a05:622a:4892:b0:3a6:8a50:b0ce with SMTP id
 fc18-20020a05622a489200b003a68a50b0cemr65550572qtb.45.1671447240469; 
 Mon, 19 Dec 2022 02:54:00 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05620a408b00b006f9ddaaf01esm1909733qko.102.2022.12.19.02.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:54:00 -0800 (PST)
Date: Mon, 19 Dec 2022 05:53:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
Message-ID: <20221219055347-mutt-send-email-mst@kernel.org>
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me>
 <87v8oqsq6k.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <20221219011647-mutt-send-email-mst@kernel.org>
 <2c6e9afa-d162-3835-0b8f-633ae924af7e@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2c6e9afa-d162-3835-0b8f-633ae924af7e@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: corbet@lwn.net, cohuck@redhat.com, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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

On Mon, Dec 19, 2022 at 03:38:11PM +0700, Bagas Sanjaya wrote:
> On 12/19/22 13:20, Michael S. Tsirkin wrote:
> > I think I agree with this comment.  This seems minor enough so I applied
> > the patch for now. Bagas would you like to post your suggestion as a patch on
> > top? Would be appreciated. Thanks!
> > 
> 
> I don't see the patch applied on your tree [1], or applied to where? Or
> even forget to push?
> 
> Thanks.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/

Here:

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=linux-next

> -- 
> An old man doll... just what I always wanted! - Clara

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
