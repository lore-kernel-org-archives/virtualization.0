Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19055C001DE
	for <virtualization@archiver.kernel.org>; Sun, 23 Jul 2023 10:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 831DA415C0;
	Sun, 23 Jul 2023 10:02:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 831DA415C0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQgEjY65
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIE8BmhbhoMV; Sun, 23 Jul 2023 10:02:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AF8D409F8;
	Sun, 23 Jul 2023 10:02:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AF8D409F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 600AEC0071;
	Sun, 23 Jul 2023 10:02:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4D35C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 10:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AB3C40640
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 10:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AB3C40640
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RQgEjY65
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xs-_UxGCwFO5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 10:02:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C32854011D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 10:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C32854011D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690106543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDsrxTSy5pdFtexf9LRIFDEmJDg8QkrIZ2QGbjkCzEg=;
 b=RQgEjY65Tl+vU3AIDavcBi8L9yBZxBbQ9OW+cApPy2rPb0GAnglw3+TwiaUyN13wSGdl+V
 7yNHaCnz3OznBW/GeCGWuV8VxmYz9uJ7CMDYrCtdtph8zTvvq7Ydwv5t/PN0/5V1c7bfx0
 BmS2NLpq+qkAWlBGsIu9V0qc6KTGLdk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-8vBHvJlzNcuiCLsr4ohDeA-1; Sun, 23 Jul 2023 06:02:21 -0400
X-MC-Unique: 8vBHvJlzNcuiCLsr4ohDeA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-314394a798dso1644078f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690106540; x=1690711340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDsrxTSy5pdFtexf9LRIFDEmJDg8QkrIZ2QGbjkCzEg=;
 b=eHo/IskbRyAvMw+lAiVnUllxJO6qZhYQBl0dnId/36r+9KkieZ7A7zt1U0sQ9QyMxb
 FLxwQSB0R2GMujpl7uBZpYU0Mx8L5xZBMQ3085jdWDFZfdmcHp0q2v0zpbCFDOcMRd3Q
 2PJbandnzvtoLGwO7H5F2tDhYLBRCTv1iKPKIDY9LGilNbs7L/kthZwMOed6z8h/8z4U
 yIQ5qr1EWzwVCXsrzmj9a9Jn9Op4L/e1JXoROC3ZzlOZ+EPgSomgMsys/CnJo2C/bCjO
 ynm+593A69m6SGG+NiCRpFQtMHtWG6Uh2rFYFVD+2die2CMCyQymuSPlecjc+9hth2nX
 okSg==
X-Gm-Message-State: ABy/qLZJ6fzolWwVYtp+w1xq6VbhR3XF7GIbaPY9/MaF8+W3hC0eauno
 e6ZHEib7jdHgq+huEqCDCmtzQldRjFnPWpEWNBram9S11jcs4jpiN2av7Kb5towvQN1GBkK5DrG
 RTrqXpq8sNdN/EmhnrZkyRzaA2KmnMmWLAj5ZDWpCaA==
X-Received: by 2002:adf:f586:0:b0:314:1f0:5846 with SMTP id
 f6-20020adff586000000b0031401f05846mr8129286wro.19.1690106540636; 
 Sun, 23 Jul 2023 03:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHyAZcTfeQBjC7G73huCAs7jm2K69QvhdMZ2qkoeEG9Sth+ZH3hv0lYt69KLL9FZqfhMrMYew==
X-Received: by 2002:adf:f586:0:b0:314:1f0:5846 with SMTP id
 f6-20020adff586000000b0031401f05846mr8129277wro.19.1690106540254; 
 Sun, 23 Jul 2023 03:02:20 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 m12-20020adff38c000000b003145559a691sm9270907wro.41.2023.07.23.03.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 03:02:19 -0700 (PDT)
Date: Sun, 23 Jul 2023 06:02:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230723055820-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
In-Reply-To: <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> 
> > Sure, that is another undergoing task I'm working on. If the nlattr is parsed with
> > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore (which is the default
> > for modern nla_parse). 
> 
> For the general netlink interface, the deciding flag should be genl_ops.validate defined in 
> each ops. The default validate flag is strict, while the developer can overwrite the flag 
> with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to say, safer code should 
> enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> 
> Regrads
> Lin


Oh I see.

It started here:

commit 33b347503f014ebf76257327cbc7001c6b721956
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 12:32:00 2021 +0200

    vdpa: Define vdpa mgmt device, ops and a netlink interface

which did:

+               .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,


which was most likely just a copy paste from somewhere, right Parav?

and then everyone kept copying this around.

Parav, Eli can we drop these? There's a tiny chance of breaking something
but I feel there aren't that many users outside mlx5 yet, so if you
guys can test on mlx5 and confirm no breakage, I think we are good.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
