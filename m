Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA36C63777
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 19:48:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648E20B1F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8tCVBB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9648E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E41812E115;
	Wed, 25 Nov 2020 19:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8y+-zH8FLgdQ; Wed, 25 Nov 2020 19:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 04071203D1;
	Wed, 25 Nov 2020 19:48:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6482C163C;
	Wed, 25 Nov 2020 19:48:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 997DAC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 19:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D4EA875F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 19:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXw1rMpKi1hT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 19:48:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A57FF87600
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 19:48:18 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APJitnU054929;
 Wed, 25 Nov 2020 19:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=epiqMBJ5lLDXN1oZKLWUGI5EBe3pcqP2c/wa0GUUOfc=;
 b=V8tCVBB9OAlZVOSR18OalnrluszF+sEyOdESr+ierhQ8blCu3jGg2JFJBRU0sfGJrdgb
 u6ovEIV876lB64+8W1lQiKL6isw/nEGry7mUewNbHHkTTRQPyh56MuBgOhnhJBTWGRB1
 QD9lYBFz8nB9EzKqnlV4EU5lw58Z+drV0shOyHV8C857VdvnTqmng5AAjz7w4AEfM3j6
 xXIdFixV0EmTvIvHQuC6hgcAkWK4OI7XccXCZ9BeEO/UaokGi2dtJyTiJWg2uY+J+J9J
 OUD7EK8ZbPYBR4DxaY3/0HWhnfecFR9ONPXnK3fG+x3MOAx6zz+n41cIZichiC/GLpWR rA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 351kwhb57c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 25 Nov 2020 19:48:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0APJixPw018399;
 Wed, 25 Nov 2020 19:48:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 351kwetgkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Nov 2020 19:48:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0APJmChZ024738;
 Wed, 25 Nov 2020 19:48:13 GMT
Received: from [10.159.138.187] (/10.159.138.187)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 25 Nov 2020 11:48:11 -0800
Message-ID: <5FBEB4F9.3060008@oracle.com>
Date: Wed, 25 Nov 2020 11:48:09 -0800
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] vhost-vdpa: fix page pinning leakage in error path
 (rework)
References: <1604618793-4681-1-git-send-email-si-wei.liu@oracle.com>
 <20201125042834-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201125042834-mutt-send-email-mst@kernel.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=2 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250123
Cc: lingshan.zhu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com
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


On 11/25/2020 1:30 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 05, 2020 at 06:26:33PM -0500, Si-Wei Liu wrote:
>> Pinned pages are not properly accounted particularly when
>> mapping error occurs on IOTLB update. Clean up dangling
>> pinned pages for the error path.
>>
>> The memory usage for bookkeeping pinned pages is reverted
>> to what it was before: only one single free page is needed.
>> This helps reduce the host memory demand for VM with a large
>> amount of memory, or in the situation where host is running
>> short of free memory.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> Not sure which tree this is against, I had to apply this with
> minor tweaks. Pls take a look at the vhost tree and
> let me know whether it looks ok to you.
Thanks Michael, the commit ad89653f79f1882d55d9df76c9b2b94f008c4e27 in 
the vhost tree looks good. Sorry, I don't think I ever attempted to 
merge with linux-next when v3 was posted, although I did it for the 
first two submissions. I will pay attention to it next time.

Thanks,
-Siwei

>
>> ---
>> Changes in v3:
>> - Turn explicit last_pfn check to a WARN_ON() (Jason)
>>
>> Changes in v2:
>> - Drop the reversion patch
>> - Fix unhandled page leak towards the end of page_list
>>
>>   drivers/vhost/vdpa.c | 80 ++++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 62 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b6d9016..5b13dfd 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>>   
>>   	if (r)
>>   		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
>> +	else
>> +		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
>>   
>>   	return r;
>>   }
>> @@ -591,14 +593,16 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>   	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>>   	unsigned int gup_flags = FOLL_LONGTERM;
>>   	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>> -	unsigned long locked, lock_limit, pinned, i;
>> +	unsigned long lock_limit, sz2pin, nchunks, i;
>>   	u64 iova = msg->iova;
>> +	long pinned;
>>   	int ret = 0;
>>   
>>   	if (vhost_iotlb_itree_first(iotlb, msg->iova,
>>   				    msg->iova + msg->size - 1))
>>   		return -EEXIST;
>>   
>> +	/* Limit the use of memory for bookkeeping */
>>   	page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>   	if (!page_list)
>>   		return -ENOMEM;
>> @@ -607,52 +611,75 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>   		gup_flags |= FOLL_WRITE;
>>   
>>   	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
>> -	if (!npages)
>> -		return -EINVAL;
>> +	if (!npages) {
>> +		ret = -EINVAL;
>> +		goto free;
>> +	}
>>   
>>   	mmap_read_lock(dev->mm);
>>   
>> -	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
>>   	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> -
>> -	if (locked > lock_limit) {
>> +	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>>   		ret = -ENOMEM;
>> -		goto out;
>> +		goto unlock;
>>   	}
>>   
>>   	cur_base = msg->uaddr & PAGE_MASK;
>>   	iova &= PAGE_MASK;
>> +	nchunks = 0;
>>   
>>   	while (npages) {
>> -		pinned = min_t(unsigned long, npages, list_size);
>> -		ret = pin_user_pages(cur_base, pinned,
>> -				     gup_flags, page_list, NULL);
>> -		if (ret != pinned)
>> +		sz2pin = min_t(unsigned long, npages, list_size);
>> +		pinned = pin_user_pages(cur_base, sz2pin,
>> +					gup_flags, page_list, NULL);
>> +		if (sz2pin != pinned) {
>> +			if (pinned < 0) {
>> +				ret = pinned;
>> +			} else {
>> +				unpin_user_pages(page_list, pinned);
>> +				ret = -ENOMEM;
>> +			}
>>   			goto out;
>> +		}
>> +		nchunks++;
>>   
>>   		if (!last_pfn)
>>   			map_pfn = page_to_pfn(page_list[0]);
>>   
>> -		for (i = 0; i < ret; i++) {
>> +		for (i = 0; i < pinned; i++) {
>>   			unsigned long this_pfn = page_to_pfn(page_list[i]);
>>   			u64 csize;
>>   
>>   			if (last_pfn && (this_pfn != last_pfn + 1)) {
>>   				/* Pin a contiguous chunk of memory */
>>   				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
>> -				if (vhost_vdpa_map(v, iova, csize,
>> -						   map_pfn << PAGE_SHIFT,
>> -						   msg->perm))
>> +				ret = vhost_vdpa_map(v, iova, csize,
>> +						     map_pfn << PAGE_SHIFT,
>> +						     msg->perm);
>> +				if (ret) {
>> +					/*
>> +					 * Unpin the pages that are left unmapped
>> +					 * from this point on in the current
>> +					 * page_list. The remaining outstanding
>> +					 * ones which may stride across several
>> +					 * chunks will be covered in the common
>> +					 * error path subsequently.
>> +					 */
>> +					unpin_user_pages(&page_list[i],
>> +							 pinned - i);
>>   					goto out;
>> +				}
>> +
>>   				map_pfn = this_pfn;
>>   				iova += csize;
>> +				nchunks = 0;
>>   			}
>>   
>>   			last_pfn = this_pfn;
>>   		}
>>   
>> -		cur_base += ret << PAGE_SHIFT;
>> -		npages -= ret;
>> +		cur_base += pinned << PAGE_SHIFT;
>> +		npages -= pinned;
>>   	}
>>   
>>   	/* Pin the rest chunk */
>> @@ -660,10 +687,27 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>   			     map_pfn << PAGE_SHIFT, msg->perm);
>>   out:
>>   	if (ret) {
>> +		if (nchunks) {
>> +			unsigned long pfn;
>> +
>> +			/*
>> +			 * Unpin the outstanding pages which are yet to be
>> +			 * mapped but haven't due to vdpa_map() or
>> +			 * pin_user_pages() failure.
>> +			 *
>> +			 * Mapped pages are accounted in vdpa_map(), hence
>> +			 * the corresponding unpinning will be handled by
>> +			 * vdpa_unmap().
>> +			 */
>> +			WARN_ON(!last_pfn);
>> +			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>> +				unpin_user_page(pfn_to_page(pfn));
>> +		}
>>   		vhost_vdpa_unmap(v, msg->iova, msg->size);
>> -		atomic64_sub(npages, &dev->mm->pinned_vm);
>>   	}
>> +unlock:
>>   	mmap_read_unlock(dev->mm);
>> +free:
>>   	free_page((unsigned long)page_list);
>>   	return ret;
>>   }
>> -- 
>> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
