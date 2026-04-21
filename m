Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3B3859F3
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763165; cv=none; b=g7ZOYN0oinm8cqVA5dTL5cz3+SClIiksy+CBqF8P9AHizdL0K8Ua6aLSANIAv6gpcFBtiXq/OGBdn8X39M1z55F0srFeeh9WY8JxN0PiWd4UN9dVRPfJbZNEykLMosVeaRxV5yq0QGzGTCt/qaYCYzwSy8Zi7V8qEoUDPpcpIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763165; c=relaxed/simple;
	bh=vA8dG9GlY96VNHOZhGCF9p2/cBCk0zZRcFSc89U9vNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0JSaKJbRfLg7B6l4BgupAJ8KGdCZME5W5Rb7wgvVGV+tU6p3ao5l+grQ373XryVHN5E6cWzX45iQOrWtfAcCPsO4URxstks184F0l+k9c5oyH0rzb3q4PYJWFau/3J6sMczlmrUKDwhK0N/m6juCFYqEXXS+Kn/uoCPXmH/m3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+zdq84W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTfsutzl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+zdq84W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTfsutzl"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L5MeLR1015347
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 09:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HcbE2WqfgUl698UND0roUyAgaaJ3j0TBz8C3IFVjikA=; b=J+zdq84WcK4QhWLj
	hjfKtDhLZ0v41QRPzMExRW01Y2zQfug8MnfnBTUXdkfvCSGn4mXoj92tPhkCZZ1j
	WRsGH3Vw3NECXgkyQfHMWyVOkzLfCmDbw+iwo0EglZTUn6iVsqNmwxZOElgUeiw/
	hhIeQCAPwHhyU4h51KyIKq/agVW0Ed8NnDV49o8ISmAytSt0TExCF3HYcL5haiKX
	0KHILJCrlZANdWwB2m3xOsrRkSudKXn/CJ/OjBUh86jLK+gbUwtvGq2TrMD+/vRO
	+GYzM0EOkc9XnJ3O0RnGKVKvDLt1ALPbxU2TOVk22K7EJAmeY5BRADVr96T6Ix2M
	CMpjdw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt902g2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 09:19:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso9819262a91.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776763163; x=1777367963; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcbE2WqfgUl698UND0roUyAgaaJ3j0TBz8C3IFVjikA=;
        b=bTfsutzlY9kpzey/doEvXNbRKCHSPv/AVqA224jJHioaGuBlrRo9GWTg56tqi32rfM
         ivTtJz8LhD/TzZk14ptRj0tmkUB9isz0wbCehAb6s+h/0CJfBqPv4DdrKJ9OaqYtAFMZ
         Hee5i+1J1ShOoNQtrFfVB58DKmAmSs5ht5e4DTulKZtwGgzb79kpMs5J/Hyvz87jw9SR
         KMMBoamXK/XnTJSN8btUx73BT0t1DtbnEIzOdzhPKlckF20jBBJBY676pn8DqflMmzWR
         QQsFccpXw8BTNjib5PQpMH58PBXLJ59axRehWwKrDDmWpIX2P1vMuu06qFw4U7rAVvnx
         Y1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763163; x=1777367963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcbE2WqfgUl698UND0roUyAgaaJ3j0TBz8C3IFVjikA=;
        b=neBfIeFYtLycDDHfaIXRomhbvURwGZCKsGOAjTEpZD8H5wgmsn6z8VBu3ICa116h0K
         z2GjkOxJCnmFYEkUofr7fJ/kfVkRCY7Z0fItYGdKRIxzU+Oxcs8buh57SPpgBmPVK3uQ
         N/hGYbL4e014wKrLPBmyJa526jSZwJcN+XVrq2r/LYkcTmsH+BhkRMm92pz4fE1AlM/t
         TfF+41Oma3tgvbsNwX7d72QUUnrhIvNcSI3A3YL+nkIOkm+58lzInOqUgYJ6h5yC1F+/
         HMhAA/6HEbRnvBXd+RhMJAKNpe6bST+cv+u2CVgM9Ua/jG/4/ju5Eayfpee+gE5+1geW
         r3Yw==
X-Forwarded-Encrypted: i=1; AFNElJ81218Ig6uLkHROgJrbNfTblydrT5EDD6pjT3340Lxj1/A6/7FUS5IQOjQRJlkxepzp/yx7EgZpyQSQM0R/OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVvqpsBceWUaMA0XlPku1NGOo1fT8/mC4oJ8AwxxrrXO5xdapM
	2lru5YlRC1mJZepNNqe4EzW93drY81zrh4gnJwcq5l2fq+ffVar0fo98XKLrkvwAn/fNwyZSORs
	BTgwHI4YVb98TLPuLtKIcrslXm6TEYGADZZ8lzFnP9yons+Wu6q7xtLVWm3zehpHkanPkSA==
X-Gm-Gg: AeBDietbTca5jYqDWClVcG9OZUrwXuDX5f+Y5A094XSJX0qqizbFnG6q4gd+eAF3POv
	v2pXY2I0yTeVLcxxxC4vHFbGsHXZOjDyhRnKrUj1PneFZXkW33nENVgRwEpQUlUBbnjxi1J+mmo
	4k8yMInmSv/cll7FEN3vp0JRq1yXbZWYhEsK60cJqy75XPk2ja63A8rbA1WOhe2zTP2OHysh+iC
	RFUZGglJDD5A5bpzELi7XOZHRRDusL3hkkcYrSOxpRZz9xZeUfM4d0UqwbHyWvGcl0beE6TfF7G
	QiFhpapcgibmvidXrDewKYKXzkTsugkxfLScGoiUVeS+uNYFwgEgFCEGkFiqdlzYMj48b26j106
	bbiVVqFShxYeYntIKsqgOPPoYwTqenf4VTe/Hbaofk1hYz518p3GKYoJi
X-Received: by 2002:a17:90b:5203:b0:35f:b9ea:8f9f with SMTP id 98e67ed59e1d1-36140464842mr15574566a91.16.1776763162667;
        Tue, 21 Apr 2026 02:19:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5203:b0:35f:b9ea:8f9f with SMTP id 98e67ed59e1d1-36140464842mr15574527a91.16.1776763162107;
        Tue, 21 Apr 2026 02:19:22 -0700 (PDT)
Received: from [10.253.14.183] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140ff148dsm12809307a91.7.2026.04.21.02.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:19:21 -0700 (PDT)
Message-ID: <d6908885-7f87-442c-86de-3a08eadf417f@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 17:18:59 +0800
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
From: Peng Yang <peng.yang@oss.qualcomm.com>
In-Reply-To: <37b513d6-770b-4442-b3b3-93b2801f3c71@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e7411b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=TpNw2uGOYBV3wa7vfS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ejHGDKLwxwpSG0lHGICSy_rnXfC7oKd_
X-Proofpoint-GUID: ejHGDKLwxwpSG0lHGICSy_rnXfC7oKd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA5MCBTYWx0ZWRfX2Fr+0lQEjmDP
 jlDe60Z0vb8Np042X8Kf8GQ6lblqeYk6F4b37PEsUnQy71C8CFJCufr6gYgHRpQYvnIcRHUfKLz
 9R3bzzBsjmhYU2M9efLynknasRAqwHn5WRqUCICXywiWqtNrm0SbdfKeqSS4Qq2HnSKXF9C3SED
 yLyFL5lJ9MEb7hkqcQRtfD3CTc6ZNOsw5mKIR1ThysS7A9ixrIXuxvjqRoM/CcehNTCDrKtCBB1
 /20Kekqt5GyOngJFPe6Ff6ImgJXVhZmiFcKkEaDrLxkm/OOuI+cWfwQlBcAExvwQ/4p0QylIsoW
 82QPf8Qk38J018A+53/Q/PM8C8XahZaYIeWMx42Xv1yApkKkfZS51yT3xOk/w50/g+x4pUd/ykh
 VszJsXqNMkQnOwnLwbaKkZqG22MotlAGlxq+8dX9h2m+LrwjIuSQJik6G2061VC6fIWjxJBoI7C
 5QAhBnRzvwx2+6l7nvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210090



On 4/21/2026 3:38 PM, Arnd Bergmann wrote:
> On Tue, Apr 21, 2026, at 08:57, Peng Yang wrote:
>> __send_to_port() busy-waits in virtqueue_get_buf() while holding
>> outvq_lock with IRQs disabled. If the host stops draining the TX
>> virtqueue, this loop never terminates.
>>
>> This was observed during secondary VM boot: virtio_mem plugged memory
>> in multiple iterations, each emitting dev_info() messages through the
>> hvc console. A writev() on the hvc TTY entered __send_to_port() and
>> stalled in the spin loop. When the watchdog bark ISR fired on another
>> CPU, it attempted printk(), which tried to acquire outvq_lock through
>> the same path and spun indefinitely. With all CPUs stuck, the watchdog
>> could not be serviced and triggered a bite.
>>
>> Add a 200 ms deadline using ktime_get_mono_fast_ns() to bound the spin
>> loop. ktime_get_mono_fast_ns() reads the hardware counter directly and
>> is safe to call with IRQs disabled and spinlocks held.
>>
>> The 200 ms value is chosen to be far above normal host response latency
>> (microseconds) to avoid spurious exits, yet well below the watchdog
>> bark-to-bite window (typically 3 s) so that CPUs can escape the loop
>> and complete the bark handler before a bite occurs.
> 
> Which host implementation do you use? The way the virtio_console
> driver works really assumes that virtqueue_kick() consumes the
> buffer synchronously. Even though that is not how virtio is
> specified, this does tend to work. ;-)
> 
We are using crosvm as the host VMM with its virtio-console backend,
running on Android. The trigger is Android host reboot/shutdown: when
Android initiates a reboot, the crosvm process exits and tears down
the virtio-console backend. At that point, the TX virtqueue is no
longer being drained by the host and will never be consumed again.

The crash dump from the actual failure confirms the exact deadlock
scenario:

Core 3 holds outvq_lock and spins forever in virtqueue_get_buf waiting
for the host to consume the buffer:

virtqueue_get_buf
__send_to_port
put_chars
hvc_push
hvc_write
n_tty_write
  <- writev() syscall

Core 0 has a watchdog bark ISR fire and attempts printk, holds the
console lock, but spins on _raw_spin_lock_irqsave waiting to acquire
outvq_lock:

queued_spin_lock_slowpath
_raw_spin_lock_irqsave
__send_to_port
put_chars
hvc_console_print
console_flush_all
console_unlock
vprintk_emit
  <- printk (watchdog bark handler)

Core 1 has a virtio_mem worker calling _dev_info, spinning inside
vprintk_emit waiting to acquire the console lock which is held by Core
0:

vprintk_emit       <- spinning for console lock
dev_vprintk_emit
dev_printk_emit
__dev_printk
_dev_info
  <- virtio_mem worker

Core 2 (khvcd kernel thread) is also blocked in __hvc_poll trying to
acquire outvq_lock:

queued_spin_lock_slowpath
_raw_spin_lock_irqsave
__hvc_poll
khvcd

With all CPUs stuck, the watchdog cannot be serviced and a bite occurs
before the graceful shutdown can complete.

The 200 ms timeout is intended as a bounded escape from this "backend
already gone" scenario. It is well above normal crosvm response latency
(microseconds) to avoid false exits under normal operation, and well
below the watchdog bark-to-bite window so that CPUs can escape the loop
and allow the graceful shutdown to proceed.
>> @@ -632,10 +634,18 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
>>  	 * buffer and relax the spinning requirement.  The downside is
>> 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
>> 	 * console driver writes something out.
>> +	 *
>> +	 * To avoid spinning forever if the host stops processing the
>> +	 * TX virtqueue (e.g. during VM shutdown), a 200ms deadline is
>> +	 * used to break out of the loop as a fallback.
>  	 */
> 
> Did you by any chance mean to use microseconds instead of milliseconds?
> Waiting this long with interrupts disabled likely breaks a lot
> of assumptions, e.g. in the scheduler. If you have to deal with
> a hypervisor that does not handle the console output synchronously,
> the alternative suggested in the existing comment would likely
> be more appropriate.
> 
>       Arnd

The unit is intentionally milliseconds, not microseconds. The timeout
only triggers in the abnormal case where crosvm has already exited —
under normal operation crosvm drains the TX virtqueue in microseconds
and the loop exits immediately. The 200 ms value is chosen to be well
below the watchdog bark-to-bite window (typically a few seconds) so
that CPUs can escape the spin loop and allow the watchdog bark handler
to complete before a bite occurs.

You are right that holding IRQs disabled for up to 200 ms is far from
ideal and breaks scheduler assumptions. We considered the alternative
suggested in the existing comment — copying data to a GFP_ATOMIC buffer
to avoid the spin entirely — but that approach has a fundamental limitation
in our case: the spin loop is not just in __send_to_port called from the hvc
TTY path, but also in send_control_msg, and more critically, the deadlock
occurs because printk itself ends up calling put_chars → __send_to_port
while holding the console lock with IRQs disabled. Refactoring to eliminate
the spin loop entirely would require a more invasive rework of the console
write path, which is beyond the scope of this fix.

The 200 ms timeout is intended as a minimal, targeted workaround to prevent
the watchdog bite in our specific scenario. We are open to suggestions on a
better long-term approach.
