Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505879;
	b=e3htXOFTVcZgTX14GUVdhCAwOXKSEkHzNKcO1zr4ORq6wRmY4oaZFAl9B11oH+x90u76
	 7qxHqWSjylk6h8KKZQn5y9pekBC/UFujUI/Yr92D+MT/xbQtCpcknVWSQnvXZyTzPsplH
	 Xs8B5vVCFR9ajC98Vyap4GY3iLce8DOmLPoCTBGIh/2mCSQG47EQ+XcU2jYAlLUKwzgx4
	 SC6zGcEQ2S9dVRifNAAmLWbgNycSEpqbTnf8d97or6ltx8v6/QySaqUKxaDNPNoJEaiFo
	 dBgNM4L963nNf4b0j2uE3Em/m3bQXUYVC1UwNSdUPeHlFrk17szMlMl2tlMTMsAlU+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
	b=IV8FS8uTJBjRo081f3EdA4z7EmxbpX2eOkiOgKsc4ucvPPYgm/8wqijedkepca9eubVS
	 R0tlkWe0pFwRdXtBOSKijrz0ew6636Sstm2RtuQYjWm60FjSbW3l1aiwl4pURmMkFWw5w
	 8glNGE4bGDdDCb4U2Cq4qjNAxDocLb/Zqpfo+bMn9PhjQmBDYY/uFfLVBCIDI0a8gg6gJ
	 qQXawS8AhPPms6ZALGEMrNpvYpubOcWnnaLtcztQVD6fZpbsGSJwKrtIoNV5SA6WUHem7
	 0doFQ/QiE7LYkn1SGGbNMFDXlKd0f1I0Yxcsw9TSMVh14BEzefX5LYocZjJd4JBB5sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CD3FUqPF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC608606A681
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 07:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC608606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CD3FUqPF
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k2jo3701109
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=; b=jB2OhFnb5kcQJfBh
	9PooZCIYHGNUVjDcGwumXONQT2rphRiM+HKb+Z5rBcfoZ9URBb6HmUCKyU398p1z
	0DE3n1unAJCPGSKA9qHqDKxoWrwnFiNfWRaB4F0mZuQ+gIyw7qVkk0rFFWIT+hr0
	xlGvD+nbKD4m1GM6eRm0zn5N+zABS6NWAAQ4zM+xLUUTfkXPLcKrmGNQSuaj6NVk
	LSMFCUkYtOrVzKgsE9JjRJp/p/+NgBxqv/l5UGfpSyCfsEnsySH6HhHWtAFvnFTH
	QiJHfUK8nig+0y+RvbrdRu8nHxWlPz45JWmVSfVxj87VvZ9rM/3qatNGi8g/YvkN
	LVZ85g==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1aen-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 07:37:56 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67bdee091feso5436039d50.3
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 23:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505875; cv=none;
        d=google.com; s=arc-20260327;
        b=VbdW82E3eo13tKrVcQikEEA6F/GwRKKgUlfoGD4Hax676yqiuLkw+7e8QKxyJqyJDA
         3De016h2HzCpW3ya6OJV3Xs5g8P5IVFYGVhYiE2WiCjOgcM6gMe2mx984qL0Qgr97e1m
         GJKOI0p8kNNT7zUvdGpu4lp438mwX2XWv8Zv8trAPjwQKMiG56J6XJ1Baw6iT/ZGf7hn
         rdwRZucjzeGFiW/upC/B8xnybiL/+bmUkW5ux/sQZFMkyCnVmeJQA0hINOG4Kp6qTSZn
         IMzRC4pu5FZHmDGQ+m5LrB99hkrnMrwdaPdXpdDsHumi/Drl49Qebr2GF9fBeybg1F1K
         CPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        fh=h+DSbbp/B3ukkrhTL5056aBEeoEoYRu1H06H9v1N0lw=;
        b=SmeT8dyaULMS/BxVPK6S3hTSpx/rj1Mn/sID0KRSWXMl/BRK5mNmQC1mipvwlF3BiT
         RMKATZrVWjPJnBMqxJE6N41oxFcNdNZTt4CLXvO/yKFPKLFWhSDz2rGvMmm/oC1bjOrO
         qex2hoKM7ee+B9G0gkvsjcx0oGOHNetOeCgd/TAQnGLXIq96GE/EQO3HuHFYR5tx43y0
         2L67LqT63Y4x38dHlrFAe8rftPWKyIls1qp9dIwipHUZG6Zc4ZfOhHSpsl3Q/CyoHrk3
         /gu9e2sT/8QnQH1pP5iyoBATXRA9zD9OCHsaZxgbqrhXuA4t3YXY70mIHuoKil47U+7w
         0gxA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795505875; x=1796110675; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=CD3FUqPFYkbvyJqyB0fNmZTl3RNdHLYua1eADYZRYgIuy9DHIVBxG81AGn4UXTkkxo
         Xcp8n095sJtm+APQH4p8JkwB8zl4iSbB23qZQssYnv4JZrX55DLUtAI/yv/oGyzNpOa5
         KSba66zNqNpvoOAcm3ZeRBNBWgyvz8Cv1J328I/9GPrEFyCLsv8IkW06GDWR57dTzf5y
         bm+ogHmy2MTWkG7z9uZJWv0ROYeAHgDkwVnsZg9FPpS+mqiks/pyHDtXB0KzVDZs5Zqt
         8gxjl0AuyJhDH27i5d1FPWbA7/i0GwNGyMw93d62V8e3k8NsrzLFjnAmEnkzxWmb473Y
         zXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505875; x=1796110675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=niJH1Ua7O4uiovs/kHLCZ6NHEu5OxioYHlZ7BIvWa3/Ub1PiCKvrMlzWgsZ5CohDpk
         uu9J+xNl+yNw1yfVv7y3yGOV2rC4XW4Ih7Cr9Vr3mjZ18bVGqDkVTOCYUYVO4lLJdBE3
         wLY5zlD1aMpCHpi8OlTs1Gb43jPRuJjBpjx6W6b2hWnA2qzbeDDbkpQCknylufSeFxfN
         37eWIBLve5ucA8gUNrxEZ377CDCB18/MatgHQafS5FmCNVHlYbJZuOTaT/B+waa3HEQL
         3DxK/Gbba8qwtIgLtNOynXAJ6JH7/5s5fmn4fumcQTtE+5ck5FTfdsHaMaFCLoUoNsbX
         svzg==
X-Forwarded-Encrypted: i=1; AL+hErGBvCmufMjwBfmnHPeEYCtO78n68J+5aWrDfeFjs8fZYS2UiIsXeew4nUWn7G7P7B0Z3J3ZfKrHd4q0ayal0w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Ru3s1ZKnvfUM4zjAWXn6P+xwrD/XIAd21h6ShqDVaMGVVYAOO
	q0SYnTen0AqoE9em1Kye9SyGOpik6qtlTipVAgj/pihahByTXng2sA3gMOU2xewJ4WdGIZQ95L9
	XJXs/amwZ9RYHvQ4FKKjOEV308Yu47ZPapkYGR62bbSnx2GJ12QZfqwcnoge1RT/r4/VdLaU+U9
	YZTjw9YHzSV0kjzJfM+r94bpTkFc2Nq3qJJ86QeIAUtxdm
X-Gm-Gg: AZFdTZelGvw9TjAGGWkPpXESP+BxZctgKVFmO6+yf8LKc9lqeqyK3B6WgBFK0ABjaTX
	f3ebxewZeV9YV0KxUST3FYcMDqfVZgp1XBFfAcod1ApivrIbOswXz2YsjU9Fy943CZxEF871itY
	sMSDvAltZKLVr5IB3SqcSN7VeHo2vRfT3zRekZxKno0aK1XNRgB9g7+K1lbUErhCLvafOrsXVGT
	dVieds7VfVWPwikjbl19z8IcNSUvpDjUut7Mk+Y
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id 956f58d0204a3-67df447c2b9mr2926909d50.75.1795505875002;
        Mon, 23 Nov 2026 23:37:55 -0800 (PST)
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67df447c2b9mr2926857d50.75.1795505874551; Mon, 23 Nov 2026
 23:37:54 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:37:43 +0100
X-Gm-Features: Aa3M54q5vxZ2pH5GHxV6_gcu1Tnc83EBXhtYw1pJ9H77Fl7U3CQoqAKpEumRrbk
Message-ID: <CAGgiveX=Z5gS7iJWBanyysVUStDRbgTnVktQwJySXw_-xL+sUA@mail.gmail.com>
Subject: Re: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b053ed4 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=97S62Xg_vF6B0O42EdoA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: AsxdoZNG2WpzKNY-85w_kdeYhkaV7YO3
X-Proofpoint-ORIG-GUID: AsxdoZNG2WpzKNY-85w_kdeYhkaV7YO3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfXwjQKbRfLndcn
 SnlyUG7LLKdOEH0tGFSDL7d60FBF42cb08TDDDmHreQhWWEwU1qCV9N1jFBAkBdixrbNCaecGQC
 rt9HGg3NpVZLAMV3/9XESHO37jft0ew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX4qSyhxhX+iZ9
 abaE0BkS0vZmFw57sEEBoPm+ABw7vqlsbH6hXSIbhiHiC0JiRpO8AI/kKF2fyNrcRZK9OI93C/+
 7TWMLskpfXVg1ArSGKBM9xmI6iiiQpu440ro7N+tuthA3EwQmLxsfghZP6yxVluHzKId8O2HYo2
 XxBTc5n2a2StD/1DzqGGb4z5OvlyqnxyzfjZYwF3iJ4duDBCuXK8nBU4waQlPS7zF94Tha8vx05
 d+0iN4VcFIDYMhRWb9L10YVG1g7pQwJwiNVCTgPpNBB0XyP6hjJp5K7A1taUGK53XZ7M9bKMgvU
 raSS6Hj9tc2gstrCvCkoYhh37MRuXMjLawiCHIPO6fZoP9l7nef+snxD9UGPWqgFFrqFaf6tgT5
 XaeIlAE+V3qX4k7tuHGGwBnuY91W9Oazb+17xGQvRtOtjQGFnAFlp8kfXrcSx5lSlSScaMFTbRf
 suPmPiPBWnzeHl+QaWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030

On Thu, Nov 5, 2026 at 10:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> PFN remap mmap action to map the shared memory.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  drivers/tee/tee_shm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1e089e..8fcbf0232aeb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, =
struct file *filp)
>         return 0;
>  }
>
> -static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> +static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       struct tee_shm *shm =3D filp->private_data;
> -       size_t size =3D vma->vm_end - vma->vm_start;
> +       struct tee_shm *shm =3D desc->file->private_data;
>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> @@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
>                 return -EINVAL;
>
>         /* check for overflowing the buffer's size */
> -       if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> +       if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> -       return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHI=
FT,
> -                              size, vma->vm_page_prot);
> +       mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
> +
> +       return 0;
>  }
>
>  static const struct file_operations tee_shm_fops =3D {
>         .owner =3D THIS_MODULE,
>         .release =3D tee_shm_fop_release,
> -       .mmap =3D tee_shm_fop_mmap,
> +       .mmap_prepare =3D tee_shm_fop_mmap_prepare,
>  };
>
>  /**
>
> --
> 2.56.0
>
