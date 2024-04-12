Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955822EE0
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954625; cv=none; b=rPVBpWDf3CVy5hu0NdCotjyyZ3cHgLh5HbleRCvqb9cnb3bEwlwWlcKGCM69JRasCrt3tvSUVIfWJFDQrUdsf0NxJ2ODtzahcQgHtm+cSH+RoHE8gxsU71UoN3zCl01bfxFSafGZb1Uf3tjZ73N1PNe8rjTukR8aaZYjKX7UItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954625; c=relaxed/simple;
	bh=a9drh6RDh/gc5LP0JJH2bApYl3sZg5E6LTjci3KDBS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBr81uBYdHbdmMZdGAlnG01Hs8kHrn4jd0mVif/q0gSy/n/fAQDUiJGzWwaYKLSFYHZfGtl5ldJxmqMLpLJ/qER4nzBisOVEgJ6jzIeDPTNyOLJZIDpC1qzMsxrZFqkerJpJj/+YPkHqRSHevxSLL5lqCc3Hrn1+dw/q2XpiyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeyUBeEU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeyUBeEU"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434c3d21450so4998861cf.0
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954623; x=1713559423; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n51BvZIT+WN9Wvb7bAXMMtFVvL7V11A9hSVIjwpajTo=;
        b=VeyUBeEU5iSsiS/RN0I1Rm8YTwI36yY6bZgtoVyT3jBWF1okdcHhBbSNPqzQcaFI/A
         HDBnBjJrZE3qpmP7+4E/eWeNLGf7Re2GD564uv0NuO0C2ulLniNumgkQjjGAWDMurHX+
         rBS2qgg6/QP6bQWKbBBRRrYZyh8o+39G8t1K1pAH5ensw3zdim0cvUO/pzc3I15Brwio
         bty/jh9DrSMKb5P4E126YFt0nGc89Wcz5ccVSOzk32wsZhvsop1ezGmwqWu0iieDOX71
         VfMe8Dz2wdQegKuw/XrI0Mppzh2putR9A1J/86p37gNmFUOR8ssyO4vSt7okPcdX+QkP
         DjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954623; x=1713559423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n51BvZIT+WN9Wvb7bAXMMtFVvL7V11A9hSVIjwpajTo=;
        b=I9T8sWZrL6u4mUA+LbOaymiiMwdivB8532S8YMgpUei08La1PJMIkcxFwFl7V0YHWO
         FBCI1bQzOYQcsHQZT5PA3vRySRUYTy5ZYfU3esa85K6UDSS711OLhs4p9SWfTzJ3evlW
         PvseW9Hh3DrTxkTDw3xI+tz/AkH1hQP71tatX/7ZdNUaHHJTfN50gcdpnmoAL2OlDdRx
         UN+kyaWAo33u9Z3swD1bvpNUuJarS9PwIv+w1Dj6BIx6+mgNej5KckooCvh0yNrD/3ND
         Zq0HOcu3ieGTsRLZiKLEbsH6WxV/kNGHKNDbyTiddWLqF3zasPZVdzjjfWqaSZwyWA6r
         6u5g==
X-Forwarded-Encrypted: i=1; AJvYcCWR0PUOQGVD1HQxHoFNNasnYE4N/6wmhSZ8UCgD2rLq6vgHCCVcXQnOUUw8f1X3l1z1EsYIopfO2UbWveEQI4+J2zEktNFtdlAnMyh3OAc=
X-Gm-Message-State: AOJu0YzM/X1DvtWItQ0Vu0ZptFJFpo02dQLgCVruYfQr2G39BTasnZ6Y
	gjegX0nTDm/SiuLNxk1LAH3gRtQgM2G4UJbRayS3Emqk9mU3evLP
X-Google-Smtp-Source: AGHT+IHZCGsvpaFveX/T5xCZgBDGCi4rgvJEU/PhlFJDpUHv1LskwNrc66A6TbKBWCp4fE9QMdzADw==
X-Received: by 2002:ac8:598f:0:b0:435:bda5:483c with SMTP id e15-20020ac8598f000000b00435bda5483cmr4253599qte.62.1712954623068;
        Fri, 12 Apr 2024 13:43:43 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id v9-20020ac87289000000b00436b2135b51sm285562qto.64.2024.04.12.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:43:42 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:43:40 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 5/6] selftests: forwarding: add wait_for_dev()
 helper
Message-ID: <Zhmc_KsL__7noHWZ@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-6-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 959183b516ce..74859f969997 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -746,6 +746,25 @@ setup_wait()
>  	sleep $WAIT_TIME
>  }
>  
> +wait_for_dev()
> +{
> +	local dev=$1; shift
> +	local timeout=${1:-$WAIT_TIMEOUT}; shift
> +	local max_iterations=$(($timeout * 10))
> +
> +	for ((i = 1; i <= $max_iterations; ++i)); do
> +		ip link show dev $dev up &> /dev/null
> +		if [[ $? -ne 0 ]]; then
> +			sleep 0.1
> +		else
> +			return 0
> +		fi
> +	done
> +
> +	log_test wait_for_dev ": Interface $dev did not appear."
> +	exit 1
> +}

How about rewriting the function to make use of the `slowwait` helper as
follows:

wait_for_dev()
{
	local dev=$1; shift
	local timeout=${1:-$WAIT_TIMEOUT}; shift

	slowwait $timeout ip link show dev $dev up &> /dev/null
	if (( $? )); then
		check_err 1
		log_test wait_for_dev "Interface $dev did not appear."
		exit $EXIT_STATUS
	fi
}
