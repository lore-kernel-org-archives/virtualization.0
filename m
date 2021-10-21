Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827FB61284
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 827FB61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 509D483C08;
	Thu, 21 Oct 2021 14:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ES1Sa9daSOea; Thu, 21 Oct 2021 14:35:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C452983BEA;
	Thu, 21 Oct 2021 14:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9CEC0033;
	Thu, 21 Oct 2021 14:35:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CEF8C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 14:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EB1060F04
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 14:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eVrWBXyhdsEd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 14:35:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2219660F01
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634826908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
 b=cFz+b8GpgUJ8L3LhXQRA9WnqE7Jvqg5jM7sz9r+C+ytGV1Hvfopeao2XOL5gKQSxTUf+cD
 wrKu497PVobeWv8kdTC1WxJmhVDo7YUuvJEWmIOmvAewluXlNutdJPZ4KWbrg06ThUh19t
 wcaSjhs9Ko2Iaim7r1/xDgHbDMAnpNo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-uvxJa0ziMwGMcDRzce8RkQ-1; Thu, 21 Oct 2021 10:35:06 -0400
X-MC-Unique: uvxJa0ziMwGMcDRzce8RkQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 s12-20020a50dacc000000b003dbf7a78e88so584430edj.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
 b=3TT2E+9Y+uxlrREMu+2xN19427EIOSb7zZWfZNUDDKWptEVO7u4LyHw8zASHNTtu3u
 nzqa/MiOtUZXix1M2JA1FuMVgO84FtNbT85rxSd/CILlJEx944Dv0GLxsIuOSVg1U30u
 4k9avDSlxJA+frilsCsLFrP1eHG7VfeVl5+yX5O5ZwhH5zlt+OMdFjY8xcbfh6D5Ikvv
 CJC5ZdNXdIhZYZDDeMHDme5q0R2sjZUiuQQMn88Rys7LBgddOhTthuPatW3tQxUAWsdU
 jRBcYI3qAUszgU+yNPTsTG3PoDQF5T9vsQFNLmJOmTw+aj/XCNSaKY6h12HwYBhcVPkU
 Pg/Q==
X-Gm-Message-State: AOAM533Ki3j4ArQJtqcdq/Oq3TVBlOAx+K7THvOBV68dp1MAO4R+5XYn
 wym7lI01wGgbyQNOm9yS348tXwLsF40iNk2q3zrCFBE8SxgAxxFuaAzqRlWdOgcszvA2NM4RFmC
 e7TAc5uacLJ3osjr4DoUYekIH0zgfSZhdbsuen5TtBQ==
X-Received: by 2002:a17:907:961e:: with SMTP id
 gb30mr7883135ejc.484.1634826905602; 
 Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSRO0xBoE29HcFaVDTP+mg9VveZQjRkYIv8YWZhFjn3jIIO8pGIPgUQcl4cBQPn6cnJIg4Xw==
X-Received: by 2002:a17:907:961e:: with SMTP id
 gb30mr7883111ejc.484.1634826905435; 
 Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id u18sm2900999eds.86.2021.10.21.07.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Date: Thu, 21 Oct 2021 16:35:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] virtio-blk: fixup coccinelle warnings
Message-ID: <20211021143503.xp7u6qmypvhbl5th@steredhat>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, Ye Guojin <ye.guojin@zte.com.cn>, pbonzini@redhat.com,
 Zeal Robot <zealci@zte.com.cn>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 21, 2021 at 06:51:11AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>coccicheck complains about the use of snprintf() in sysfs show
>functions:
>WARNING  use scnprintf or sprintf
>
>Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>
>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
