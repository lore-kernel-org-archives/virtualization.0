Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3F349CE8
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478421; cv=none; b=TG/y7C7ePmpNF0ivW5ID7eACDzoO8RSEUQ4VM44py6L9v5dcXvLqsQB6MCDuW8dNMkuojOS7xe1NdQF7McFUJQUotherOyJVwrMsHAoqADX5RTMIa0TEUw+ZDvY3DxuYBH0n1XdRCPg5waAgb1ohI0uNmzIN8aAyRgU8DPZ4fUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478421; c=relaxed/simple;
	bh=/qWtFqHBkrtLXXAD1XpvUaW1zHKMs9ArEGyHDtyLBkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs0gZApbQwipTZWdPIViOVlYUCUbmNXriPX5dgSK/pvB3mhW4a8xG1Dnwz+XZpEgswmRtAwO8ThFw8Hn9tA40QCxLvmUVQVt4I159IjWWlvNuJgNUX7KzI94etSZ7a4c31Ier7GHzvNbpAzQBsUHdk+M6ZB5alPQp8xfIWMGtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FnO8MgWY; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FnO8MgWY"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5bfaa014978so240458e0c.3
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 16:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788478419; x=1789083219;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qy1+fiy5vVG6Fgi2325/mnWQkrttmVDQVIUSqg+HoGM=;
        b=NxsoT/P5afiXcAZU4vVllGMHUwxlBLjPNcK2StzZoMda4Fe6cVucUEN12XOdEeCfBs
         7Gszz33TO1JAGfVI5MABDcsNfCaQm3lrwkoJ1rl7rGl3EVQX2WkhlGjY1pwI6OhyU0Fv
         6U28vVMa7choC5CSeO01fgOYQtiy1jVkrsgWY/9Kro24lEobTqf5BznGH5NukSB+zIEx
         amd/LkP0o6aWJZG0bU7sErOkK22dZSYLthHKBFUAFfFZ4qfeIDHTEH5VAQ1LhxzHMZ4H
         VfJO9vOOpQ3sMRjsQRvYOPkxPJDD8gLnQbrve5HXlCsJiexeyPiprSsnkA8KKbk+14Hv
         PSDA==
X-Forwarded-Encrypted: i=1; AKwUvByUXne3DibPCEydwJqnsmKX3pHi86shHfOT7E0Hpao+NWdAOR0R18B7ZZh3rC730+Tf4NgpoBkznhPgIWGjHQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mUyPquACeVfbbXpB9SzhoUcJD9TEWHDQJJgDDlYPtj5Lfh0Zg4
	YiANLIJmiSPIAjMH3oCFuAghXrQt4LRw1gD9DF8ZzyC/+EPG6ql1yrGGbtaNYX69MRh+JssSzmI
	Tx9L8GSJzsLmRHMuDGwyEQiw6Oo+RnSV5gmTra+6TI/rnkM03aq5z0mpaNAs/SuFfOZXjy1wka9
	xrVJzu/+uQYBgM/PNEYiWhlYoGMC/fYlJsClisKC9GgO0OTuc1TLFbw6+vxtwXd+LGsqHwi4ldn
	qr4POU/4WNeD8bpgIukqtW1Y44=
X-Gm-Gg: AYBFou272ONuGeI4n5Y61JoTu2HB6i+E1HWg3ZAGaf7z0ZMr3++XkCVQ9CCaOP5HJ0d
	Q6gj3JKgO3PqXoj3b/vzxvx07c+w4WLOdEFJfQABF6CBc6a7fEoeMHguZLikSsvZfBWIwY9sTPL
	HKB2ilYL70e6EFj9UbWXgGvVNSjFMl3R9nJf6I9JinCmC8NMoq3gpDqBMhA2+LG2MfQOPzLV/Dj
	28vcFnj89rCtyww3esdLa0tdD9tkTPBc0epasidnMWk2WJPjhg+jtdRBo1JT7o6swRtELl/YHQt
	KB2zI1i1wPo2F20L2UAtsfIYvU68+g0HgeTlijPF+myj6FnJyxkUWGaAJ88sC+HJXzmJyzUq93t
	5+7eTaB/uaMbvhDL6YxN4Gt46psFcUbe5cEO++40wBG34Rt1ICHPYFIsiArIOCsQO4Aoqe3z3Gj
	Z3lNhriY0dxlerIWWbxGy5pMW58xHhssbGB1zXelPj
X-Received: by 2002:a05:6122:4f9d:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c7ed525e15mr934434e0c.2.1788478419007;
        Thu, 03 Sep 2026 16:33:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ec138a06sm435557e0c.2.2026.09.03.16.33.38
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 16:33:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso638184a91.3
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788478418; x=1789083218; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qy1+fiy5vVG6Fgi2325/mnWQkrttmVDQVIUSqg+HoGM=;
        b=FnO8MgWYFFtRfa3LNy0dXu4c0afPuknQZYfQhTk6DJZIm/CcUMI/CRR0wVDaRi+Asr
         iYsvHkNlf6c42lXarXRxgOr+Ca8kWgkg3kWzgtXYA+WZFxkgVPIT4kypi2HsG7YuLd5W
         /sPa9332Ky6pbIrmgre8ITWk6pNU6lJTKN/bs=
X-Forwarded-Encrypted: i=1; AKwUvBzvmjIKz/dW7Nl58C4OixHMmM84ypHL4sUAvVRhQdmn0dRmg8AgQqxoms9Txtb2bpIumem2+rEevAAUJV/ttQ==@lists.linux.dev
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39b261b1bcfmr3210978a91.16.1788478417640;
        Thu, 03 Sep 2026 16:33:37 -0700 (PDT)
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39b261b1bcfmr3210904a91.16.1788478417146;
        Thu, 03 Sep 2026 16:33:37 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm2238141eec.2.2026.09.03.16.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 16:33:36 -0700 (PDT)
Message-ID: <b858b84b-a1ef-45b4-a7c1-35ba28490e35@broadcom.com>
Date: Thu, 3 Sep 2026 16:33:42 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall
 arguments
To: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
References: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
