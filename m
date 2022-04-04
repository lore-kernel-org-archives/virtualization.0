Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00350C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Apr 2022 16:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C31B60BD7;
	Mon,  4 Apr 2022 16:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pM2saoouMu6v; Mon,  4 Apr 2022 16:27:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 380DB60EDE;
	Mon,  4 Apr 2022 16:27:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08F11C001D;
	Mon,  4 Apr 2022 16:27:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95D2EC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FAC160EDE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CyeJOO928o0J
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:27:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6BA760BD7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649089641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P7hJ01+Z8CTQmsHFJdXv1elOc2Pqcj7fQA/ZIutEB5E=;
 b=i0TTI0Sv3Gi0njaigApTcHR/tyQK4TjtuSbfUu4IrmjpvdBtEtt2WRmeBriThyMaLnVBLZ
 EyYEIrp4SFmwmYmbAP40186KULcGFSrhUJp9vglfjc9Z02eVud7zH1Zm93rjVQ68ggQ8VF
 5tqkja9eIYQLAUClUfoLEMwbe+7lyFk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-2_78a04XNBqskgthUv-t4Q-1; Mon, 04 Apr 2022 12:27:20 -0400
X-MC-Unique: 2_78a04XNBqskgthUv-t4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 i184-20020a1c3bc1000000b0038e4c5968b5so5962804wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 09:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P7hJ01+Z8CTQmsHFJdXv1elOc2Pqcj7fQA/ZIutEB5E=;
 b=Lr6O17cglQp3epLW1cjhXKCr8k8tCPp0mOB8OyXpo9FLwSJ65shR6mPUD3oO4W6hu/
 ELKyCj2ZqyjGE21za4Sn9SuFKYEZGs6h4m2hBRN4tUS/QbtpCZF3OFMmbNX9X0gTi/Gi
 X0Fc6iT9JNOKWg/lJuw0hgPFtlmGdvbhleffu3xP35qe3wQIx9oDFD0KMTDJ9+RAiVGL
 bWrMjF7q+lyTei08qO5vBNd82c22DKOt+kNI+W/sqQC2UQaVIMEFM0EG86QWCJZ+iYrg
 3CAxn713gmVPe9tH8Mn3yKXaSjMrBeaWGtm1VENc13FuZYYHTvbMph7MpheaJjFKlvuM
 UhnQ==
X-Gm-Message-State: AOAM532y9gzJ1QoZ/UXHmmizEsCWgcC/zPFC5sLMdnL8as+ykTrzW2kx
 Po+yFZYfbZEl6wx4M7hCMHwN1YzmDvEQgDBNMltU37HdlEgCEWMVnUzNz8kgH2+h5IWXFZpbiU7
 snIuQUU2woz0xvotYmrGJ9Tr0akIvTQrlskDs1QstBw==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr432725wre.276.1649089639382; 
 Mon, 04 Apr 2022 09:27:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuDmOwegjvGJFl7L9LJ7bym2qL/D7kmZ5IhcobdoiPO6Grj58r50Xw6ksaa9Y+iOv1AFo58Q==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr432713wre.276.1649089639209; 
 Mon, 04 Apr 2022 09:27:19 -0700 (PDT)
Received: from redhat.com ([2.52.17.211]) by smtp.gmail.com with ESMTPSA id
 az19-20020a05600c601300b0038cadf3aa69sm26246102wmb.36.2022.04.04.09.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Apr 2022 09:27:18 -0700 (PDT)
Date: Mon, 4 Apr 2022 12:27:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
Message-ID: <20220404122707-mutt-send-email-mst@kernel.org>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
 <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
 <073dc28b-1707-cd04-daba-13aa4fac5a85@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <073dc28b-1707-cd04-daba-13aa4fac5a85@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 04, 2022 at 11:11:16PM +0800, Xianting Tian wrote:
> I can't find it in next branch, will you apply this patch?

yes, thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
