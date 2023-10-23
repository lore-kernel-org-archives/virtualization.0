Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D03CC001E0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 16:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28E7842133;
	Mon, 23 Oct 2023 16:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28E7842133
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R86D1YbV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNVbDhnJll3v; Mon, 23 Oct 2023 16:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE8AB4207C;
	Mon, 23 Oct 2023 16:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE8AB4207C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84DBCC0071;
	Mon, 23 Oct 2023 16:09:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33662C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01C9342133
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:09:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01C9342133
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ep7Yvd0FPlwA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:09:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AA174207C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AA174207C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698077362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqqE5czpXMxH5iFgmUcq2irlpONgu0FEk0Dvm4SVDQU=;
 b=R86D1YbVnJUc4OOS5bZrRpCufNR1t+Ab/85A1S/+z2Vdsftx+foBFcvNn8tDQHQnzssQq6
 6UWEJXSnhc85rzjHs73ApL4z2y2a0nBfVlka9bUGIC1K2eiUWBaVazKrMulIW6Tt6fPXti
 n8dJShZKQbdNQOnQv26Jtc/G+lhqvrM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sf54ycbpPr6aHnTnily_zQ-1; Mon, 23 Oct 2023 12:09:16 -0400
X-MC-Unique: sf54ycbpPr6aHnTnily_zQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7913a5d6546so469975039f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077355; x=1698682155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqqE5czpXMxH5iFgmUcq2irlpONgu0FEk0Dvm4SVDQU=;
 b=Ks71eRlN0cwWfVCA8IzjdH6nKdEztRIFt1noBPIOiIdaTLJJDbKq3ISPLPvQ4Hdhd4
 JnJjEQHJ2OM6/qIa5FhSU6WdsZw+itWgRf53Mtg2BKZ1WcyOmWW5Tu7Ros/NEAKcdiez
 ge5OQHa3j4EwBaL40q1N3Q+gceWy3OED5ypf9+XkFdKwuF/6zc1gdH8ZV1ivs40EAeDI
 8zecTWNdiZq6py1mAJQAQzR7hKNXy9zN2bIdlH5qDmINv5U/hln16kxR2vJeP0dTN557
 1iQUoGdsg9kWxMYF2NLhzbfJCuFL3XsgAHJKSJUZmaMU7oHx3yXZGGQwPrd1sqDurPAh
 oXdw==
X-Gm-Message-State: AOJu0YzElNQsOLiewriBF68UzXy1iuRIRhk+mcS1YqtQRyqWMryi1zIh
 QpUzBKvqCj9S0lr6vUyeyDILxqDYcsnO01+FIbwn7uMok/gDCixfqkwpZ/5gn9pnbGlw/IcoJSi
 lhV+tyNkpMo7n8IcxkZPzT2rz1ZfdEBZkm8mo8kFzIQ==
X-Received: by 2002:a05:6602:150d:b0:7a9:5ac1:549e with SMTP id
 g13-20020a056602150d00b007a95ac1549emr4219047iow.8.1698077355386; 
 Mon, 23 Oct 2023 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMh98OjQBLUxNybkpE1MPJ4Xw+W2v26Ibokh2vgJ0Hf/IrBfQpSS6ukaHHKPqIszxXCSSIOw==
X-Received: by 2002:a05:6602:150d:b0:7a9:5ac1:549e with SMTP id
 g13-20020a056602150d00b007a95ac1549emr4219022iow.8.1698077355151; 
 Mon, 23 Oct 2023 09:09:15 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 fw13-20020a0566381d8d00b0042b4b55f46fsm2275798jab.117.2023.10.23.09.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:09:14 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:09:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V1 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231023100913.39dcefba.alex.williamson@redhat.com>
In-Reply-To: <20231023154257.GZ3952@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
 <20231023093323.2a20b67c.alex.williamson@redhat.com>
 <20231023154257.GZ3952@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, 23 Oct 2023 12:42:57 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Oct 23, 2023 at 09:33:23AM -0600, Alex Williamson wrote:
> 
> > > Alex,
> > > Are you fine to leave the provisioning of the VF including the control 
> > > of its transitional capability in the device hands as was suggested by 
> > > Jason ?  
> > 
> > If this is the standard we're going to follow, ie. profiling of a
> > device is expected to occur prior to the probe of the vfio-pci variant
> > driver, then we should get the out-of-tree NVIDIA vGPU driver on board
> > with this too.  
> 
> Those GPU drivers are using mdev not vfio-pci..

The SR-IOV mdev vGPUs rely on the IOMMU backing device support which
was removed from upstream.  They only exist in the mdev form on
downstreams which have retained this interface for compatibility and
continuity.  I'm not aware of any other means by which the SR-IOV RID
can be used in the mdev model, therefore only the pre-SR-IOV GPUs
should continue to use the mdev interface.

> mdev doesn't have a way in its uapi to configure the mdev before it is
> created.

Of course.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
