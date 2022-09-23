Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860CBC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 05:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2756F60D53;
	Fri, 23 Sep 2022 05:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2756F60D53
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K49QB8Py
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GNjQBFhbPUgv; Fri, 23 Sep 2022 05:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1CAA60B79;
	Fri, 23 Sep 2022 05:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1CAA60B79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8398FC0033;
	Fri, 23 Sep 2022 05:27:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AACBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC6EA60D4F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC6EA60D4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5KkUvyWkyqa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:27:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71A1060B79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71A1060B79
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663910836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54hcXs5NaqvHuVFOWYtJJdu3qAmbMvzeuWcRhmg64jQ=;
 b=K49QB8PyPG1a9uZ881iDNlWlNKckjBMZ+Sk2qf44JXAyN8phd7XPQtjIbabtzwiPKluJc+
 dr3qz8VFcyXpNz3104V75SEkCZUZjOVjQYJfqASS9CLGAGl6JAT6q2Xhgr7X2nOcnDGofe
 EiUFoXAylX6X+jjWtRk40MpgAtrhwuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-pTKlOzaqPmWQ4mcDkiiang-1; Fri, 23 Sep 2022 01:27:15 -0400
X-MC-Unique: pTKlOzaqPmWQ4mcDkiiang-1
Received: by mail-wm1-f72.google.com with SMTP id
 i132-20020a1c3b8a000000b003b339a8556eso5054548wma.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 22:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=54hcXs5NaqvHuVFOWYtJJdu3qAmbMvzeuWcRhmg64jQ=;
 b=inlBTvnFqy7FLTpc1wcx8u+/JoZqbeD+81lpkpR5OsMWa4dSbpu4fck4EpW13bssJH
 h3EFj4rmu0c99S8FjO+f/pGabFbDWEMAgTCz9hcP6DlPoA/F2i4mDeaJsuHvMac5987W
 znkMs9Hz2Lp4TUsdZXoq1/kNpDYxAkRsIGT/CFNz/pLGzYWSqDsyhH3Q+KNqrbglVK1K
 fsBrVgby/w5tRkiFTfZl2Cfw7y8hBkbWA3x5vglHmR8jcnLMQxftKWOyGX2Get7BWbc5
 lUICo+k8ssLmWyqxAcO1X78UZu0723r74TQiBkBU2AbJAU54UXzJ39al6cfMyawd/YD9
 V0BQ==
X-Gm-Message-State: ACrzQf0/WbebjuD3qQsAQ/NgTFu1YjhWLXpJ9ALR1l8ArkZeuVjVq9Jw
 YHK1EdnEsUH5j+yAhwvoiWF8VwNzZ5LPpbV4WDA1cRWlHodh7D1H2XW+QmnauYe219rXSzULTcd
 6B+VeYUNjtMk59JCQJ/sFec0NPTfx8sNCF5Yy52MJWQ==
X-Received: by 2002:a5d:6b49:0:b0:225:6e92:22f5 with SMTP id
 x9-20020a5d6b49000000b002256e9222f5mr3737865wrw.529.1663910834241; 
 Thu, 22 Sep 2022 22:27:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4C6UJQjurk6zOcCsVpPEPwbuqmlFv7XTmYueUwSwHnPfu4Ub5OWlkNcasEg4DvYeYALwWjWg==
X-Received: by 2002:a5d:6b49:0:b0:225:6e92:22f5 with SMTP id
 x9-20020a5d6b49000000b002256e9222f5mr3737858wrw.529.1663910834037; 
 Thu, 22 Sep 2022 22:27:14 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 q18-20020adfdfd2000000b0022ad393ba3csm6451386wrn.107.2022.09.22.22.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 22:27:13 -0700 (PDT)
Date: Fri, 23 Sep 2022 01:27:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vDPA/ifcvf: fix the Calculation of queuepair
Message-ID: <20220923012645-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB34246957523C124C501790CD854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20220922050156-mutt-send-email-mst@kernel.org>
 <33788b06-6c12-a9e3-4ae3-c817c0842bd3@intel.com>
 <20220922061655-mutt-send-email-mst@kernel.org>
 <b85f98df-62a5-7312-fcdb-12a6f1c61ae4@intel.com>
MIME-Version: 1.0
In-Reply-To: <b85f98df-62a5-7312-fcdb-12a6f1c61ae4@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Thu, Sep 22, 2022 at 06:31:32PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/22/2022 6:17 PM, Michael S. Tsirkin wrote:
> > On Thu, Sep 22, 2022 at 06:07:58PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 9/22/2022 5:06 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 22, 2022 at 08:55:26AM +0000, Angus Chen wrote:
> > > > > >From 4f65eae86ab15d7abb8bd30401187cb195dfd27b Mon Sep 17 00:00:00 2001
> > > > > From: "angus.chen" <angus.chen@jaguarmicro.com>
> > > > > Date: Thu, 22 Sep 2022 14:47:28 +0800
> > > > > Subject: [PATCH]     vDPA/ifcvf: fix the Calculation of queuepair
> > > > > 
> > > > >           The queuepair should be divided by 2
> > > > this is just repeating what the patch does.
> > > > can you include more info pls?
> > > > 
> > > > Documentation/process/5.Posting.rst says among other things:
> > > > 
> > > > To that end, the summary line should describe the effects of and motivation
> > > > for the change as well as possible given the one-line constraint.  The
> > > > detailed description can then amplify on those topics and provide any
> > > > needed additional information.  If the patch fixes a bug, cite the commit
> > > > which introduced the bug if possible (and please provide both the commit ID
> > > > and the title when citing commits).  If a problem is associated with
> > > > specific log or compiler output, include that output to help others
> > > > searching for a solution to the same problem.  If the change is meant to
> > > > support other changes coming in later patch, say so.  If internal APIs are
> > > > changed, detail those changes and how other developers should respond.  In
> > > > general, the more you can put yourself into the shoes of everybody who will
> > > > be reading your changelog, the better that changelog (and the kernel as a
> > > > whole) will be.
> > > > 
> > > > 
> > > > > Signed-off-by: angus.chen <angus.chen@jaguarmicro.com>
> > > > Format should be
> > > > 
> > > > Angus Chen <angus.chen@jaguarmicro.com>
> > > > 
> > > > Also pls drop leading space.
> > > > 
> > > > 
> > > > > ---
> > > > > drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> > > > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > > index 75a703b803a2..3e4486bfa0b7 100644
> > > > > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > > @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
> > > > >           u32 q_pair_id;
> > > > > 
> > > > >           ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > > > -       q_pair_id = qid / hw->nr_vring;
> > > > > +       q_pair_id = qid / 2;
> > > Yes, this should be 2 and actually this cap never work as expected, we are
> > > re-designing this.
> > Do you ack this patch then?
> Yes,
> 
> Acked-by: Zhu Lingshan<lingshan.zhu@intel.com>


Pls note there should be a space before <>. E.g.

Acked-by: Zhu Lingshan <lingshan.zhu@intel.com>

Thanks!

> > 
> > > > >           avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > > > >           last_avail_idx = vp_ioread16(avail_idx_addr);
> > > > > 
> > > > > @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
> > > > >           u32 q_pair_id;
> > > > > 
> > > > >           ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > > > -       q_pair_id = qid / hw->nr_vring;
> > > > > +       q_pair_id = qid / 2;
> > > > >           avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > > > >           hw->vring[qid].last_avail_idx = num;
> > > > >           vp_iowrite16(num, avail_idx_addr);
> > > > Pls CC more widely.
> > > > $ ./scripts/get_maintainer.pl -f drivers/vdpa/ifcvf/ifcvf_base.c
> > > > "Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:6/6=100%)
> > > > Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:1/6=17%)
> > > > Zhu Lingshan <lingshan.zhu@intel.com> (commit_signer:5/6=83%,authored:5/6=83%,added_lines:102/102=100%,removed_lines:108/109=99%)
> > > > Stefano Garzarella <sgarzare@redhat.com> (commit_signer:1/6=17%)
> > > > Tom Rix <trix@redhat.com> (commit_signer:1/6=17%)
> > > > Colin Ian King <colin.king@intel.com> (authored:1/6=17%)
> > > > virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND NET DRIVERS)
> > > > 
> > > > Thanks!
> > > > 
> > > > BTW, Zhu Lingshan, would you like to be listed a patch reviewer in
> > > > MAINTAINERS so people rememeber to CC you? You are working a lot on this
> > > > driver.
> > > sure, please add me in the list.
> > > 
> > > Thanks
> > > Zhu Lingshan
> > > > 
> > > > 
> > > > > --

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
