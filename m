Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E4C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 06:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 958E040A65;
	Tue, 18 Oct 2022 06:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 958E040A65
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFac8LPd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCy8dSFBxVWZ; Tue, 18 Oct 2022 06:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 102764016A;
	Tue, 18 Oct 2022 06:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 102764016A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC84C0033;
	Tue, 18 Oct 2022 06:14:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEA8FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C64540A5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C64540A5F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXRoZkLwCSEy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:14:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9112940A49
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9112940A49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666073689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rsyECWNyjXr2eRw7NdPKSjRklFvEOQGdEB16qYBEA8=;
 b=GFac8LPdw/WM8/wji1OD1PY6L3qJqxRJz7hM27ZnDrHQC2dRRRTPaB+bjkeGgVRb+t/PAK
 4NLMuS6Lmnp2jMm80NZ1/GL7J5nsHToTeuNeFyGtsrl5NdFZvJAnpjGIe7nCa4wMQl1Kpf
 RdnHWASFclE81QBlgJYmA7/M2HkMTkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-prF9aSRvOqigQG5rwmMUyw-1; Tue, 18 Oct 2022 02:14:48 -0400
X-MC-Unique: prF9aSRvOqigQG5rwmMUyw-1
Received: by mail-wm1-f71.google.com with SMTP id
 q14-20020a7bce8e000000b003c6b7debf22so6420282wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 23:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rsyECWNyjXr2eRw7NdPKSjRklFvEOQGdEB16qYBEA8=;
 b=xIVWdSxOSEkb89N7OmyyKmv+Hzna7c/jGuOosYynr2rRaieamHc5Vr6zkiqqZ8Muci
 yfLTzpjyW2SJQE/YMS9k/HbyZh1yChAj/xJTSSpDy4bGzjWJdzF2DGcmlQIi2KQirAZ3
 FkdtVx5QmNV0fwQTbhxF+uItXbx0EZ1Ws1L1pjX6zOwABIaBEIEPocN27fk3s+/vsmjE
 tsS2JyTZ9Ka9UNF2jiDQhMQcycKbmlpVqGoJ93IGCwNFKgHOf6ABJNE/eJaQhhy9ekGO
 tLArCvuFYBf85VL9YoqZaqOzIHwT6Hd76I1M0m0E/kknPQE78joHkBd3Rjj9NlczOpQW
 hETg==
X-Gm-Message-State: ACrzQf2ZRZSuotyRaOnxuv6ee3MgRUmCEEep8mfYkJnYskML0Q5nHMpC
 8X+7AKxasr1gsUeBbHf/TruDKLF+yNIvMrRofOl81A472VHVTiFsw8/cr6mwVUrZ/VHFmCAR9B6
 yZeQSOpxjAnrX0rfc3Aa6Dryb8mOoPWJoxMxydIIa2w==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id
 n20-20020a05600c501400b003b5088958a5mr732383wmr.140.1666073686959; 
 Mon, 17 Oct 2022 23:14:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Tz7u48gFvEAO/aAysHRaUfjhMadI4s9LTLGub/eSJZGoKlxT9ZIOy08iJmgIfqzqyr1UssQ==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id
 n20-20020a05600c501400b003b5088958a5mr732364wmr.140.1666073686483; 
 Mon, 17 Oct 2022 23:14:46 -0700 (PDT)
Received: from redhat.com ([2.54.172.104]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d6a52000000b0022af865810esm9962451wrw.75.2022.10.17.23.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 23:14:45 -0700 (PDT)
Date: Tue, 18 Oct 2022 02:14:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Subject: Re: [PATCH v2 4/4] vdpa_sim: Implement resume vdpa op
Message-ID: <20221018021343-mutt-send-email-mst@kernel.org>
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <bdbf1921652c93e372b1e283cd9367a9b5f31447.1665745877.git.sebastien.boeuf@intel.com>
 <CACGkMEvwpt6=hVyZ1aB-oAnt=Wgr158OKvp3_eKqKxJcuJB_7w@mail.gmail.com>
 <2f9a1b3a32d35ab6c40a87fe158f55430ebeb2e2.camel@intel.com>
 <CAJaqyWeLi+mmOFi8-+65XwurFbBcAnCe5XFKjQ=4Gbo4hwhdUw@mail.gmail.com>
 <82ae5fc04bb24019c27552a9cc8a973919f1088d.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <82ae5fc04bb24019c27552a9cc8a973919f1088d.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Oct 17, 2022 at 11:44:44AM +0000, Boeuf, Sebastien wrote:
> On Mon, 2022-10-17 at 13:05 +0200, Eugenio Perez Martin wrote:
> > On Mon, Oct 17, 2022 at 10:47 AM Boeuf, Sebastien
> > <sebastien.boeuf@intel.com> wrote:
> > > =

> > > On Mon, 2022-10-17 at 15:26 +0800, Jason Wang wrote:
> > > > On Fri, Oct 14, 2022 at 7:15 PM <sebastien.boeuf@intel.com>
> > > > wrote:
> > > > > =

> > > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > > =

> > > > > Implement resume operation for vdpa_sim devices, so vhost-vdpa
> > > > > will
> > > > > offer that backend feature and userspace can effectively resume
> > > > > the
> > > > > device.
> > > > > =

> > > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > > ---
> > > > > =A0drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> > > > > =A01 file changed, 13 insertions(+)
> > > > > =

> > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > index b071f0d842fb..195dc60bad3c 100644
> > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > > @@ -527,6 +527,17 @@ static int vdpasim_suspend(struct
> > > > > vdpa_device
> > > > > *vdpa)
> > > > > =A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > > =A0}
> > > > > =

> > > > > +static int vdpasim_resume(struct vdpa_device *vdpa)
> > > > > +{
> > > > > +=A0=A0=A0=A0=A0=A0 struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0 spin_lock(&vdpasim->lock);
> > > > > +=A0=A0=A0=A0=A0=A0 vdpasim->running =3D true;
> > > > > +=A0=A0=A0=A0=A0=A0 spin_unlock(&vdpasim->lock);
> > > > =

> > > > Do we need to schedule work here? Or the assumption is that the
> > > > individual should take care to make sure no kick is lost during a
> > > > suspend/resume?
> > > =

> > > The guest vCPU should be paused, meaning no kick should come from
> > > the
> > > guest while the backend is suspended. But I don't think it would
> > > cause
> > > any harm to schedule some work when resuming the device as this
> > > would
> > > provide a more permissive implementation.
> > > =

> > > Please let me know what you think about it.
> > > =

> > =

> > We should enable the case where the device is suspended by the VMM
> > but
> > the vCPU continues running in my opinion.
> > =

> > I preemptively scheduled work to accommodate this use case in
> > previous
> > versions of the suspend patch [1].
> > =

> > [1] https://lkml.org/lkml/2022/5/24/768
> > =

> > Thanks!
> > =

> =

> Sounds good, I'm going to update the patch to kick the queues on
> resume.

I am not sure the right thing is to kick on resume, that
will bring all kind of issues around startup.
Save and restore state fully.


> Thanks,
> Sebastien
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
> =

> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
