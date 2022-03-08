Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55915C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 10:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E18EA400FD;
	Tue,  8 Mar 2022 10:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHjW5cCYzy7C; Tue,  8 Mar 2022 10:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 617EA40144;
	Tue,  8 Mar 2022 10:48:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C89C001D;
	Tue,  8 Mar 2022 10:48:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1CEEC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD97980ACA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veo9jZk7CiGP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FD25801CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646736508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnC9ehja7ZSJ6msiheS+nNacdW6wbFxQ3RGKfaD8O5k=;
 b=ShBnyN1D6VcelytBsW4rQgLwQSSyX0+4tfUfhBsZWbib8OnPzPbE7D27f1aM3RQJ0sVB32
 mSmWjOC8QFTAJwYu7+qdxgwr+EjD+qnVEftmBsONvM+NCsP5XAqz56NDWH0eDOi5XwswWV
 5AZg1ycsp0/CchzDsDEWgDwaVaNno44=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-8QMF2BQdPR-iXgRYphtOeA-1; Tue, 08 Mar 2022 05:48:27 -0500
X-MC-Unique: 8QMF2BQdPR-iXgRYphtOeA-1
Received: by mail-ed1-f72.google.com with SMTP id
 n11-20020a50cc4b000000b00415e939bf9eso8199180edi.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 02:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AnC9ehja7ZSJ6msiheS+nNacdW6wbFxQ3RGKfaD8O5k=;
 b=6u0+vdDw0x0f/93SJ1o6MyOAVmQyJiH5d+u+hbmsWL1CLadPl2xs60pop6UFJxDqIb
 0dGQU5c/oK+ZENH4ukqedyL/Dtvymcr/8m5p7qhmF+GCzjgK24KQgQrGQmn6v/iLw+kL
 GEhFnP4YWd6vr1WCHBbIXNNiyN6G4UFBDl13qYsTB1kYXVfsqxnZlGh9OCSwz62WGsZ4
 ie9RBJmaP1BQgizcnYIHcebsImve170LiL9wzRZggVgyujN6b8eJWMZdETSQe3iAjBmS
 DXuw8uiu/JxEMGsZvhJqiLGjGnYJ4ydKW0DiwJKq28jWCbkElncspY16jNGOmLFo/yu7
 JEQw==
X-Gm-Message-State: AOAM5327SeOlBlZ7Yitkt1pkJVmyGfsyOpoEjvUTj+t1fblY9Joy+CyP
 o/DRhROU0s+be1MuDjZkGgdcrcL3EuWjlXQW4DLUIZh9eVQjec9BYt3oJgnDf0S7b3YKGU0OE2j
 syC6ACbFndOsP5r8LgoOExVv3oo6oXAoNp2yHzenFYg==
X-Received: by 2002:a17:907:2ce3:b0:6da:b9f4:c100 with SMTP id
 hz3-20020a1709072ce300b006dab9f4c100mr12260272ejc.573.1646736505784; 
 Tue, 08 Mar 2022 02:48:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw73tUo/sc6bSY1rnt1E3h/MWEHU6Uwo/FK7zyJJjJIiZwAoLv6FB1YhFDm08NtbzewiVsZ2A==
X-Received: by 2002:a17:907:2ce3:b0:6da:b9f4:c100 with SMTP id
 hz3-20020a1709072ce300b006dab9f4c100mr12260238ejc.573.1646736505582; 
 Tue, 08 Mar 2022 02:48:25 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 r22-20020a17090638d600b006d584aaa9c9sm5700447ejd.133.2022.03.08.02.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 02:48:25 -0800 (PST)
Date: Tue, 8 Mar 2022 05:48:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
Message-ID: <20220308054623-mutt-send-email-mst@kernel.org>
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <14d4fde4-6ea5-4805-b684-c33f6b448565@redhat.com>
 <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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

On Tue, Mar 08, 2022 at 04:20:53PM +0800, Jason Wang wrote:
> > Not by itself but I'm not sure we can guarantee guest will not
> > attempt to use the IOVA addresses we are reserving down
> > the road.
> 
> The IOVA is allocated via the listeners and stored in the iova tree
> per GPA range as IOVA->(GPA)->HVA.Guests will only see GPA, Qemu
> virtio core see GPA to HVA mapping. And we do a reverse lookup to find
> the HVA->IOVA we allocated previously.  So we have double check here:
> 
> 1) Qemu memory core to make sure the GPA that guest uses is valid
> 2) the IOVA tree that guarantees there will be no HVA beyond what
> guest can see is used
> 
> So technically, there's no way for the guest to use the IOVA address
> allocated for the shadow virtqueue.
> 
> Thanks

I mean, IOVA is programmed in the host hardware to translate to HPA, right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
