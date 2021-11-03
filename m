Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB2C433F5
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 06:37:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B2560F02
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 06:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1B2560F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 545F040293;
	Wed,  3 Nov 2021 06:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExbHfWDVx3j6; Wed,  3 Nov 2021 06:37:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D94640001;
	Wed,  3 Nov 2021 06:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E006FC0012;
	Wed,  3 Nov 2021 06:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CD6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 06:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E7564043E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 06:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nbby93F20REH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 06:37:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 491444043D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 06:37:48 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id r5so1852431pls.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 23:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KvV07TGoZaoGw8L0LWYKUbxKaPDqvzThxG6WFrFLoZE=;
 b=qV6o2DHzNyXcnTFQQPyEAH5HGAgqErf+nLausmvme7o+/HaH5BSY6GgQgYvm3NkDV1
 OR0M6iMn7ErGmFwBNJwqGcnzu3l2AYFln/0aOue4QU9nVvw9ay2ysnUE2cF7dZWoUOYH
 zLARG2g2WK8ganoyxRfEwndQ4J/4Irml4yeScRNO3KiamTkfwqbjH+IAAIoL15ZP5V26
 1v5s1K+xO1a1+PH3LDRkuvG2tCjW+/AJpoOYNzC9a4nhJRD9Sr7QgBzIa9O7SeyT2KwP
 3Ddois9E1aWdVaOecGfUI/sREvr3AoThqfVKlOv1mH9c7izxYcqWyPDhvnLUSt8A5x8+
 O9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KvV07TGoZaoGw8L0LWYKUbxKaPDqvzThxG6WFrFLoZE=;
 b=l9I0Dov1XGyUtjTQmiTLSUSvt6tHL1NJZ+BKIg39v/dfHtH2R6cREApTbPhaGDDkXo
 K0OZoRrzDeZUn284ViWmx48pNKJbikZ3gRkyVLmXSgTxPAkqNUTB/x12JwblYtlQmGMA
 VDFHYG3GDuOMTNzKxVAfxiifX8qIoI/ycLXEgbjilCZ/qqQHi2m3J+cMnouXvkE/Xy4t
 kMzdcHblxar+Nc4zObLiHVYobArbJsEgtzc+7plCjJSbJOO+BJegBYCFcAtdpAlqL65L
 G8VlmP7W0adEqBaFuBbYapdpl3YC+52QaKFxp49aSNtVJHZwFkORefbJ5luXGxWxPn+n
 kH9A==
X-Gm-Message-State: AOAM531z2HMm3tNQGR7CeXO6Zh0UHogPlE4uxmrWwvNedL2yr+wfP/Oj
 /GwUR/pd52wV+ufr7c0eHr48Aw==
X-Google-Smtp-Source: ABdhPJzCmOo15jlPdgZPi4SyQjZk/5+4lEfnC9j8LuN0Fw6C+DU4a7f23C24EyvWV1cMUmhMJaL6/A==
X-Received: by 2002:a17:90a:928a:: with SMTP id
 n10mr12308079pjo.128.1635921467640; 
 Tue, 02 Nov 2021 23:37:47 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id oa4sm930068pjb.13.2021.11.02.23.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 23:37:47 -0700 (PDT)
Date: Wed, 3 Nov 2021 12:07:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Chen, Conghui" <conghui.chen@intel.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211103063745.utpphthou4angs4s@vireshk-i7>
References: <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
 <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
 <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
 <20211029122450.GB24060@axis.com>
 <8592a48d-0131-86bf-586a-d33e7989e523@intel.com>
 <MWHPR11MB0030C3489F38FF2AAF7C3D0A908C9@MWHPR11MB0030.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB0030C3489F38FF2AAF7C3D0A908C9@MWHPR11MB0030.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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

On 03-11-21, 06:18, Chen, Conghui wrote:
> >>> Over the long term, I think the backend should provide that timeout
> >>> value and guarantee that its processing time should not exceed that
> >>> value.
> >> If you mean that the spec should be changed to allow the virtio driver
> >> to be able to program a certain timeout for I2C transactions in the
> >> virtio device, yes, that does sound reasonable.
> >
> >
> >Due to changes in my work, I will pass my virtio-i2c maintenance to Conghui.
> >
> >She may work on this in the future.
> >
> 
> I'll try to update the spec first.

I don't think the spec should be changed for timeout. Timeout-interval
here isn't the property of just the host firmware/kernel, but the
entire setup plays a role here.

Host have its own timeframe to take care of things (I think HZ should
really be enough for that, since kernel can manage it for busses
normally with just that). Then comes the virtualization, context
switches, guest OS, backend, etc, which add to this delay. All this is
not part of the virtio protocol and so shouldn't be made part of it.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
