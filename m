Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E43FC25B07
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 10:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9228417A1;
	Sat,  6 Aug 2022 10:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9228417A1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFayHWfs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQzzPX0ENT6Y; Sat,  6 Aug 2022 10:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D865417A4;
	Sat,  6 Aug 2022 10:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D865417A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1FB4C0033;
	Sat,  6 Aug 2022 10:52:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87FD3C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 10:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6208E417A1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 10:52:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6208E417A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j6gTuODIMUKv
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 10:52:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30E964179E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30E964179E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659783152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/qh9jmfLwd9OiFNoPZvZ2ai/xbAjj6lvYqq0LiV4GY=;
 b=YFayHWfsSqvd1UWEmJO0jYKAJUzlQZXmUmKIhfyOSn3rnS8KMU8o3LE8NR7AR7TatroZxl
 dx54wDnoKN4Kzxi7CoDZB52EflzMZHnJCcp4toIt8/BMBLARs8+/QLCYhPr532fofP37/+
 5aL79TP3hTXgDfEkTj7AjxwjTMBaaK0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-8XWJgPHWNzWC8F32DoNJdQ-1; Sat, 06 Aug 2022 06:52:31 -0400
X-MC-Unique: 8XWJgPHWNzWC8F32DoNJdQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 m22-20020a056402431600b0043d6a88130aso3025049edc.18
 for <virtualization@lists.linux-foundation.org>;
 Sat, 06 Aug 2022 03:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=0/qh9jmfLwd9OiFNoPZvZ2ai/xbAjj6lvYqq0LiV4GY=;
 b=N5ZLADZrNQ21+A69tCf/3wTdde/sOWf8mRE0qJt5ecNTinlTQJB1xHGBTEx+xjM4hX
 qs+7l8C7Bhx0WLqheRyFwB6zFCUZKk1KQKsE4HDQe2RRsXVwSYBwcWJJ7fma5vmeurtz
 LQ6iqz6kBwt014n6UMDYM4X5RQAS+EF2IOuAxbik9H9Azq53JW6A8CxCoW2cF7d24MTQ
 w28ZpXQKrNIHqeo4O9lXRlepaCM4PD0RRFvSKspji8ECWe7twt9jcw3rNX8lOckQJ+q/
 /Pzbh8lydrfWnsNlghy0cza2NwZQzwa7Xsdw5KVchPHBETsG8J/3yWyHeC0HDLGCDbN4
 /Qbg==
X-Gm-Message-State: ACgBeo0R+k6931BW+cqIsSUPh2N1/i3rn4TyZNke44KLzXsLfq7QnCz1
 xPVsUpQP6abtrK9kaRaZNzYKSK/c+Y5Jyl0L0ioPIofptxUkC3XB1AXSuyyI2pupPWl2UoB831o
 gybzknVSKfjUISG3AkxhBWUcND53r8sOzddKhRmdswg==
X-Received: by 2002:a17:906:9bc9:b0:730:6595:dfc8 with SMTP id
 de9-20020a1709069bc900b007306595dfc8mr7963493ejc.286.1659783150514; 
 Sat, 06 Aug 2022 03:52:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HQzhwXQO5W/vBjDoNvbpv3Lfd+BpG+2vIUeviBxP2TGtghFHSnafgjrZHJe1Foup75+pBNA==
X-Received: by 2002:a17:906:9bc9:b0:730:6595:dfc8 with SMTP id
 de9-20020a1709069bc900b007306595dfc8mr7963477ejc.286.1659783150311; 
 Sat, 06 Aug 2022 03:52:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 kx11-20020a170907774b00b00730df07629fsm2358448ejc.174.2022.08.06.03.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Aug 2022 03:52:29 -0700 (PDT)
Date: Sat, 6 Aug 2022 12:52:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806105225.crkui6nw53kbm5ge@sgarzare-redhat>
References: <20220805181105.GA29848@willie-the-truck>
 <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
 <20220806094239.GA30268@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220806094239.GA30268@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org,
 keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, kernel-team@android.com, torvalds@linux-foundation.org
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

On Sat, Aug 06, 2022 at 10:42:40AM +0100, Will Deacon wrote:
>Hi Stefano,
>
>On Sat, Aug 06, 2022 at 09:48:28AM +0200, Stefano Garzarella wrote:
>> On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
>> > The fundamental issue is, I think, that VIRTIO_F_ACCESS_PLATFORM is
>> > being used for two very different things within the same device; for the
>> > guest it basically means "use the DMA API, it knows what to do" but for
>> > vhost it very specifically means "enable IOTLB". We've recently had
>> > other problems with this flag [3] but in this case it used to work
>> > reliably and now it doesn't anymore.
>> >
>> > So how should we fix this? One possibility is for us to hack crosvm to
>> > clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost
>>
>> Why do you consider this a hack?
>
>I think it's a hack for two reasons:
>
>  (1) We're changing userspace to avoid a breaking change in kernel behaviour
>  (2) I think that crosvm's approach is actually pretty reasonable
>
>To elaborate on (2), crosvm has a set of device features that it has
>negotiated with the guest. It then takes the intersection of these features
>with those advertised by VHOST_GET_FEATURES and calls VHOST_SET_FEATURES
>with the result. If there was a common interpretation of what these features
>do, then this would work and would mean we wouldn't have to opt-in on a
>per-flag basis for vhost. Since VIRTIO_F_ACCESS_PLATFORM is being overloaded
>to mean two completely different things, then it breaks and I think masking
>out that specific flag is a hack because it's basically crosvm saying "yeah,
>I may have negotiated this with the driver but vhost _actually_ means
>'IOTLB' when it says it supports this flag so I'll mask it out because I
>know better".

Thanks for elaborating, now I think I get your point!

If I understand you correctly, what you would like is that GET_FEATURES 
should return only the data path features (thus exposed to the guest) 
and not the features for the VMM, right?

In that case, since we also negotiate backend features (with
SET|GET_BACKEND_FEATURES ioctls) for IOTLB messages to work, maybe we 
could only expose that feature if VHOST_BACKEND_F_IOTLB_MSG_V2 has been 
negotiated

@Michael, @Jason, do you think this could be doable?

>
>> If the VMM implements the translation feature, it is right in my opinion
>> that it does not enable the feature for the vhost device. Otherwise, if it
>> wants the vhost device to do the translation, enable the feature and send
>> the IOTLB messages to set the translation.
>>
>> QEMU for example masks features when not required or supported.
>> crosvm should negotiate only the features it supports.
>>
>> @Michael and @Jason can correct me, but if a vhost device negotiates
>> VIRTIO_F_ACCESS_PLATFORM, then it expects the VMM to send IOTLB messages to
>> set the translation.
>
>As above, the issue is that vhost now unconditionally advertises this in
>VHOST_GET_FEATURES and so a VMM with no knowledge of IOTLB can end up
>enabling it by accident.

I honestly don't know what the initial design was, though, from what
I've seen in QEMU, it only enables the known features, in fact for
example when we added F_SEQPACKET for vhost-vsock, we had to update QEMU
to pass the feature to the guest, so I think the initial idea was to not
unconditionally accept all the features exposed by the vhost device.

Maybe this part should be clarified.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
