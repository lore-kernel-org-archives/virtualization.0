Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6037FF6F
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781451; cv=none; b=sLs2tZ/pLEV2DIr/wBGu8vhJdIByosepTjXmKUXp3LqJcCrwLKLzwtxa36cwmkgG4Gg+e5lFntLnSGAQ/EPO05WsLxGRSY8cW2RuI0oO1i0BFGvcFtm4OyeAEp5K3ekioNRzyPZTMvOGsErD7YfbALmuRU+U5ewgYzX7vV16BoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781451; c=relaxed/simple;
	bh=1rXHSuH/I8GRMhnd+YsBX5x/JhKjP7jhEEWF4AlQlX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oW4Vnfg8WPW7EanRt0GQauX1gSmsLBBdTcLXsKo4JnKfs8iZ2BocZA2fqpVTZ/bDBv5q221e693Qf7Ko1srRiamxFlVcGYlEmGu04P4qM+LT5jR/28Mk+kQe/UT8nqhMkL8M1oXvmkhGW7sjoHam06Eq/y5DPDg8rF6xI2kjjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWdtrbFk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iLZRrsyA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWdtrbFk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iLZRrsyA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LA6CBq1834915
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	61L2ICsEUf0Di4YW/bbJVwneFaoftw7+9hq+b7ipqCk=; b=mWdtrbFkSxX8QzVG
	VUuusnFw+HlEV6CENPpTGY8CBox2MAkmROJgyCnPXLZUyI3FyxO1eL7yDdIcTMfe
	6zgOYgwLJGqv0R62TZtlhrNTwaZMnO/jFHoiV3ZYI6V3DzqxtiT0L4gwC1cQWERu
	Jv2L6HpNQiWAGC5xckhzZApwzMNZDNQeFcx+lR5FeoXyV5DA74dTTOAChHAJMi2C
	xhHJQMzrtaMrmjPgP8x24FNZiBnNcQ541mMa5jMsra6lPMMddnPgNoLVUI32aL/P
	LCDUqWVM59ME8NesuilI9KTegF8eU2EwEHNw3r+SDq0QmqmX/G1ISAK+Oq+N+OS/
	TQmmYg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp76grve5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:24:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca154e2b5so5154146d6.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776781448; x=1777386248; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61L2ICsEUf0Di4YW/bbJVwneFaoftw7+9hq+b7ipqCk=;
        b=iLZRrsyAUSX7cvyVZytCcjOi7dZICqa5T/jAzN2mCJSdbxPilu7rCmed46rDfUAyUW
         epURiVKcARcCx6fUhiTTQYYdObwtohusQ/zHscJJ9H9ch38pGPf925KgTmmaywDJ/2Fq
         ZpPT+WqR20FXAvYZ987wH60CWo7sTooriuJTlCGZ1SmH4CoLqypjXW1FOuyxTgCYrD9c
         lQO0ThtRysPXKRR0+tkmFj0DI1F4REnltCb+B9ocXTBHacEQbxCNbzdwmyqpXlTMII1H
         +KYTPGbJup5ImvyuDL7tS2tGRfSPLHy118f/BnpFAD+JMqe5Jv5/EMads4oSaA8DpKWS
         0bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781448; x=1777386248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61L2ICsEUf0Di4YW/bbJVwneFaoftw7+9hq+b7ipqCk=;
        b=PehDBmX/8fUCJL8zeYGf7d3izBnTJui4MiEiwBsDbcd1fR8oYkj+2mTufvEJ3tYe+d
         wIEgFnCILp4nP4Yz1x3fceG0zP7acq0sRDLRC/NvvLmd8kKZw4ruBr2lD09cV96q+efr
         XjVH67/JFzvJtD4DfGgiT6fEBIpwWzS92tGnMy4FUG8T78A0euEgJElDxYtK75rhF303
         Tfhldrw/5eiwFe+iExXTIs2xu4hnY9iqGViMgnzbhsAQNdH/69H+bO+/Pp3St2TiwupV
         sDgnUWaIU0fS7Vlf7rtXSWHARMc2VPs4JEmqXzbO2o9gnv7bFWGQYZcVmjP8OGhmvksn
         rwDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H8akOGyh1V5nqiY1VGCHgia0d6pmo3kaz4D1YotxGqugiUSFYajBW2aqb+8IPq7QMO3P3xI/yCIrrc3ckkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvPsWRKV0vMfv8pkp3ghejeqdCjb5T2YQIxU0Px4VNRNUzUD0M
	DnjPUqGOh6HwblcvWswe+Bipl4hA6wo/ZhwEdQKtDQbd9ATOruuE02FmkEPTYsGWmAJPWXZi2qc
	AyQNl1Axqx0KNSrRVePxMzBjlreF7V/Gxu18SGfMZj9wXYYeOqLPQm7z4LDuE6kgLwOvnpA==
X-Gm-Gg: AeBDieuN3weZ7ui3RQ4nUc2F7kx7BtfVdO3qSzzlYEysmVDcdzDcD+92+5Fnh5IP7/p
	Ue7iqtNBex/YVFr1J8ACV2TgFS89IXulSeJuJ7aDBTuoVyZXT7br5vSYFNsEPludpPO1wXeSFMZ
	q4u2e0o8EkW6pSG4kMGQjAW30WtBBSmT6jEQc72p3/j+dYEmf/OJo6Cxdd47tvb6ocR4Ij+pRYm
	QDkM80qwC08aQZDwnY1OQMNKIijji4bCNulwxAuSaUiYz77jMf0brQHN9PKOpdc7+EcPlg3FzIh
	ctJ6D+IK0jvGPoP6Pr1EK9vW8sHFrulzP+EjRGOVY+492A8mlz6fi6kpQuxAu8Jo4aJ6RKoiMxg
	60AFMqhrGAQxS4P0P3rzePtOyyhHvFfbxcNiCBIPgRAoKm3cqM3hoF++c
X-Received: by 2002:a05:622a:11ca:b0:50d:a8f5:1bef with SMTP id d75a77b69052e-50e36ec1d54mr263474531cf.46.1776781448342;
        Tue, 21 Apr 2026 07:24:08 -0700 (PDT)
X-Received: by 2002:a05:622a:11ca:b0:50d:a8f5:1bef with SMTP id d75a77b69052e-50e36ec1d54mr263474131cf.46.1776781447775;
        Tue, 21 Apr 2026 07:24:07 -0700 (PDT)
Received: from [10.238.138.234] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3fbc6513sm99310751cf.2.2026.04.21.07.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:24:07 -0700 (PDT)
Message-ID: <2cbef155-2a84-4151-8081-b33c79ffae68@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 22:23:59 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_console: add timeout to __send_to_port() spin loop
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com>
 <37b513d6-770b-4442-b3b3-93b2801f3c71@app.fastmail.com>
 <d6908885-7f87-442c-86de-3a08eadf417f@oss.qualcomm.com>
 <9e5be98b-3035-4e61-8325-52ed8fcf65fa@app.fastmail.com>
From: Peng Yang <peng.yang@oss.qualcomm.com>
In-Reply-To: <9e5be98b-3035-4e61-8325-52ed8fcf65fa@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MyBTYWx0ZWRfX1rAus03JkQf8
 4/7lgh15Z8sed6RUm121cX0q8cEDhZEJfwdM91SfH94aVPAE6JIoe1hSsE3ZqDYOG2rp8dqBGlc
 Qz3kgO6fHGHIKDyVsjua7GXhjleCBPammqS7NNsWPn8A/cS4BXsCymWlI+WL/jZ8dTgCJnWJspY
 REAoVuxef35IvO2eJPtXOq1HHqJCzu93tZ/r7KpOE3yXAT1PQqa6m8kANQUrq82OJIg8Icabrla
 lfNvfpv0dOkhXr7XwnnOak7Ip95NxU9T49db7IPuOrwMZyjbeldJ8hbAGuzC5X6o3e8p+cxglW/
 CSLWRCXYrV7gVrlmrjJxoNaBvEeooQPgIVJBfqbKA0rkgqDIWxFRFBVbR3exzmhlb5r6sL6Ibxo
 AhciNMA5HRIumKv60E5qrp3BGUSn8JRtdEfOoeejUC2+22fr7RNjHyNIxelg1Mr6P4xqJpc4Xf7
 ogSvuQfMuUBUMw86zPQ==
X-Proofpoint-GUID: B3GoBU2EJcAsGwG0TQAiu2sqx_4WsizL
X-Authority-Analysis: v=2.4 cv=crWrVV4i c=1 sm=1 tr=0 ts=69e78889 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=i56tckeGD7E5QaJy4WgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: B3GoBU2EJcAsGwG0TQAiu2sqx_4WsizL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210143



On 4/21/2026 8:14 PM, Arnd Bergmann wrote:
> On Tue, Apr 21, 2026, at 11:18, Peng Yang wrote:
>> On 4/21/2026 3:38 PM, Arnd Bergmann wrote:
>>>
>>> Which host implementation do you use? The way the virtio_console
>>> driver works really assumes that virtqueue_kick() consumes the
>>> buffer synchronously. Even though that is not how virtio is
>>> specified, this does tend to work. ;-)
>>>
>> We are using crosvm as the host VMM with its virtio-console backend,
>> running on Android. The trigger is Android host reboot/shutdown: when
>> Android initiates a reboot, the crosvm process exits and tears down
>> the virtio-console backend. At that point, the TX virtqueue is no
>> longer being drained by the host and will never be consumed again.
> 
> I see, so the normal behavior is likely just fine, but the error
> handling is what goes wrong. Maybe there is a way for the guest
> to detect the device being turn down already so it does not
> actually have to wait any more?
> 
Yes, exactly. Normal operation is fine; the problem is purely
in the error/teardown path.
We investigated both the virtqueue_is_broken() path and the
virtio config status register path. Neither works in our
scenario, for the reasons explained below.

>> The crash dump from the actual failure confirms the exact deadlock
>> scenario:
>>
>> Core 3 holds outvq_lock and spins forever in virtqueue_get_buf waiting
>> for the host to consume the buffer:
>>
>> virtqueue_get_buf
>> __send_to_port
>> put_chars
>> hvc_push
>> hvc_write
>> n_tty_write
>>   <- writev() syscall
> 
> This current loop here is
> 
>         while (!virtqueue_get_buf(out_vq, &len)
>                 && !virtqueue_is_broken(out_vq))
>                 cpu_relax();
> 
> which looks like the virtqueue_is_broken() check is meant to
> catch this exact case. Do you know why this does not break
> out of the loop after crosvm tears down the virtio-console
> device?
> 
virtqueue_is_broken() only reads the guest-side vq->broken
flag, which is set either by virtio_break_device() or by a
failed virtqueue_notify() kick. Neither happens here:

- When the host VMM exits, it does so as a pure userspace
  process termination. No PCI interrupt or notification is
  sent to the guest, so virtio_break_device() is never
  called from the guest side.
- __send_to_port() runs with IRQs disabled and outvq_lock
  held. Even if the host were to send a config change
  interrupt, it cannot be delivered in this context, so the
  async chain virtio_config_changed() -> config_intr()
  -> virtio_break_device() is completely blocked.

As a result, vq->broken remains false forever and the loop
never exits.

>> Core 0 has a watchdog bark ISR fire and attempts printk, holds the
>> console lock, but spins on _raw_spin_lock_irqsave waiting to acquire
>> outvq_lock:
>>
>> queued_spin_lock_slowpath
>> _raw_spin_lock_irqsave
>> __send_to_port
>> put_chars
>> hvc_console_print
>> console_flush_all
>> console_unlock
>> vprintk_emit
>>   <- printk (watchdog bark handler)
> 
> My first thought here was that __send_to_port() should perhaps
> release the lock during the while() loop, which should avoid
> blocking the other threads on the spin_lock_irqsave() but
> would not avoid blocking on the loop.
> 
Releasing the lock during the spin would unblock other CPUs
waiting on outvq_lock (e.g. the watchdog bark handler trying
to printk). However it does not fix the root issue — the CPU
holding the lock would still spin forever. It also introduces
a TOCTOU race: another thread could modify the port or queue
state between the unlock and re-lock. The timeout avoids both
problems by bounding the spin duration without releasing the
lock.

>> The 200 ms timeout is intended as a minimal, targeted workaround to prevent
>> the watchdog bite in our specific scenario. We are open to suggestions on a
>> better long-term approach.
> 
> Not sure how to do it, but I think finding a way to call
> virtio_break_device() at the point the host device goes away is
> the best solution here. Ideally there would just be a notification
> from the host, but since __send_to_port() may be called with
> interrupts disabled and may be running on the only CPU, that
> would still be unreliable.
> 
> Maybe there is a way for virtio_console to read a status
> register in the virtio config that tells it whether the
> host has turned it off? I was thinking vdev->config->get_status(vdev)
> but that seems to only get updated by the guest.
> 
>       Arnd

We checked this. In our host VMM implementation,
VIRTIO_CONFIG_S_NEEDS_RESET is never set on the teardown
path — the device simply stops responding without updating
any status register. So polling vp_modern_get_status()
inside the spin loop would not help here.

We agree that the ideal long-term fix is for the host to
trigger virtio_break_device() via a clean PCI hot-unplug
sequence, but that is not possible in a crash or forced
reboot scenario.

The 200ms value is chosen to be well above normal host
response time (microseconds) to avoid false positives, while
remaining well below the watchdog bark-to-bite window
(3 seconds) to ensure all CPUs can exit the loop and complete
the bark handler before a bite occurs.
