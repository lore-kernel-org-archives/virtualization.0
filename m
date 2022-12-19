Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A0DC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 11:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67CC04090F;
	Mon, 19 Dec 2022 11:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67CC04090F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LothAIOM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-DP-Z0Og6Bn; Mon, 19 Dec 2022 11:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB71F40360;
	Mon, 19 Dec 2022 11:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB71F40360
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DDCC0032;
	Mon, 19 Dec 2022 11:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABA63C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D16860B6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:04:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D16860B6F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LothAIOM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2YNFemBngaRX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2F9160AE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2F9160AE9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671447846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFU8kays3P6TY4J+vE9PvJg8dI00vA5z+YC53FInzgk=;
 b=LothAIOMqq5KmALCQ+2N1AR7Q0HGdP5/BaCXIZKQv54aSmBEUfAGvNHl1ub/+AgVQRi2AJ
 GpjnJzDwtSxi102Z/ou7IivWzlKPTPpOqhuEilxT29Vu2smyPXiz3aWYPOsWwUpQiXcc1o
 I4Kxz+2jcoXT+06QzHH4ABQlq8vp1nw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-ZOEFDVI0PwGys6iTHuWxcQ-1; Mon, 19 Dec 2022 06:04:05 -0500
X-MC-Unique: ZOEFDVI0PwGys6iTHuWxcQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 y11-20020ad457cb000000b004c6fafdde42so5362270qvx.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 03:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFU8kays3P6TY4J+vE9PvJg8dI00vA5z+YC53FInzgk=;
 b=WmIF/jeI+LBAox0bv16jJ/AvAzUsEI2bCM11EXKAQd5rjawARr7T4LF0SPaAOGu1A4
 wrUrFISBBg7IJsxBKtp+zVyGPI20LaQhYQgCBYiv2zVIzFRptQOTj8dbK211N2uAho20
 3kfbUKCHRxDvROwazQQbHTkrawM5SshAYRpsY2CDDwnA1bBGFj5mdfMQnwoEsE8y8C8n
 wKSv8/Lkw+vZ0kS6rsgdENkggZpzq1yGsmoD00fCbIFzkoR/MYLxcKzN6L1CQjlEWrBa
 dLgQ3OIQJG9n+E17etGy3XEFOAQJ5Y4tuC858Vv5Q/RawR/g29JZEMGjpq22YPN4k0W8
 Dbqw==
X-Gm-Message-State: AFqh2kpgkDTOgcgJD8nD0KljjVuDwJmbRxcli5cEz5578jnOEG1QEsOl
 7rJ5JlxFgujE5DJVp/gm9uLSJ83nD77PTFgd/+UUoRHL7kFecQv1Q/azog/hxhFBVueH3dDKRdf
 ItpS3aIlrZg9OHhaSoVLJbpGbJiM4G9M3UVDci+GEyg==
X-Received: by 2002:a05:622a:5c87:b0:39c:da20:602 with SMTP id
 ge7-20020a05622a5c8700b0039cda200602mr14663292qtb.12.1671447845009; 
 Mon, 19 Dec 2022 03:04:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtpZ3T/fTyuYoCeJGeHnvVExHiT5qqMEWOXtZlMAViLpfhcHqxU5KbvEr1y4ZuyR4lkv//1pQ==
X-Received: by 2002:a05:622a:5c87:b0:39c:da20:602 with SMTP id
 ge7-20020a05622a5c8700b0039cda200602mr14663237qtb.12.1671447844491; 
 Mon, 19 Dec 2022 03:04:04 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 u14-20020ac8750e000000b003a70a675066sm5774006qtq.79.2022.12.19.03.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 03:04:04 -0800 (PST)
Date: Mon, 19 Dec 2022 06:03:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219060316-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
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

On Mon, Dec 19, 2022 at 12:55:02PM +0200, Alvaro Karsz wrote:
> > could we add a comment explaining this trick please?
> > can be patch on top ...
> 
> Add a comment where?
> Do you mean adding a comment in the change log?

Right here in kconfig file where the trick is.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
