Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79DC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 10:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F07F60F3E;
	Tue,  8 Mar 2022 10:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahfFkujCvTEA; Tue,  8 Mar 2022 10:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D899D60B33;
	Tue,  8 Mar 2022 10:46:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7EADC001D;
	Tue,  8 Mar 2022 10:46:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E26DDC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D12F4829DB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXfM7hKujtz4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:46:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22C6682998
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646736380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ir4eth+8SXEAvu2iu7KvlL909Ar2sGBjZGhyG6OKBvE=;
 b=CQg4vXtHR0X7Qe9EID/xq9upILmwC3873HMND0HOxmPvdDZLaZYiJZ5/T29iVxf5wku7Py
 3zAOTdOx5S9JXXYoJJgYJw9j+1WGdsp/LmaR4kHP0M3flwrSg6HQvwmVVzx1M0sMmoapOw
 HdWDDIDnz0HoKe1sVZRYpH6GYsejVy4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-w_OLgBmrP2evBBFZX-VD2Q-1; Tue, 08 Mar 2022 05:46:17 -0500
X-MC-Unique: w_OLgBmrP2evBBFZX-VD2Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 m12-20020a1709062acc00b006cfc98179e2so8488254eje.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 02:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ir4eth+8SXEAvu2iu7KvlL909Ar2sGBjZGhyG6OKBvE=;
 b=IndHRhFhRsk5ZvgdCgxcUAAPqwbhp1ZXJ4Vv543gAbw/XiVVnfp3BuamBwO+Y96nuF
 PJmCzOjyYolrJXMRV5MQzZPkFGjFim6w0OLK3cgI5Z/TRkz0zqiz92XbEQs5ajJvFsL1
 UFIErttGh0CLDemVtyd+HOSPVVkpaIWqrrhW9wr4NqjKTkQnv8CvUgdPSwqBLx6lj52P
 q+6IFD+COk5lxfKvXNkdjYLzIwjGe3WzRpjKQe2gz5mHgn7c6VCcAFx/t9qn70DU8eTm
 ycbb1JVDaUupFLKryQVduiOEkC3Q7DPyZpQjIUEqg3Pyb2gn1Nb4QiP7EFELAfYeWc+d
 M6SQ==
X-Gm-Message-State: AOAM5311X0QhEdFviAk3j7elgCRWCDfhu4aIn2qHJVWq0CVRMy+2CdQ2
 NHB3LqIslI2KeocE6Ejh8EQjU52yx7yGOHh2s/tRgwKb5mDY8KjDIHrO43PezmS4lMKuTYdyTuH
 FLyLBdY6Npfd/qiM4Zgo2QqapFCtnY203lLKY1cRmeA==
X-Received: by 2002:aa7:c5d7:0:b0:415:ee77:d6f2 with SMTP id
 h23-20020aa7c5d7000000b00415ee77d6f2mr15566315eds.208.1646736376538; 
 Tue, 08 Mar 2022 02:46:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztJ1XPjjMKydcCWNB4A1TRlRhUc+HOKibm3mmtdw3nibRNcdVRjv2cCSorjNhOwjHxV8IHxw==
X-Received: by 2002:aa7:c5d7:0:b0:415:ee77:d6f2 with SMTP id
 h23-20020aa7c5d7000000b00415ee77d6f2mr15566287eds.208.1646736376326; 
 Tue, 08 Mar 2022 02:46:16 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 u9-20020a170906124900b006ce88a505a1sm5851858eja.179.2022.03.08.02.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 02:46:15 -0800 (PST)
Date: Tue, 8 Mar 2022 05:46:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
Message-ID: <20220308054213-mutt-send-email-mst@kernel.org>
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
> Generally, yes.


So generally I support the idea of merging code gradually.  And merging
with an unstable flag to enable it is a reasonable way to do it.
However we are half a day away from soft freeze, so this will just
result in the feature getting to users in it's current not really
useable form. If we just want to simplify upstreaming then
merging patches 1-14 for now would be one way to do it.
If you want to do it through your tree then ok

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
