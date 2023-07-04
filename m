Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00457EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 19:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 662344058B;
	Tue,  4 Jul 2023 19:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 662344058B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0J8e9rE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1JhjC6kFd9h; Tue,  4 Jul 2023 19:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFB2B400E7;
	Tue,  4 Jul 2023 19:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFB2B400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF454C0072;
	Tue,  4 Jul 2023 19:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61CA3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 19:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 275AB41061
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 19:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 275AB41061
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0J8e9rE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2TorWPaO2lU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 19:22:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CBE0409E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CBE0409E3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688498561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFBR9aLLd+UbaMyLdyzrVxs4N2kaUNBTqCwcKCV+cF4=;
 b=F0J8e9rEAa/Nw2FcpcaP1fJgqY8CCyrF+8xKkcDXU/Fjl95NYf/64RmSDsbkzkQtSECdbN
 puOgu+W5cyoAMe9Ow3XlxdZp4+qxMVgui3eIn9CYzi+rsOBxsZ0NAwIspZs9WZn6MMvCUD
 SJszzxAn4yeIjpNREkMcD16hzeEv8VM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-bNqzE_xcOrKocHm-YoH1Eg-1; Tue, 04 Jul 2023 15:22:38 -0400
X-MC-Unique: bNqzE_xcOrKocHm-YoH1Eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C620D800159;
 Tue,  4 Jul 2023 19:22:37 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7DDF641E;
 Tue,  4 Jul 2023 19:22:35 +0000 (UTC)
Message-ID: <1f4ac369-75f8-f65d-6f31-9c4a5a2a357f@redhat.com>
Date: Tue, 4 Jul 2023 21:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
 <20230704164045.39119-4-maxime.coquelin@redhat.com>
 <20230704124245-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230704124245-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 7/4/23 18:43, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 06:40:45PM +0200, Maxime Coquelin wrote:
>> Virtio-net driver control queue implementation is not safe
>> when used with VDUSE. If the VDUSE application does not
>> reply to control queue messages, it currently ends up
>> hanging the kernel thread sending this command.
>>
>> Some work is on-going to make the control queue
>> implementation robust with VDUSE. Until it is completed,
>> let's disable control virtqueue and features that depend on
>> it.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 1271c9796517..04367a53802b 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
>>   
>>   ATTRIBUTE_GROUPS(vduse_dev);
>>   
>> +static void vduse_dev_features_fixup(struct vduse_dev_config *config)
>> +{
>> +	if (config->device_id == VIRTIO_ID_NET) {
>> +		/*
>> +		 * Temporarily disable control virtqueue and features that
>> +		 * depend on it while CVQ is being made more robust for VDUSE.
>> +		 */
>> +		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_RX) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
>> +				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
>> +				(1ULL << VIRTIO_NET_F_MQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
>> +				(1ULL << VIRTIO_NET_F_RSS) |
>> +				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
>> +				(1ULL << VIRTIO_NET_F_NOTF_COAL));
>> +	}
>> +}
>> +
> 
> 
> This will never be exhaustive, we are adding new features.
> Please add an allowlist with just legal ones instead.

Ok, got it!
I'll post a new revision.

Thanks,
Maxime

> 
> 
>>   static int vduse_create_dev(struct vduse_dev_config *config,
>>   			    void *config_buf, u64 api_version)
>>   {
>> @@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>   	if (!dev)
>>   		goto err;
>>   
>> +	vduse_dev_features_fixup(config);
>> +
>>   	dev->api_version = api_version;
>>   	dev->device_features = config->features;
>>   	dev->device_id = config->device_id;
>> -- 
>> 2.41.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
