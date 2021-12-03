Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FAAC433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 17:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AC9C60B9B;
	Fri,  3 Dec 2021 17:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUuz303yrTKp; Fri,  3 Dec 2021 17:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C2B360B99;
	Fri,  3 Dec 2021 17:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28BB1C006E;
	Fri,  3 Dec 2021 17:01:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 759ABC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 637D640996
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9890tHMZFJY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:01:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7BFD40993
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 17:01:48 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id 7so6929569oip.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Dec 2021 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=tbEwySXb6yGxG6N7AFD65uHpUF9qIsmwiRZG3EFyfoQ=;
 b=d9FGTw97nQD8RVohATVwa6tURsiCtdhyWxDCP+26+2Ikkr/XRh+pPSWCpeCH4rnVYB
 oGUBk4yopd0Z2OEEVwiP6lupdhrTzce9hz+z6ulzORp22FeRLLgxy7Qwt7Ir/tlNU8UF
 PX5IeZYu+ttbrZXG/yR0aT9/nYTAQZLkzBoUEPi38eMUUHove2S0H1Ur2ktHHBn1mDVw
 tSUr0UrwAqJOC0zj0ruLb3Rije4TpUP+E2xxIxDanNTN9MH3lBPNANxZJs9WEePWjb/e
 wwfLzWtMjNbobR2ybnomh9q+0ZFKzDfTwQYP8v04m6zlboke0kD5otrmDN2uvbTCKbUm
 Ts7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=tbEwySXb6yGxG6N7AFD65uHpUF9qIsmwiRZG3EFyfoQ=;
 b=TszexH+V9tmPN2VE2NwvgLAQJ7kaz6KL0eSZerAtlVWW2z83Iy74hXbVi41qMdVWc+
 11f36Q0UsdbFhUPmKafwpAjwcf88ehmc4RO9TfuGO5nNBKonpxHJfuH5aBmyyEi5/Gvq
 K4dopZ/Jhgxubphy8/+48fuOb/McNCCVBtKs1cA4oWYyE58FXaflEwqLuU0Eh5PXUeLW
 A2VtZkCa63XXm1o8BlooLjGlKT1/7S1OaU7rjHBDqNex6jDZHCkTwWeZjM1dc9BJE7s3
 YMoXyrCdwRR7mjkrGZSi+7o+u5tvPVlGuh2cMy8ops+QnuBMoOpioEVRHokkWjzfzGk4
 JA6w==
X-Gm-Message-State: AOAM5335sQVHy/cSJPULo8O9NLCPl/mneuqYNZUg/sIOpA5zeha4RQzA
 1OVF2w+ovVREZQejLvbFU5s=
X-Google-Smtp-Source: ABdhPJwA0bZvUL3WcE1oyAKNlsn3/8Ee5b6FzsxNUmDJeKAM1vTb6I7OCxXwldT3drUiGwTyvxNX4w==
X-Received: by 2002:a05:6808:aa7:: with SMTP id
 r7mr10976017oij.120.1638550907915; 
 Fri, 03 Dec 2021 09:01:47 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id 69sm704731otf.33.2021.12.03.09.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 09:01:47 -0800 (PST)
Message-ID: <778b1eb5-3f46-2489-4de8-17fda15d3dd5@gmail.com>
Date: Fri, 3 Dec 2021 10:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [iproute2-next 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
References: <20211202042239.2454-1-parav@nvidia.com>
 <20211202042239.2454-5-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211202042239.2454-5-parav@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

On 12/1/21 9:22 PM, Parav Pandit wrote:
> @@ -154,6 +156,31 @@ static int vdpa_argv_mac(struct vdpa *vdpa, int argc, char **argv, char *mac)
>  	return 0;
>  }
>  
> +static int strtouint16_t(const char *str, uint16_t *p_val)
> +{
> +	char *endptr;
> +	unsigned long int val;
> +
> +	val = strtoul(str, &endptr, 10);
> +	if (endptr == str || *endptr != '\0')
> +		return -EINVAL;
> +	if (val > USHRT_MAX)
> +		return -ERANGE;
> +	*p_val = val;
> +	return 0;
> +}

duplicates get_u16
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
