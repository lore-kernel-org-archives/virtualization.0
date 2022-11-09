Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B935C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 06:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DADE416D2;
	Wed,  9 Nov 2022 06:52:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DADE416D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UiZDjOtX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFraMXLNKDAm; Wed,  9 Nov 2022 06:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EF164031B;
	Wed,  9 Nov 2022 06:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EF164031B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7126CC0033;
	Wed,  9 Nov 2022 06:52:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C183BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 06:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 867AC416D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 06:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 867AC416D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGZTInF6vpXf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 06:52:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B9B24031B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B9B24031B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667976734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEQm6ll15sTbXHinKEExTDczQQxF7mS5pezlmOAp8H4=;
 b=UiZDjOtX819JyfCqsQjlepl4iZkDJHM2XdQIW4L08vVsLqRGodtMlV3W8klhcrDtbDtFFF
 +kTIg+fINPXzqWcJEaaoG9sLRBpm+z9k30n9OFClIPm84wWC29OJbS2ldyrPbgjLvuBGUq
 GMMY1Zq/lovcd8V0dwzlXbSUjE1iW/Y=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-U-IxZoAkN6KoqXhzpHm4Ww-1; Wed, 09 Nov 2022 01:52:08 -0500
X-MC-Unique: U-IxZoAkN6KoqXhzpHm4Ww-1
Received: by mail-oi1-f198.google.com with SMTP id
 z19-20020a056808029300b0035a774ed30aso2864613oic.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 22:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEQm6ll15sTbXHinKEExTDczQQxF7mS5pezlmOAp8H4=;
 b=FdGStyeOc5YX/vVKXqDIkJTF/lJn9ijXDdzgAg24iKTus1066C0Xd4lanVmbW9HrO6
 amH47oFx35vHlVPocKPCfqILEbAigAGfqW3D2a3hJ3/XfnMALHOiLnfN6mFxVQS1WI/F
 urZKERJe4FhAEtUUe6nqNEertBJG/kcUqGn9h9ZLy3HaGI7YU0EehkpRbyXXCS+Sh6Jw
 7CrmIMrdLmMALbYBNShxrEMLOcNLRcTW4vB0sNcuxc7pzzF2QO/oqqLqCrkv+5RqocHS
 9HGvhX+EjVw55WFOgZBai8EmTZN+YLUlDQ+BwbeaNsrAvaq2tJokTMrTAsAxY8PX5ELM
 /Cqw==
X-Gm-Message-State: ACrzQf0bXxHTXwSe8qte+vSPswRJjNRvPMbZ33QXNUUtuRHnRVFZqO3V
 oIxf8wCV7nea1QbCgiBUVUHUakIzH9IkIj5Dcpb35lwlLb2fLZpJve28RFDKgsZNHMhZIR+N/RM
 +S1w8LPZevsD4E5RTrO9LtYA4CVjZ8YsmkFqWGtj5M2CKy8wXWyyDG7kZAg==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr15034516oib.35.1667976728079; 
 Tue, 08 Nov 2022 22:52:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4qtLuPh0nKXATGmBFwCEqcdI+mDTOIOAIjlRFKg/2JfSc3O/3P80AYknl85fIYJF2/IYcsnQ6UHQu8+qfn8Xo=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr15034512oib.35.1667976727889; Tue, 08
 Nov 2022 22:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
In-Reply-To: <20221107093345.121648-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 14:51:56 +0800
Message-ID: <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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

On Mon, Nov 7, 2022 at 5:42 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This series implements features provisioning for ifcvf.
> By applying this series, we allow userspace to create
> a vDPA device with selected (management device supported)
> feature bits and mask out others.

I don't see a direct relationship between the first 3 and the last.
Maybe you can state the reason why the restructure is a must for the
feature provisioning. Otherwise, we'd better split the series.

Thanks

>
> Please help review
>
> Thanks
>
> Zhu Lingshan (4):
>   vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
>   vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
>   vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
>   vDPA/ifcvf: implement features provisioning
>
>  drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
>  drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
>  3 files changed, 89 insertions(+), 109 deletions(-)
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
