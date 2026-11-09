Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215685;
	b=tkkbbDy5IeVCBsk7JuMPEMqo74q4L+aQfPLiZlPp8mWnY9+oRaRwTx0Ku4l4TkuqGIeH
	 9GZA2SXDFN7TXh0izFC1n1ELw8FhDVlAmMoMn645yAuJHyBq+5e2LlQ5CUPRj95sB0CDS
	 iu6vekedYW+WIYqZO17jyauxGbVMU8xolq2DQUrocGR9cuD7DXIwwLG8yhkC8+1uwhMM8
	 FHvYpEdoiHB0oR4agzTRHuBsCfFebn25VO8auFr/0JGmI+05XG6lsdzlEf+UnVONKsoF0
	 kJ6Cv/OgSzzqKnARgxJbi0ZeF5oe7+v9Wfcma4FnXUylc4mK5LpxX20S5w5jkOL9X9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215685;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	b=HKGMTcCIZp9Hmptnh73vxoNSM2wF8g+EyD/lkHTnFjcSq5dJivwZGtLjnfuxJkP5nKJX
	 8MwV/Q04C46N6RVDvLVWr6zKc2gkEgxJh6s1MGAJMtz8kMN4M0tUqiRGtM80sl/bbqxeI
	 oh5d3vvn/MNDTp+6EHZ0X4FxDOvYOOxBWxoqknc77S5X9E7wp8d+fz0v1aYFyeAXLNyjn
	 uX5twYvixRo1Gho3JzcbwQcDNwiVQvssUlVa8qrqx9TwzRL/yZJWtsH+ljLBH7OEKLg8Q
	 RJNT9d87sYpWiPCrbWLPgU5ug27vxVHwsbqJFnQwuGjg8Mw1Y66JJ9uhrO7ergvnMLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XiAQR9Bk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A138606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 09:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A138606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XiAQR9Bk
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96AYej066311
	for <virtualization@lists.linux.dev>; Mon, 9 Nov 2026 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxdp4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f37c94ceeso134962985a.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215684; x=1794820484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=XiAQR9Bkjk5qx1bNerHR60m/WTq+utSIO6vrQ65B1vNtkWMdLHokMGhxerk8vYF6tg
         mmcejotFCIGDSriLiMtQEM629HQkw6+MxQLA+R7CtZ7OwBJDu8gWqmBArkQd/sHsLCYp
         rgOEYbJFg1Hpmcy2lFaf++H26RJJFaAWvmO4cTVbS9saLUcYgxy1xToVfg4Q/u9ewM1x
         kodAnY/AtF6iZ+sf2Yz4rJW5RxT9h8zIUBSV1D2sm7VPtJ+cI/ZfLbCB6bJUAXlXmQGX
         zA9AOQXphlA6VHQm6e0YrSaYWEqgFQdxIleh+aan2V0KxKqDH6T9MCEjc8W4BD46ml/P
         JxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215684; x=1794820484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=Coeryj83asPPT3p41jvoVn+u7pzG2FOtt4+HkILyihXusPmK7kfhog6Gi2wg+KTCWb
         +LLk/8pQllKmlx5hRjhLmzI/zYaMib/PZ13wFfCk3TdCl2kZhtwpIDlXDAs6ZsW0EIFu
         KL0gpsxXRiCPZzUB9nZz9eo4Qn5FKUY8moRURJUwKaJntKbEFwNoGNMHR0wPcCyuYG6p
         isz55AEOJcGBFGvZ+NvUkR8JPWQMVdAQYxZyg27wRfw9y35+TUS91qSjH5MT94jpQwHy
         G+s8wDRzqbOwGpBn3V1AkPoGznu2bBQlx7poyv7U9lwaBzGcE2hRexnH9KNZLXCMtTCU
         BZdQ==
X-Forwarded-Encrypted: i=1; AL+hErEo/G/6mSsoYFnEjVO8yQUdB8JUPO2mOUF6CBYMoA58XZeNUcKGO38/PeAenixeWIDzx1THDz5UUOvQLjRA3g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Vb31pSFABc7BpZIubEheoV/HWcnMj78dy/bjvPAzATGuQF1Bx
	bTzpvrYsk/lU4Ex6HP2XPnuHZHLQTqaXQdlnAwgkE4ECUV99ZcVOe5DX1PJ33TtsxZ5sYE7ElWf
	sGj/uFlaniNB5u7s+C9x8Qfe68MiIcH70rU9RUOftjMZt+xKgQw+tczWP0+g5S/3J/mNbEg==
X-Gm-Gg: AYBFou2Og5AYqwgjonm611qb1OVXYTL4BYyz1pn3eY9GyLXmlfzylxUuaxFdttQxJzu
	RswHmBZBjCc6fQn181Fy4+DYAVa5te09Z8AZ/nr65nNbjDlbkUR4CvAaMHcoKEpNcKA6mnormKb
	+3c0o8JQ/qcpFpR8KcgJltu1gDxEEVGv9b79OZOJJev6dhubK+8aPQC9fy+Sqsm+cuTTDfTY+L3
	2Rs1m9aOQNJvMgqZErw9YW8K3IBwXokelEFugIVmzHRA5nHzN1CMFtYH235pNNaWHHSyP46EcZs
	EgyPBWSJuFh1N2+S7a7/FinU1IzPat7HpIMFo304ynOS/LIBuXa1GNj/WTEkJ7gB1TYREanIUcT
	aAbKqENQ5jefI8EM4sii7FSxZuACECgB6lk8FUyRMNgno4zKcaKlcZ8Lsw6uk++c=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886327085a.13.1794215683467;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
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
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-GUID: Vv2rki67B5moNTGlSvIcCpfE4eC76Z0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX+G7KGexSVZjf
 CFXfI4JtbK8rZNASLBPh8IgKNyDFYuB7scxwk1j2h3aowfR1cDZ0XR9y6BK80uvg/6hdFN6I4MZ
 m9VK4VQkYlHnxKr50sHsIWFm+UJNLcjZHQjAaNEGzonrhXktmDsFVzs/mpCGrPrnunxUA7L1gNs
 +859fS6Aje6lGXRa/otzosvqgQvKJ6lv+aw8OORxOjlUM7o90hmIX4gn76G85qyyOB++G4RIjAf
 0TBK4b2uc/cgyciDw5e7+uqfvOy6hnwNtxvswgtmL5959DhwCJjE8bGMvpQyWTjYMt3ac3ULdFP
 Qop8OmTydK2lwFqovZ2651LPjdye3KGt80TD6ppmSsxQ3HyYIEl4TV1amGw6hJPyIdvbpoGs+xU
 yC56Osv9/pwzq5v5FdgPUrm1lhBkuSihuAHgcOxD//j5tbaoU2WYxQWUcQcDprdEAEFxcgZp+/u
 XyQinA/M1+h27azKA5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfXyy8THrCNF6/k
 sQqZnpe3gf8d8OzYJrog7yeGOpq62f+Bd8nMAdjwLBAEZOx5lL0SgpKkOj52glgexor61DyXIaY
 gevYZcdIL4nkedfE4aCU4jwO5/IYDI0=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Vv2rki67B5moNTGlSvIcCpfE4eC76Z0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
