Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF3C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 06:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 111BE82F8A;
	Tue, 18 Oct 2022 06:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 111BE82F8A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUIEpgF+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrYwkOGEiX8q; Tue, 18 Oct 2022 06:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 888B782F51;
	Tue, 18 Oct 2022 06:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 888B782F51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E236C0033;
	Tue, 18 Oct 2022 06:13:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1426C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8775640A49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8775640A49
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUIEpgF+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9c1c33U1Vkcz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:13:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 177484016A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 177484016A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666073599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtXof9EW7Eoxhg4x3Pzb8oLCq9PDwrnwJ3aeGtXQeNM=;
 b=ZUIEpgF+RNwV05Se6ezoWenMwJShGeX0kMx51hrJqSjI5yAuQnl7HpQr7bRJkqbhW8peey
 AmBiHAQ2ZWPvfpAKOBddFg+UaMx/swcY0rxWYYN6Q86pYcHuoUA2oxK25vSIO3ZKUEE3a5
 Xnhm0iPQM96Z/WUh4p0TlF1T/g0Yyt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-mSOZ28csMWe8Fqa1ekX9LQ-1; Tue, 18 Oct 2022 02:13:18 -0400
X-MC-Unique: mSOZ28csMWe8Fqa1ekX9LQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 az35-20020a05600c602300b003c5273b79fdso10720616wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 23:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtXof9EW7Eoxhg4x3Pzb8oLCq9PDwrnwJ3aeGtXQeNM=;
 b=ytcBINSDj8vef/nK6o75AIbJ9kt0oiJzEV/LYSsS00iisFrLZanHsrD31uESXUW0Do
 qm+6/E4I9DdUGONyHyENuoMA1ijDyBRKmQ3+17wkn9mMfK+OLGqSiFIwidrZKVyF4nir
 3hur43AhTBCTvPNyCSCaKE9XZPxHqFqZThKZtvBBi2mi7eBQbfVLrIfEjJ3W633dg4Yh
 Fg1kwMCbIWCx9XSuhdcyiH7QvDvubqOniKiI8YjjlDwPEPjvZvyafj9yc5cK4mZwOykX
 DkmoJIdkg5lS6glfn8G05c8sBwdpaECO9kGXZ6xRu/lQIEUzmkdk/QeSN1pOwyL9WqWw
 w+mQ==
X-Gm-Message-State: ACrzQf07/PymyCH3iw8H4rjTzmKJD989aLd2InLT7j36iV3JvzHXHNU6
 fsQBLFb+xEUeVdVF4h9EalNj26T/Y215NFOQmuAauosvAo0j1kIMy6YAbA7vMR5DKSlA19+2qq9
 UGLT/Uu5ksMcdY5du6s8HoW5wh1NcLKOgBh9/pPGCwQ==
X-Received: by 2002:adf:edd1:0:b0:22e:5257:a19e with SMTP id
 v17-20020adfedd1000000b0022e5257a19emr719799wro.180.1666073597460; 
 Mon, 17 Oct 2022 23:13:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5uNZkSRTZ32Gg6x3HdzbQkEeK4vYrc7zr2SS5jCl4w1fCtqfoQs5i68ApvuwPUEEAFi0ExJA==
X-Received: by 2002:adf:edd1:0:b0:22e:5257:a19e with SMTP id
 v17-20020adfedd1000000b0022e5257a19emr719777wro.180.1666073597185; 
 Mon, 17 Oct 2022 23:13:17 -0700 (PDT)
Received: from redhat.com ([2.54.172.104]) by smtp.gmail.com with ESMTPSA id
 m187-20020a1ca3c4000000b003b476cabf1csm12342609wme.26.2022.10.17.23.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 23:13:16 -0700 (PDT)
Date: Tue, 18 Oct 2022 02:13:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v2 1/4] vdpa: Add resume operation
Message-ID: <20221018021110-mutt-send-email-mst@kernel.org>
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <491fb8fe786739958eb9ff3df2250a4188b0bbe5.1665745877.git.sebastien.boeuf@intel.com>
 <CACGkMEviBPXzg1Wyx6coi8o9EPNtERZ43AN_L8Lk5mfuhryycg@mail.gmail.com>
 <d017b048-6f40-bd02-5639-03f0526fef5c@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d017b048-6f40-bd02-5639-03f0526fef5c@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, sebastien.boeuf@intel.com,
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

On Mon, Oct 17, 2022 at 05:12:42PM -0700, Si-Wei Liu wrote:
> Hi,
> 
> I don't know why but it looks that this series wasn't showing up in the list
> for some reason. Only the recipients in the To or Cc lines seemed able to
> get it. Would it be possible to fix the mail client or include me to the
> thread for review?
> 
> Thanks,
> -Siwei
> 

This is true! I didn't notice.

https://lore.kernel.org/virtualization/491fb8fe786739958eb9ff3df2250a4188b0bbe5.1665745877.git.sebastien.boeuf@intel.com/

Sebastien the fix is not to Cc Si-Wei - please fix your setup and
repost, confirm the patches are on list. I am not merging patches that
were not on the list.

thanks!

> 
> On 10/17/2022 12:19 AM, Jason Wang wrote:
> > On Fri, Oct 14, 2022 at 7:14 PM <sebastien.boeuf@intel.com> wrote:
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > 
> > > Add a new operation to allow a vDPA device to be resumed after it has
> > > been suspended. Trying to resume a device that wasn't suspended will
> > > result in a no-op.
> > > 
> > > This operation is optional. If it's not implemented, the associated
> > > backend feature bit will not be exposed. And if the feature bit is not
> > > exposed, invoking this operation will return an error.
> > > 
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >   include/linux/vdpa.h | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 6d0f5e4e82c2..96d308cbf97b 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -219,7 +219,10 @@ struct vdpa_map_file {
> > >    * @reset:                     Reset device
> > >    *                             @vdev: vdpa device
> > >    *                             Returns integer: success (0) or error (< 0)
> > > - * @suspend:                   Suspend or resume the device (optional)
> > > + * @suspend:                   Suspend the device (optional)
> > > + *                             @vdev: vdpa device
> > > + *                             Returns integer: success (0) or error (< 0)
> > > + * @resume:                    Resume the device (optional)
> > >    *                             @vdev: vdpa device
> > >    *                             Returns integer: success (0) or error (< 0)
> > >    * @get_config_size:           Get the size of the configuration space includes
> > > @@ -324,6 +327,7 @@ struct vdpa_config_ops {
> > >          void (*set_status)(struct vdpa_device *vdev, u8 status);
> > >          int (*reset)(struct vdpa_device *vdev);
> > >          int (*suspend)(struct vdpa_device *vdev);
> > > +       int (*resume)(struct vdpa_device *vdev);
> > >          size_t (*get_config_size)(struct vdpa_device *vdev);
> > >          void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> > >                             void *buf, unsigned int len);
> > > --
> > > 2.34.1
> > > 
> > > ---------------------------------------------------------------------
> > > Intel Corporation SAS (French simplified joint stock company)
> > > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > > 92196 Meudon Cedex, France
> > > Registration Number:  302 456 199 R.C.S. NANTERRE
> > > Capital: 5 208 026.16 Euros
> > > 
> > > This e-mail and any attachments may contain confidential material for
> > > the sole use of the intended recipient(s). Any review or distribution
> > > by others is strictly prohibited. If you are not the intended
> > > recipient, please contact the sender and delete all copies.
> > > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
