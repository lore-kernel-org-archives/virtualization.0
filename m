Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0092DC352A1
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 10:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7335660BF5;
	Wed,  7 Dec 2022 10:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7335660BF5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B2z1Cupf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zl-UUplKkUBh; Wed,  7 Dec 2022 10:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F01E760BBF;
	Wed,  7 Dec 2022 10:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F01E760BBF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C598BC0032;
	Wed,  7 Dec 2022 10:33:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0058C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 10:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7ACF760BF5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 10:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7ACF760BF5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zUQ6rkAayq5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 10:33:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC7EA60BBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC7EA60BBF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670409228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ls/fVzNOQDXdkwGawkCzgkRpahtmHyBL8VCkLV4JQsI=;
 b=B2z1CupfmRljz6erG/A9JjECKNsryZ+mnROZN7KpeqOT0UTlSQFKQ2+dkMjFwo5LK5noaK
 WQNlcBs1vVoxNhh51gDjQybRkzDjQToMULdDNbuPrl27H/wYXf1nszuen7FGZona57GwiA
 1+yLIUg359Qi4w81UVeagX65//DI9Ys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-7Txrvld-Pzy0SCXnXDXn7w-1; Wed, 07 Dec 2022 05:33:32 -0500
X-MC-Unique: 7Txrvld-Pzy0SCXnXDXn7w-1
Received: by mail-wm1-f72.google.com with SMTP id
 c187-20020a1c35c4000000b003cfee3c91cdso9777904wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 02:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ls/fVzNOQDXdkwGawkCzgkRpahtmHyBL8VCkLV4JQsI=;
 b=r0ionaTEJG5uWnf5B6es9+XhHKVy/R9c6NSDMws5s31K4jIjoopF0fE/0+OmNwhItq
 s0zlhs+qAd4YdZVcWRrnQHFvytiLfoLuCxog3p4hkG1uqQQeMOAjfAeodww1WKPrfoqr
 Y9+6NurfPRi11vzyFMD6W+mdjhUersF/OxtokytuQYv/tYuZyVOcBMcfmd7sO/+BWGCt
 Ax+CrHxX6oO3WO8Waa0iHPOehwGkp05tQ+if6WzPpWvNIniObcK+dAkGzNttm0KieXI+
 QIlo59Me8DH+0rq2itn+VLtImUc6/9C2azVkFTogOAk7QkllRUIZEz1XO2ZIK1zAOzmC
 dXaw==
X-Gm-Message-State: ANoB5plK5hgX/lRyDgET4X3AKuVFsik1z7qPLztQVN0CqTyRf+Y+NZgX
 NvB1MukOLMC18nSSxSXpnlTwT+F/U/g7B0MpST6mUVv8GZ2HdPFrP9zyaEc0iIC3p5bDEo2ziiN
 PtMLZdcGhT9svKklVW3vHoyVzgSPjA0/YJgwf7gZu0A==
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id
 d17-20020a5d6dd1000000b0023675a8058dmr56602612wrz.295.1670409211072; 
 Wed, 07 Dec 2022 02:33:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FBlRBE2GeVd3WJhHDz0cWwP9kKA/AUXb7mzTw2ZMVDwXZf0YLLk4DOpcAQ2mrMfXIGB+xvw==
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id
 d17-20020a5d6dd1000000b0023675a8058dmr56602601wrz.295.1670409210856; 
 Wed, 07 Dec 2022 02:33:30 -0800 (PST)
Received: from redhat.com ([2.52.154.114]) by smtp.gmail.com with ESMTPSA id
 b18-20020a05600010d200b002423a5d7cb1sm16105958wrx.113.2022.12.07.02.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 02:33:30 -0800 (PST)
Date: Wed, 7 Dec 2022 05:33:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v2] virtio_pmem: populate numa information
Message-ID: <20221207053242-mutt-send-email-mst@kernel.org>
References: <20221115214036.1571015-1-sammler@google.com>
 <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
 <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
MIME-Version: 1.0
In-Reply-To: <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Mina Almasry <almasrymina@google.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, nvdimm@lists.linux.dev,
 Vishal Verma <vishal.l.verma@intel.com>,
 Michael Sammler <mich.sammler@gmail.com>, linux-kernel@vger.kernel.org,
 Michael Sammler <sammler@google.com>, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Ira Weiny <ira.weiny@intel.com>
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

On Wed, Dec 07, 2022 at 05:09:42AM +0100, Gupta, Pankaj wrote:
> +Cc [MST, virtualization-list]
> 
> Hi Dan, MST,
> 
> > This patch is reviewed and tested. Is there anything that needs to be
> > done from my side (e.g. sync with mainline)?
> 
> If there are no further comments, Can we please merge this patch?
> 
> Thank You,
> Pankaj


I'll take a look. Generally if you want my attention you
should CC me on the patch.

Thanks,
MST

> > 
> > (Adding my alternative email address to this thread as I will soon
> > lose access to the address I am sending this email from.)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
