Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB0293B47
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421650; cv=none; b=uddb1h8yWC/XH8+xMJfMzHowpxnqKiQ6niwqDgqGW7KnNQ0/no0GOycNTULCSQ/JoQAYxRz8KL49lmW3OOKU87yjPPxKBL1ToD9MjtuwgEkIVEYQz75OcWKN2VXhG7lBmmj98TfnLJJPYIRmBTwcs2FKzSbybTJ0PBvGYl3vrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421650; c=relaxed/simple;
	bh=VDfwmOCVRoGoEsvlBNbRNn+5O+sBsS7veCm7PZofIIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE9RVlDN76mAI/EAzpwUtcWLkDC9Hi/1eI1zTUOeDFN4qwRk47vhEduTjagfH0hIztpzqNtTYlr5YQalJritQSqFukCQNYlfxoREwT3DdIMJBelb8OGDLIz6+m616IMDbu/+OL0u5LE3W3mi8biJExQ4CmHY3ItZiMnsL1ITOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBFW1VbM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBFW1VbM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376e311086so9336766b3a.3
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745421648; x=1746026448; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay1hJ+xxSveKW4SXff1bMvJ/IKV12NveP9f4RrvhN6c=;
        b=BBFW1VbM7npxRU9xar2T+bfyLfRrLeJJR986Z+246lbuLj6NCvihiEGlm+waDapmwL
         qPiGp+EIgFqcdojBpSIkKAt1GA/y0u2NcncRfsvbfDsuHvzY6Tpmi+dthfIIdJirhP/I
         VQ7Rt2dRg/us8KkPM1YFBs/0rrvQLp2F0XbVDIp1LJyfAhHg0FH7j/7SRgjlCtpMDmNH
         QMTQDtxNI39XzWupi1EFf4UaDXEIbsVZdVkK1ZbfaYcFZu6VkzXgSFRqwLwABj7JLBba
         wokI1Z0bI5EW3y3s3YdDqHPzXGg2yvAp93jw2dnGm3IB4GrZUCOot6j9QP+NEkzTjJqz
         cs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745421648; x=1746026448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay1hJ+xxSveKW4SXff1bMvJ/IKV12NveP9f4RrvhN6c=;
        b=P8jVbQ4VxBC6mH8l+GFiYbS1jbJmtMVsR0kzPdM/Gft9b2K1PCMgcL3HWCevDHVf/9
         45z8X3LKDKcSObNCyzhSMtsrBSYpdcmbpBi6HZIViO9R9D1CrLv1bcpHGd3+LGr+y/S0
         k5v3o41R0mgCNUp8rePswH6dqvl8PhWoRjmDVro86VQUoNw/LzkQXd5RXGLM2yq/NM1d
         YCMOPpyTHyPdZtfdFJdR8FKZVVdNHH2YxKFCEjgCtouIdtAkFCACemshvQBEVGOX1V8s
         z4IE1MZoYn1UjBAOZD2fbDAe14lmE+rY3M1OhN5/os3IrLeo/qR49+a0AfK2n3UHOsZh
         f6fA==
X-Gm-Message-State: AOJu0YyceGlQaSt2auWXP68NLLTFpMgWLZfBZSalMWn+awofVAvOcTR+
	qHFX3mjull7SzjU9A+itHDRqfvnk21Oaq/iavFI49NvEbI19bzJa
X-Gm-Gg: ASbGncslnqVkkqlay2O4qHC5q7y9qI+LWyox2a/nxMwUd4svPIOgwAjWdzYTI+Ae6I/
	cGSR3Pevy7S0hM6BdULxmXTOdMJCiPSkXucc/BTJNinELfViECf62AXO4TwIzYk2u+08DnyhNAi
	hQl2Efkpq0NfNseLXbOmgLvA0mxSP3R7k3HEGpCbmgt1TR9k4deyhTKgCe6gwlQiy5WcSTsNRzg
	qsq59WdMtdf8rdJKJplPE1wl+xFRSYo/2Le1VyVTOwBTIio6zDVwiiH0KdLcNQK2PkkXirm1Vjo
	7WNWJ3uVOw/zVMkZL/dXLbPinfoJXe2ah9CXI554OASixkWJLKlf6fKHJaBxHgB+oMwVWOlItO7
	xW8v2UWl6V/t0ww==
X-Google-Smtp-Source: AGHT+IF0njUnwLJs73OxHmEO22W7D/ZiIYfKXmFPNk7S0195rDOuNRKX5c2xxOZE+G0FANmjiFezMw==
X-Received: by 2002:a05:6a21:3a8d:b0:1f5:8cc8:9cc5 with SMTP id adf61e73a8af0-203cbd27edemr35835560637.34.1745421648443;
        Wed, 23 Apr 2025 08:20:48 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9? ([2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a3396sm9277066a12.28.2025.04.23.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 08:20:47 -0700 (PDT)
Message-ID: <aac402b4-d04c-4d7e-91c8-ab6c20c9a74d@gmail.com>
Date: Wed, 23 Apr 2025 22:20:41 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
 <20250417072806.18660-5-minhquangbui99@gmail.com>
 <20250422184151.2fb4fffe@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250422184151.2fb4fffe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/23/25 08:41, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 14:28:06 +0700 Bui Quang Minh wrote:
>> The selftest reproduces the deadlock scenario when binding/unbinding XDP
>> program, XDP socket, rx ring resize on virtio_net interface.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   .../testing/selftests/drivers/net/hw/Makefile |  1 +
>>   .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>   create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
>> index 07cddb19ba35..b5af7c1412bf 100644
>> --- a/tools/testing/selftests/drivers/net/hw/Makefile
>> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
>> @@ -21,6 +21,7 @@ TEST_PROGS = \
>>   	rss_ctx.py \
>>   	rss_input_xfrm.py \
>>   	tso.py \
>> +	virtio_net.py \
> Maybe xsk_reconfig.py ? Other drivers will benefit from this test, too,
> and that's a more descriptive name.
>
>>   	#
>>   
>>   TEST_FILES := \
>> diff --git a/tools/testing/selftests/drivers/net/hw/virtio_net.py b/tools/testing/selftests/drivers/net/hw/virtio_net.py
>> new file mode 100755
>> index 000000000000..7cad7ab98635
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/hw/virtio_net.py
>> @@ -0,0 +1,65 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# This is intended to be run on a virtio-net guest interface.
>> +# The test binds the XDP socket to the interface without setting
>> +# the fill ring to trigger delayed refill_work. This helps to
>> +# make it easier to reproduce the deadlock when XDP program,
>> +# XDP socket bind/unbind, rx ring resize race with refill_work on
>> +# the buggy kernel.
>> +#
>> +# The Qemu command to setup virtio-net
>> +# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
>> +# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
>> +
>> +from lib.py import ksft_exit, ksft_run
>> +from lib.py import KsftSkipEx, KsftFailEx
>> +from lib.py import NetDrvEnv
>> +from lib.py import bkg, ip, cmd, ethtool
>> +import re
>> +
>> +def _get_rx_ring_entries(cfg):
>> +    output = ethtool(f"-g {cfg.ifname}").stdout
>> +    values = re.findall(r'RX:\s+(\d+)', output)
> no need for the regexps, ethtool -g supports json formatting:
>
> 	output = ethtool(f"-g {cfg.ifname}", json=True)[0]
> 	return output["rx"]
>
> ?
>
>> +    return int(values[1])
>> +
>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>> +    # Probe for support
>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>> +    if xdp.ret == 255:
>> +        raise KsftSkipEx('AF_XDP unsupported')
>> +    elif xdp.ret > 0:
>> +        raise KsftFailEx('unable to create AF_XDP socket')
>> +
>> +    try:
>> +        xsk_bkg = bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
>> +                      '{xdp_queue_id} -z', ksft_wait=3)
> This process will time out after 3 seconds but the test really
> shouldn't leave things running after it exits. Don't worry about
> the couple of seconds of execution time. Wrap each test in
>
> 	with bkg(f"... the exec info ... "):
> 		# test code here
>
> The bkg() class has an __exit__() handle once the test finishes
> and leaves the with block it will terminate.

I've tried to make the setup_xsk into each test. However, I've an issue 
that the XDP socket destruct waits for an RCU grace period as I see this 
sock's flag SOCK_RCU_FREE is set. So if we start the next test right 
away, we can have the error when setting up XDP socket again because 
previous XDP socket has not unbound the network interface's queue yet. I 
can resolve the issue by putting the sleep(1) after closing the socket 
in xdp_helper:

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c 
b/tools/testing/selftests/net/lib/xdp_helper.c
index f21536ab95ba..e882bb22877f 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -162,5 +162,6 @@ int main(int argc, char **argv)
          */

         close(sock_fd);
+       sleep(1);
         return 0;
  }

Do you think it's enough or do you have a better suggestion here?

Thanks,
Quang Minh.

>
>> +        return xsk_bkg
>> +    except:
>> +        raise KsftSkipEx('Failed to bind XDP socket in zerocopy. ' \
>> +                         'Please consider adding iommu_platform=on ' \
>> +                         'when setting up virtio-net-pci')
>> +
>> +def check_xdp_bind(cfg):
>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>> +
>> +def check_rx_resize(cfg, queue_size = 128):
>> +    rx_ring = _get_rx_ring_entries(cfg)
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
> Why guess the ring size? What if it's already 128? I usually do:
>
> 	rx_ring = _get_rx_ring_entries(cfg)
> 	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring / 2))
> 	ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
>
> IOW flip between half or double and current.
>
>> +def main():
>> +    with NetDrvEnv(__file__, nsim_test=False) as cfg:
>> +        try:
>> +            xsk_bkg = setup_xsk(cfg)
>> +        except KsftSkipEx as e:
>> +            print(f"WARN: xsk pool is not set up, err: {e}")
>> +
>> +        ksft_run([check_xdp_bind, check_rx_resize],
>> +                 args=(cfg, ))
>> +    ksft_exit()
>> +
>> +if __name__ == "__main__":
>> +    main()

