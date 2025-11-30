Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050E247291
	for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543823; cv=none; b=aUj30E2910StTRHmKERQQnWdVRNiquHyFHjKj2zM2dtL/cnbp7aGA5Tj8D8p+Zljd1ccRhbc60oybiK0zRfQkwkAcahyZmy8/lROvTNoOR0KrRjWGQmLOZuaXQlmnuKLJfa9QTFPLOZNt2MLH4OexjQyQXDE/ArnfEmOs+GhN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543823; c=relaxed/simple;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6ubpOGQCBsiB4K6DO/Ns7Jq5daS3IUAXlPS7qFzap3CiOAc779seUlDNyRJGltkmqGq8GHrayi1SH6/sI+rayXLtaPB7oemax7OEhL/X5N0RkQmKA4PRNfUxF1f2Ls8GvCzMJQgJmxzhrI716EZSd8xjB1ikigrpEwCeobpEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so598430f8f.3
        for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 15:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543820; x=1765148620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=MyJkGgExtoJr8C4crN4B7Bh9mhJs6txaibQMfDaopdjFf8hBcPTA9Q5u/TLynCumT5
         MUeHsFsj6sLI6Vr/HBLL858K1MpG9I8YL4rFFgZYUhENnsbSJBcs7vaPx1R35+GXXkdq
         fugqlbyLm5QdLi3T9UB3QTfzBjXH1TWxD9ClMB3Yd9t9rnjnIgTbfx+EqJ2A3tCy1f3j
         sgxqY7lhxVHTIkjODYWW9vEnmlmvbEtdqvtEtSlCefS50FKY5Vz4BIgKDe205oLa7M+F
         T0py6HIDZQ4rV/a6gwpKXx6tB5eiCDqO4CsHNkBgQPFanAbxS2ffdUi/9Mub8vOp02RQ
         NDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv0/7C+kCMGNOu+Dq2DRtH752zZdWghZ0c7Vc9mncERIsbF0W8JTWHsjZVMaw+PTmqXEYnaiCv+MxsD9+tvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzfSa/FyzzMNLPH+fiMGxdhDgsR6uLZGmQI7nHKNDEz27DyavS
	ZpcTrjIsTtMnBVcIRQHMVJbw3u9nR+GHWgpep+P6u9KblMtceTqj+UOX
X-Gm-Gg: ASbGncu6ZzT72jUop9VG7DhEO7+NQ/KjSO1camGM7KH6zoYPXqjT8H+I9qLB1CB2TI8
	qACjX1hrUANuh7i9GAn5jgIV2F6S5173igp98afdgJLmMWOGw7/MYIQ810ZkwCrKp1/qJGhWG7D
	sahl5I3oyB/LT1P8uy5XrRwwzNSFO/Xc1pJAnXjUe/6SwYZSkRvPgM6fS1nyal2RdgwfX4iukL5
	ObOU5L9hN05g4os90ChkhaeHn22/WZX6ljbG63ZkQc9jCeBCuIewdUH80I/VFI0KBby/hJSS/bL
	CCFfskJzo9LR8dmcfZKsnGR00qrPHQMcQqizWUvo3Qe46XhY/H66OmA3jUHb//dp9PP1TZGG2vH
	UnJPgyEuZYmJNWzUbU7+cdm29oSZkE+hFD88gQY6P6gC3YlwSes81yG9ovOfkxnP66shS0bZ/Gm
	paBCpsmUheByo6vcZHJxGLgqKxEgrlD/fjzvELwH70
X-Google-Smtp-Source: AGHT+IG0kUJO7SYN4V6YpXy8uJxkqAm9wDLe/yTWTady0nKXHIsEefrNGBZg2POKGw5qhetClLnvgw==
X-Received: by 2002:a05:6000:2484:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42cc1d0cf34mr37257663f8f.30.1764543820316;
        Sun, 30 Nov 2025 15:03:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22401721f8f.40.2025.11.30.15.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:03:39 -0800 (PST)
Message-ID: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
Date: Mon, 1 Dec 2025 01:03:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio
 chaining
To: zhangshida <starzhangzsd@gmail.com>, Johannes.Thumshirn@wdc.com,
 hch@infradead.org, gruenba@redhat.com, ming.lei@redhat.com,
 siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangshida@kylinos.cn
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sagi Grimberg <sagi@grimberg.me>
