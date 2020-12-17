Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D783CC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:57:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69922233A0
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69922233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E04612E2AF;
	Thu, 17 Dec 2020 16:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tCLA3Ep0QmJg; Thu, 17 Dec 2020 16:57:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A429B2E2AB;
	Thu, 17 Dec 2020 16:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF12C0893;
	Thu, 17 Dec 2020 16:57:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 928D5C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 81636875A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Runq-b1-wlW8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 096D087592
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1608224152;
 bh=c0PHT/TGtjHfuIdfwbbLYZ4BFjPZ6wV6q0w2OaDOfOQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=dIpw1EMrBmjlWPZRTLkwhTEYE/KNsbQfede19koJ79Vg1r+xqgByTv8i8tx6/30Bs
 x5l9qypGF0frL05vX877GBhB0byofEgF1yLQEQNqMazl435XbwWS9AVzgowOzANOmE
 sXrE2iA9Qhb+Vl/Ht0x9YNnoq/rHz5gxkbN8TVj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1kD2qL0MgH-00fECf; Thu, 17
 Dec 2020 17:55:52 +0100
Message-ID: <b84976b575676ad6ddb495a74087229aeec4d117.camel@gmx.de>
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
From: Mike Galbraith <efault@gmx.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Date: Thu, 17 Dec 2020 17:55:51 +0100
In-Reply-To: <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
 <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
 <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
 <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
 <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:WaqrFesBWE7MAabYptFLLhYagqZZiQDKrj3xWOx/T2LQISwqsOo
 1B+wbsHhmKdp60rSeJ+7bf2cdRVe08Nt5dK9QeW3qofuTR8ArAS8C9Bpt5+njpqTmGRWwDB
 vN2FSQT8qoBrevoi4l0kV8BXd/g92pxAY6E+BctB7M+Gf3R2J6h02rK1Na1VTFKKOOEfohM
 +mYWGWCPTlYNfZel94rYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zr+ombKlrdQ=:6A+/WfAIWi08aIWV+/Nus7
 0ZXoXJUyQinRakWNl6FaLh9Zfv3iynJCDGtt1R5quZcR+PRYdQHV1TwiRi8R0aXLnaf7+jt2h
 Snlez/u8i0SAdvmJVIBxRWWQW8RFD3tjVv9KrV+6BQLL5TxNRLS0mkdbECpBfoZZ20M8sc12m
 PwpmFAsYiCNcoD8z6ex2EtnJ0467V7nWLFgOkcPQy5SsMa/vO7ZZmPYz+6RTqxAexDu3j5bto
 LB8SUuht/N40p/eCvV3S8dAXeSxU4mwukdmEmPsemBGb1OhoW9o07OHLTB92duH8Lxzs7neQF
 +Vkxy7YXq4T4Z7g3upTUwqUA2Q3+4EcEJuHga+2wiz/GH6RV59tI+hPZGFA2xawKPXMffj2rt
 J5pXDn9mE0NuRIGajMY4EUvpgevxtvRybKBEscJXDuDictq85OV1WdB8mJQPljCm8lnIcTlFa
 W2wpcMVkTBhbO1ZU+4wYFSOpibYQVoT/FKJytRDsXBE1G89ZULQVaEFuIplglQ+7rvo29H/RU
 0bp0b14nJCFpxhpnZ2ENK95iMzQrLBQL8hWwV473i9eBOajC+BAe1G/1dyqpuXkmLX4jQSG74
 Kf+eHuF9VgraXyf9seWmRGwhzH32hTj4DWIq7hHsq9cOo3NXOkCvMNqfAl1oRImSIuhF39hj0
 4Nt75hIHSkFbDZLzmBHfBlTiHT9S2ER02sXeyuNVkHGROZ1/yt7WNtGjvgtmtmk5CWayFeh2+
 p7zc933AQ9YNswoFPxPYxw3p0kFfarD8yGN/8yPBjUjAWwqXzSXEyUC+o6h99h33J0oV67oBO
 RpRdCQQjIDm5oGLL6kIQ6WM1hxXjVMaZ3Dj5zTjxdn1wRMHYA/Tj3tIBo6+mFWTmAEr+3kdKb
 Dnxom02UGLHFGR6UHagg==
Cc: Dave Airlie <airlied@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 2020-12-17 at 17:38 +0100, Christian K=F6nig wrote:
>
> Mike can you test the attached patch?

Yup, one-liner made it all better. That was quick like bunny.

	-Mike

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
