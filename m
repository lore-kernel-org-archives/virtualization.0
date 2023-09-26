Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC32E7D271
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 09:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A12ED40227;
	Tue, 26 Sep 2023 09:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A12ED40227
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HMjbNINa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p-7Bdpr8rVGD; Tue, 26 Sep 2023 09:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81F144003D;
	Tue, 26 Sep 2023 09:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81F144003D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42C69C0071;
	Tue, 26 Sep 2023 09:45:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B9FBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 09:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 082CC40574
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 09:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 082CC40574
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=HMjbNINa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4611x508R5O
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 09:45:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A71F1400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 09:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A71F1400EF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeI+tLNkGcADM+0efXYRfFpY8jAQ+ufPFtnj06v/waqREx8VP0U7b3CXBu+BIGNLI47VIJLte5mw5c3e8ZFjalRwlmln11KMg9pgQ3LWFvuWTmJ2JFKmlHI/PlVhq1RONXP47gbIm3dhgqDRohLRmv68yBjkl89MbVhcugcQzLgYez3WwyL6KDp1uUc+OKXliRLnj6cr88z5hgNbVt82KJx20hZwwTOY3T43xjnd99tvKQbKO4I3i1if7Hy6B1hGh17O03JCETUwZtA8EWXWu9aUH2DmZJUR92BtB0AjXaDwO7DO/NKz5tZFwrseG4smX+PHSD7WJI7CJKdbS46CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THVxwd6wYb8wSJZDhp5g6detOrK0HdlbXxTxr390FMQ=;
 b=Ukx/+8B04PRiKzxC1ThOCD2TmpzeKKdRhEw2vrdQ28uaen+ChxQLdAh8yAyiGq1FbnM28UVG3hmrrcTizbHt2Uvxk0rS8QVSd5oB78LnV5dgF3GNx9YNZmmLLoGYiGKYPrrOvpSfVQp2v1VYlK8CT5nScibs2HcPpxv3UrVR6iniuJPcQ8lgqmSSaZq+lNRVSz2pZx1p8SYy39MBd37pGg/Rpjz7KLlds8+Tihiw7eCjZ/QrCoyACB7xA4w4w7m+bJWG9dOePB404yx8Zy1KACXIL7O9zEU/nCH/nNd6IQc3+pKtOoyxfZXovi8xfn5sx0ktEQ8Us8p4izCoClgZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THVxwd6wYb8wSJZDhp5g6detOrK0HdlbXxTxr390FMQ=;
 b=HMjbNINamQbrh2pyscDze0sFiO6xX7YVUryUGg8P+np+2jhPZDecLzPyDHozr16zGR9pYNAYc4bE5n/Uy0zQKCG7XGAPK014EU/mAYerZh/iCMxtqRa/FInP3lWazqXDWhskVMSA/tOgXAUbtmgaU01RAvyQcjVjSjiqsMn5ytG4zioFNOEHGZTXOIY8Vt8Dm+fAZUKt26ruvLpyproJ4YVJ+wJ3zsrSFoCsheT3d4kkGNKDMXAB8rVgY0WS2zgc3OgsQDE2nXUrx3AzUyex/b2iqoxx5bmduFqfulhNgyns2ysnQhYsK7ezDhtagbanDZ8EU334XjOsvDNsIOId0A==
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 09:45:53 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::6c) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 09:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 09:45:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 02:45:38 -0700
Received: from [172.27.13.90] (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 02:45:34 -0700
Message-ID: <e050e4b3-6432-5784-63ba-28a501d2b56a@nvidia.com>
Date: Tue, 26 Sep 2023 12:45:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH vfio 08/11] vfio/pci: Expose vfio_pci_core_setup_barmap()
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-9-yishaih@nvidia.com>
 <20230921103532.3e5f319e.alex.williamson@redhat.com>
In-Reply-To: <20230921103532.3e5f319e.alex.williamson@redhat.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: dee9c506-7d3b-4213-8270-08dbbe75600e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpHn/Usi5lCtkYf25fjRostnp59bhndM9X9we8hoRVd9TIL84mO13GF/MytfB10PZstIAgWYTqBbKqgfK8kS5W2myvLAqTTiqw01WeyrjwobXqroKSQ+97l4OaVRu4egJ70LochyDS/07kkfcRH+EtQX8dIzz0OWXIf/Tsnzs8vq8kx1sjnLTH00EX9IdIVfCoF+oyk3gfLtd8Zbc1dpRXEe60neB3mL3ZWEglfwfJb70MPux6ncXqaTxtZXjSRxIvQ0PhPUGc1fwQmWz3pX3CaDV09mTMTEedd0fVIJs2h8Sv/iyrzV+ALgAOYwltDEVOadYDorfXJy/isctg/S2uA1jSvh0NE29nh2mROV7l4UkrbiQ5tfHC60rGstgWhD6JuzCkxDmYIKaU1YlfCcn60MGnURoeQSMA6x8vf0Q7rBjL+Q7NefLGjhIeO4KbybCIRWjOMZpxZXU5czCvOyWN3iZjTaDLjpl0vV6DqCqhcjyErKtLMK4b5DULuVdVu4O9x5xjOm//yYxqbXFmYoLzqHH10KxOWSKx8zG3Vyu/DV4yiMrXI1y8B0/Ftq8xWzNUnctnIxxYKHPIQ6TvsZysOM+uZUyno+4TSvynvsrfyhGnp5xsnJ1mbilL/IegckKNXdvFM2uVTMvhRG6YsLXRFVbXx8Z4uj5dcAF7gwGgcfchZbm73UsNxR3rpDmxg/GtCgax3ct4awmtCygcb/w4p7k2xWa8Oqx/5vsaUOceMiV6LdxcrdZSNYDUkSQh8aXxWUe/kCIoEx2y8tHCbfXw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(47076005)(2906002)(40460700003)(478600001)(36756003)(82740400003)(6666004)(86362001)(336012)(426003)(16526019)(83380400001)(107886003)(26005)(53546011)(31696002)(2616005)(7636003)(356005)(40480700001)(8936002)(36860700001)(41300700001)(8676002)(4326008)(16576012)(316002)(5660300002)(31686004)(70206006)(70586007)(6916009)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 09:45:53.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee9c506-7d3b-4213-8270-08dbbe75600e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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
From: Yishai Hadas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yishai Hadas <yishaih@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 21/09/2023 19:35, Alex Williamson wrote:
> On Thu, 21 Sep 2023 15:40:37 +0300
> Yishai Hadas <yishaih@nvidia.com> wrote:
>
>> Expose vfio_pci_core_setup_barmap() to be used by drivers.
>>
>> This will let drivers to mmap a BAR and re-use it from both vfio and the
>> driver when it's applicable.
>>
>> This API will be used in the next patches by the vfio/virtio coming
>> driver.
>>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 25 +++++++++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 28 ++--------------------------
>>   include/linux/vfio_pci_core.h    |  1 +
>>   3 files changed, 28 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 1929103ee59a..b56111ed8a8c 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -684,6 +684,31 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>   }
>>   EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
>>   
>> +int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	void __iomem *io;
>> +	int ret;
>> +
>> +	if (vdev->barmap[bar])
>> +		return 0;
>> +
>> +	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> +	if (ret)
>> +		return ret;
>> +
>> +	io = pci_iomap(pdev, bar, 0);
>> +	if (!io) {
>> +		pci_release_selected_regions(pdev, 1 << bar);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	vdev->barmap[bar] = io;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(vfio_pci_core_setup_barmap);
> Not to endorse the rest of this yet, but minimally _GPL, same for the
> following patch.  Thanks,
>
> Alex

Sure, will change to EXPORT_SYMBOL_GPL as part of V1.

Yishai

>> +
>>   void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>>   {
>>   	struct vfio_pci_core_device *vdev =
>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index e27de61ac9fe..6f08b3ecbb89 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -200,30 +200,6 @@ static ssize_t do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>>   	return done;
>>   }
>>   
>> -static int vfio_pci_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>> -{
>> -	struct pci_dev *pdev = vdev->pdev;
>> -	int ret;
>> -	void __iomem *io;
>> -
>> -	if (vdev->barmap[bar])
>> -		return 0;
>> -
>> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> -	if (ret)
>> -		return ret;
>> -
>> -	io = pci_iomap(pdev, bar, 0);
>> -	if (!io) {
>> -		pci_release_selected_regions(pdev, 1 << bar);
>> -		return -ENOMEM;
>> -	}
>> -
>> -	vdev->barmap[bar] = io;
>> -
>> -	return 0;
>> -}
>> -
>>   ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>>   			size_t count, loff_t *ppos, bool iswrite)
>>   {
>> @@ -262,7 +238,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>>   		}
>>   		x_end = end;
>>   	} else {
>> -		int ret = vfio_pci_setup_barmap(vdev, bar);
>> +		int ret = vfio_pci_core_setup_barmap(vdev, bar);
>>   		if (ret) {
>>   			done = ret;
>>   			goto out;
>> @@ -438,7 +414,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>>   		return -EINVAL;
>>   #endif
>>   
>> -	ret = vfio_pci_setup_barmap(vdev, bar);
>> +	ret = vfio_pci_core_setup_barmap(vdev, bar);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 562e8754869d..67ac58e20e1d 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -127,6 +127,7 @@ int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
>>   int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
>> +int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
>>   pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>>   						pci_channel_state_t state);
>>   


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
