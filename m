Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC8C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 16:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73273417D3;
	Wed,  8 Mar 2023 16:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73273417D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZZTeEms
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WD_NirFDeq9S; Wed,  8 Mar 2023 16:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86187417DF;
	Wed,  8 Mar 2023 16:50:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86187417DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58AC3C0071;
	Wed,  8 Mar 2023 16:50:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E769C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C46840546
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C46840546
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DZZTeEms
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igQyykZ2pWwA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:50:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71B5640242
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71B5640242
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678294199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gljgvTCI1kHUupXR+SD/Ba2XdyToueuZYJ1UjcQwS/U=;
 b=DZZTeEmsQALhQsBvydZxANf1CXAqhb5JoTT1tkq3DJZN4RDZUEuuoWlQR6Nlm3Y/8I337C
 k4FDzpx3YOtwlcn9Bxl/cRWj3FNSW8hYr6+QMKMqJanMjvZcHBgDuo9aUXywCtqvNwrb1k
 Qj/Znkrvy9x0x5K4S08eglIAh3QAEUM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-lwmydwK5P1e_KZLgHiu1QQ-1; Wed, 08 Mar 2023 11:49:56 -0500
X-MC-Unique: lwmydwK5P1e_KZLgHiu1QQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c7-20020a7bc847000000b003e00be23a70so1176010wml.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 08:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678294195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gljgvTCI1kHUupXR+SD/Ba2XdyToueuZYJ1UjcQwS/U=;
 b=hJiyIcHkGprtKNvDRP8hm+uK2Rp0NrzZw0JE6B1FpEuTNOzgpgPXQq1iNEXnxbMd4O
 zy9Tmi/31bVPZaDDIHf3rAqN2i5T+V8qKaOBw/ZjABF9/orMUjNo4K76ewy7KTs0EELM
 uMuEx607w55IFW2bqdEPfzWZDlVO3AT3V2CRNmgWsB2LPkFuoZSs5iSka5sW2fn+w0Vi
 6OywvnElpQV1aEVrpdFRWSYeQDQYsgAGApEefwxfN8FSlfSgJ96TPtqyup6Pb8L1NsZ1
 5JVVUiDkevg3bcAa1xc5pAag1X+1J9hlvqVrHGBxVZoQcnOLvyvzQtPswEehTAhO5fg1
 qOwQ==
X-Gm-Message-State: AO0yUKXjlHk7ioKdMgt3buRrB7CixX5Aiwd0/8HHf496pxFqIeqXIrkh
 UB2sjg3o6dAcZW5QQypZYgAls05fXQgfvI8MO2A/Nb6MbuX4F+8OwOgljhr6aammslw7YH/846d
 ECpIuQVaHqXOyeRcllhB6d6AF4x+qMfbGZlKYvv8TmQ==
X-Received: by 2002:a05:600c:310f:b0:3ea:edd7:1f24 with SMTP id
 g15-20020a05600c310f00b003eaedd71f24mr16853525wmo.39.1678294195677; 
 Wed, 08 Mar 2023 08:49:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8fh1BLkNcgl9m9EKm5hypc4cy8CrZdiL36g82dDvvqxuHMSYoeD0CnnFIdUiQpQ4V0tuuv3w==
X-Received: by 2002:a05:600c:310f:b0:3ea:edd7:1f24 with SMTP id
 g15-20020a05600c310f00b003eaedd71f24mr16853506wmo.39.1678294195228; 
 Wed, 08 Mar 2023 08:49:55 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d564e000000b002cde25fba30sm15747898wrw.1.2023.03.08.08.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 08:49:54 -0800 (PST)
Date: Wed, 8 Mar 2023 11:49:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308114919-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <m2ttywzzxd.fsf@oracle.com>
 <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
 <20230308091321-mutt-send-email-mst@kernel.org>
 <4c031230-c0ac-7809-a85e-09f07c3f7e06@nvidia.com>
 <20230308110235-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230308110235-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "feng.liu.kernel@gmail.com" <feng.liu.kernel@gmail.com>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
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

On Wed, Mar 08, 2023 at 11:26:04AM -0500, Michael S. Tsirkin wrote:
> On Wed, Mar 08, 2023 at 10:59:57AM -0500, Feng Liu wrote:
> > 
> > 
> > On 2023-03-08 a.m.9:13, Michael S. Tsirkin wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
> > > > On 2023-03-07 04:14, David Edmondson wrote:
> > > > > External email: Use caution opening links or attachments
> > > > > 
> > > > > 
> > > > > Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
> > > > > writes:
> > > > > 
> > > > > > Add const to make the read-only pointer parameters clear, similar to
> > > > > > many existing functions.
> > > > > 
> > > > > In many of the modified functions the local variable that is a cast of
> > > > > the argument could also be const. Is there a reason not to do both at
> > > > > the same time?
> > > > > 
> > > > 
> > > > Hi,David
> > > > 
> > > > In order to prevent the content of a pointer parameter from being
> > > > modified and increase the readability of the function, it is recommended
> > > > to add the 'const' keyword to the parameter. This is not necessary for
> > > > local variables and non-pointer parameters, as they are only stored on
> > > > the stack and do not affect the original value or structure member
> > > > passed into the function. Therefore, in this case, the 'const' keyword
> > > > is only added to pointer parameters.
> > > 
> > > This makes no sense to me. If ytou cast away the const then it is
> > > pointless.
> > > 
> > 
> > Hi, Michael
> > 
> > I really don't quite understand your point of view.
> > Is a local variable that needs to be add const? Can you help to point
> > out the specific problem/point ?
> 
> I just repeated what David said.  Basically most of these functions use
> to_vvq which uses container_of which in turn loses const qualifier.
> So your change is poinless since rest of code accesses vq through
> to_vvq.
> 
> What to do? I don't like the idea of to_vvq_const.
> So I propose a version of container_of using _Generic
> which preserves the const qualifier.
> 
> 
> #define container_of(ptr, type, member) \
>     ({ \
>         const void *__mptr = (ptr); \
>         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>                       __same_type(*(ptr), void),                        \
>                       "pointer type mismatch in container_of()");       \
>         _Generic((ptr), \
>                  typeof(&((const type *)0)->member): \
>                  (const type *)(__mptr - offsetof(type, member)), \
>                  default: \
>                  (type *)(__mptr - offsetof(type, member))); \
>     })
> 
> 
> I'll hack it up in a day or two and post.
> 

Oh wait a second. There's already container_of_const.
So just use it in to_vvq.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
