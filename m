Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B379C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 12:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEF2460A74;
	Wed, 14 Dec 2022 12:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEF2460A74
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOSMM2kQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGSGYkDvpTxm; Wed, 14 Dec 2022 12:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B1B960AE1;
	Wed, 14 Dec 2022 12:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B1B960AE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B5DC0032;
	Wed, 14 Dec 2022 12:00:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F99EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 12:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21E2260AB7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 12:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21E2260AB7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2nsHvsato3JZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 12:00:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE4D860AD5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE4D860AD5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671019205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ORJ82nUqgmRWHPSLvhoNWLJ0+9bS/SAj60kUH3rLBhw=;
 b=MOSMM2kQrAq1q5srvZDDwdIkI0kfgkP3iBsd3xG0sH3INj/YYTleJaHF0vF9AYp0InRWve
 zZ/yuugfEnWUZ5UbXPf6/nDhbsmE6RZTb4iH/+crITKqoB24chZ0l5o+SO4OI/QyuVhKgT
 cdNHN58jctER5OtWQLIdPakLcTQ656M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-YJhY3wxaNM2Iti1uddTE0A-1; Wed, 14 Dec 2022 07:00:04 -0500
X-MC-Unique: YJhY3wxaNM2Iti1uddTE0A-1
Received: by mail-wm1-f70.google.com with SMTP id
 f1-20020a1cc901000000b003cf703a4f08so4097091wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 04:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORJ82nUqgmRWHPSLvhoNWLJ0+9bS/SAj60kUH3rLBhw=;
 b=GPk7+LLORPEvQb3W6nHlO7yv9PbwWcnThHTJcrEX1F/A//rYE7uWoDOZiFDIELq4vY
 cGDtEzS442caXmMWOFnJYk9oQ40DIZlnV/54oHIzxo689CfHtw3XyCvFbZKOsteft5d3
 K3ZeL/3PQfYVnlgs/Xzn0y28UtrsURrGq3e/3riZaR4sTEpEYiOBwP0PKC7xAAkHqDrm
 IFxssHUG2BW92EAbvdX47zXGapiYlG+kbeNt6kYpn7oMRvR3ebTlpG2euUMNXxFeCbkH
 9ykpEjIipdU+d+cJhe1RP1aUDJm8k8sviLPTqeB0u2Uht0JF0eJx+p8NOO3u17DBkbe+
 8heg==
X-Gm-Message-State: ANoB5pnMejOho2g53QFPs47H+M7e7BRAfsaPCnzo/RXeK9T2G2X/O5h2
 UVRJh+mI43gn5ukSQbRiMrS4Ws+Mnp3DlHuxlAjosQxeKlxv2k1IZbkK3mmpEYVYUKBW2M2f4n0
 8O7fk9aQeoaTWgjZwJDj0qpVHLV9xJr4s4PdP7RA9fA==
X-Received: by 2002:a5d:464d:0:b0:242:19ba:c325 with SMTP id
 j13-20020a5d464d000000b0024219bac325mr14267621wrs.30.1671019203203; 
 Wed, 14 Dec 2022 04:00:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf70rUn2JP0a8uV9qrEQRacU9eDMVqCZ636ZVH7ao6T+VGi+4vl1vzH82Lks4swv/K9ZhapOSw==
X-Received: by 2002:a5d:464d:0:b0:242:19ba:c325 with SMTP id
 j13-20020a5d464d000000b0024219bac325mr14267609wrs.30.1671019202999; 
 Wed, 14 Dec 2022 04:00:02 -0800 (PST)
Received: from redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6687000000b002425787c5easm2609121wru.96.2022.12.14.04.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 04:00:02 -0800 (PST)
Date: Wed, 14 Dec 2022 07:00:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wolfram Sang <wsa@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 asowang@redhat.com, Conghui <conghui.chen@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jian Jun Chen <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214065856-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
MIME-Version: 1.0
In-Reply-To: <Y5mjcuCRP45ynJis@shikoro>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Wed, Dec 14, 2022 at 11:20:34AM +0100, Wolfram Sang wrote:
> Hi Viresh,
> 
> > I understand that it is okay to pass the maintainership, within the
> > company, for platform specific parts from one person to another, since
> > they have the best knowledge of the code and are the only one
> > interested in maintaining it too.
> > 
> > But what is the rule for generic drivers like this one ?
> 
> Dunno if this is really a rule, but if a maintainer steps out and makes
> sure there is someone to pick up the work, this is more than welcome.
> Way better than a stale entry in the MAINTAINERS file.
> 
> I mean, it does not limit the chance to have further maintainers, for
> example. I believe in meritocracy here. Those who do and collaborate,
> shall get responsibility.

Exactly. I'd like to see Jian Jun Chen do and collaborate first.

> If not, then not. We can fix this, too, if
> needed.
> 
> What is the reason for your question?
> 
> All the best,
> 
>    Wolfram
> 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
