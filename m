Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 11:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F1B760BD7;
	Tue,  8 Mar 2022 11:05:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cr3-xaq5DCiq; Tue,  8 Mar 2022 11:05:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEB386058C;
	Tue,  8 Mar 2022 11:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9513CC001D;
	Tue,  8 Mar 2022 11:05:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A853C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B19382A26
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jHRL6KVby4eZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:05:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98DC7829FD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646737531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCTl0NyGnslmoDNlbPArwT49YkiFqe8KOOW4Ouvu6mc=;
 b=IuZGtZcwY/KFRNZJ3QpnIkJPkviOfS3S9HLXKPOpljk95NayY0imQdbIghDNaduY72Z1zl
 plMFcfrUOe3RXYbaTk9m37hV96EHFRhT+wnZMFPfKKqmbSffeP8Md5xATDdUxnJGM+ZVaT
 YQnTYCrnVXt6XCxixt4BeyrxaADe0f0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-MIv6U2DKNS-u7HART2r2xQ-1; Tue, 08 Mar 2022 06:05:30 -0500
X-MC-Unique: MIv6U2DKNS-u7HART2r2xQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 og24-20020a1709071dd800b006dab87bec4fso5041549ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 03:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FCTl0NyGnslmoDNlbPArwT49YkiFqe8KOOW4Ouvu6mc=;
 b=i+kMAT21TpyMJVioiundat5ZweMCWfPVOEC2OkGO9lyECiPTrDKzDlLbGymCGgy+RL
 FXszB4/QT93NlfUK07EcMYwoxPv5i05gQHopzGcxjNcMZacTtJlPxpDsCD0r/HgmpLUx
 uakYlkN9P9Yy5Qfp3FOt/Yc8KIrwtUNng+udCijCysijM/t62br6gY0nlNvp57HKL9m/
 zxckhpwCVIeNw3JE0n2MBJZadtdS9olix/JKrlze8+3KanK4U50vz50Pc1/GOECaxbXb
 GoknguBd+U6osVke5FMpShfaCWc8WbcSw29/5zb+ypYVNfZnE0yfs04wFWDdrqkKN/SI
 Hqxg==
X-Gm-Message-State: AOAM533xbv30qycVmrSb6/iC9guKgbrmy6jsMAFRa/9GyzrWHTbsJTnZ
 j8y8OtykIz+hnHs9T5QxHm7E5TR9Cs2NXqVX79aW9RnWuT1sLOAx0SLXr30zFor/w1yl2w/Pcv5
 08a2ZEt9LCDTextFS12wV66Ukl713p4lqL0eSIKUlog==
X-Received: by 2002:a17:907:2d22:b0:6da:91fe:15a5 with SMTP id
 gs34-20020a1709072d2200b006da91fe15a5mr13286728ejc.448.1646737528796; 
 Tue, 08 Mar 2022 03:05:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgv7cglanKYuGFfnW0Rf0VAUYwA4cx1PX1P0MLrG9UedzvWygSn4/xGLczSKDMdkoHZTSdZQ==
X-Received: by 2002:a17:907:2d22:b0:6da:91fe:15a5 with SMTP id
 gs34-20020a1709072d2200b006da91fe15a5mr13286713ejc.448.1646737528603; 
 Tue, 08 Mar 2022 03:05:28 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 y12-20020a50eb8c000000b00410f02e577esm7525742edr.7.2022.03.08.03.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 03:05:28 -0800 (PST)
Date: Tue, 8 Mar 2022 06:05:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308060210-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com>
MIME-Version: 1.0
In-Reply-To: <Yicalf1I6oBytbse@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Tue, Mar 08, 2022 at 09:57:57AM +0100, Greg KH wrote:
> > > And what happens if the mutex is locked _RIGHT_ after you checked it?
> > > You still have a race...
> > 
> > No, we miss a warning that one time.  Memory is still protected.
> 
> Then don't warn on something that doesn't matter.  This line can be
> dropped as there's nothing anyone can do about it, right?

I mean, the reason I wanted the warning is because there's a kernel
bug, and it will break userspace. warning is just telling us this.
is the bug reacheable from userspace? if we knew that we won't
need the lock ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
