Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03535C433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 11:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97F9360E63;
	Mon,  7 Mar 2022 11:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id anb64b8U8riT; Mon,  7 Mar 2022 11:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4C2E60E72;
	Mon,  7 Mar 2022 11:03:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 929C9C0012;
	Mon,  7 Mar 2022 11:03:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 633D6C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50CC781BB2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QVG4YAxdUY-V
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F1248138E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKlQndKpc6XZ/z9opgQKP+3GoXTGgKcZfZnP3SujciF1nDv0RTrbVZj1PIg10TKY93EbCZxbY32UvGfL1J32oMxIVdzNER9maSi56CspY64PAtryAcsvP9++mPqC5V2Bs1uXCF3ePH4NzpT89tQOHuWDN6A82cgMFdQP82nZyVUv/kjzdwSsoMPE2DjcJve0d4LCCwVNpWs3b3LnUatfNEVAfmOoofatR4OOUTwE3kIHSh22l65fnczuLmw7F6gLLtWltsUK1S5v2auPxI5QY3119BsWCOcN2yElb/2Z9YFbvYDCE616ZvaXweRebFgILnvpNaWFqs9gDdV9y6vY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2acC0Y/fUCLbQ7T0HHNQEBe6UGrSTTbIbHvZ/I/7eM=;
 b=PZfnU/KsYsFNOQVrWF/+qs1YqsrJ+rd5oxKjU2MKTKtrxPCJ9OG1IzxP5mfyGEDxV9e3yicnYGgHlWdCKNi1uxT+hakevFvIsjI45wYLK/6vai1N2HR2I+QiK6vXwZYZmWTOfwxYsRoOjiryk9g2ANnWK11eyocv79JVsd3hHsBAQ9QDn6zhalZhF14SodD1N3L+GoK4ELi8KH/WrH7M22SQ9SeUrj2ATsDyIL0Dlr34NIxQKCDf8KoSWVUs/jV+rxtE17CjctfeYCxoIvMqNwYZ6X9Fcs63Eh1efWr74+rrePdVHZpWjZuMTjJ/ioSEPTb8wvm/7XjqWb3M1drdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2acC0Y/fUCLbQ7T0HHNQEBe6UGrSTTbIbHvZ/I/7eM=;
 b=GUYh1Kg+7VX2KeHnyVE5BfHO7f/jt1Mn03qbOdmLv4YtcHlReht9QJOGUvOb9d8Vs7flsbASluoVBwb/NLFUvu/gp2rAwu+JgsqiHF0mo0/VvZo8udGr56lpwbUN8iiG45Km7HorxcnIzQTFhzFmXCfhv37EPLndz1XMh8Sh2ivNv0xyZgHUxIG0n5YAOdkmPPf4VZT5s26nCudzUWYfPv9gALPzQx0Oq4NjZX2vyG7T3JyWB9U4eJesIZp72i7qs/I7UtfSrZKGkZq59qQ+lU3OVkw+SkRyLXhbMHpF7N4lb5DWReTJ8BIFuIRmyXhbv1QNNvKYtHjq3rhNEZ+xNQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN8PR12MB4628.namprd12.prod.outlook.com (2603:10b6:408:a8::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 11:03:06 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8527:54fa:c63d:16b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8527:54fa:c63d:16b%8]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 11:03:06 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "si-wei.liu@oracle.com"
 <si-wei.liu@oracle.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
 "amorenoz@redhat.com" <amorenoz@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>
Subject: RE: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Topic: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Index: AQHYIwtYQuHoqq6wH0ab3gBlI5UWKayz1/YA
Date: Mon, 7 Mar 2022 11:03:06 +0000
Message-ID: <PH0PR12MB5481F6D44451F01814470112DC089@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
In-Reply-To: <20220216080022.56707-2-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35865b1a-591f-48c3-e38d-08da002a0f0e
x-ms-traffictypediagnostic: BN8PR12MB4628:EE_
x-microsoft-antispam-prvs: <BN8PR12MB4628AA5152E8966DB7BAF319DC089@BN8PR12MB4628.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZUJOSB13qMsgmBw8zFmw8OS886gJFKEMXl5cV/M8/WCALIj6WnQQBJKIU5BJIwg8/VNp/6E2NbhKtUmnkFuUM/W4NrcTN2qskwci6uZSCQ6D9jfNaV2rOKKBh/3DHlsCJsa56fT/9tivPq+Nb2pGPz4fgVwUxGDWGzUdpgj2+uKRDcwf5Zv1u9QDphTARUVtz5u+V++xtoHzkN+bxpLaYw4+TTzdxuOWPri159Gqkv095zuJ2z65hVvySS2vtO+KLMhnZKZdHhnIN69lH25h0LGRN5CwaZTQE9aIyRy7gkVqlR0FsTzuq2n0d6XoOuhWbJ0P2Taa/fg2kfTIgqWTLEd2O9gSqkbrkQChsP2+fwp+Eq3QxCH+ImrhfECvcmI91i4XE8XTQWVXMD282zPvVXzoM4D8EU1N/oxTZDRVfjOapsB9gF8qnBYvDGfT211l2IJNmqye5PW7zJmMB7G1Vlq6xtkmO9qW77qyFB6+WK80oSId71FDPMHkp4vTkeJFQewTK3q5HKVt+HQBl1tUzd3HGux0W0kMB8XkikKWULmDWcD6jFO+vB9GKdpWGVyZ9GxnftAfZnfvqC3Zjz11sO/p0702AoVLWH135PLDWInfzSkaV91vp7U5sbUQSyHZdk9C9friWeWA5vmMvQQIU7GWODwag9LlHSH1+PlLlSRaMzRQmiMa86PxsNOecAuWVR2RKzsd19OkHj6SGqRhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(55016003)(71200400001)(38100700002)(7696005)(2906002)(83380400001)(38070700005)(33656002)(5660300002)(76116006)(316002)(26005)(66946007)(66556008)(9686003)(52536014)(8936002)(122000001)(86362001)(186003)(8676002)(110136005)(64756008)(508600001)(66476007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SaL4c77mlM1ri80J1zrBUa1L++sTzsGOSOOd5fOVT5mjPff1ZTRnwh4z5Ml/?=
 =?us-ascii?Q?kkWtm58sh6LnkvgkivBAItUOnabfPuT0SQeW/qC8Owezzani3r7FVOeFbfGS?=
 =?us-ascii?Q?Kkr5kTIRho7ZWQ3S9a8t48LEbU//kpt4SFSjW4xIkitcuhaOy4fNoT12J3SA?=
 =?us-ascii?Q?x+yfF81zLtO2Qj2z7xaNeWVZio7Pwp/+b9u5ZgvLpi6FjxefLF3rmy+cDYY5?=
 =?us-ascii?Q?gRyaMDeSO/SPps0z9fDZLJlPk10uQnJDrfcuwh3+Qh5dzSiDgsUdhqMiMzW5?=
 =?us-ascii?Q?lKAaTUQT7xK5gHvLQ1DUdEZdQBoKUUEwMWfxmFDNxf6pG7j0msHkUXhPbnt3?=
 =?us-ascii?Q?8NY2DurB7yrDC3Blf+ZC7xnyIFgWYfeHY8I07WmWhU4Ht/yZtBSHx8luo06G?=
 =?us-ascii?Q?I+d6vCTJoLqzdYsNO4rAvPV4elKYlsfDXwj2YXR20BHu9O0zyyMwzeRimVB3?=
 =?us-ascii?Q?MO5hRPRoPuz6+jRyK9T1js/jgqo5TEVqI9QPqRyutsup8JiXtnuT+SCGTcw4?=
 =?us-ascii?Q?JfmYAZ7mJXuJcyV7iLRWN+G6wR1feSjLfAi2cWf5hrREQnQYfyBeHl9SQyBY?=
 =?us-ascii?Q?5QL3iDd/QWhHF/hRJKb2XQXkw9PbhN+PcCsJBRh88PbXfUXefymuEfBqxFs8?=
 =?us-ascii?Q?v9YILWsmnGAVFg5opc59KyAcExdx5DNeeAtspHCLao7Gs5cdwoZL4O7DP1V0?=
 =?us-ascii?Q?1HLnjRZku9T42bREQYFWC+E01pzjrz+b4qJhmILNG11MuK+jzbp27ECQnsyi?=
 =?us-ascii?Q?PS1Ti401oA+PIiiFbOgWbzKnRzjmNBVoRuVg2Zb7ASigXR/hdatXfCrMR+zM?=
 =?us-ascii?Q?1sZ+1kIrApMrRDRo0KtIl4Xp+4g65P0CbpMzpjFQEFJiFICJAdnKsCMAXHMO?=
 =?us-ascii?Q?X4yO9uDhfk9EwFmtpjDnxSCyygZwAl7adghzzQQYB0CXoC2+mTh7ncUP/YaE?=
 =?us-ascii?Q?ecTzOcR91hNWv+clzF4q0bfC10Mxhd7GuRt25fygt4V690YGGAoaYSJWQwgQ?=
 =?us-ascii?Q?85N7y8w5JPSEQxAmRdejpffH2fvmrkeKr6ZM5dopIOMlwH+I/ZvMYUiJgpCK?=
 =?us-ascii?Q?y5U0Ivy2/vJkJZRWXHwjsWxfDPqVqrYP1QDXkMA0xk8PfWs2AzisIhyd94Tr?=
 =?us-ascii?Q?ChIWu6VqFhMogysqLQ3oeSn6bVFkXg/nI/Tgf32tmlTB+6FZbK42WrNv3W5S?=
 =?us-ascii?Q?uFNkxUY2RtQXd+8bKF+og2+O5GK96vzMOlT62tRnvOw4DG98SC23CtlGJe/S?=
 =?us-ascii?Q?c0NisgQsPLhLuSiHYZ9BP7GlF4fRoogKAW5dR7ZpEhSqoU+fUGTMpeSmlI2y?=
 =?us-ascii?Q?IM4rZMLM2IvJjYUrsL0FFy1TLA7IUAcRmvS/AiCdeLxiY5MeYxnk8x3EuXFj?=
 =?us-ascii?Q?9XMHlSmc0JzHdJs1MNDPC3w/NuveelsT3iGIU1KBbCwuW/YuQ0n5i1syJmxt?=
 =?us-ascii?Q?cRMVDAPopZUxpIt5AqsdmdMOzwL9PwK50PEeo/Q1lvLRED5nCmWd41iebBxK?=
 =?us-ascii?Q?66QTI7VutmpZtm1sbOxDDMsCc9sgkG2M4yLQOHqHJl6M4V1H4OiImPnalLOY?=
 =?us-ascii?Q?Clw06g4smDg7CoIjmP5mss0tOdrVKs3u7z/jWysCDq18w6lJawI+VpNeMnav?=
 =?us-ascii?Q?NA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35865b1a-591f-48c3-e38d-08da002a0f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 11:03:06.7138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hvmhhm8LzTikocWhaEoC46vjTlijE63UqFnmrlmUJ4tvb455vQdHrGkPVXZMYbtupuP8qUunKeG74JE6ioMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4628
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Eli,

Sorry for my so delayed response.
Please see below. 

> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, February 16, 2022 1:30 PM
> 
> Allows to read vendor statistics of a vdpa device. The specific statistics data is
> received by the upstream driver in the form of an (attribute name, attribute
> value) pairs.
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +			       struct genl_info *info, u32 index) {
> +	int err;
> +
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +		return -EMSGSIZE;
> +
> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info-
> >extack);

There is implicit assumption about placement of netlink attributes, like name1, value1, name2, value2 etc.
Things can break here with such message framing in in place in the future.

Netlink has more generic way for addressing and avoiding above strict placement of fields etc.

A more elegant way in kernel is to use nested and self-describing attributes.
We also want to use standard netlink infra built in iproute2 to parse in generic way.

So please change it do like below.
A bit long response, as it contains a pseudo code example.
(ignored all error checks to keep code short)

overview:
---------------
Each vendor stats entry is a nested entry.
This nested entry contains: 
a. stat name ("rx_desc", "cmpl_desc" etc)
b. value of this variable as u64

All of these individual stats entry are put under a new vstats nested entry.
This enables us to parse and reuse existing netlink interface for nested list of entries.
Such as iproute2 mnl_attr_for_each_nested() API.

pseudo code:
------------------
enum {
	[...]
	VDPA_ATTR_VSTAT_LIST, /* nested, indicating list of vstat entries */
	VDPA_ATTR_VSTAT_ENTRY, /* nested, indiating each vstat entry is self-contained */
	VDPA_ATTR_VSTATS_ENTRY_NAME, /* string of the entry */
	VDPA_ATTRS_VSTATS_ENTRY_DATA, /* u64 value of the entry */
	MAX,
}

/**
 * vdpa_vstats_entry_fill - This is an API expose to vendor driver to fill the vendor specific stats
 * A vendor driver should call this in a loop for all the valid vendor statistics entry for the specified queue.
 * A vendor driver should call this API in the get_vendor_vq_stats() callback.
 */
int vdpa_vstats_entry_fill(struct sk_buff *msg, const struct vdpa_vstat_entry *entry, u32 q_index)
{
	/* created a nested attribute in a msg  for this entry */
	vstats_nl_entry = nla_nest_start_noflag(msg, VDPA_ATTR_VSTAT_ENTRY);

	/* now fill value of name + its value in it.
	nla_put_string(msg, VDPA_ATTR_VSTATS_NAME, "string1);
	nla_put_u64_64bit(msg, entry->val.u64);

	/* end this entry nested attribute */
	nla_nest_end(msg, vstats_nl_entry);
	return 0;
}
EXPORT_SYMBOL(vdev_vstats_entry_fill);

static int vdpa_vstat_fill(struct sk_buff *msg,
			   const struct vdpa_vstat_entry *vstats, u32 q_index)
{
	int i = 0;
	int ret;

	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_DEV_VSTATS_GET);

	/* put the device name also, so that same routine can work 
	  * for the dumpit too in future for all the queues
	  */
	nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)));

	nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index);

	/* start list type to indicate that we will have list of nested */
	vstats = nla_nest_start_noflag(msg, VDPA_ATTR_VSTAT_LIST);
	
	ret = vdev->config->get_vendor_vq_stats(msg, vdev, q_idx);
	nla_nest_end(msg, vstats);

	genlmsg_end(msg, hdr);
}

iproute2 to leverage mnl_attr_for_each_nested(), like below.

vstats_show(...)
{
	mnl_attr_for_each_nested(cur_attr, nla_param[VDPA_ATTR_VSTAT_LIST]) {
		vdpa_vstat_entry_parse(nl);
}

static vdpa_vstat_entry_parse(struct nlattr *nl)
{
	mnl_attr_parse_nested(nl, cb, nla_value);
	/* get the value of each entry placed by driver */
}

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
