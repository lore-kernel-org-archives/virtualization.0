Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95356C433F5
	for <virtualization@archiver.kernel.org>; Sun,  6 Mar 2022 10:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EEC81761;
	Sun,  6 Mar 2022 10:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WISf2FR_9jEI; Sun,  6 Mar 2022 10:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A4A5481470;
	Sun,  6 Mar 2022 10:18:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F85BC001D;
	Sun,  6 Mar 2022 10:18:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF8CEC000B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 10:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9C9881760
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 10:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2vSzAWF1mOE
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 10:17:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93D6781470
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Mar 2022 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646561875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HR3oYw2L0TBEEwKYGpSkfoswQiCxqqEEKf8dnKi9Lc=;
 b=FYHotiiL9Zbjz2lKCRDxPPWOAJcVPftAX+x3m4rdUFhKhUcsjaD40DjYlYsqhk5ikP7ezR
 Ck3c85Jescl9KJgLWPhqTNTDVYDCckdEvEBtNm5NBxq+SrC1rq7dqqPmkxiCtOlv46xjet
 Yr8yOUSdOW/OKDswjFdAMrjLaFlYxog=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-KcyQ5FNwO4K_EQXxVxDgAg-1; Sun, 06 Mar 2022 05:17:53 -0500
X-MC-Unique: KcyQ5FNwO4K_EQXxVxDgAg-1
Received: by mail-ed1-f71.google.com with SMTP id
 l14-20020a056402344e00b0041593c729adso6717517edc.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Mar 2022 02:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+HR3oYw2L0TBEEwKYGpSkfoswQiCxqqEEKf8dnKi9Lc=;
 b=eHQKdygQIjo7hhkPkdq49irE2zRdPsQOQMqm5OvYmKf+cfVBdo34TUWVEdIPUDcMJE
 jwaGj4GMWrBxTbTsLzf+sIt5Du7qJwEY/LS0D1knFJP+QuIweVFhJkNjDjdXdhOUzgxT
 o6Ma6RwHwLTznN3TWmfFyegCBksGEZtjo569jRM8mpJGwLRYvAMYMGymSe3F07B3i8gi
 JHXpk2YdUQOs3JplWNOw1xuZ3PJouLpkGaptHvUSPlbeUK/Bm8b2JKWZF4CAgrCyGrov
 7fqk5W34thb7LYeyYVb9rZPAeVtNSjnW8GeskhIcKEbKTvScZtOUaPoMo7DwkFfF+pN6
 nNdg==
X-Gm-Message-State: AOAM5324Av1hqBw6P9GwCDThmo8Cs/M4UV96mU1h9aw0ZotemWQT/fTb
 ittPFZe+dFViXXUldF5NcEIa2IN7fjgTn0zdsN/WEPBYPl/+mMeYT9b3cqZLxk27hmPyV1zk3iU
 aiC1wBVBLYATIyJkU9JGYneCImQrLUsN17Se4NBjqBA==
X-Received: by 2002:aa7:cac8:0:b0:410:cc6c:6512 with SMTP id
 l8-20020aa7cac8000000b00410cc6c6512mr6233408edt.408.1646561872613; 
 Sun, 06 Mar 2022 02:17:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC/SPxcRqLasrXClAamp+EBJRp7bCmy97E6mB34HSrfBRS9D8+XLdt1Qx+oSidKl7XdjTs/g==
X-Received: by 2002:aa7:cac8:0:b0:410:cc6c:6512 with SMTP id
 l8-20020aa7cac8000000b00410cc6c6512mr6233390edt.408.1646561872426; 
 Sun, 06 Mar 2022 02:17:52 -0800 (PST)
Received: from redhat.com ([2.52.16.157]) by smtp.gmail.com with ESMTPSA id
 q18-20020a170906771200b006d2a835ac30sm3683042ejm.151.2022.03.06.02.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Mar 2022 02:17:51 -0800 (PST)
Date: Sun, 6 Mar 2022 05:17:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <beshleman.devbox@gmail.com>
Subject: Re: [virtio-comment] [PATCH v5 1/2] virtio-vsock: add description
 for datagram type
Message-ID: <20220306051658-mutt-send-email-mst@kernel.org>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20220224221547.2436395-1-beshleman.devbox@gmail.com>
 <20220224221547.2436395-2-beshleman.devbox@gmail.com>
 <20220302160958.62s34i2n2tccsscz@sgarzare-redhat>
 <20220303032801.yvlfu5vqqibu7eyo@ip-10-100-118-60.ec2.internal>
 <20220303021413-mutt-send-email-mst@kernel.org>
 <20220304234315.ccyecxidyh5rfvw5@ip-10-100-118-60.ec2.internal>
MIME-Version: 1.0
In-Reply-To: <20220304234315.ccyecxidyh5rfvw5@ip-10-100-118-60.ec2.internal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 arseny.krasnov@kaspersky.com, jhansen@vmware.com
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

On Sat, Mar 05, 2022 at 01:25:44AM +0000, Bobby Eshleman wrote:
> On Thu, Mar 03, 2022 at 02:15:24AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 03, 2022 at 03:29:31AM +0000, Bobby Eshleman wrote:
> > > On Wed, Mar 02, 2022 at 05:09:58PM +0100, Stefano Garzarella wrote:
> > > > Hi Bobby,
> > > > Sorry for the delay, but I saw these patches today.
> > > > Please, can you keep me in CC?
> > > > 
> > > 
> > > Hey Stefano, sorry about that. I'm not sure how I lost your CC on this
> > > one. I'll make sure you are there moving forward.
> > > 
> > > I want to mention that I'm taking a look at
> > > https://gitlab.com/vsock/vsock/-/issues/1 in parallel with my dgram work
> > > here. After sending out this series we noticed potential overlap between
> > > the two issues. The additional dgram queues may become redundant if a
> > > fairness mechanism that solves issue #1 above also applies to
> > > connection-less protocols (similar to how the TC subsystem works). I've
> > > just begun sorting out potential solutions so no hard results yet. Just
> > > putting on your radar that the proposal here in v5 may be impacted if my
> > > investigation into issue #1 yields something adequate.
> > 
> > 
> > Well not mergeable, but datagram is upstream in Linux, is it not?
> > So we do want it in the spec IMHO, even if in the future there
> > will be a better protocol.
> > 
> 
> As of right now, it is not upstream in Linux. The virtio transport just passes
> -EOPNOTSUPP up the stack when the sock invokes it.
> 
> I think what you're thinking of is the vsock dgram in VMWare's vmci and
> Hyper-V. They support dgrams, but are not compatible with virtio (e.g., don't
> use virtqueues).
> 
> -Bobby

Oh no, I was thinking about SEQPACKET actually. Which has the same issue
I noted on another thread with memory accounting as datagram by the way.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
