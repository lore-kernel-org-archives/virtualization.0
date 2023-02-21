Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4795C6379F
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 14:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48E0240FC4;
	Tue, 21 Feb 2023 14:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48E0240FC4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=KahLum3L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bH30SIsuhyE0; Tue, 21 Feb 2023 14:27:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB9C74013B;
	Tue, 21 Feb 2023 14:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB9C74013B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C05E8C0033;
	Tue, 21 Feb 2023 14:27:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9624EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A11A82890
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A11A82890
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=KahLum3L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fU6YkCM56Rzp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:27:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C5BE82846
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C5BE82846
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:27:41 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id da10so19143807edb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N0H9IouRLM5K3a/SnEEfZMtruvcZWhcuKfglAwbop4k=;
 b=KahLum3LcRQIxk4LHJojb0wrF6lCzXucNgO7RojcCYjPxydIgV9oeB+kbEDjQGa7E3
 35ZfoXfynKTeFKoxXQ9Gfx3LMlsQvD+k3/qcHbTSfvuk6ARsDHcKTmr38bZAZ9TRK/1B
 3l9XPkwu70HUshC6gu29+JSPt/GkAv6bmli3MgyND9ObZ8Bz9eKWZRGUw65gnYeyCAu8
 1t2AwDzaWh5apSfVhU/Q9FQy7ZILZ+c+qp+9FekGC6Zo9/Kf4SpbePcSmB1Vzi18GnMI
 3gE5inWvgneoE7jr5we2OdHCT6Suf/RBB1VuIsqQPPtiJ0voQBNXe+mdH8SxxJRPwm5f
 uJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0H9IouRLM5K3a/SnEEfZMtruvcZWhcuKfglAwbop4k=;
 b=oqdpLHk9usua4VPsYH/Ym+JT4zj0J6QPAM/bjdLTCQ7AluFcLfB+2UKUFA1uAjAjqa
 O757tF0WLpSdq1arHjKLcXkyT8yTDPpcceUSFt9/npeVNIL1qpOPdkgKhyfe3po4Fy2r
 uwrkiK+8qXkE+aqbb3uki9qVbb3OYo4LQB8u1J9nWGV1LsZFUOg7xmiTDzoIlX1/Pfqb
 6AzEum82hvln4Ydb4464XnTzXomZgehGe01wE4g/dchOG4//Sw0RyEmss1ngavV6F7+p
 5JuxHCXjcpXBVg6GlLzJZ+K3nuUyKJwtlcskkknbX38aFGHB9eQMD3bpMCqjHb3YNDbT
 1mUQ==
X-Gm-Message-State: AO0yUKU+9E4g7xBpIwcc4pUHa7/s5y1LUcxmZAimlsCSOSOdlK/6BT2u
 ZlBJzsLZm7esMA0M60uliWh/Cw==
X-Google-Smtp-Source: AK7set9QVVxB8CyVe0rkcVCCD0vgO8MbFhLkRGfhxWf8dFBXTMXk8/Hd1QGe9IbCWGDavh3bt1gUIA==
X-Received: by 2002:aa7:cace:0:b0:4ac:c4c2:1c51 with SMTP id
 l14-20020aa7cace000000b004acc4c21c51mr4878700edt.27.1676989659619; 
 Tue, 21 Feb 2023 06:27:39 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 z14-20020a05640240ce00b004accc54a9edsm1689425edb.93.2023.02.21.06.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 06:27:38 -0800 (PST)
Date: Tue, 21 Feb 2023 15:27:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
Message-ID: <Y/TU2W05FEIH5lGW@nanopsycho>
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho>
 <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho>
 <20230220074947-mutt-send-email-mst@kernel.org>
 <CAJs=3_BW+8xL9gvUvUpFwRM_tBVvK3HY5aAQsGboN933_br9Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJs=3_BW+8xL9gvUvUpFwRM_tBVvK3HY5aAQsGboN933_br9Vg@mail.gmail.com>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Tue, Feb 21, 2023 at 02:39:31PM CET, alvaro.karsz@solid-run.com wrote:
>Hi,
>
>Our device offers this feature bit as well.
>I don't have concrete numbers, but this feature will save our device a
>few cycles for every GSO packet.

Cool. I will try to include this into the patch description. Thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
