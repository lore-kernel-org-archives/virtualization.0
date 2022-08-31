Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB3ECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 15:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD790610FB;
	Wed, 31 Aug 2022 15:46:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD790610FB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VkOc/eUs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLt9MGC6b6Si; Wed, 31 Aug 2022 15:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 797D2610C2;
	Wed, 31 Aug 2022 15:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 797D2610C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39F54C0033;
	Wed, 31 Aug 2022 15:46:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29393C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E477E82FB1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E477E82FB1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VkOc/eUs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33IlZRXyWsEZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77F0E82FCE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77F0E82FCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661960780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FDnsKK2cZELk5wddqmtKkVouG+DKHN8ltWUs0oV7mCc=;
 b=VkOc/eUsODxiVivu1spYJvbiSSztMf0h7EENeoGeeL+wIqrQdfYj6cOgXzd3UaZmMjJENK
 5D1C1hbHvObBHZrChzNxrtJDpVkm27xDfYkqRRh7bnnNRiTuqQNIX42L8qUrb36xY+yZzg
 Q+ty8ZB+9kR5OEL0zH24nd3qvLoRYpY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-FpkmJPzZMKmw0jtwJYdFFA-1; Wed, 31 Aug 2022 11:46:19 -0400
X-MC-Unique: FpkmJPzZMKmw0jtwJYdFFA-1
Received: by mail-wm1-f70.google.com with SMTP id
 h133-20020a1c218b000000b003a5fa79008bso11868260wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=FDnsKK2cZELk5wddqmtKkVouG+DKHN8ltWUs0oV7mCc=;
 b=iiSRjYkQGTSsSc4AsU4hYD2E6BEtA8OlB60SkIEyQcmg/4ooBNFYaq12mDj8dsSsux
 mqV19gxJgzVI91I3XMYbSbRNN4iB0OfOnv5O6QQH14zzQueQUbvCW6FnGaYgylaRuZp9
 4ALHRCf4o4n8Ll1XGYVevBN1Ym6RIoGYzQUH5Hz0Fj+V2NXNSqpTdFq3CG2PV50hnEIt
 akStrC0SL9cmqa/Cj0EuSSxXBRCsRqjcsFeMYsMhtx9OmRyyn1hSCR3DabJTsjIK/XQk
 Sal4IjUED3rcEFeYlb/M3tdWmXy3+lSFXmtMBYL5++iLFCHjBSuLjFGoua57m6nsc9Xb
 WDjg==
X-Gm-Message-State: ACgBeo18QRkNwdWysZTcatm/raiLF9nl9of4D8f7MKjhCYXCG+VfVDEL
 wztsNdBnxkAp+a2LA6ft5ZOa7aiZLoAebRYWHcxy4awJdDxCIHnVwq7ht6J7/QNJNzdoc5m9N/o
 LQQSe0XpY6h9t+zMDnMhlHLxU6v/iTm4O+PK43OFFrg==
X-Received: by 2002:adf:f2c5:0:b0:226:e838:3ed8 with SMTP id
 d5-20020adff2c5000000b00226e8383ed8mr3256080wrp.545.1661960776896; 
 Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR51lk4waATJlZuT8JdfrFRa/Uuco6WTTGuyB1nHXQejK5PjPhp5O0007rSiEEDR6ePRgGWKog==
X-Received: by 2002:adf:f2c5:0:b0:226:e838:3ed8 with SMTP id
 d5-20020adff2c5000000b00226e8383ed8mr3256066wrp.545.1661960776675; 
 Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4850000000b0022546f469e1sm12162234wrs.28.2022.08.31.08.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
Date: Wed, 31 Aug 2022 11:46:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <20220831114534-mutt-send-email-mst@kernel.org>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
 <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: guanjun@linux.alibaba.com, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, gautam.dawar@xilinx.com, dan.carpenter@oracle.com
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

On Wed, Aug 31, 2022 at 05:01:11PM +0200, Maxime Coquelin wrote:
> On 8/29/22 09:48, Greg KH wrote:
> > On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> > > If the VDUSE application provides a smaller config space
> > > than the driver expects, the driver may use uninitialized
> > > memory from the stack.
> > > 
> > > This patch prevents it by initializing the buffer passed by
> > > the driver to store the config value.
> > > 
> > > This fix addresses CVE-2022-2308.
> > > 
> > > Cc: xieyongji@bytedance.com
> > > Cc: stable@vger.kernel.org # v5.15+
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > 
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > Please no blank line above the Acked-by: line here if possible.
> 
> Sure.
> 
> Jason, do you prefer I post a new revision with this single change or
> you will handle it while applying? Either way is fine to me.
> 
> Thanks,
> Maxime

I queue these normally.

> > thanks,
> > 
> > greg k-h
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
