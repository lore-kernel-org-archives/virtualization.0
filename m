Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DE47FAFF
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510896; cv=pass; b=Zvn63PXGgLloX3Aj1V1aDtbi6I3sJqmm8iaMlMzSaOlWRHst8yDhLoG67OXIg8R0m3vk4MQo0zXBpDvSAZyIGmfy907ClicdZP7tsTyWoTIIAVZUBS3G+ocm9gjmQSbDjbwZkqOW/nY02S31riHMcagowat1lUy8BP+IJYz5eBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510896; c=relaxed/simple;
	bh=zMEH3dKvgIFeOLNgenpgNKtSSPQyo3I2Bi4hOFPx7Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZWNvWeqATms0ktY3JyEQJji2eg/9+f+J0W2KtekoN0JmJwNT74Fv8IzMAhep00FVm9jSIWxbj4kZUNjLOAsrPXkaAI1cQyNGjY8r0b5D+OHUtcwz96BtGC8IGONPSF2vTlRiowykvZ9l3/lZFXFS+JleMl1/lXB6tQhUIdTHK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV/k2TQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VYGMs4OU; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV/k2TQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VYGMs4OU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLYsDf1152283
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=; b=IV
	/k2TQjkUrsTGpshqW8f1AkLpzgE6WqJLnJXyVNHKYz8mozA+vLQbIOpShvI99Nvk
	BGk11nj45xZQZMebNdo7NiYw/EO7W5wcvHVc8eAkRKtGrNMclkKkbe3unomYvdUd
	vFaT1byqggr1zubtRjDzuTG9pECEQdOzFAiv4kdIU3d7CXM0IsQ27dhrP8NvQBkU
	TlOdMgPnM8h4FF25SXM2n03VFD94RLvjnLlaGSHHxie20ptztZeSDX3B4EelrzMT
	n1DLEJiB1mKEp0dVH3Si7JCiMZpC8ZcIigaByfbQDV2F2ANWVcL1rru5kNRyAlZ9
	ag1DWjYpUlLQQuGalXdA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux4d0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:21:31 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-45e83fd0663so6244514fac.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 15:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789510891; cv=none;
        d=google.com; s=arc-20260327;
        b=WLNZq+Uuc8xbWSZs4tT52KgKK9hJr+42mop6IshOBIdA8ba9a3SIilLh5jxaPmx6E1
         WXe3uVia8dyVGsDOoqYihXK4vzQjD7In63Gboacy3twQjvkaXr9XZ3+YvevLSinOzuL5
         j5q3JpkJXLFTAlTSdxDwYGwN4xh7gQBxpbkfyh4moJiE1Ok9RCHiEvVrVuIeHkNUB3zV
         C+elvZN66FnNggGrO5Gu8cyqHg7xb8m+u0kC1fwC7/5xJt58Syc0fJHO1HINSMIgdf4n
         wc49ETDU62efRyQ12OEtCaIhFOi0NcSWO6t98xbYZATQOg5wiBpNQjCw4lIGTbjnIvF2
         HxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        fh=VOXvZKCh8zwstieTyn5ifY7BFZl/p8muAJ+bv5WHp8k=;
        b=QoRp2AWfmuUQoJChaUWNfnZGcWeEHZmyV4SYVTui+uBAPokk0jlrLgL8ryQLSKx99T
         UJO8jT6xzS3tFV+sZCQlvCTvDypI3sFxbwm+MaJJEZ9AsKks1Z61dMVhD2MuOqgAJ8fR
         +9Wsr//Mf2tk65c4CMPvATUWdwRDVNVqXQUSkIDnEzWmLl9q624GmFfI0B9c4XXA1H1K
         zeeFQL3toUZSlwlTQc0pKdStClYNLRBebkvej726Pvjl5jJIf6o4h6V7r23gFk3blyxn
         B0e+w86OaR32u/WPk+OopPYymZaFfXNPRHZkXz8FsSIU+7M5jyY3hQhtVBg4Xl+kG1dv
         jS+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789510891; x=1790115691; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=VYGMs4OUWMErYH9Sy8KafE6/h2zBxYfPYmLSDc48SLSwCaThhxNPDMpT5Pi3DAGwII
         E3CG+5i8zo7F/zUGBOuGU8AelfYY3u5C3gqKD74q4vHKZO5EzwLBrVC22o64I98zDVvm
         b9v0yjgMPBMasfDIawnv4yfrUiAxvRbp0s6uS9BPdhOOR9szfZhEPcKHZFgpd8XsYv+c
         HURKE2wmOH3VOba3XBXK8DwwjmxDT2+/fSeP9q9EZ2C3FeJa5fobHWwWvgT4C+fr5gl6
         ZgECQ+z2wFkG9FOo2Ruc9X9fOx4ba6TdFjFx20DZLw1O/TwdZg3WdOuHNsSQ9tp4amzZ
         oDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510891; x=1790115691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnJAniUUz5UpK0eAzqlFlmnyP+PG3E6KxIttKsrRd1w=;
        b=woqvjLzmvtL07TzXPR7fhTvpRbFLdm6vWjpVsVFwMVt1Kc52NdKyfec7h33BoQ0/gk
         y19GEYuHoJ8hjwHYqqQ+3NVQUdlXxKjsgzPQh8YxvkxotAESGeS0Yo6P22Pgf2PCNT0z
         l+NOYyloJpdvIAPyKK1uyDoznsjdvH4Yg3QAEzW98ioQ/JgDhRxHq6P0AwE5U+33BhUM
         K/llx8mIlYj8RRFA4GX+pfiQCYdR7Z69MdCjlKVJ57dVE7W1ok2zbu9cP9x1I/Fpn6W1
         Jrt7ZnGp18yVe+QucWELkCfbe1hDYW9o1kgVsKpE/C4ln8pnqzFcsbT4MHDk5O5MbNuq
         nDXA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ+XURZKmVFbh2DNullVzTWEjQZC5LIvI63EX2oyhSZWnjw9FPEVcHV6rxTTyI7hG7p7qIoBbK6VEoMvuXzw==@lists.linux.dev
X-Gm-Message-State: AFuF++mCRsF1ZlxIe/50V3u5cyaGePI9QhiuS183Gfr1xx84klcEAWhz
	9hIlfyZIsyd45HEUFV7cW2qxrKF7voosbjmtuaXsqcxuHFB3ve4rGV93mE7ezDfOgzWMkC4CBDZ
	kJtNZL6MypOwrwVuxqVLv0a+udmt4iOLJIDSPMpojmj8/zEDll5WXDqjpeu4M/Xljuh7b73iPJv
	zMDpaLZ5jtU5OKg88nFElf9QuYmhojsPa6slzmy8N4iWEg
X-Gm-Gg: AYBFou0ff2PwjDgp7iuYW2EQ+tla/AjpYnUvUMBI/N2EyQxgO1PUFydtJYTdpsaP8Tb
	uIZ5ZE743EQZpYgHLhDu4av97miHR+zNA68Tm1i/FiIcYWK+gVnH91CBzEmQliymdFIWACscCwx
	B2oDWB0iq/uckPnnHNtwIACPfBD8BXJTT2aFQ9DquHXmOy6vgGhdfWnxC6
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id 586e51a60fabf-4847584c51dmr189765fac.2.1789510890854;
        Tue, 15 Sep 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:30f:b0:45e:2de4:95f1 with SMTP id
 586e51a60fabf-4847584c51dmr189724fac.2.1789510890430; Tue, 15 Sep 2026
 15:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 15:21:18 -0700
X-Gm-Features: AcwNN1UxxSxAxz0XPK7niSod0Tx_HsUs-C3mKdcqDSaFkh659BGkCorPygYZGHE
Message-ID: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfX4Kl3Joi5hTnK
 lj8Zg22snn/P0X8zNYHwVxujFaIymyiZRhhJCGChNGSzAFUG/v3WcuamiwmbiKiOiPSfYlrJcec
 XcpoXobWxyWIpUaKclZ5fJv709bog/6ekd7I2cPGF7xbRKVLzAk2652R7eNvNM79awE8PEQP7Na
 c1sJl9Fe1OPz4Li1PqKhb7VXyaDIbvQeWn1DYqZRQmTEvRpPpJZoDWZOliBt0+kb67gWnQcNXl+
 FIuwNc2N3mUJNXXfv5CsRYjmZvYg96LTUTLQfkqDINtc5BMY3yFUm9SBCTHoxySsL04tOWzN1j1
 4WF26J4JZ/gJ93yP9wiIcpiJI23uf3uUZamIIcmYRMz5soujlqEL/dbzGb/RxRIqMdpuio8wdPT
 m1rmc8xlF87C5VxvRHgVy2fa7kBek6/PKzN/kFQwK/pznBvC2PnWu2BuuJhMextXEiEqxcERibj
 aDM9vrt2Xt/JZMbtJEw==
X-Proofpoint-ORIG-GUID: sncyO-wYUiW-BY50M6EHTewkLRaeAu-N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMyNiBTYWx0ZWRfXwS87AVHVkYDU
 tVv6P+DSkzm58p5LEutO+9IQy9+g9cBiOylQkpticpVpOAzz45Gsuo4vhcfLMx90Z/TKXIFbbwP
 RszbXaYTDEJ7OZvNhuxLYhSYtpp/9WU=
X-Proofpoint-GUID: sncyO-wYUiW-BY50M6EHTewkLRaeAu-N
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa9c4eb cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=2Rxv5svHm-zNKBYa0PsA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150326

On Tue, Sep 15, 2026 at 9:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it i=
n
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
>
> Honestly, I am *not* a fan. At all.
>
> I think this adds complexity rather than removing it.
>
> The diffstat tells a story:
>
> >  106 files changed, 962 insertions(+), 861 deletions(-)
>
> in how this adds a hundred lines more than it deletes.
>
> But to make things worse, it adds them in bad places: low-level
> architecture assembly code.
>
> Those extra lines are *not* making complicated code simpler. Quite the
> reverse. They are taking fairly straightforward "just deal with errors
> with normal cleanup in the place where it makes sense" and makes the
> *straightforward* case simpler, while making the big picture more
> complicated and subtle, and adding new code to places that are not
> simple and just blindly do somethign that makes no sense in that
> context.

With fd's it is more than just about error rollback.. exposing an fd
to userspace mid-way thru an ioctl is an easy security bug to write..

OTOH, "just use FD_PREPARE() / fd_publish()"..

BR,
-R
