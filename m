Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB6C0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 09:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2104B40122;
	Wed, 25 Oct 2023 09:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2104B40122
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HI9ZunRp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y04Ijg9K9Cqc; Wed, 25 Oct 2023 09:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47FE74029B;
	Wed, 25 Oct 2023 09:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47FE74029B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDF13C0039;
	Wed, 25 Oct 2023 09:18:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B7D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5555C70412
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5555C70412
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=HI9ZunRp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8F_klHSfu1cZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:18:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 333A7703F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 333A7703F6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2R7Y0FM+8PJzq8EQjZJKUxhruxbbwt5cd/3twAABGpzPCE7XiJPLyIu4QR4LirImf2UG6QJwXb5bohoknqm7WENAKqvCWrBClI2Y4ooWV53xz0AJiceLbIAKiBgQ41dPru63tV0UUVPPmhfDC+99F90ozMR7QY6YsfC0yjWv6Fv64JPSZDDquSBPcM8pRR93/fs8mf6G+g7CBIjcS+00IEbOpICoWdqa7HKcjVAc+XIhY3Vl8S+Pszn0aQBuh4BgOVzLGudSu7smnB4LZ/jCqP3Oog502kz+w07QheBCVY+OsKpGORupWJVswc6VO0eCshAhd6JxKhl+hBr/e/81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx13Px3EgXYAM+cXdqDFLdW/U28qJZImGeIN39hp87A=;
 b=ljlRZfhm2AsUNAl4XtJhoN4i4pIUdP6G+sO/Mz81cQ86fFXewFqJVjVD2BWlBRL/QVgrPz0kGZtmUywbZjQLhHcGOsk+NccfU0srU3N0IoFQX54xxODkG+tem8kZkl8bS0pZl7JDsj7BskUQksrhUqrAqCmySL5qIHVzdAQyp3mQX6vqNvy/3hBVNbvRnYGrads9hMT7TzgpQMVgbLuxhzJ6JEwUcCDqqHzITQGjdO5MKpwQzv85oKR5La+1SlSQt6vEULJqoptamtnq9nARCfMbos0MNicuEcrq6A83dusRXzHzKq+rnkf0KnCm6cZiwvyjkxkuDHsgNUdQFTC64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx13Px3EgXYAM+cXdqDFLdW/U28qJZImGeIN39hp87A=;
 b=HI9ZunRpvV/oHy/ipEKnLViSEr+Boh4rm8zvVhKcOM7+eI+72gC3NupXYGUQPLacGytDv+viDFhwLfZq+6y03Uc0o1BnYW+49JekUkwp3Myr7WYmaWAdp4ywXrewl42WGQHA17NnnQPSJ9RT9bTWCaysU/BoVKuEv6Hxu9l4+DwIQlsjjvsv1mjVbS3QhFvGQ4CBNxAflEwxWEQKOFkURXvx7f0pzNKvpiBF0vrsnwInVWe8eX2EoDbZLyaiaFYmJQQ1aRLYiIk08wl3u8FwLRUgpa1Cc52nNyinmAqz5OgHoazhSoi6KpZ4S8sztbpqBL1LV0R6HO/D/8u0q68SKQ==
Received: from CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::29)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:18:53 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::be) by CH0P221CA0006.outlook.office365.com
 (2603:10b6:610:11c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 09:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 09:18:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 02:18:38 -0700
Received: from [172.27.14.159] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 02:18:34 -0700
Message-ID: <5a83e6c1-1d32-4edb-a01c-3660ab74d875@nvidia.com>
Date: Wed, 25 Oct 2023 12:18:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-7-yishaih@nvidia.com>
 <20231024165210-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20231024165210-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd6aa64-0a7e-47a7-c112-08dbd53b67df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+5S0ugVA6F/55wUjOXfbCfZhpMD7LQv+OEvGeGPC0lKihYKav4RPzYb3bh+HdepvxYFBzI5ulUaomjUozqf8+7tScO6ZKW+TMiRRaGknATAo0ITdWEX2v4caC8WZc1vWhs148zk21SGHIbkXcHdfHPhYEugOgYepeMcUc8y9tByefavCX30mDzeCGMWGh0wXSzz4mvIVlELvA8Bn+WrrdJOSA+Gfh7lR/5ZT3UsHCyC+3dIOiRuc5wMYMxmQsVrzGEw1Sh7INHVXD/1nkWnLcZE9MFhl5IWtyEegslW7eR8le+oljT85lEQEgo7sUR/PTsJdKs85LRbxuQoYZg6vzDlsRSgjbwoSneR62iy2tZ3lrUl+grNRdEdYmvt0i4TrY1RnwBaVVASVhiAIgrO0nU5Eqr29vBRWWALxS1zIHEU6ZL0rBY4cWL/j6UMfXBEXw5NK3tXtpGvlf9Wwf2rLD4xUv0P6D3PZdUNlEWtuFzTSbdXtfi5rZ99VQD53EOrYUzNThBdHm0ZmhgbBAmgKKcQZo7j2WXLSIc3Bj1nJJn0xGCFf4BlZ9CtBJogWHiCCc8C8o0O2pGSuJvT8njjVVuSKz+OyvdHUN9wb6IHRVngyPf7bMBW4AnNxUVV5z64NqOvEpVpw9/Ckm/njmvMZqpQ0KUB8SJoBZUWnjwqc9IXTZw5k5rKx1EEvic4dUhn8It0PV1F4EledexRAQRat2nis1vUyoYJcuLLVWJD/pE4NCUcrIQytTqf5RFVerhw5KAPmEtNuAKZFIm16M0i6Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(16526019)(31686004)(30864003)(2906002)(36756003)(31696002)(41300700001)(5660300002)(86362001)(40460700003)(8676002)(36860700001)(4326008)(8936002)(26005)(7636003)(33964004)(107886003)(54906003)(70206006)(316002)(6916009)(356005)(82740400003)(16576012)(2616005)(70586007)(478600001)(83380400001)(336012)(426003)(40480700001)(53546011)(47076005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:18:52.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd6aa64-0a7e-47a7-c112-08dbd53b67df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
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
Content-Type: multipart/mixed; boundary="===============0498958998876134780=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0498958998876134780==
Content-Type: multipart/alternative;
	boundary="------------rT2c8vlU1nkNa7JU6rVG1fBY"
Content-Language: en-US

--------------rT2c8vlU1nkNa7JU6rVG1fBY
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 25/10/2023 0:01, Michael S. Tsirkin wrote:
> On Tue, Oct 17, 2023 at 04:42:14PM +0300, Yishai Hadas wrote:
>> Introduce APIs to execute legacy IO admin commands.
>>
>> It includes: list_query/use, io_legacy_read/write,
>> io_legacy_notify_info.
>>
>> Those APIs will be used by the next patches from this series.
>>
>> Signed-off-by: Yishai Hadas<yishaih@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_common.c |  11 ++
>>   drivers/virtio/virtio_pci_common.h |   2 +
>>   drivers/virtio/virtio_pci_modern.c | 206 +++++++++++++++++++++++++++++
>>   include/linux/virtio_pci_admin.h   |  18 +++
>>   4 files changed, 237 insertions(+)
>>   create mode 100644 include/linux/virtio_pci_admin.h
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index 6b4766d5abe6..212d68401d2c 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -645,6 +645,17 @@ static struct pci_driver virtio_pci_driver = {
>>   	.sriov_configure = virtio_pci_sriov_configure,
>>   };
>>   
>> +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev)
>> +{
>> +	struct virtio_pci_device *pf_vp_dev;
>> +
>> +	pf_vp_dev = pci_iov_get_pf_drvdata(pdev, &virtio_pci_driver);
>> +	if (IS_ERR(pf_vp_dev))
>> +		return NULL;
>> +
>> +	return &pf_vp_dev->vdev;
>> +}
>> +
>>   module_pci_driver(virtio_pci_driver);
>>   
>>   MODULE_AUTHOR("Anthony Liguori<aliguori@us.ibm.com>");
>> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
>> index a21b9ba01a60..2785e61ed668 100644
>> --- a/drivers/virtio/virtio_pci_common.h
>> +++ b/drivers/virtio/virtio_pci_common.h
>> @@ -155,4 +155,6 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
>>   int virtio_pci_modern_probe(struct virtio_pci_device *);
>>   void virtio_pci_modern_remove(struct virtio_pci_device *);
>>   
>> +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>> +
>>   #endif
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index cc159a8e6c70..00b65e20b2f5 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -719,6 +719,212 @@ static void vp_modern_destroy_avq(struct virtio_device *vdev)
>>   	vp_dev->del_vq(&vp_dev->admin_vq.info);
>>   }
>>   
>> +/*
>> + * virtio_pci_admin_list_query - Provides to driver list of commands
>> + * supported for the PCI VF.
>> + * @dev: VF pci_dev
>> + * @buf: buffer to hold the returned list
>> + * @buf_size: size of the given buffer
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
>> +{
>> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist result_sg;
>> +
>> +	if (!virtio_dev)
>> +		return -ENODEV;
>> +
>> +	sg_init_one(&result_sg, buf, buf_size);
>> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
>> +	cmd.result_sg = &result_sg;
>> +
>> +	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_query);
>> +
>> +/*
>> + * virtio_pci_admin_list_use - Provides to device list of commands
>> + * used for the PCI VF.
>> + * @dev: VF pci_dev
>> + * @buf: buffer which holds the list
>> + * @buf_size: size of the given buffer
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
>> +{
>> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist data_sg;
>> +
>> +	if (!virtio_dev)
>> +		return -ENODEV;
>> +
>> +	sg_init_one(&data_sg, buf, buf_size);
>> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
>> +	cmd.data_sg = &data_sg;
>> +
>> +	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_use);
> list commands are actually for a group, not for the VF.

The VF was given to let the function gets the PF from it.

For now, the only existing 'group_type' in the spec is SRIOV, this is 
why we hard-coded it internally to match the VF PCI.

Alternatively,
We can change the API to get the PF and 'group_type' from the caller to 
better match future usage.
However, this will require to export the virtio_pci_vf_get_pf_dev() API 
outside virtio-pci.

Do you prefer to change to the latter option ?

>
>> +
>> +/*
>> + * virtio_pci_admin_legacy_io_write - Write legacy registers of a member device
>> + * @dev: VF pci_dev
>> + * @opcode: op code of the io write command
> opcode is actually either VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> or VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE correct?
>
> So please just add 2 APIs for this so users don't need to care.
> Could be wrappers around these two things.
>
OK.

We'll export the below 2 APIs [1] which internally will call 
virtio_pci_admin_legacy_io_write() with the proper op code hard-coded.

[1]virtio_pci_admin_legacy_device_io_write()
      virtio_pci_admin_legacy_common_io_write()

Yishai

>
>
>> + * @offset: starting byte offset within the registers to write to
>> + * @size: size of the data to write
>> + * @buf: buffer which holds the data
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
>> +				     u8 offset, u8 size, u8 *buf)
>> +{
>> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
>> +	struct virtio_admin_cmd_legacy_wr_data *data;
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist data_sg;
>> +	int vf_id;
>> +	int ret;
>> +
>> +	if (!virtio_dev)
>> +		return -ENODEV;
>> +
>> +	vf_id = pci_iov_vf_id(pdev);
>> +	if (vf_id < 0)
>> +		return vf_id;
>> +
>> +	data = kzalloc(sizeof(*data) + size, GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->offset = offset;
>> +	memcpy(data->registers, buf, size);
>> +	sg_init_one(&data_sg, data, sizeof(*data) + size);
>> +	cmd.opcode = cpu_to_le16(opcode);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
>> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
>> +	cmd.data_sg = &data_sg;
>> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>> +
>> +	kfree(data);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_write);
>> +
>> +/*
>> + * virtio_pci_admin_legacy_io_read - Read legacy registers of a member device
>> + * @dev: VF pci_dev
>> + * @opcode: op code of the io read command
>> + * @offset: starting byte offset within the registers to read from
>> + * @size: size of the data to be read
>> + * @buf: buffer to hold the returned data
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
>> +				    u8 offset, u8 size, u8 *buf)
>> +{
>> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
>> +	struct virtio_admin_cmd_legacy_rd_data *data;
>> +	struct scatterlist data_sg, result_sg;
>> +	struct virtio_admin_cmd cmd = {};
>> +	int vf_id;
>> +	int ret;
>> +
>> +	if (!virtio_dev)
>> +		return -ENODEV;
>> +
>> +	vf_id = pci_iov_vf_id(pdev);
>> +	if (vf_id < 0)
>> +		return vf_id;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->offset = offset;
>> +	sg_init_one(&data_sg, data, sizeof(*data));
>> +	sg_init_one(&result_sg, buf, size);
>> +	cmd.opcode = cpu_to_le16(opcode);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
>> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
>> +	cmd.data_sg = &data_sg;
>> +	cmd.result_sg = &result_sg;
>> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>> +
>> +	kfree(data);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_read);
>> +
>> +/*
>> + * virtio_pci_admin_legacy_io_notify_info - Read the queue notification
>> + * information for legacy interface
>> + * @dev: VF pci_dev
>> + * @req_bar_flags: requested bar flags
>> + * @bar: on output the BAR number of the member device
>> + * @bar_offset: on output the offset within bar
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
>> +					   u8 req_bar_flags, u8 *bar,
>> +					   u64 *bar_offset)
>> +{
>> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
>> +	struct virtio_admin_cmd_notify_info_result *result;
>> +	struct virtio_admin_cmd cmd = {};
>> +	struct scatterlist result_sg;
>> +	int vf_id;
>> +	int ret;
>> +
>> +	if (!virtio_dev)
>> +		return -ENODEV;
>> +
>> +	vf_id = pci_iov_vf_id(pdev);
>> +	if (vf_id < 0)
>> +		return vf_id;
>> +
>> +	result = kzalloc(sizeof(*result), GFP_KERNEL);
>> +	if (!result)
>> +		return -ENOMEM;
>> +
>> +	sg_init_one(&result_sg, result, sizeof(*result));
>> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO);
>> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
>> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
>> +	cmd.result_sg = &result_sg;
>> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>> +	if (!ret) {
>> +		struct virtio_admin_cmd_notify_info_data *entry;
>> +		int i;
>> +
>> +		ret = -ENOENT;
>> +		for (i = 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
>> +			entry = &result->entries[i];
>> +			if (entry->flags == VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END)
>> +				break;
>> +			if (entry->flags != req_bar_flags)
>> +				continue;
>> +			*bar = entry->bar;
>> +			*bar_offset = le64_to_cpu(entry->offset);
>> +			ret = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	kfree(result);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_notify_info);
>> +
>>   static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>>   	.get		= NULL,
>>   	.set		= NULL,
>> diff --git a/include/linux/virtio_pci_admin.h b/include/linux/virtio_pci_admin.h
>> new file mode 100644
>> index 000000000000..cb916a4bc1b1
>> --- /dev/null
>> +++ b/include/linux/virtio_pci_admin.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_VIRTIO_PCI_ADMIN_H
>> +#define _LINUX_VIRTIO_PCI_ADMIN_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/pci.h>
>> +
>> +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size);
>> +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size);
>> +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
>> +				     u8 offset, u8 size, u8 *buf);
>> +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
>> +				    u8 offset, u8 size, u8 *buf);
>> +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
>> +					   u8 req_bar_flags, u8 *bar,
>> +					   u64 *bar_offset);
>> +
>> +#endif /* _LINUX_VIRTIO_PCI_ADMIN_H */
>> -- 
>> 2.27.0


--------------rT2c8vlU1nkNa7JU6rVG1fBY
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 25/10/2023 0:01, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20231024165210-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Tue, Oct 17, 2023 at 04:42:14PM +0300, Yishai Hadas wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Introduce APIs to execute legacy IO admin commands.

It includes: list_query/use, io_legacy_read/write,
io_legacy_notify_info.

Those APIs will be used by the next patches from this series.

Signed-off-by: Yishai Hadas <a class="moz-txt-link-rfc2396E" href="mailto:yishaih@nvidia.com">&lt;yishaih@nvidia.com&gt;</a>
---
 drivers/virtio/virtio_pci_common.c |  11 ++
 drivers/virtio/virtio_pci_common.h |   2 +
 drivers/virtio/virtio_pci_modern.c | 206 +++++++++++++++++++++++++++++
 include/linux/virtio_pci_admin.h   |  18 +++
 4 files changed, 237 insertions(+)
 create mode 100644 include/linux/virtio_pci_admin.h

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 6b4766d5abe6..212d68401d2c 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -645,6 +645,17 @@ static struct pci_driver virtio_pci_driver = {
 	.sriov_configure = virtio_pci_sriov_configure,
 };
 
+struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev)
+{
+	struct virtio_pci_device *pf_vp_dev;
+
+	pf_vp_dev = pci_iov_get_pf_drvdata(pdev, &amp;virtio_pci_driver);
+	if (IS_ERR(pf_vp_dev))
+		return NULL;
+
+	return &amp;pf_vp_dev-&gt;vdev;
+}
+
 module_pci_driver(virtio_pci_driver);
 
 MODULE_AUTHOR("Anthony Liguori <a class="moz-txt-link-rfc2396E" href="mailto:aliguori@us.ibm.com">&lt;aliguori@us.ibm.com&gt;</a>");
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index a21b9ba01a60..2785e61ed668 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -155,4 +155,6 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
 int virtio_pci_modern_probe(struct virtio_pci_device *);
 void virtio_pci_modern_remove(struct virtio_pci_device *);
 
+struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
+
 #endif
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index cc159a8e6c70..00b65e20b2f5 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -719,6 +719,212 @@ static void vp_modern_destroy_avq(struct virtio_device *vdev)
 	vp_dev-&gt;del_vq(&amp;vp_dev-&gt;admin_vq.info);
 }
 
+/*
+ * virtio_pci_admin_list_query - Provides to driver list of commands
+ * supported for the PCI VF.
+ * @dev: VF pci_dev
+ * @buf: buffer to hold the returned list
+ * @buf_size: size of the given buffer
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
+{
+	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!virtio_dev)
+		return -ENODEV;
+
+	sg_init_one(&amp;result_sg, buf, buf_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.result_sg = &amp;result_sg;
+
+	return vp_modern_admin_cmd_exec(virtio_dev, &amp;cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_pci_admin_list_query);
+
+/*
+ * virtio_pci_admin_list_use - Provides to device list of commands
+ * used for the PCI VF.
+ * @dev: VF pci_dev
+ * @buf: buffer which holds the list
+ * @buf_size: size of the given buffer
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
+{
+	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+
+	if (!virtio_dev)
+		return -ENODEV;
+
+	sg_init_one(&amp;data_sg, buf, buf_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.data_sg = &amp;data_sg;
+
+	return vp_modern_admin_cmd_exec(virtio_dev, &amp;cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_pci_admin_list_use);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
list commands are actually for a group, not for the VF.</pre>
    </blockquote>
    <p>The VF was given to let the function gets the PF from it.<br>
    </p>
    <p>For now, the only existing 'group_type' in the spec is SRIOV,
      this is why we hard-coded it internally to match the VF PCI.<br>
    </p>
    <p>Alternatively,<br>
      We can change the API to get the PF and 'group_type' from the
      caller to better match future usage.<br>
      However, this will require to export the <span
      style="white-space: pre-wrap">virtio_pci_vf_get_pf_dev() API outside virtio-pci.</span></p>
    <p><span style="white-space: pre-wrap">Do you prefer to change to the latter option ?
</span></p>
    <blockquote type="cite"
      cite="mid:20231024165210-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+/*
+ * virtio_pci_admin_legacy_io_write - Write legacy registers of a member device
+ * @dev: VF pci_dev
+ * @opcode: op code of the io write command
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
opcode is actually either VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
or VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE correct?

So please just add 2 APIs for this so users don't need to care.
Could be wrappers around these two things.

</pre>
    </blockquote>
    <p>OK.</p>
    <p>We'll export the below 2 APIs [1] which internally will call
      virtio_pci_admin_legacy_io_write() with the proper op code
      hard-coded.<br>
    </p>
    <p>[1]virtio_pci_admin_legacy_device_io_write()<br>
           virtio_pci_admin_legacy_common_io_write()<br>
    </p>
    <p>Yishai<br>
    </p>
    <blockquote type="cite"
      cite="mid:20231024165210-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+ * @offset: starting byte offset within the registers to write to
+ * @size: size of the data to write
+ * @buf: buffer which holds the data
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
+				     u8 offset, u8 size, u8 *buf)
+{
+	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
+	struct virtio_admin_cmd_legacy_wr_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int vf_id;
+	int ret;
+
+	if (!virtio_dev)
+		return -ENODEV;
+
+	vf_id = pci_iov_vf_id(pdev);
+	if (vf_id &lt; 0)
+		return vf_id;
+
+	data = kzalloc(sizeof(*data) + size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data-&gt;offset = offset;
+	memcpy(data-&gt;registers, buf, size);
+	sg_init_one(&amp;data_sg, data, sizeof(*data) + size);
+	cmd.opcode = cpu_to_le16(opcode);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.group_member_id = cpu_to_le64(vf_id + 1);
+	cmd.data_sg = &amp;data_sg;
+	ret = vp_modern_admin_cmd_exec(virtio_dev, &amp;cmd);
+
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_write);
+
+/*
+ * virtio_pci_admin_legacy_io_read - Read legacy registers of a member device
+ * @dev: VF pci_dev
+ * @opcode: op code of the io read command
+ * @offset: starting byte offset within the registers to read from
+ * @size: size of the data to be read
+ * @buf: buffer to hold the returned data
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
+				    u8 offset, u8 size, u8 *buf)
+{
+	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
+	struct virtio_admin_cmd_legacy_rd_data *data;
+	struct scatterlist data_sg, result_sg;
+	struct virtio_admin_cmd cmd = {};
+	int vf_id;
+	int ret;
+
+	if (!virtio_dev)
+		return -ENODEV;
+
+	vf_id = pci_iov_vf_id(pdev);
+	if (vf_id &lt; 0)
+		return vf_id;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data-&gt;offset = offset;
+	sg_init_one(&amp;data_sg, data, sizeof(*data));
+	sg_init_one(&amp;result_sg, buf, size);
+	cmd.opcode = cpu_to_le16(opcode);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.group_member_id = cpu_to_le64(vf_id + 1);
+	cmd.data_sg = &amp;data_sg;
+	cmd.result_sg = &amp;result_sg;
+	ret = vp_modern_admin_cmd_exec(virtio_dev, &amp;cmd);
+
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_read);
+
+/*
+ * virtio_pci_admin_legacy_io_notify_info - Read the queue notification
+ * information for legacy interface
+ * @dev: VF pci_dev
+ * @req_bar_flags: requested bar flags
+ * @bar: on output the BAR number of the member device
+ * @bar_offset: on output the offset within bar
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
+					   u8 req_bar_flags, u8 *bar,
+					   u64 *bar_offset)
+{
+	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
+	struct virtio_admin_cmd_notify_info_result *result;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+	int vf_id;
+	int ret;
+
+	if (!virtio_dev)
+		return -ENODEV;
+
+	vf_id = pci_iov_vf_id(pdev);
+	if (vf_id &lt; 0)
+		return vf_id;
+
+	result = kzalloc(sizeof(*result), GFP_KERNEL);
+	if (!result)
+		return -ENOMEM;
+
+	sg_init_one(&amp;result_sg, result, sizeof(*result));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.group_member_id = cpu_to_le64(vf_id + 1);
+	cmd.result_sg = &amp;result_sg;
+	ret = vp_modern_admin_cmd_exec(virtio_dev, &amp;cmd);
+	if (!ret) {
+		struct virtio_admin_cmd_notify_info_data *entry;
+		int i;
+
+		ret = -ENOENT;
+		for (i = 0; i &lt; VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
+			entry = &amp;result-&gt;entries[i];
+			if (entry-&gt;flags == VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END)
+				break;
+			if (entry-&gt;flags != req_bar_flags)
+				continue;
+			*bar = entry-&gt;bar;
+			*bar_offset = le64_to_cpu(entry-&gt;offset);
+			ret = 0;
+			break;
+		}
+	}
+
+	kfree(result);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_notify_info);
+
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get		= NULL,
 	.set		= NULL,
diff --git a/include/linux/virtio_pci_admin.h b/include/linux/virtio_pci_admin.h
new file mode 100644
index 000000000000..cb916a4bc1b1
--- /dev/null
+++ b/include/linux/virtio_pci_admin.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_PCI_ADMIN_H
+#define _LINUX_VIRTIO_PCI_ADMIN_H
+
+#include &lt;linux/types.h&gt;
+#include &lt;linux/pci.h&gt;
+
+int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size);
+int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size);
+int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
+				     u8 offset, u8 size, u8 *buf);
+int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
+				    u8 offset, u8 size, u8 *buf);
+int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
+					   u8 req_bar_flags, u8 *bar,
+					   u64 *bar_offset);
+
+#endif /* _LINUX_VIRTIO_PCI_ADMIN_H */
-- 
2.27.0
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------rT2c8vlU1nkNa7JU6rVG1fBY--

--===============0498958998876134780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0498958998876134780==--
