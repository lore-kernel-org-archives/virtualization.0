Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D9AC38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A6576126A;
	Fri, 27 Jan 2023 10:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A6576126A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qvi74xFR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CF9hNnjtaG4B; Fri, 27 Jan 2023 10:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD82C6122A;
	Fri, 27 Jan 2023 10:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD82C6122A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D1BC0032;
	Fri, 27 Jan 2023 10:43:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11BFBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCA596122A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCA596122A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mrQ_EnC6FMqc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:43:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B93A608A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B93A608A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674816196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTfPl3c3f1VoKTsiAdeDP/J/ZEut+m7MZnA9ug3tumE=;
 b=Qvi74xFRjN/7v7YH8o4L9AnP7sXMhjOWTaQdFY7YQixhvlhwuDRPGgxJkfwEqqWyg6GdI7
 LlBhqZi2R5y5xF/3c6G1lqtFUAjSCuQibjzRvr9grelD+zzWHomoHRRqOtYg/XejasB0zR
 nxpnObJDAesoS6RfANRKspOeZIGcJG4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-4XpFWErqO0eGbuGnsNCyiw-1; Fri, 27 Jan 2023 05:43:15 -0500
X-MC-Unique: 4XpFWErqO0eGbuGnsNCyiw-1
Received: by mail-wm1-f70.google.com with SMTP id
 r15-20020a05600c35cf00b003d9a14517b2so4441003wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTfPl3c3f1VoKTsiAdeDP/J/ZEut+m7MZnA9ug3tumE=;
 b=kZLzhX6jKkFTbAKH01iqD/5UISfbpatBG42/67UXc0/sGoqZxISIJeIFzTVH7+HwJA
 KahDuYjnASOdzO7BQMReSrXXy6bHmQvo4d9THLZ8p5utF4IZLw0bC+bz9lOPD3kTQYvK
 7Cc67vCyML0ZTNssplBLo2i840hJ4nPDC/QpKdBvepaMucU4d+nSt6OZ7y2e5gRIcbiD
 qVJpgUqd3jGGQE6JS/865E5NwgmmHQVOkMcn+9STpezN+K2TbcC1t7arwbqDErEJOk5p
 TIndCL2lKHbD7HfnJsHBCVMyW9/9ScbfXRqeIyEQ0XSYr3yXsqKx6YNbQpnQXLmuOcOz
 J4GA==
X-Gm-Message-State: AFqh2krVHLquHEfQHM9Bh2oCmodENNiizfK+kY6ZFuLMZNxkNYbN01u3
 GPiR8YDb2F6p7l+xVHwcqS0rAeLkns/Jc5+jh7AQadSIwg5Vp0/TC8bP/o0Ni1bDIY6J8on2vpw
 11KW0gH/WiazTvvajXAPNC8RjGA8tFXIua9btKB3Snw==
X-Received: by 2002:a05:6000:1f14:b0:2bd:c484:1b01 with SMTP id
 bv20-20020a0560001f1400b002bdc4841b01mr34985206wrb.53.1674816193892; 
 Fri, 27 Jan 2023 02:43:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVxdYiISutO2q/Q3HoxZljfBek202+XRPURlwvkirHbx7Vz96fqEFBZpHhDE57rD5mXCYTfA==
X-Received: by 2002:a05:6000:1f14:b0:2bd:c484:1b01 with SMTP id
 bv20-20020a0560001f1400b002bdc4841b01mr34985198wrb.53.1674816193681; 
 Fri, 27 Jan 2023 02:43:13 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 m14-20020a5d6a0e000000b002bfd09f2ca6sm1832835wru.3.2023.01.27.02.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:43:12 -0800 (PST)
Date: Fri, 27 Jan 2023 05:43:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH -next] vdpa/mlx5: fix check wrong pointer in
 mlx5_vdpa_add_mac_vlan_rules()
Message-ID: <20230127054259-mutt-send-email-mst@kernel.org>
References: <20230104074418.1737510-1-yangyingliang@huawei.com>
 <DM8PR12MB5400CDBCE2E0150F50E2224FABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB540012D1421616399D0903CCABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230104085605-mutt-send-email-mst@kernel.org>
 <DM8PR12MB540017B7D9940F73F6C060FCABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB540017B7D9940F73F6C060FCABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yang Yingliang <yangyingliang@huawei.com>
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

Were you going to do this?

On Wed, Jan 04, 2023 at 02:31:52PM +0000, Eli Cohen wrote:
> Sure, thanks!
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 4 January 2023 15:58
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>; virtualization@lists.linux-
> > foundation.org; jasowang@redhat.com
> > Subject: Re: [PATCH -next] vdpa/mlx5: fix check wrong pointer in
> > mlx5_vdpa_add_mac_vlan_rules()
> > 
> > On Wed, Jan 04, 2023 at 11:41:31AM +0000, Eli Cohen wrote:
> > > I see these patches were not sent yet.
> > > Michael/Yang Yinglliang, isn't it better to send a fixed patch instead of
> > sending the original and fix on top of it?
> > 
> > depends on the severity of the fix. in this case it seems to leak
> > uninitialized stack data to userspace, so I'd say it's best to
> > squash in the fix.
> > keep signed-off by of the fixup contributor so they get attribution.
> > 
> > --
> > MST
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
