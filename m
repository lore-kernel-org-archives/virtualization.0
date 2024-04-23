Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C767A0D
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870195; cv=none; b=hJH+/HrVNritEh8aCSsPitYezj2BjmsXPJho74Lrrkt4qqgjP5DDoae6UXyLSEY55fLrReB8Zwjb0crQ3hGTAFjLUdSILCuCDoictGwY3NjhqHeWg7bm05Wq4q/M1gRKcukoN97MQYNaCcNcbMSXRGUmnFsWzIjH4HH+foKrLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870195; c=relaxed/simple;
	bh=XVamdcRVYCVsZGkPVKNqOgjiNe7NUzWCSLeSXHaRMd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgDOuQiB7GkbWFFFacJGBZUEqQLjRVQ2KX9Sj5cq9qXcnfz4L9p5ALXM4cxzwLdbSQ09H/ykCdBpaQQoAhts4iJ1sbN0JH/8Ogz16m/MXfj8m+BUyYFZY5I8inox2r2xnNYiJ773IFgLK3Bpx9DxsUCIbXIdetjb8dfWAKsIiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J9xuHobn; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J9xuHobn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713870190; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1Qy5JS1oLG695lpDQ8ENP7HAFr0YTA6hwVQ5C4STsdY=;
	b=J9xuHobniGQnCgsJ0koODQR4JR6EkqbWzoAfXDWJHv/mT3cgJZuxULT4bxDOoDtF2rpnL6PvM0+6VNtEjqX1QrnJU1V6faebokndqJUJnMxAb+4LgLbLJ4RcgJk1r6upSgUcWnvnCV8ZyyW/eR87TKcgy9Wljh1wAuYTB1dSDEc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W591OMf_1713870188;
Received: from 30.221.149.17(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W591OMf_1713870188)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:03:10 +0800
Message-ID: <cab1ae8d-00b8-40e3-a5a6-31f231966a7b@linux.alibaba.com>
Date: Tue, 23 Apr 2024 19:03:08 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] virtio_net: virtnet_send_command supports
 command-specific-result
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240423084226.25440-1-hengqi@linux.alibaba.com>
 <20240423084226.25440-2-hengqi@linux.alibaba.com>
 <ZieK1lmc0czcEXWk@nanopsycho>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ZieK1lmc0czcEXWk@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/23 下午6:17, Jiri Pirko 写道:
> Tue, Apr 23, 2024 at 10:42:25AM CEST, hengqi@linux.alibaba.com wrote:
>> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>
>> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>>
>> The virtnet cvq supports to get result from the device.
> Is this a statement about current status, cause it sounds so. Could you
> make it clear by changing the patch subject and description to use
> imperative mood please. Command the codebase what to do.

Sure. Will add more text in v2.

>
> Thanks!
>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> drivers/net/virtio_net.c | 24 +++++++++++++++++-------
>> 1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7176b956460b..3bc9b1e621db 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>>   * supported by the hypervisor, as indicated by feature bits, should
>>   * never fail unless improperly formatted.
>>   */
>> -static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>> -				 struct scatterlist *out)
>> +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
>> +				       struct scatterlist *out,
>> +				       struct scatterlist *in)
>> {
>> -	struct scatterlist *sgs[4], hdr, stat;
>> -	unsigned out_num = 0, tmp;
>> +	struct scatterlist *sgs[5], hdr, stat;
>> +	u32 out_num = 0, tmp, in_num = 0;
>> 	int ret;
>>
>> 	/* Caller should know better */
>> @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>
>> 	/* Add return status. */
>> 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
>> -	sgs[out_num] = &stat;
>> +	sgs[out_num + in_num++] = &stat;
>>
>> -	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
>> -	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
>> +	if (in)
>> +		sgs[out_num + in_num++] = in;
>> +
>> +	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
>> +	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
>> 	if (ret < 0) {
>> 		dev_warn(&vi->vdev->dev,
>> 			 "Failed to add sgs for command vq: %d\n.", ret);
>> @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>> 	return vi->ctrl->status == VIRTIO_NET_OK;
>> }
>>
>> +static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>> +				 struct scatterlist *out)
>> +{
>> +	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
>> +}
>> +
>> static int virtnet_set_mac_address(struct net_device *dev, void *p)
>> {
>> 	struct virtnet_info *vi = netdev_priv(dev);
>> -- 
>> 2.32.0.3.g01195cf9f
>>
>>

