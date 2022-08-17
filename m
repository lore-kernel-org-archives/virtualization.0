Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B8C32772
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 08:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 763218315C;
	Wed, 17 Aug 2022 08:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 763218315C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0HWELlu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmZ-4K7Q-czF; Wed, 17 Aug 2022 08:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C785831EF;
	Wed, 17 Aug 2022 08:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C785831EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E515AC0033;
	Wed, 17 Aug 2022 08:55:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A21DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DD49401D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DD49401D0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0HWELlu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KX6FFjgO7Wk3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 757DC40069
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 757DC40069
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660726541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxXD+nXe69utb78dojqgzjisp1/GKHU9/l3M8qyZRmc=;
 b=E0HWELluDiboUHnUpv8RCJyrGyu+UYRtSxx2BuFjTSUeQ0ntplx8i0OC9LAIXplB7zAk00
 YW2tnf5LxETkKEQm737UnJVXS3+3jJ5ATc39LZkJ7GG/2INK5kVJBPtSGPJZ8Mo1zIbH+c
 vPLghqysyXEU1dOnHjK9yntEzh1PyRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-FmR6HV_fMTS7GPOV_CLabQ-1; Wed, 17 Aug 2022 04:55:40 -0400
X-MC-Unique: FmR6HV_fMTS7GPOV_CLabQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 m2-20020adfc582000000b0021e28acded7so2258880wrg.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 01:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=kxXD+nXe69utb78dojqgzjisp1/GKHU9/l3M8qyZRmc=;
 b=Akwo0SrvPbC4+fGTPsHVNUz/do4yDjgy78SUNE9lfRcK4HXdFq9FJKrp2yS0UUYhH9
 7pcARb82ykR57NfpMn/Fn7PrsK0oyOHLTcobR/HpBLncd+ktEYbk1AgsMYXRowUepTlT
 d45dMEwC6OAayxGBDUT+UQ8LTYPc5AG+zhO0fjOfci75o71bj+cCoLD2vt3FYPx2MwAY
 fz1J4h7UFDWw3Ujhfh7L7lEXCAYYgkJmu53DPEBrUAyS0rbvLzlW/XsfLIj8CVFGuAOa
 7UOzCtbk+ziXM6Sgu2EenyjF24hDHH96Rap7g/Sz16KCqEqRxSf85/4h+BuuuNJn1CQ0
 3PdA==
X-Gm-Message-State: ACgBeo3zzJJI+XhKCMSWS8FUgKvgBmcsxfn3DhnvDG8Lh08xmqFSzHpF
 rJ7eumpq+mQCUVO2AW+J9JxnamjfFV+6V69uCFHd8EheqLt6vO1NazThrDKZqeSi80hRstrqO8F
 1lwykQ7A5Udz0jNvAjx5t5SI+jWsy7gtsIWo8mOr1ig==
X-Received: by 2002:a05:600c:1d9b:b0:3a5:d66e:6370 with SMTP id
 p27-20020a05600c1d9b00b003a5d66e6370mr1433277wms.73.1660726539049; 
 Wed, 17 Aug 2022 01:55:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6joZazkqh/7hPdngPGw0ZOIMJpCoIUyVh/yzbAhFI1ASubyybt/XwdZKSVEcy82NUPWtkj5Q==
X-Received: by 2002:a05:600c:1d9b:b0:3a5:d66e:6370 with SMTP id
 p27-20020a05600c1d9b00b003a5d66e6370mr1433257wms.73.1660726538821; 
 Wed, 17 Aug 2022 01:55:38 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 bn21-20020a056000061500b0021e43b4edf0sm12352740wrb.20.2022.08.17.01.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 01:55:37 -0700 (PDT)
Date: Wed, 17 Aug 2022 04:55:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Message-ID: <20220817045406-mutt-send-email-mst@kernel.org>
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
MIME-Version: 1.0
In-Reply-To: <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

On Wed, Aug 17, 2022 at 10:14:26AM +0800, Zhu, Lingshan wrote:
> Yes it is a little messy, and we can not check _F_VERSION_1 because of
> transitional devices, so maybe this is the best we can do for now

I think vhost generally needs an API to declare config space endian-ness
to kernel. vdpa can reuse that too then.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
