Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57ABC4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 20:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24C5D812D9;
	Mon, 12 Dec 2022 20:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24C5D812D9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tWrwRuw+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFPbP1PnSVaZ; Mon, 12 Dec 2022 20:18:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADC5780A46;
	Mon, 12 Dec 2022 20:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC5780A46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88B49C0032;
	Mon, 12 Dec 2022 20:18:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A629C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 20:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F351060BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 20:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F351060BD1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tWrwRuw+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdVndnGtmoBv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 20:18:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD416605AD
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD416605AD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 20:18:17 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 3-20020a17090a098300b00219041dcbe9so1147637pjo.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 12:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axhmleuH8rpWvYOnrEikJutSJr7tOe+t2XEG/Vl+vQc=;
 b=tWrwRuw+j/boDtM3gaZ778LpIC001lK9QGYYUMX9E9RltU8x4J4umuRNOae8QzTVAQ
 FTjxY86vc729tJulRuxmao1ufLPCjmc3hQ+FDzqU63T37gwHn2doK6/rc6vFahDZUprz
 lC4Eult3Y71ap/gHA8nE6oUPGEEqGnZHU0FhYANh9kefc/2SqzXv3v/n3bjc68mv9iEz
 t6+EtMA+2RKvPhqC4dK4KVUgW9eX6BpP2zOnKtvC1UvDt8PKgyEuBvXVBRHEBO9WEuy/
 8NNxv9xYJtfDgC/p2Pdbs5fIRkkiCP3qtu4bGAktkQkVP2WMyIkLENZu1E4Sr7mjtLDP
 A9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axhmleuH8rpWvYOnrEikJutSJr7tOe+t2XEG/Vl+vQc=;
 b=iXFwonJ4LaaJuEKjdGcq9ivY8dfcvG5j+XfWiqCfgKPaCMEWAKw36fDaSZJIinzFnY
 UtJRkkM09so0HSKLP8kKTBmSHeKK+pcBuwsWhVMl5NbquX8xLc5WHVZb8UBlmW9U3rzi
 4XvRDRma4M6bB63RB+SY38hCRPL1mQ+tdwza5gao7kHQDnnJffl1YSMTlK9E9vai1SPC
 JwVubjiS/PJv8164PwtdrRH0BMV6TdFCKcWBPw+2/m1HfArdrtFTuOVbbsBAhtJ5shB0
 z30udElUMBX6/8xdKcNGdx5XECQZ8Aju2Irnsn/GvhNPK2RyGmf7dMyb9OrZ6U6VSL25
 trZw==
X-Gm-Message-State: ANoB5pkdDDH5hYdIbygLEPlkgq7OX6LifnKBs2h9JQNrqOhN3iT4VBvv
 9QpjRW1QiUjXVK2YVCYnbxhpSXseQMirLNzv/Qr7gQ==
X-Google-Smtp-Source: AA0mqf5WNAvXFSTfWfvUwZfrRe1Gym0jHQBebEfisP8IEEnEdxx5vnffhLqwK7ffd7oDRYtVx2rRNoXRJrVB+lu2tK8=
X-Received: by 2002:a17:90a:a00c:b0:219:6b57:9e77 with SMTP id
 q12-20020a17090aa00c00b002196b579e77mr34340pjp.120.1670876296957; Mon, 12 Dec
 2022 12:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
 <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
 <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
 <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
In-Reply-To: <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 22:17:39 +0200
Message-ID: <CAJs=3_Aso4kRbMao-mfeD3B-DX8vgryCZVP96-U+_53CEZu3aQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

> No, it won't. It would force SNET_VDPA to be built as module if HWMON
> is built as module. Then you would not need IS_REACHABLE but could use
> IS_ENABLED instead.

Ok, thanks Guenter.
I'll create a new version tomorrow.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
