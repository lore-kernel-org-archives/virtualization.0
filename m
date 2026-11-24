Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795516861;
	b=hUZBwxptcyJfRcg1VwBDa0ZKbl1OBn1me80SM5bggNNRJQWPZtr0GYtF6KrY4CGVgYbk
	 iLHhSKvnBEWNWgzT75lm/s5HbNsJmhS1pQ/Ti8+X2Dnx+vMXx9QfqScqHQoB61K4TTx4N
	 py0MqgiXtUnlm7C3BqItRi7bVqnc6hrBU5Jql6hXfvULisEH5vIHwgOD5zwSOOhMsRian
	 I5e5z29BJvfD0jKbdFc0dKU7+U5RBPI2ZEyVOp6X3JgSKABA5wT6ibrTptvqGUdHIHvY1
	 REWGPPrOCIbowbRuirIYo4/HZ9Xpqgy63QV0L57guJO3HRKAioakOxZY7ZGHVlsMS9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516861;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Z5asMDzHqKaACwKnIWeqeUA6z3j0tfHNb+KJAkzQqKQ=;
	b=hVa9ZzM9LSooEZ6euIh7/UWxiWD9wo+nY0nfZUkDDU/ogQuttcW29/jUfrCK+TrZsQu1
	 L98WfSUo5CuLPm/mRG9bGcVIrvBp0ALqF1mLUebcj5LKbOnz3+tCTXOK9gnU+O8tCncY3
	 u0+8saLRNsAcihI0ZUIQ1hQrY0W0jppWUD6XMuGPbrrO5Ei9qcIUk7denBqI75sQnPicB
	 V/b1s5e/eGQ7/XQ4xHQMAdIkutXl1mnBSMEwimxu3FRhf4URbGw6niavs1camRoSkbaik
	 Ga2x+reqwK7FnsGhF2rd6gEwKDXm+YOwQronfTx1Lpe1ABzobgGnkeHPOfEndiZompQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GHffESWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.10
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CA606A336
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 10:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7CA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GHffESWU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmkXqmiERqu/PoDaGEArpbzO4GxZjpm+RD9b8ux2uZM65Ctc0mgpmYOJrwV7ALr3zAW2GvPU2n/LGAu5Ffz6CZp0vvzD+XReD97ft6wuuhw2eR7OWb2Qvj50lyHvG8CGbRfNNlwDbDlyKEubcaiA3pFCpdmSbaia4AREAnmbHX5FvkLy1MJLJlhbvwFf71Pb2q/vG1VHCxLFZMk6DaeDLTgKzHfzllnQiFMve6cmgaWTvbpj82csaMnUPMoZaQ7HO60hlQSHr0cDu8ykExcBhU6XttPvqOWOR0U29y1pbKMEYHRDCOr7l0ODiiM40xbHqSYLuVWRDRCuMMkOwJw0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5asMDzHqKaACwKnIWeqeUA6z3j0tfHNb+KJAkzQqKQ=;
 b=KsyQCj+6DFHo27ZZ4JCdH5Wd/Lhr1TxKztfoAKm3w/XCuT/kA+e9B4FdPAxybjPvQ9GTsocw5TOqM3FiRBrnbIlZ/c3dnzBDdk21GAr2/2rFwSkUZBn3yAzXhnbi2kKq7ybhrtaytpuzfME0/pMWPt/kH1XWPFEXaYdfo4lfx2rQJNTmdH3rtbhBRF5t8EjgtkzxCi7jdWtZgA9Syyc9nONAwDX+XY2ldDJzqk+EqzaNWqhoo/EnaH/cyoQB/mToPBNCxru1T2HTO1dtAPkyLxj/NGw1HCuIS79CrsiBQxeeoTH3RgRpueF8xqsAsqRYqZxe9jiw9+FP/MKj6bFSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5asMDzHqKaACwKnIWeqeUA6z3j0tfHNb+KJAkzQqKQ=;
 b=GHffESWUa8Vy7HaOb3goyFC/Z9rWRTWyuEAjOU2fWN0J+976xGPX3ByPsgUwb/WnKBHI8yNi1qKyfcm2ILJALXL/hgLFTnOe7Hz6jaT1JDDNfcm9cca82FFt1bjHUqvVXrKe8MRfRAOu0dA75TNI0xPzR1UuuxgXE4oH29Jp7nCB/7fZ8zAMv52uoD+ml5DAtE1qnd8oSAZvi+N91/wh8II3y1hhynbe+ZB3ZrN/8zEz15489J9PRgn+uGDsKZ9IQZtLX78lX6+6cAbE/RQYA3LMmL1n/pr+MJNRJ1QitlkQuB61JgqtgGKKm3cFAz2qhvlxuT5R1agyoG7EEaHCxA==
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 10:39:25 +0000
Received: from BN7PEPF000000A8.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::43) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 10:39:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A8.mail.protection.outlook.com (10.167.245.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 10:39:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 02:39:06 -0800
Received: from [10.221.209.237] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 02:39:04 -0800
Message-ID: <ca6bb010-9ddb-4aa9-b26d-3ffee33c315b@nvidia.com>
Date: Tue, 24 Nov 2026 12:39:01 +0200
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/virtio: read migration buffers and f_pos under
 migf->lock
To: Qican Ma <goonsomeway@gmail.com>, <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>
References: <179550684893.38679.618538654837589800@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <179550684893.38679.618538654837589800@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A8:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: e5309de8-d00b-41df-14d9-08df4a173564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261022105027099003|11063799006|56012099006|10067099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	emmGd+6WWU3DN4Wgfso1BsNNqphqsIdPTCfx+E63D6oaqr4V73P7LqIMJv0fuQtmP+n9mWhu43IecxBKIJ8KsmJISXP/pHMqTFGO6PDHK1LmLdUBPSbmjttoscHG4yPAD7EAhjTcmcv4lqecQC9GGpfnXcikJ2pGjaSjyzJEl8EeDISrFMbL7dtv/CS4lvxdsllxuB7f4nmoCZ5QhJ/r+LbNHfrhlEEpYbbp7NcTD80JGy8B/Nd4EFA/w5s8uuW04/coy/tY6oUWH95wo8+xlm4CW+VXsT31tzlfe0LK/wUNFLexQOxt4hUk55owNJmb7m/p0KuyA2FZ6OBgqsrSyl0jHOMc+TpPNA9wD+5SShCgFkJKYHfoJKUDI6FLvi/pi9E+vC5bq9Khlb2L6/eYBb4OBi8JKDlQqnzUh1eqq5KRJMizX08286lxlWe7kQRa5aQo5NsHgoUgqx8WuTSSvj0H9Rf/0mgPntqtKgiqDeB2MvXMh2bXp9IMd4WRGtaDJ+i7uHDtrDsS0I1u1/K60UGpANn8LXdBgaWHKZu/HRX/a9Gt366oCdJ08WnSxqN+9ZPDEs60I+hd3qKFrULUC/I4cJFPoGDf28X57jy8zQ3YTDuhltuJsvlKDca8T90eSna84YyI430+plV3Tlneb2dnIshLzwwBJ+kpeZ8YxVgaRdwoeT5bRXuBZeEhrbqyNMIxsQ+I11Te9rAOS3pR7g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DFce0CGI1RFy/dapVqkmFtKpx+Nu/gVVqTY4xljLMv5V+s6ey4ekK17Xb2+i/JLPWrAIJ89mAin3Ci3rzRLI/vTUD85/5tofMeNRu9H/+ZxIBWXUI67Poch/zvhhML/q1OYJ1pSWznMav3JmSmqyZq0p0E06DRyYoY2mRpluxE7EcAuh0HBxhEWA6sMUoX+GJKgohhJ8I1/X9An5xKydL5KeUGGzcdV/4mzsBjKrbheIM4WIVAqhPXLA0f7Sj4p5YlAucrL/6QH9UlVqbddJFFSxkVukRkxz911SvSroGIcZNTpfFdyMakrmk5CSqBp8hhhnyQTTdHV2qE8QssvTGox0yovEOO75RF0JkQ6GoA8gfvKRy4ou5ybvl+4cVm1xGstNNgFeicn9N9MUxdamN0etK+3xCOq/Wp+/zGLtJDG9LAvbcqNaHdpNKRHyFifF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:39:24.8609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5309de8-d00b-41df-14d9-08df4a173564
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

On 24/11/2026 9:54, Qican Ma wrote:
> virtiovf_resume_write() reads migf->buf and migf->buf_header and checks
> filp->f_pos against vhca_buf->start_pos before taking state_mutex and
> migf->lock. Because virtiovf_pci_resume_device_data() opens the file via
> stream_open(), FMODE_ATOMIC_POS is cleared and concurrent writes through
> duplicated file descriptors are not serialized by f_pos_lock. A racing
> writer in VIRTIOVF_LOAD_STATE_PREP_HEADER_DATA can free and reallocate
> migf->buf_header under migf->lock while another writer still holds the
> stale pointer captured before the lock.
> 
> Move the buffer pointer reads and start_pos check under migf->lock after
> checking VIRTIOVF_MIGF_STATE_ERROR.
> 
> Found with an LLM-assisted code review tool and verified by inspection on
> v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of virtio VF
> live-migration hardware.
> 
> Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qican Ma <goonsomeway@gmail.com>

Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai

> ---
> v2: resend via direct SMTP without line-wrapping corruption in the diff.
> 
>   drivers/vfio/pci/virtio/migrate.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index 4b1e5502f0a..5e47f349511 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -918,8 +918,8 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
>   				     size_t len, loff_t *pos)
>   {
>   	struct virtiovf_migration_file *migf = filp->private_data;
> -	struct virtiovf_data_buffer *vhca_buf = migf->buf;
> -	struct virtiovf_data_buffer *vhca_buf_header = migf->buf_header;
> +	struct virtiovf_data_buffer *vhca_buf;
> +	struct virtiovf_data_buffer *vhca_buf_header;
>   	unsigned int orig_length;
>   	bool has_work = false;
>   	ssize_t done = 0;
> @@ -929,8 +929,6 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
>   		return -ESPIPE;
>   
>   	pos = &filp->f_pos;
> -	if (*pos < vhca_buf->start_pos)
> -		return -EINVAL;
>   
>   	mutex_lock(&migf->virtvdev->state_mutex);
>   	mutex_lock(&migf->lock);
> @@ -939,6 +937,13 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
>   		goto out_unlock;
>   	}
>   
> +	vhca_buf = migf->buf;
> +	vhca_buf_header = migf->buf_header;
> +	if (*pos < vhca_buf->start_pos) {
> +		done = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>   	while (len || has_work) {
>   		has_work = false;
>   		switch (migf->load_state) {

