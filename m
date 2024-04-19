Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001081292DC
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534684; cv=none; b=r48Q18CwATUA8xBtv5u32QwhDX2DVxX1BUe2vgmmZUtqZPgWlPi9XjSIVXidrhBb+590hHLgI3WbbY4kA+5f7bMis1GK7lPLafRHReA33wR3xTzkj2FNl6Mac8pNUgHGdymyp1VQ8VtAL37r6X53ip/O2XfUSuzXm36dtl+FYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534684; c=relaxed/simple;
	bh=mi6XnFalf9EtQ/ENxG+jKIfTecVDeLfY3D2+zCxoRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI4qhrgb7mW23qI6aodFw/fqVsaadIdOeiakk/41+6LcOLkEA3V1tfzVT6XPUOgzbNUStUu2TuiAb82+U2V1smdw6A/5yjkDaWP7bz866vkiQ3xN/H628qtCHwkOrxXAnv0SoVCyhBac9Poi9kTkazq21BA2Hofn+ylz3BnpFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HA7pGsmb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HA7pGsmb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418bbc690e1so17407915e9.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713534680; x=1714139480; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdhA12ApYJzVjqZj6OB/MpvC9ZtmrqHdwY8N+5n/lLM=;
        b=HA7pGsmbDcASLrACMuB6FcLZaZrOgSSsxGtS6GJ0y35zaVi4K0xiw58ctE37T4kj2g
         i/ZLvyyf3AGpNcWzWQaxEqA0M7q+17y7lSoWF5CF0CLA9Ox3aMYezOciYYiZb3+QKDAx
         C7VbEnUjQQv386ZU3xFOBnTT/ms8LOKW3xRZOhCyzPCgddnZz9fnHXWlfhV9WgODVyGs
         dzFq1gHHZd2fbfW7t40Xs2p0CenIzohxtx78lEjSoXH8GZGIRloZVifCH3bipBBITvVp
         DrrotoUg/rTKWwiVce/R25+OW3oGcT//UDzpwLBjGKxCCjuw8YQE69UXhfSuyMLOnPaT
         bPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534680; x=1714139480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdhA12ApYJzVjqZj6OB/MpvC9ZtmrqHdwY8N+5n/lLM=;
        b=JDRJyg8XHWRxZOfD0V9I3LDjQXIsFoRQEXJs350ikLS5Zap7tWAaszWKUavKgMA2h6
         91GspfgQLiNw4FNhjgGAOgTTdvhnBsx3yB4/L9rjMmSkyP+KBtFWcD/uXjgiQ+V9a9mh
         a+yGn1YA0BD5STWsLHmlLg4IE+d8PK9LR91EvfV5zVzAqAWbd/wCtfnR/7jO/cbPk58A
         sCHc6azm1gsaBeFVeA+g7EcVD+RMe2P5CfdZLCEtUEUSYrQRD766FO2ALi7cqoBoWYqd
         Yt+JULNAxhUtUZELygewtfZfe/1QGwoQ9YKplmZ/hyHMEpVKJG4J6HD1G0W+yBs5DiKA
         I/4g==
X-Forwarded-Encrypted: i=1; AJvYcCXgKTctYILo90mGgwJmEN3NY7gvisI/s4lGO17X9nVY/+LcuwLLrJxxZgjS6eVsIGjj3nPZvkZi/TG0zvXK340VVrQlXnvISzHwAOct/c0=
X-Gm-Message-State: AOJu0YyZ4+chPRQBVY7lxF5CoRFUFLzPOiMOTL2zwDtmUwp+akgTeY9X
	tN8YclmfGiJpwsSc6lKo0GPWNA9EEaNOBlu0J79kbBqggOb5mXwtYsjaKUAq/MM=
X-Google-Smtp-Source: AGHT+IGXzjcSLJNod0+4HL4Ih6pp20uZOLo+tZhLBwZQD5QFrAyhVsfR1DSp8c+sjOb8Yj00NhB9bA==
X-Received: by 2002:a05:600c:3b06:b0:418:df5a:3fba with SMTP id m6-20020a05600c3b0600b00418df5a3fbamr1474289wms.32.1713534679953;
        Fri, 19 Apr 2024 06:51:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000050c00b00349ac818326sm4463206wrf.43.2024.04.19.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 06:51:19 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:51:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v4 2/6] selftests: forwarding: move initial root
 check to the beginning
Message-ID: <ZiJ21Pz0Pa1bo0KJ@nanopsycho>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-3-jiri@resnulli.us>
 <ZiFq9EmbGZ3psdho@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFq9EmbGZ3psdho@f4>

Thu, Apr 18, 2024 at 08:48:20PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-18 18:08 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This check can be done at the very beginning of the script.
>> As the follow up patch needs to add early code that needs to be executed
>> after the check, move it.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - removed NUM_NETIFS mode, rephrased the patch subject and description
>>   accordingly
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 7913c6ee418d..b63a5866ce97 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -84,6 +84,11 @@ declare -A NETIFS=(
>>  # e.g. a low-power board.
>>  : "${KSFT_MACHINE_SLOW:=no}"
>>  
>> +if [[ "$(id -u)" -ne 0 ]]; then
>> +	echo "SKIP: need root privileges"
>> +	exit $ksft_skip
>> +fi
>> +
>
>There's a small problem here. ksft_skip is defined in net/lib.sh which
>hasn't yet been imported at this point.
>
>Also, on my system at least, the code in the next patch can run
>successfully as an unprivileged user. So what is this patch needed for
>exactly?

Okay, you are right. Will remove this patch.
