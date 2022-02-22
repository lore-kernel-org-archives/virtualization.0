Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0883AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 20:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8737540168;
	Tue, 22 Feb 2022 20:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0mk2Fl0443E; Tue, 22 Feb 2022 20:35:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A97154011C;
	Tue, 22 Feb 2022 20:35:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67262C001A;
	Tue, 22 Feb 2022 20:35:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72D99C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B82E60EFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PqmsVXxugqTW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:35:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E56160EFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:35:54 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id bq11so18497518edb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w7z+2gBVssBTwkTFXRrU+BRzNhXOykt+QfnboI/H0jI=;
 b=Nx4Ebu1Qa73CdYd5vi87qARsrD0v/VpwZMXfHgesrmKuCWb9W3U4528JazIOYaiVyn
 2VEovr0WBDKVp51vKrn7Ug0ljNa2PdcWMBEjHzr0Bgteigjs0cPTG+1hkwiEs62z4bhT
 WT3SopWeJZIBLHGxHSdnc7r+h9BKJQXkQGi7UDb8yL8iXx5FHgeu/4iZvrEHEeLS748B
 f60tjNlc9XgrCs5J6wQPEGZJJcqNXWledRb22U7avPjyWU/VVq/haVwxY81sNfYRcNPD
 x4aBo04jpJ0PINIfmFeRgGXlJ7pfe1f+T7WYiYAAlOqwBskKIJX/mMQV5VvQUPuqoAkE
 Lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w7z+2gBVssBTwkTFXRrU+BRzNhXOykt+QfnboI/H0jI=;
 b=K/SzbsWC1Ktt5lhbGuiHLtwWYCyTM/dJM9tlny6oktxFEdKmAckEmNNTgrOCX0cRED
 61L3dlGNfNyU3BdYEWuklhd1O7NwJmkFRBZJfxaCWJ//hNeOOufPUk8TPL+QCmXeVDGo
 CzQMOgZ0HItkg4iVO/FVulrRVSSq3zTGXl9N1ddmuNNiurOIkQl9/lQY864rNkdmWE/+
 OJBpCVU6H1Py4aWSqVJaW8GPn0iE3C7CrVvrHr2cig8QMS/EmLuQ2VDJjYBCXksklxxd
 8lgZVZ+E93AZL6Boi93ABHsCG9Sb5UYMZZRtFnd4H5H0RgMeIi+qMRV8H11lvCrUI8Cn
 p8dQ==
X-Gm-Message-State: AOAM531TZaifQ1V/2qmu8V4LCSzUrWwtWcI8Kz7NWnsv4luuJDVd769C
 A2O2e5V6+ZDlDNYFjiALopSI+Y8hvgPaCMde60U=
X-Google-Smtp-Source: ABdhPJxlv7Aw10zN8xQzuLGYlYSw80uywRepza8MNhd5IsDpmmj58AVIlRbtUyHYQmY8fGDgmgQIrA0TXC+15SlWS5g=
X-Received: by 2002:a05:6402:5113:b0:413:963:4eae with SMTP id
 m19-20020a056402511300b0041309634eaemr10761037edd.197.1645562152589; Tue, 22
 Feb 2022 12:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20220219170301.545432-1-robdclark@gmail.com>
In-Reply-To: <20220219170301.545432-1-robdclark@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 22 Feb 2022 12:35:41 -0800
Message-ID: <CAPaKu7Q3CAcoyEgvo1KZnJCx6-EO+CPcARCtzwE9Ddbb_OZA_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Remove restriction of non-zero blob_flags
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Sat, Feb 19, 2022 at 9:02 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> With native userspace drivers in guest, a lot of GEM objects need to be
> neither shared nor mappable.  And in fact making everything mappable
> and/or sharable results in unreasonably high fd usage in host VMM.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
