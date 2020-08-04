Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D5C433E0
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:28:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13D8208A9
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PA9Bfrjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13D8208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB21E221D2;
	Tue,  4 Aug 2020 14:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVN-J3Xp5GRb; Tue,  4 Aug 2020 14:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 93095203E4;
	Tue,  4 Aug 2020 14:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D4FCC0051;
	Tue,  4 Aug 2020 14:28:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19245C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14A8F842A4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75A0Oaj56nDa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:28:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52D3C81A31
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596551303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbBVPTz+4qQmj6PUPVBGDXy1g0Mv+s+KUivSkrwVDIE=;
 b=PA9Bfrjv9OiBxarXkYyGa+U8a0hEyln3AD1oVPHa4pfwkB6I8Ml8DuyF/a0M4SrcT1v9C/
 LMlZ5D4uu85eVRlDcwSDWFWmODDphSuwsgQoKtkk60qJnvOGSBmoXjFBVydKfVJy7YVRew
 R9+4RsoK0FM6npc0haohVU2wEkxCVaA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-DvpHUn8CMKydHWdRQqw-eQ-1; Tue, 04 Aug 2020 10:28:11 -0400
X-MC-Unique: DvpHUn8CMKydHWdRQqw-eQ-1
Received: by mail-qk1-f200.google.com with SMTP id d131so28721195qke.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 07:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cbBVPTz+4qQmj6PUPVBGDXy1g0Mv+s+KUivSkrwVDIE=;
 b=QZgQDzPpJMv0bjSpKGAi/O0+g1Vq9TWc/76yG3FL19EaqaXxdfOANHoCG7jf3mDxXT
 2j2uDU4MYk8IPdU73n8UzQcfsc2t/nnO5/Fj0njdgUTBUBpDjK6Z/oOVWjCZFlYU7L8B
 k6J+sRytri3Iu+U/ERmw7f7z3ke7oCD6+l0PZSQOPWY8AiqXqHeNZC5DnEaOar8v+g6u
 tsXVZh1li4VdNNsmvmKAiTWNmO3b47AtWOTL9fyeM+ohn01XYjagEEK6Z0NTBFOeLdVT
 KsFOCzgBq8NO0GurMBhk3yzDvETq3C1MUzV76Lr3W/bpKszE002AIzuarfXhBJgYkFlB
 mfcw==
X-Gm-Message-State: AOAM532IcktIk/yizQDjaGsPhQO+u7Lr57euMtv4i88pNodP8/sg8Off
 +yo5P68PQVtRyQEgXM08jJ+O0wuQqeT+K1Nnby5tdr9wqZ5buLU+VFslWJ9yLNqyAcRXa3/y4oX
 pZ0PoTDMJro/sIWEr/LkzfYuFId6kLdu0NAOwfdlAMQ==
X-Received: by 2002:a37:e110:: with SMTP id c16mr20618423qkm.243.1596551291169; 
 Tue, 04 Aug 2020 07:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNYr64uWxrgZzq/NhikZJkGGsFCOpYd/PIReiG0EgEVdOBFwlavIfWEGbkWktSojL8R7KNlA==
X-Received: by 2002:a37:e110:: with SMTP id c16mr20618398qkm.243.1596551290835; 
 Tue, 04 Aug 2020 07:28:10 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id m26sm26101110qtc.83.2020.08.04.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:28:09 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:28:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200804102730-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <20200804162340.046b719b.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804162340.046b719b.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Aug 04, 2020 at 04:23:40PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 16:58:46 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Currently all config space fields are of the type __uXX.
> > This confuses people and some drivers (notably vdpa)
> > access them using CPU endian-ness - which only
> > works well for legacy or LE platforms.
> > 
> > Update virtio_cread/virtio_cwrite macros to allow __virtioXX
> > and __leXX field types. Follow-up patches will convert
> > config space to use these types.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 50 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> (...)
> 
> > @@ -287,12 +288,57 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
> >  	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
> >  }
> >  
> > +/*
> > + * Only the checker differentiates between __virtioXX and __uXX types. But we
> > + * try to share as much code as we can with the regular GCC build.
> > + */
> > +#if !defined(CONFIG_CC_IS_GCC) && !defined(__CHECKER__)
> > +
> > +/* Not a checker - we can keep things simple */
> > +#define __virtio_native_typeof(x) typeof(x)
> > +
> > +#else
> > +
> > +/*
> > + * We build this out of a couple of helper macros in a vain attempt to
> > + * help you keep your lunch down while reading it.
> > + */
> 
> It might help with the lunch, but it still gives a slight queasiness.
> No ideas for a better version, though.

A later patch fixes this. Hopefully :)

> > +#define __virtio_pick_value(x, type, then, otherwise)			\
> > +	__builtin_choose_expr(__same_type(x, type), then, otherwise)
> > +
> > +#define __virtio_pick_type(x, type, then, otherwise)			\
> > +	__virtio_pick_value(x, type, (then)0, otherwise)
> > +
> > +#define __virtio_pick_endian(x, x16, x32, x64, otherwise)			\
> > +	__virtio_pick_type(x, x16, __u16,					\
> > +		__virtio_pick_type(x, x32, __u32,				\
> > +			__virtio_pick_type(x, x64, __u64,			\
> > +				otherwise)))
> > +
> > +#define __virtio_native_typeof(x) typeof(					\
> > +	__virtio_pick_type(x, __u8, __u8,					\
> > +		__virtio_pick_endian(x, __virtio16, __virtio32, __virtio64,	\
> > +			__virtio_pick_endian(x, __le16, __le32, __le64,		\
> > +				__virtio_pick_endian(x, __u16, __u32, __u64,	\
> > +					/* No other type allowed */		\
> > +					(void)0)))))
> > +
> > +#endif
> > +
> > +#define __virtio_native_type(structname, member) \
> > +	__virtio_native_typeof(((structname*)0)->member)
> > +
> > +#define __virtio_typecheck(structname, member, val) \
> > +		/* Must match the member's type, and be integer */ \
> > +		typecheck(__virtio_native_type(structname, member), (val))
> > +
> > +
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
