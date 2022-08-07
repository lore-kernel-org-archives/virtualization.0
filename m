Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87716C25B06
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 13:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1774441638;
	Sun,  7 Aug 2022 13:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1774441638
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQgXaS/7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOsS4altuVv0; Sun,  7 Aug 2022 13:27:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 46B1E415D7;
	Sun,  7 Aug 2022 13:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46B1E415D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02350C0033;
	Sun,  7 Aug 2022 13:27:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8F7EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70E9741612
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70E9741612
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jmPqKgU7BSNT
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:27:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E8A0415D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E8A0415D7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659878830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWN2+XtBy7D+eIoeR0CwA7v9KmusYi195gp46RwIqnc=;
 b=gQgXaS/7yJ2D1IWEwJNyNpQH9K5d42xv5JQv+9PeCqZhYLovQMYBcvJxR6DkS4IU8ULpU5
 63RYA+G/9J/dh4YkvPD6yizaXJd9XToFqfP9DB4oP8HoyDl0AkaTcPFhuLwDI/DJ5L3AJx
 QyiTclOMGs7Qiz1mp3aRfN9QSfWiDRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-gKcheRDKNfq44Lu36IM77g-1; Sun, 07 Aug 2022 09:27:09 -0400
X-MC-Unique: gKcheRDKNfq44Lu36IM77g-1
Received: by mail-wm1-f70.google.com with SMTP id
 v130-20020a1cac88000000b003a4f057ed9fso3558774wme.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Aug 2022 06:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=kWN2+XtBy7D+eIoeR0CwA7v9KmusYi195gp46RwIqnc=;
 b=g9f3AyFrnGV06gztqcznBmrRqoDIxgbSK4W3k8WMfQDscztun1HPEu4D/mNS/BvdaY
 wS21tdOtiNJ/vVpJDAC8Rh/nQG1QmOMX5cpIqPIqeBQ2QvIMOTVSt2mLGOLzLTgzVlJy
 +PqP31gmyLK6Q/UuSrBofXGzA/aKoOA/WM+tsqOfb+9ZHQRfqzMWCusS5FIxPwFSpykn
 4D2uQy2/I23JpcwUgJHRpOKusAmVAzZsc7zqFh2NAIDM4LbnT88oPSzIjBvChW5DMrIx
 b4/O5gKMUnozX+md5zX+yi4C8O9afYaYy5s+tYulRhwUi9YbJUcmhBazTX/pLBhBdZKS
 UC+g==
X-Gm-Message-State: ACgBeo0SFkhIuu+oNmCYTXNwG1JFMqd6YgaUke0Ygemiv8cd61TNk2N+
 4ERi+1lcEGZnkLPgZfd2+CujcviavfKopyx56CGx5ZRaBX3Hq+O/P/Fdna7rj7I3zeh5MSO0rzH
 CFLr80sc7xZrWbCGmbQoKi0XmAaNUNRDBi9HNn7Fi2w==
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id
 r18-20020a5d4e52000000b0021f15aa1174mr8959078wrt.106.1659878828292; 
 Sun, 07 Aug 2022 06:27:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4PyGIbZ+3Zk1aEnQjWqF7U3soahzcZWTwqegYNF9JB2kgqFNme3tS807SILWNR3wTzZIMDGg==
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id
 r18-20020a5d4e52000000b0021f15aa1174mr8959067wrt.106.1659878828086; 
 Sun, 07 Aug 2022 06:27:08 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 d14-20020adfe84e000000b0021badf3cb26sm10887722wrn.63.2022.08.07.06.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Aug 2022 06:27:07 -0700 (PDT)
Date: Sun, 7 Aug 2022 09:27:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220807091455-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, Will Deacon <will@kernel.org>
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

On Fri, Aug 05, 2022 at 03:57:08PM -0700, Linus Torvalds wrote:
> And hey, it's possible that the bit encoding is *so* incestuous that
> it's really hard to split it into two. But it really sounds to me like
> somebody mindlessly re-used a feature bit for a *completely* different
> thing. Why?
> 
> Why have feature bits at all, when you then re-use the same bit for
> two different features? It kind of seems to defeat the whole purpose.

What can I say? Hindsight is 20/20. The two things are
*related* in that IOTLB in vhost is a way for userspace
(the platform) to limit device access to guest memory.
So we reused the feature bits (it's not the only one,
just the one we changed most recently).
It bothered me a bit but everyone seemed happy and
was able to refer to virtio spec for documentation so there
was less documentation to write for Linux.

It's not that it's hard to split it generally, it's just that
it's been there like this for a while so it's hard to change
now - we need to find a way that does not break existing userspace.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
