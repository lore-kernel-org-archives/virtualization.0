Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F339D6EC
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780702; cv=none; b=EtWewlKzF7ioy+Ps+xYuY/j/gNVjsAZmasLozRxNnUqNWRf/iycgHig2oh7pKLObLhkafCO+9WUHRUzmTZR7k0nnr/Luv/JEuZSKcjuHUBf12XRXccgNJEyHoc6Ix1KtwHwA84f9yZEXQi4HwqoERrVY/lsMQ3Yr2tuMxXxj3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780702; c=relaxed/simple;
	bh=XT8yfTFbS399P/bczJuLfIr9YjZccWUmzpfF5mpxA3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXqZg+dTLZnRm11RS6+fbx5zGXXXhpbWtKoSBxvvcZ4SSLOpFxvDRtPon/YsLG1ij/ZbHlswHbJ2j+KbBNZV4mo5k6P+HXCgq9etB7dcFFJ6QsH5Yib7+XYJ7XqNwNB1UU12ViH/a76jhyMPHrYM2GoON/HVBDb+u0EE6edivBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9C1XN6/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNGqfIlN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9C1XN6/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNGqfIlN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBbBn21011934
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMdOsIeK5M2JLQ5enQsUgM+cE8gxR0RsxwL5DeBdtDs=; b=C9C1XN6/hwj4hD84
	+s2KccwH+CmktlXnRXaMdUnDjbZ3k5c/Mu9ksI7CZX7qotDHhr1AyY01xBc8bK4j
	8LPVNzRR+OMIeyDv7JW42iHoXFqAhqH2VFXCpTSjeCMlKCKul8+eRQ1cw1RQgT8W
	VOGEUe77bB4uj8ihwMom8PYF8DBENGz6un+9RvaKCpS189Y8PAR/AxBmqoFTRUMf
	khRd+e9qxyAxQhCldfvw52gvt+2JPQBch8PWq65rEzZPG3l4W1DdBXjkOb57c5Jx
	8hPQ+Nx2gRORep1/LUrRoP4JJ7rFhDExD1f8AjL7MPkQbSIH/uTTrjKzHPmMZmfv
	5kAeng==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt903g91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:11:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7977177675so2050051a12.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776780700; x=1777385500; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMdOsIeK5M2JLQ5enQsUgM+cE8gxR0RsxwL5DeBdtDs=;
        b=gNGqfIlNe8ikRRoG0QmuTftvcQcRU+KUYki6HfUsQuJcMwDCHE8+OB0x355FfFsqpK
         jUzyxjhsJKa+hXAoYFqcdwSRxh/99cEncJ03zDLdqWaC7HM+KgP+G/PLu7sDGFgqhyGV
         zLi+mDe4PT4r5CiB4MDciqq8finiBG8KX5q8lCccej/pZ6kcl2Svt8rXW5SbknmhdVnF
         naf/2520n/+oU3zHH1ONpvdujmJPqhqdDi8LQs8L7/50nRUBsJmqp8Jq4Avf1FiBnFHg
         6ZUKWuBjkedC27oLoJmtohxpaYZ7CMCzNauH0UyGiQjsDCayg28R1XbX1hZPsfmO5HaE
         0J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780700; x=1777385500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMdOsIeK5M2JLQ5enQsUgM+cE8gxR0RsxwL5DeBdtDs=;
        b=bHdNIr6ZeW6JwNvOxTaV4LrioqWuCg07yUJNDKBUdi94VpFAs+iPI1fRZkKIy2/W+s
         gNl+962e4OVdo5UQI/P2QvNzhrNYCpOkhffP6Y2OAkVPQQDRD8YMrkI1QQCNXK3xJyn0
         OQ5gnHlVxRTjlKs7d2DDFFqtEv7KPF0rB5Aq4RwapqzQcxa3Lz+DecjWrfnXOqS6mT/A
         u2D75uLwaA5WgKUmSHDwrwXlCmI8EmIBK2wFP3AGA66EWmbzmVf0ddPaA/oZPjI1yc6h
         iX1ukN8ESskeawQAjM5JYosjKUc0O+ukm0a7XisAhHkSqK1opojzwZvViBP8gHVAwfBl
         o2Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/I7mi6THTu/VE3W46JuHUu7HzzFla/ghTcM1M1Mfwclrzw81FoHVypwoJeoeKVLWFgKhqADBSelZIynkK2yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydYFAyd7f406elgZeZpjfzNm+tTlbhaMqCUe4JX4MlSH7hc/qD
	vUKBfoUkV0kOqCpy6HAMVdCbnR/dk4Gb+WEvcmj7LTx6V+VBTUHAemsOV4gqo/ku14tsr/v9xH1
	zO3yTjVm3tCEt168k3d92fbc3ePD9WvfVLdPcGfrRhe1yWBNLNd12BwLyRWm26LwrAeG5WA==
X-Gm-Gg: AeBDiev69yh1mwab2qdm/zgcE1hpPug37X8YF3zq3F5Qjqk6wgz8+3rE4qLWjWTT++x
	rYVwrtN0V2Q4dw1D1qvX22G0YrpiNYkbhgs1GwAy9QJBd1I9Imub2RGkEcKyqX31y5woY2eCib+
	viUaV5DHfuoqbdO9d8oM2SOfgo8mxMBN2a1+pj0V6MH+ZZ0/Wk1NEkaTC6MeOgjcTt5JNIC8JCn
	cSU49dk49RH1lme3SbMcnn1+huyTuIz6Dwkn1Segy0IbR7mHnjzxq9mf+r6UcRH0gk1OQ5QSv+k
	xgsphwq2YLr5+D4j27Cjqp8BxtnLgmHc4i0iDz0ezTgcdZf3aju6wm9YutkHDMMbLUEd5rsO+wq
	JUrdaaqSWCgJS3sKendYgUYpfrLU3OA+/21cbe5lAO/Fq8voAtC7+8JTG
X-Received: by 2002:a05:6a00:a248:b0:82f:316:3208 with SMTP id d2e1a72fcca58-82f8c8fb879mr17264451b3a.29.1776780699661;
        Tue, 21 Apr 2026 07:11:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:a248:b0:82f:316:3208 with SMTP id d2e1a72fcca58-82f8c8fb879mr17264410b3a.29.1776780699089;
        Tue, 21 Apr 2026 07:11:39 -0700 (PDT)
Received: from [10.253.14.183] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981829sm17064601b3a.12.2026.04.21.07.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:11:38 -0700 (PDT)
Message-ID: <1fd9f904-19fe-4602-904e-6a30fba20061@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 22:11:34 +0800
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
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e7859c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=i56tckeGD7E5QaJy4WgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: AdPErMvhipBvmwNWbZr0xu6nDSot6JrX
X-Proofpoint-GUID: AdPErMvhipBvmwNWbZr0xu6nDSot6JrX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MiBTYWx0ZWRfXx7WJqyvRhbgr
 I50PF3unKC0wXAV9aiNLzxuG6KXnUvDTVaaqjLmPGgmWgzZZMrhRUnIGG59j+14jtLcRPNHfvvt
 ILbWFee+HgpxXCVaJOhs9TbVctCcqPKBqyoXQZD9iHvUA571l7W8TAquOQ04LwbhWJsBORKe6TW
 Jzud4TflaphAByv0X7vwlB6O/PNXkIj5oTFUI4phMT1qkAHEfBVNE/TLKkNSuTJrzv/JN6vhAp+
 iEarfeKNei40CQCLUyTyBhUAQBJnNKq/3xv0v3qVOGWMGkuCq74zuA7yFfVQPFHTK1mLz1jU6N8
 QNo/vTdwCqKuGRQV8g4LtB1kUFAydQMQcGfBs+AuKvEE/cEeWgFfoqlta2r+Nt7gRZM0NM1vKg4
 qShhO0g7WwTh92bcTmf2zM3TMmIo7zPgBf5yfb5iWK6yDMG2lsFd2PYLYC8gsGV6pjpoRv80L5U
 /PUWqavw+Ie/T6Vmtbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210142



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
Yes, exactly. Normal operation is fine; the problem is purely in the
error/teardown path.
We investigated both the virtqueue_is_broken() path and the virtio config
status register path. Neither works in our scenario, for the reasons
explained below.

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
virtqueue_is_broken() only reads the guest-side vq->broken flag, which is
set either by virtio_break_device() or by a failed virtqueue_notify() kick.
Neither happens here:
- When the host VMM exits, it does so as a pure userspace process termination.
No PCI interrupt or notification is sent to the guest, so
virtio_break_device() is never called from the guest side.
- __send_to_port() runs with IRQs disabled and outvq_lock held. Even if the
host were to send a config change interrupt, it cannot be delivered in this
context, so the async chain virtio_config_changed() → config_intr()
→ virtio_break_device() is completely blocked.

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
Releasing the lock during the spin would unblock other CPUs waiting on outvq_lock
(e.g. the watchdog bark handler trying to printk). However it does not fix the
root issue — the CPU holding the lock would still spin forever. It also introduces
a TOCTOU race: another thread could modify the port or queue state between the
unlock and re-lock. The timeout avoids both problems by bounding the spin duration
without releasing the lock.

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

We checked this. In our host VMM implementation, VIRTIO_CONFIG_S_NEEDS_RESET is
never set on the teardown path — the device simply stops responding without
updating any status register. So polling vp_modern_get_status() inside the spin
loop would not help here.
We agree that the ideal long-term fix is for the host to trigger virtio_break_device()
via a clean PCI hot-unplug sequence, but that is not possible in a crash or forced
reboot scenario.
The 200ms value is chosen to be well above normal host response time (microseconds)
to avoid false positives, while remaining well below the watchdog bark-to-bite window
(3 seconds) to ensure all CPUs can exit the loop and complete the bark handler before
a bite occurs.

