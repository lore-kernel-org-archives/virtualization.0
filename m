Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB48E7109E
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 21:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93CB841A38;
	Wed, 27 Sep 2023 21:39:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93CB841A38
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+Mlzvwa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYRuLAXBL8zM; Wed, 27 Sep 2023 21:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2FD754053E;
	Wed, 27 Sep 2023 21:39:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FD754053E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10DD2C0071;
	Wed, 27 Sep 2023 21:39:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3648C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A2BD42400
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A2BD42400
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+Mlzvwa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CB0sSZp8tDc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:39:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AA37423FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AA37423FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695850743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeQmh1TPxqqmIxxq+JQLJxEowOzljS/niMYQZ8guqHI=;
 b=J+MlzvwaWeokwv8dJant096xhV3+Wfldvp9fzG34pDBSSWMf7noUTBGyrW8UtxBpjbFpX5
 hWM3TnvC7XODqXUX7VC6eFD5Nvn/nD1u/wyUpDhu9gkGxpdb2Rr+CKI8/l/thc/CmbYCsy
 jG1h7I/ObmIYT7S6LYiDlz4sCclVl8E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-l2nFd_S0NdmRrW0ERQqqlg-1; Wed, 27 Sep 2023 17:39:01 -0400
X-MC-Unique: l2nFd_S0NdmRrW0ERQqqlg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32339eee4c4so3284362f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 14:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695850740; x=1696455540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeQmh1TPxqqmIxxq+JQLJxEowOzljS/niMYQZ8guqHI=;
 b=SQNthxAKyIHAQvRG+1MscdUMUcbOXl7agXxI6Z4bhfJN7KUyI3OiXuBmqH2KqPWnQF
 RW6l98zgbxOEkPVycPwyH37dy3LVtaZQKvglEb3lcQwOQVk+A4Za5YzSyRkxGLOQNxZo
 BnwBRYMuJQOGKtJYyXTF+RyLrVxqGnOZFvwzxJlSwIeku6AEl/a7xHbeHKWE8AdPo44C
 ZLujGjkxOS1x4Jt6gkbP8ZKHSss+S5poYwzyqcts9bb3L49X6XOBBzsKKvqyPFQsXkrh
 YRZDDyoq+m1y+b8NRAPbCKdXuQSKKX20jZ1pYvlduR3eaPrWv+vkvYNTJ85M4/sBwSOx
 2PuQ==
X-Gm-Message-State: AOJu0YwubuGAfamKgst8JlO3YA7gEGHIKNsgFt7TWBOQE+XyOw1Cj4oU
 ds1+eqRe8fmClbjvJh1xPvxaepCO+oRTbcOnyD7cPyKHpmWAonHKUieyiX++kiNeo3zUOl8hcZX
 X/S4gOMCJ8do9qfhAto4d6nTxKMDp3yz33Fc+zz0O6w==
X-Received: by 2002:a05:6000:1378:b0:317:6fff:c32b with SMTP id
 q24-20020a056000137800b003176fffc32bmr2744975wrz.53.1695850740484; 
 Wed, 27 Sep 2023 14:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Tvll3jDgau/XxrTFtu96/pFlsjFV1jgG7sTH056j2F5OzR7W6vwud805oRB7Yim04PiBCw==
X-Received: by 2002:a05:6000:1378:b0:317:6fff:c32b with SMTP id
 q24-20020a056000137800b003176fffc32bmr2744966wrz.53.1695850740180; 
 Wed, 27 Sep 2023 14:39:00 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 n14-20020a5d400e000000b00321773bb933sm18000857wrp.77.2023.09.27.14.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 14:38:59 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:38:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230927173221-mutt-send-email-mst@kernel.org>
References: <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
 <20230925143708-mutt-send-email-mst@kernel.org>
 <20230926004059.GM13733@nvidia.com>
 <20230926014005-mutt-send-email-mst@kernel.org>
 <20230926135057.GO13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230926135057.GO13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
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

On Tue, Sep 26, 2023 at 10:50:57AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 26, 2023 at 01:42:52AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 25, 2023 at 09:40:59PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 25, 2023 at 03:44:11PM -0400, Michael S. Tsirkin wrote:
> > > > > VDPA is very different from this. You might call them both mediation,
> > > > > sure, but then you need another word to describe the additional
> > > > > changes VPDA is doing.
> > > > 
> > > > Sorry about hijacking the thread a little bit, but could you
> > > > call out some of the changes that are the most problematic
> > > > for you?
> > > 
> > > I don't really know these details.
> > 
> > Maybe, you then should desist from saying things like "It entirely fails
> > to achieve the most important thing it needs to do!" You are not making
> > any new friends with saying this about a piece of software without
> > knowing the details.
> 
> I can't tell you what cloud operators are doing, but I can say with
> confidence that it is not the same as VDPA. As I said, if you want to
> know more details you need to ask a cloud operator.
> 
> Jason

So it's not the changes that are problematic, it's that you have
customers who are not using vdpa. The "most important thing" that vdpa
fails at is simply converting your customers from vfio to vdpa.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
