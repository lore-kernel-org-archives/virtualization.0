Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CC4192EF
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767167; cv=none; b=UjMCq/cXO7Ym6vX1sw61Aq28Vq1jKH4yQFv16/37gRONCWl4nnIlNKfbvoKOgcShv3e0emlnRKhmQtzzsBwEJohaJ2odxLSJzujy7B01OG3z+7RcvaerTEzlaxpoS9l9LGIxgQ0LF2QxfYV56kzWcdSIvvD9v2L8c09u6vtY0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767167; c=relaxed/simple;
	bh=3OA1/xixfyppJthmSg4mc3vejG0dxTu9z8eAvuYaOA8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OzjKH7Td+FlicCvtvxmuvTN+8/UnQ0aWPFsaNQ184WX3hwJMttS4HBMVEMVP+/7wz57e+M+McZ1Q94sWQg1VHKdfpr7OHj60q1pmMcyo/0Va3Vy0CE7guG2br1v5AgK2pR64VSyH8APiTR+abiBVpsioV5E4l+B8CA442YlsnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 294c2aaaaa9011f19a56ed5b684f684d-20260907
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cfe5bff2-321e-4463-a9c9-0adf656d6a01,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0f6bccee99a48475681ad77a18a78966,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 294c2aaaaa9011f19a56ed5b684f684d-20260907
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 971881444; Mon, 07 Sep 2026 15:45:57 +0800
Message-ID: <e16178ad-85c6-42da-931f-f0b2f8240828@kylinos.cn>
Date: Mon, 7 Sep 2026 15:45:54 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: weirongguang <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v1] vsock: validate buffer min/max size in setsockopt
To: David Laight <david.laight.linux@gmail.com>,
 Rongguang Wei <clementwei90@163.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20260824091257.136269-1-clementwei90@163.com>
 <20260824131632.2d325c42@pumpkin>
Content-Language: en-US
In-Reply-To: <20260824131632.2d325c42@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/8/24 20:16, David Laight wrote:
> On Mon, 24 Aug 2026 17:12:57 +0800
> Rongguang Wei <clementwei90@163.com> wrote:
> 
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
>> do not cross-validate against each other, allowing userspace to
>> set buffer_min_size > buffer_max_size.
>> When min > max, buffer_size is silently clamped to an incorrect
>> value. For example, setting min=512KB then max=128 results in
>> buffer_size=128 despite the user requesting much larger buffers
>> via SO_VM_SOCKETS_BUFFER_SIZE.
>>
>> Reproduced with a test program:
>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
>> 	   512 * 1024, sizeof(int));
>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>> 	   128, sizeof(int));
>> // User asked for 1MB but got 128 bytes silently
>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>> 	   1024 * 1024, sizeof(int));
>>
>> After that use getsockopt to get the buffer_size = 128 and
>> buffer_min_size = 524288, buffer_max_size = 128.
>> The buffer_min_size > buffer_max_size and the kernel accepted
>> contradictory values without error.
>>
>> Add value check to fix this issue. Return -EINVAL to userspace
>> when setting MAX_SIZE to a value smaller than the current MIN_SIZE
>> or setting MIN_SIZE to a value larger than the current MAX_SIZE.
> 
> That is going to break userspace that sets the minimum before the maximum
> when the new minimum is larger than the old maximum.
> 
> David
> 
Hi, David.
Thanks for pointing out the issue.

Here is an alternative approach:
instead of returning -EINVAL, automatically adjust the other value to preserve buffer_min_size <= buffer_max_size.
The trade-off is that setting one parameter may implicitly adjust the other, but this is preferable to breaking existing applications.
Does this approach look reasonable?
---
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d381d..bd4646115af5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2050,12 +2050,18 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 
        case SO_VM_SOCKETS_BUFFER_MAX_SIZE:
                COPY_IN(val);
+               /* If the new max is less than current min, shrink min to match. */
+               if (val < vsk->buffer_min_size)
+                       vsk->buffer_min_size = val;
                vsk->buffer_max_size = val;
                vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
                break;
 
        case SO_VM_SOCKETS_BUFFER_MIN_SIZE:
                COPY_IN(val);
+               /* If the new min is greater than current max, expand max to match. */
+               if (val > vsk->buffer_max_size)
+                       vsk->buffer_max_size = val;
                vsk->buffer_min_size = val;
                vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
                break;                                                           

>>
>> Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> ---
>>  net/vmw_vsock/af_vsock.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index a33b2a2d381d..5faa30ee8745 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -2050,12 +2050,20 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>>  
>>  	case SO_VM_SOCKETS_BUFFER_MAX_SIZE:
>>  		COPY_IN(val);
>> +		if (val < vsk->buffer_min_size) {
>> +			err = -EINVAL;
>> +			goto exit;
>> +		}
>>  		vsk->buffer_max_size = val;
>>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>>  		break;
>>  
>>  	case SO_VM_SOCKETS_BUFFER_MIN_SIZE:
>>  		COPY_IN(val);
>> +		if (val > vsk->buffer_max_size) {
>> +			err = -EINVAL;
>> +			goto exit;
>> +		}
>>  		vsk->buffer_min_size = val;
>>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>>  		break;
