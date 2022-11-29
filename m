Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ED8C433FE
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 05:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6F9781467;
	Tue, 29 Nov 2022 05:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6F9781467
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIPmeNZ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDeiEB2h3zaz; Tue, 29 Nov 2022 05:29:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F84E813A1;
	Tue, 29 Nov 2022 05:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F84E813A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 446DCC0033;
	Tue, 29 Nov 2022 05:29:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35E19C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 05:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A48140B22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 05:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A48140B22
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIPmeNZ0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RSJpAD8-hx91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 05:29:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D7CF403A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D7CF403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 05:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669699739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYS1G95kOFRisCA7/CnHJXC2EceWUgSb/ymDdf+izlw=;
 b=UIPmeNZ0fui57yLhCl2yJutpt/snbhf8nBYitUJcd2A6kHNyXlGlq5ORjGPHCgECZFwvIB
 BfivJgg1rodUovcE1/acSTuQBk4MJ6ekiRAx790Q6Ug0HRVuMHTPgbs2eBoy2OfhO+TGs1
 xb6jTdXIUKiE8QG5HcKlbw2J/u2s1/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-cvKWUPVIP9afbhZRdB0Y1A-1; Tue, 29 Nov 2022 00:28:58 -0500
X-MC-Unique: cvKWUPVIP9afbhZRdB0Y1A-1
Received: by mail-wm1-f70.google.com with SMTP id
 ay40-20020a05600c1e2800b003cf8aa16377so7285215wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 21:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYS1G95kOFRisCA7/CnHJXC2EceWUgSb/ymDdf+izlw=;
 b=ecuu71rHDlpP9TXweFoUiDRSTRtjpOuzOMx5P+UlG3fPF/K5MLmJZIb4FA5O2jKNsF
 WM7sg+9xUpgl7uGWyKvw0TNJRkjaFIdqRI7d1Ptm7iLLduec/9Pm0OgAcUZcSIcnvINH
 2AE5abMJTkJOtyKSAPftrT262kcX5KDTfD4H2SOUQ/7CqXZYR+fztTpJsT4Huqp57gdt
 Z07u45dQ8hSYEV935HpXR/7JkPgqBz337lqA35khPRkUZrduT1aNb7tijm56uPmupcg3
 6u+xG3j7dimdnGoWGeZK/9TjJDtncrag0I9pdxgXb3znl9Hnzo8/SDJuuqtjogsu2w8b
 aUCQ==
X-Gm-Message-State: ANoB5pnyIRxra+ymFysvJ3qd4d0VCpbBiazyXf++vFwg3k9uZ9qNgjsH
 0NmzB1TsYpf59xPfeDjPhsmbFrbr7AZ2ombAorEsDzNpq4UCtFbU4jFdE208hwrw8mR4EUv3aF+
 OOpdo5SHxRTbQcgqsq4qKAtj70tiB6Obp9otOR//nAw==
X-Received: by 2002:adf:a552:0:b0:242:1425:ddbd with SMTP id
 j18-20020adfa552000000b002421425ddbdmr5842581wrb.508.1669699734865; 
 Mon, 28 Nov 2022 21:28:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5wSXKlYcnqyaxTuUcfL70Oygr4U1qikduSAwBqZm3XYAz8qpy7Yf8kSOCXNCsG/XTZKjye1A==
X-Received: by 2002:adf:a552:0:b0:242:1425:ddbd with SMTP id
 j18-20020adfa552000000b002421425ddbdmr5842577wrb.508.1669699734643; 
 Mon, 28 Nov 2022 21:28:54 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b00236883f2f5csm12594552wrn.94.2022.11.28.21.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 21:28:53 -0800 (PST)
Date: Tue, 29 Nov 2022 00:28:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221129001239-mutt-send-email-mst@kernel.org>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora>
 <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 29, 2022 at 04:28:54AM +0000, Chaitanya Kulkarni wrote:
> On 11/28/22 11:07, Stefan Hajnoczi wrote:
> > On Fri, Nov 25, 2022 at 12:09:45AM +0200, Alvaro Karsz wrote:
> >>> I suggest defining a separate UAPI struct for this ioctl.
> >>
> >> Sounds fine to me.
> >> I could use the following struct
> >>
> >> struct virtio_blk_lifetime_ioctl {
> >>          u16 pre_eol_info;
> >>          u16 device_lifetime_est_typ_a;
> >>          u16 device_lifetime_est_typ_b;
> >>          u16 padding;
> >> };
> > 
> > Looks good.
> > 
> > Stefan
> 
> with above definition how can one extend existing IOCTL to
> have new members in future ?
> 
> e.g. from above structure
> type_a -> SLC
> type_b -> MLC
> 
> so if someone wants to add type_c info for Quad-level cell(QLC)
> flash memory then type_d and so forth then how can this be
> achieved without adding a new IOCTL since ?
> 
> OR
> 
> just adding new members to user API ioctl struct will work
> fine ?
> 
> -ck
> 


You can do this since ioctl encodes the struct size.
But if that is envisioned then you don't really need padding.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
