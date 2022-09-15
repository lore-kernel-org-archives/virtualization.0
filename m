Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E783CC6FA89
	for <virtualization@archiver.kernel.org>; Thu, 15 Sep 2022 16:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49A2160F79;
	Thu, 15 Sep 2022 16:17:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49A2160F79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAqzCsSM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyMlmEtV5eb9; Thu, 15 Sep 2022 16:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D40B060FA5;
	Thu, 15 Sep 2022 16:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D40B060FA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A61C8C0033;
	Thu, 15 Sep 2022 16:17:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AD59C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 16:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAA0A419B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 16:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAA0A419B0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAqzCsSM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LuuUuA08wRn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 16:16:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCE74419AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCE74419AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663258616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QGL2aU0V44evqxOzGLTXba8gjIgDLZbDaCL5a4Fyq4=;
 b=HAqzCsSMdx45hXh098NhyKhLgrVf6zXnAZlVfTTl8afdJxmuYBINAD2zybEpKqc0DaimW+
 sDjbW6w3NzoBW7Mr8NuWyG9BxF+J59/aRMtOMN5WisYJ2rKh2evZSkyREBYCWNlAWBRVUw
 YmWvtUO5PKNlHz0Ezmuq53W4A7V8pwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-ABE21HtdNSKlSuYTn9vzWw-1; Thu, 15 Sep 2022 12:16:55 -0400
X-MC-Unique: ABE21HtdNSKlSuYTn9vzWw-1
Received: by mail-wr1-f71.google.com with SMTP id
 w29-20020adf8bdd000000b0022ad6fb2845so623143wra.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 09:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=5QGL2aU0V44evqxOzGLTXba8gjIgDLZbDaCL5a4Fyq4=;
 b=swVjHc4xvoRQwVTP9ytrMqoB3cH2+Imo3ux6rUEG9uFMYo3zTf4boEcsY7dh1wAnyc
 wsM126ix9i8eM3A3DU/U6LnmDC01CUAbMQzmQL3LzNexLb5ATq268mJbne0GZq5oIY7K
 ZtTGLI1JyUs796KTU+F74PFM2GVNTUi8+LXl/PfVpDNzYjrcr4Sv5+nBbCII+nyeB7eC
 VvKQfnqw9zSV+WkwPwzx+IE978ZzeFrCi4npoVom1H801GD2QG37hMLK6MNS/WMw3gah
 gFpXRHxNzJYm5oDXcyfa97rvtlgDnQDR0lNMEx/U46NrpLAM6tdZut4EaeSfT0+lLGLU
 rmyQ==
X-Gm-Message-State: ACrzQf3mU6X4Pi1iKZT4H83JDbpCqiuUdV7iuHwEYIg44PZQot/Wxde0
 df/Y1J6vnBh0oqzM3Zx2n13xCL24cBbMso14TwMKHdKKhssNgfXbBS5t+zkLr/Ftk6pm6jVOusQ
 P2wa6M4gJiT2E4uzJMGLSfl8m735Bo8cjkjbCixp+1w==
X-Received: by 2002:a05:600c:3b1a:b0:3b4:858b:aef1 with SMTP id
 m26-20020a05600c3b1a00b003b4858baef1mr398019wms.193.1663258613942; 
 Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6CYMxX0xbHz8gi5YOfJkZsL2gJtb0R6qnAZColXSHX9SLm5vk9dkl8TUPMZ763A++JeCAPKg==
X-Received: by 2002:a05:600c:3b1a:b0:3b4:858b:aef1 with SMTP id
 m26-20020a05600c3b1a00b003b4858baef1mr398003wms.193.1663258613767; 
 Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
Received: from sgarzare-redhat ([79.140.208.123])
 by smtp.gmail.com with ESMTPSA id
 bh16-20020a05600c3d1000b003a531c7aa66sm3455234wmb.1.2022.09.15.09.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Sep 2022 09:16:53 -0700 (PDT)
Date: Thu, 15 Sep 2022 18:16:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: vdasa@vmware.com
Subject: Re: [PATCH] MAINTAINERS: Add header files under VMWARE VMCI DRIVER
Message-ID: <20220915161650.fchcxhnei5jxdi35@sgarzare-redhat>
References: <20220915031321.1121-1-vdasa@vmware.com>
MIME-Version: 1.0
In-Reply-To: <20220915031321.1121-1-vdasa@vmware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Pv-drivers@vmware.com, gregkh@linuxfoundation.org, bryantan@vmware.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 14, 2022 at 08:13:21PM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>Add include/linux/vmw_vmci* files under VMWARE VMCI DRIVER.
>
>Acked-by: Bryan Tan <bryantan@vmware.com>
>Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
