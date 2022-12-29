Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE8C3DA79
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 22:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9D7540338;
	Thu, 29 Dec 2022 22:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9D7540338
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Aj1RtIzi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOjW7xkz-Ftd; Thu, 29 Dec 2022 22:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2779340227;
	Thu, 29 Dec 2022 22:27:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2779340227
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02309C0032;
	Thu, 29 Dec 2022 22:27:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6076EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 22:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2688340338
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 22:27:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2688340338
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2lp6ToDsuOk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 22:27:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C27E5402E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C27E5402E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672352874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHbnoPEKbPMw3NITOja3/J1RVGN2ZoCb1fhOFa94LW4=;
 b=Aj1RtIzigq214ew2gghR+NALwlZdF1c/8CBWtWkiMFZKO1qL10FmTfco1AYlc236yIMCDI
 6GyK4jnqgkXSHZdUGkHeDezzCNYYflySa6jJf+t3eBfuDkqYYGVpq+XosFoTqYe3Vmcfzr
 7zYfSh3+OyuiJysyEYfUSbETRShnTgo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-dk35kM4fPGiqZLlmlP2xRQ-1; Thu, 29 Dec 2022 17:27:51 -0500
X-MC-Unique: dk35kM4fPGiqZLlmlP2xRQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 lp10-20020a056214590a00b0053180ee70f1so6103423qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 14:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHbnoPEKbPMw3NITOja3/J1RVGN2ZoCb1fhOFa94LW4=;
 b=1sz/L7X4E9O0eHh8keZlJCDaTsSyH6gFfVCoUnXtQAKrrVYYs8Wu7gNUrnSVp6wex/
 8JXKbB93yDRwTf6UTZKB25tTs+2iyAsSRpRCH2tIjpWQv+jxNL7c6V7z0dLhIX2tXB9I
 /DhaXsfbAC+eczibiHo/SGpzBh629dwten5UIGo3NChZznr5s/ISmfGdXYomxtbYY7Vn
 p6NjTZSF6QE9nR/JZbi36LkXySgP2pTECSleR0qBuVUfqSe0RWA4Auwi5PJkG/CplEoh
 C+GnEOwL20ArgF36RbdvncWUOqPHhU7wEWDvUu7JYc89xPOptm+qSzlRKO2JGYCfo6+I
 ux4A==
X-Gm-Message-State: AFqh2kqpNsqvCUi/41jAYulWQx/zBJOD9wiUaIVEYhhLbUBY/cHXfReq
 NuWRaoUpEMmQgzUuOj1nnfGKWw6XdwB/5N4HmL1bhTbtRB3riKa9pg6U8KkOmvIuWaJm6yuJ1pH
 ui90tGjq4d/wvMfLsWnxfoC7onVW0r0Nl1PE7EQisqw==
X-Received: by 2002:ac8:65da:0:b0:3a9:7332:3f74 with SMTP id
 t26-20020ac865da000000b003a973323f74mr39481605qto.19.1672352870114; 
 Thu, 29 Dec 2022 14:27:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvl1146S1SoqnZLGbNKPU35QzmMmqiJgwLqeEadXm8SV5fx7paXucmPsv2beTTyd8SjCaMJYw==
X-Received: by 2002:ac8:65da:0:b0:3a9:7332:3f74 with SMTP id
 t26-20020ac865da000000b003a973323f74mr39481590qto.19.1672352869857; 
 Thu, 29 Dec 2022 14:27:49 -0800 (PST)
Received: from redhat.com ([5.181.234.214]) by smtp.gmail.com with ESMTPSA id
 bn35-20020a05620a2ae300b00702311aea78sm13723685qkb.82.2022.12.29.14.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Dec 2022 14:27:48 -0800 (PST)
Date: Thu, 29 Dec 2022 17:27:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229172715-mutt-send-email-mst@kernel.org>
References: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
 <20221229212906.GA631104@bhelgaas>
MIME-Version: 1.0
In-Reply-To: <20221229212906.GA631104@bhelgaas>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bhelgaas@google.com, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org
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

On Thu, Dec 29, 2022 at 03:29:06PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 29, 2022 at 11:06:02PM +0200, Alvaro Karsz wrote:
> > > On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > > > The vendor id is used in 2 differrent source files,
> > > > the SNET vdpa driver and pci quirks.
> > >
> > > s/id/ID/                   # both in subject and commit log
> > > s/differrent/different/
> > > s/vdpa/vDPA/               # seems to be the conventional style
> > > s/pci/PCI/
> > >
> > > Make the commit log say what this patch does.
> > >
> > > > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > >
> > > With the above and the sorting fix below:
> > >
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > > ---
> > > >  include/linux/pci_ids.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > > index b362d90eb9b..33bbe3160b4 100644
> > > > --- a/include/linux/pci_ids.h
> > > > +++ b/include/linux/pci_ids.h
> > > > @@ -3115,4 +3115,6 @@
> > > >
> > > >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> > > >
> > > > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
> > >
> > > Move this to the right spot so the file is sorted by vendor ID.
> > > PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> > > added in the wrong place.
> > >
> > > >  #endif /* _LINUX_PCI_IDS_H */
> > > > --
> > 
> > Thanks for your comments.
> > 
> > The patch was taken by another maintainer (CCed)
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70
> > 
> > So, Michael and Bjorn,
> > Do you want me to create a new version, or fix it in a follow up patch?
> > 
> > BTW, the same is true for the next patch in the series, New PCI quirk
> > for SolidRun SNET DPU
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3
> 
> I don't know how Michael runs his tree, so it's up to him, but "New
> PCI quirk for SolidRun SNET DPU." is completely different from all the
> history and not very informative, so if it were via my tree I would
> definitely update both.
> 
> Bjorn

New version pls, I rebase so no problem to replace.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
