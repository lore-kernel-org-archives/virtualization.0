Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD03C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 17:39:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 341F3612C8;
	Tue, 21 Feb 2023 17:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 341F3612C8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEGLbbVo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJDiFCzT9D3h; Tue, 21 Feb 2023 17:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EC9D60B94;
	Tue, 21 Feb 2023 17:39:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC9D60B94
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 725FAC0032;
	Tue, 21 Feb 2023 17:39:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5D62C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0A7F42A6C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0A7F42A6C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEGLbbVo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 43HF52sSA_be
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:39:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 501BF42A69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 501BF42A69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677001160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPuIrvpqk087p+R5h2joKaFXJupChM4KtrAD5lv9Wqw=;
 b=BEGLbbVoT7XEsYo//zHjmYEXRQ79MqTM1s5aN0Rhoa5+7H5zLwdkQjkfm+2Ww39eWzEJ73
 NifO3XGMt1VzUAT/pryzfGgOe0DPOawmwjIHxA66H0PivHQmwVYs6yP+DY+q319y7kW768
 KJkC5ZnBdEIln2cXZ3/QJC3jRVydwXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-Z2MaX643MZCKe3yJ4oispQ-1; Tue, 21 Feb 2023 12:39:19 -0500
X-MC-Unique: Z2MaX643MZCKe3yJ4oispQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 z6-20020a7bc7c6000000b003e0107732f4so2309333wmk.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 09:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPuIrvpqk087p+R5h2joKaFXJupChM4KtrAD5lv9Wqw=;
 b=szwSRkZ+TkBoWNkSzaA1/J0NSyxJpmZ3bXRwIPMwzd6LQSJbP4SdOrCsC8vAPrzIUD
 mRGUWI3n2ilbz0TvG+nB1VLuRImzI3yAy3w6j1+20CQNRqcJs4xU9JOQTLLC6dBdCQAv
 lXGbp0Qivym4BgMNKdVeXAnNiv7m5n4PZYgRthvuVvdnFiTo9/FbKar4Bha6BVPxm/rY
 iziA1Rk09/jFDJb5w86B5L/L/oyvL5aOBQkheyxjtJHOgxWtfMGiSzdEKx500f2HSaFe
 4JpYqiDscj8HoNCrITuuvGWkblABrgAMMiNuAQKHusZWwGLmWj89JvUZbqkvp6hbOw9T
 gmKQ==
X-Gm-Message-State: AO0yUKWrJmaNpSmnnL26C/uCu4ij5GHh3rpA3GUn63eM60xRMrVSqaZy
 KFJKCnPtTOanTcMwdpstvrnLS+7YCGo36URlKyFMGYEoc+wPgD9qloqWsR2SUt3gK7k8jrHVzw0
 yTTQGVxjSUCh+0aw9KPJvKfqi0YCRipncEsBzwFuS8w==
X-Received: by 2002:adf:dfd0:0:b0:2c5:54a7:3646 with SMTP id
 q16-20020adfdfd0000000b002c554a73646mr4633686wrn.5.1677001157982; 
 Tue, 21 Feb 2023 09:39:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9wztbZgAM6luozt0YiTQObP3jqXSOKc3Fe3WqAJGUETTWXCPM1umIXBSiSiwaNKLULuxY00w==
X-Received: by 2002:adf:dfd0:0:b0:2c5:54a7:3646 with SMTP id
 q16-20020adfdfd0000000b002c554a73646mr4633673wrn.5.1677001157701; 
 Tue, 21 Feb 2023 09:39:17 -0800 (PST)
Received: from redhat.com ([2.52.2.78]) by smtp.gmail.com with ESMTPSA id
 i18-20020adfe492000000b002c56287bd2csm5471677wrm.114.2023.02.21.09.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 09:39:17 -0800 (PST)
Date: Tue, 21 Feb 2023 12:39:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <20230221123857-mutt-send-email-mst@kernel.org>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <Y/TltJnD4k5hB6Z1@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, vmireyno@marvell.com,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Feb 21, 2023 at 04:39:32PM +0100, Jiri Pirko wrote:
> Tue, Feb 21, 2023 at 04:11:53PM CET, willemdebruijn.kernel@gmail.com wrote:
> >Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
> >> set implicates that the driver provides the exact size of the header.
> >> 
> >> Quoting the original virtio spec:
> >> "hdr_len is a hint to the device as to how much of the header needs to
> >>  be kept to copy into each packet"
> >> 
> >> "a hint" might not be clear for the reader what does it mean, if it is
> >> "maybe like that" of "exactly like that". This feature just makes it
> >> crystal clear and let the device count on the hdr_len being filled up
> >> by the exact length of header.
> >> 
> >> Also note the spec already has following note about hdr_len:
> >> "Due to various bugs in implementations, this field is not useful
> >>  as a guarantee of the transport header size."
> >> 
> >> Without this feature the device needs to parse the header in core
> >> data path handling. Accurate information helps the device to eliminate
> >> such header parsing and directly use the hardware accelerators
> >> for GSO operation.
> >> 
> >> virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
> >> The driver already complies to fill the correct value. Introduce the
> >> feature and advertise it.
> >> 
> >> Note that virtio spec also includes following note for device
> >> implementation:
> >> "Caution should be taken by the implementation so as to prevent
> >>  a malicious driver from attacking the device by setting
> >>  an incorrect hdr_len."
> >> 
> >> There is a plan to support this feature in our emulated device.
> >> A device of SolidRun offers this feature bit. They claim this feature
> >> will save the device a few cycles for every GSO packet.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - extended patch description
> >
> >Is the expectation that in-kernel devices support this feature, and
> >if so how would it affect them? If I read the spec correctly, devices
> 
> Well, the tap driver actually trusts the hdr_len to be of correct header
> size nowadays.
> 
> 
> >still need to be careful against malicious drivers, so cannot assume
> >much beyond what they do today (i.e., a hint).
> 
> Malicious how? There is upper limit of size in tap which is checked.
> I assume that for hw implementation, that would be the same.
> 
> But anyway, this discussion would be rather part of the spec/device
> patch, don't you think?
> 
> 
> >
> >Might be good to point to the definition commit:
> >https://github.com/oasis-tcs/virtio-spec/commit/4f1981a1ff46b7aeb801c4c524ff76e93d9ce022
> 
> There were couple of fixes to the spec since then, that's why I didn't
> include it. It is trivial to look it up in the spec.

This might be a good link:

https://docs.oasis-open.org/virtio/virtio/v1.2/cs01/virtio-v1.2-cs01.html#x1-230006x3


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
