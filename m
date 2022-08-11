Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5ECC25B0D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 11:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2200415C7;
	Thu, 11 Aug 2022 11:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2200415C7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D+KA/Quy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cgJ6BjWeceP8; Thu, 11 Aug 2022 11:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6EACB40338;
	Thu, 11 Aug 2022 11:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EACB40338
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3321FC0032;
	Thu, 11 Aug 2022 11:23:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CAF5813C4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CAF5813C4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D+KA/Quy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7QWCmL3guoAr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:23:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A653813BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A653813BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660217034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDxPkPA/Vk3OxCoIfjmUcXBTKk9JZQyuU+Qz9bpxhDI=;
 b=D+KA/Quy6UhWFGd/iR0A8xCeS+AD+pKwgcF+8PtRLJSLIHJgl4Yl+TkgpKNT2QeWPeO34f
 4BAwzz5TEtPZ6oiQsR0ylMCmpshqzNw1crvDsnDIieQRmq20Xl2oLZ6hIACzK1RysFxlp/
 2Cx1YFiCwOX/fVHBeKKQub7Y0ZlfhsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-QDKoROUcM6On5whjlUPezw-1; Thu, 11 Aug 2022 07:23:53 -0400
X-MC-Unique: QDKoROUcM6On5whjlUPezw-1
Received: by mail-wm1-f70.google.com with SMTP id
 h62-20020a1c2141000000b003a4f57eaeaaso3328392wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 04:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=QDxPkPA/Vk3OxCoIfjmUcXBTKk9JZQyuU+Qz9bpxhDI=;
 b=vRZiP3Sy30w+VReDNetMABwJkqxcc+vWZMghwmMFWSabJywxskA8PiHyRcqvGTH1Xg
 oh4WomR0p8k9w2f/oOIOOfocEqFzDtk/tJYGya1QGvp3GigmeX1KgvJCkB8zz8SvsqAU
 RSnZR9vVceA6jZ8RD4rw8bCg8GsEoVEO+eFBTDrOt+ZNtdxXn19Rb5bGCvnJI/hoO1EP
 bOUp/jVXOZluOnzDb6HUgls0pl2mhhveEqGIoyFnQq/vkYdBjnu+gXBgnVgYRNbkc43n
 uxQO/NUxLs2T2PTUrkyFQ+x4ts+wK31HZH6PDDzDGDjHott9oU3dkn8ZBMKjEjJzQIBf
 fFhg==
X-Gm-Message-State: ACgBeo0Zr3h/0U7glwah8w1sBkllD7W1I+r8fEsEype1F8wzPhNaV6JE
 dEfDUJaKym6ZccU2WUdZxoxATg32t3qL4ho3y1pOtX7K5w9khMlonVnEHGxhNrks0eAA4J+UAXk
 xGET/pNAQOhVbpQSpbQqpj5nKU7K6z0JiQaTdPYC6jw==
X-Received: by 2002:a5d:6d49:0:b0:21b:a3ba:30b5 with SMTP id
 k9-20020a5d6d49000000b0021ba3ba30b5mr20332436wri.513.1660217032222; 
 Thu, 11 Aug 2022 04:23:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77S6dIzOGsnWQiMM//cWa1GSRI2vnhXId8PTMJGmuNW0RZNb5joCOLTnulYlpkcuj3mY6sIw==
X-Received: by 2002:a5d:6d49:0:b0:21b:a3ba:30b5 with SMTP id
 k9-20020a5d6d49000000b0021ba3ba30b5mr20332411wri.513.1660217031983; 
 Thu, 11 Aug 2022 04:23:51 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c502100b003a5c21c543dsm1192075wmr.7.2022.08.11.04.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 04:23:51 -0700 (PDT)
Date: Thu, 11 Aug 2022 07:23:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 1/4] vdpa: Add suspend operation
Message-ID: <20220811072125-mutt-send-email-mst@kernel.org>
References: <20220810171512.2343333-1-eperezma@redhat.com>
 <20220810171512.2343333-2-eperezma@redhat.com>
 <20220811042717-mutt-send-email-mst@kernel.org>
 <20220811101507.GU3460@kadam>
MIME-Version: 1.0
In-Reply-To: <20220811101507.GU3460@kadam>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Xie Yongji <xieyongji@bytedance.com>, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 dinang@xilinx.com, habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 lvivier@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ecree.xilinx@gmail.com, hanand@xilinx.com, martinpo@xilinx.com,
 gautam.dawar@amd.com, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Aug 11, 2022 at 01:15:08PM +0300, Dan Carpenter wrote:
> On Thu, Aug 11, 2022 at 04:27:32AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Aug 10, 2022 at 07:15:09PM +0200, Eugenio P=E9rez wrote:
> > > This operation is optional: It it's not implemented, backend feature =
bit
> > > will not be exposed.
> > > =

> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > Message-Id: <20220623160738.632852-2-eperezma@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > =

> > What is this message id doing here?
> > =

> =

> I like the Message-Id tag.  It means you can `b4 mbox <mesg-id>` and get
> the thread.

Yes it makes sense in git. But I don't see what it does in this patch
posted to the list. It seems to refer to the previous version of the
patch here. Which is ok I guess but better called out e.g.

Previous-version: <20220623160738.632852-2-eperezma@redhat.com>


> Linus has complained (rough remembering) that everyone is using the
> Link: tag for links to the patch itself.  It's supposed to be for Links
> to bugzilla or to the spec or whatever.  Extra information, too much to
> put in the commit message.  Now the Link tag is useless because it either
> points to the patch or to a bugzilla.  Depend on what you want it to do,
> it *always* points to the opposite thing.
> =

> But I can't remember what people settled on as the alternative to use
> to link to lore...
> =

> In theory, we should be able to figure out the link to lore automatically
> and there have been a couple projects which tried to do this but they
> can't make it work 100%.  Maintainers massage and reformat the patches
> too much before applying them.
> =

> regards,
> dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
