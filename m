Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DA3C433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 13:26:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE98D20729
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 13:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE98D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 613A3855BE;
	Tue, 26 Jan 2021 13:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLpQ7_XkC5ct; Tue, 26 Jan 2021 13:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A24D1855D7;
	Tue, 26 Jan 2021 13:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B13C1DA7;
	Tue, 26 Jan 2021 13:26:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA821C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A965F86738
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eEEwxre+zZv0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5990086731
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 13:26:15 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601018760001>; Tue, 26 Jan 2021 05:26:14 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 13:26:14 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 13:26:11 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Jan 2021 13:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOmoKT994c9Cx3f9v4LF3A+wqpXmmSba+4FoDln0ERZK/K0sB2ZcDReXqrP6/oGe+lyrlnk2Yci0MJLeej7IeankOnpM8nhUS1m1/KDxlA3Lj1dNEguvz1klUf+48+AGW/4zUYztjy1H0d+3Zu8rXAYvWqRIOEUI/mzcGtlOS6O0p9ZD9lnL1B25SUqelGYM5F7BcdQvgSyYAe7WD8HHCnaCsldP6+TmrXZsn+QJeQh2B62IDkhLOxbpHSdqe9a/q/SBcCNmt9ZL2p9wY4qhds+Xe6EL+RCU1iG5EmT27PcuNFCA6bNZ/ACaQC7NTyDO8qxfB0gg03InEkBOFOW8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pHs0o46eW4a1FM4QtyAwyG1ES7lq5uXSD8gdctxFLQ=;
 b=k+Q4h8b6gS8jp7hBhr6AoiGdGe00KGKR6SG9UAqMO/A5YM0Ialz2teNyTBET6E0qhiPEREoGOOdtvKAsh6V/kgyKY9daLbmpWJpCc+NLNsIn4w4ceYc6FC75qQQpNYrOW4b5nvcdH3H6C5nAoifD95qyoShrBrf8DXMfHyYqZPIdQ8j0lh71PVyqgGNJY3AEJQps3Uif8rD2FZrVseMRE0o2HavaRWOGl/hkVIw46zq32TtViKqevek3mqQ/pjbaidLX1PSb7ePgYsB1j+cmtO4H6EkTwMf/Snkv0gSKD5djNRia3CAvL40bftv0mYxViSS2pyiKha2DQR12cAyfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 13:26:09 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 13:26:09 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH iproute2-next 2/2] vdpa: Add vdpa tool
Thread-Topic: [PATCH iproute2-next 2/2] vdpa: Add vdpa tool
Thread-Index: AQHW8LGLTT19qJhe80mPlaw7nLnuRao5VFaAgACXVYA=
Date: Tue, 26 Jan 2021 13:26:09 +0000
Message-ID: <BY5PR12MB4322CD2FF36716821AB3EB9CDCBC9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210122112654.9593-1-parav@nvidia.com>
 <20210122112654.9593-3-parav@nvidia.com>
 <dc59454f-5e8b-2fce-9837-44808df933d4@gmail.com>
In-Reply-To: <dc59454f-5e8b-2fce-9837-44808df933d4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 498e31ba-abe9-46e3-c230-08d8c1fdf152
x-ms-traffictypediagnostic: BY5PR12MB4819:
x-microsoft-antispam-prvs: <BY5PR12MB48190B4E98CFBA31EBFD83F7DCBC9@BY5PR12MB4819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4dUQbM6uItEMfy7hQAwPqa5afOdURUeZg1Vi7D0aXKOnaYDbUBVaacEZh8FrNO7SRZw8CIgZqIzNjqywzR//std36aulyF4x3UFTPQ8IbSJG1b0V3Mqm9kLzoRN3VCWXha/a54X3SbeiXlhquTeO2mtzSb8PnXu9rWFUvzT+GnPG2p8Gu1AdRLvshhPpCGHo07sNdQz/Izi0fUNGoSFcNrSi9xwLwyL85SC2D3yI5MlXUD0NAVWd8/9b1IXw8PP8UAKAe5wCWOZMQLEths0ysZmbuh5XbEeIJABtHSyohBgBYT+Wwe4luDn4DFI4MafkBlIT0YupACFL75X/3gohZDPuZ0651XYgHbT1gZO2dli3zr3+/tMJ5QvSc9w9G0tzAr3KbET57X+JjkiJsctdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(9686003)(316002)(5660300002)(7696005)(8936002)(71200400001)(33656002)(6506007)(53546011)(110136005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(52536014)(76116006)(2906002)(83380400001)(26005)(55016002)(478600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d3RTbFpQbUdlTnhNanpyaGlBeExOVnhyRUNKSlV1YjVxQkRzd0NySFBOcDkx?=
 =?utf-8?B?RFJpSUNUS1lLZ1hYUWQ3YnN5dmJRajVmR2V6WXZKWTVCYnVvajZpeVlRdTdl?=
 =?utf-8?B?ZUlRQXVZd1preng2WWZ4TzE3L1ptZStGamdXT1NHSGJEM003UHQ0OVRJeHUv?=
 =?utf-8?B?eWRpZENTVzBhZW1ocGdlSlVwTXg3V1NzK2h2a2RFZ0l3UEZQOXRmZkR4OFFy?=
 =?utf-8?B?SkZ3UGplaGFDRFNJakxGd2I3UlZVbUh1V0VJMmUxNGVOOENkQklUZ2t1Mmo1?=
 =?utf-8?B?bWRVZFB2SWpZclNjTEZQbURuZ3JWKzFRVGdXY2p0R2pETXB3N3lnRThzT1lI?=
 =?utf-8?B?RXRPMGEva01CeFBiOXpJSnpaR3Y3N3RmT1RYaExXeDB6aDJSb0hNMExmTFh4?=
 =?utf-8?B?Rlp5SzJ1bTdSVm5pK0NvcWpJN1JxMi9majB4QVhtUjZ4cEM0YUt3M0x5SWFQ?=
 =?utf-8?B?RitoZVZiRW5wUERJRHBJaHdEeWNrcGdqb2dCVW9EZHhKcDFpNlFtZDB3Nk12?=
 =?utf-8?B?YWFIeTFJUUtHNG1YakphSjNPdWl2VjNHTitQQWJnOE1NZzRRMFBmMlUzKzg0?=
 =?utf-8?B?RlNyTEUzWUNtczE2aEgrQlhUcko4OElHL3Y1b3pldFVPbW9LNklDQ1JweGdR?=
 =?utf-8?B?bmhmYno2RVlmcm93eE13UnhVR1RNNTJFSmRtU0t3MENGODZpQTZHbVBHcmFD?=
 =?utf-8?B?NkE0UEN1YVlLQzN1Z3E0SThhOG5HVVc4Q09NZTQ4dnBpTmV4UFhaS2QxZVRN?=
 =?utf-8?B?T1EwcXpVa2EyM0NMdU1IR0cxc0xnNHNsUzlwVUN0OGJMRTJoY0pMbHY3UEJY?=
 =?utf-8?B?SjJNRG11UzlTbVRhRnZ3Mm91dFVRR2ZzS0F2VGJlZHVKa2FBNEhrY3hvWm8y?=
 =?utf-8?B?Z0VFK25XL1V0YmtCVVQ3c2pHKzJkM3MzR0IzcHR5eGNFNUh4RGtXMUNDR0dz?=
 =?utf-8?B?TTNNb01rdVo1TDFSbkQxVFhvSkUvL2toT1RiSjliNng4V1JRcnQrL09MQk5a?=
 =?utf-8?B?bXdyMDRnZXJnUE8vZHhTRE5Sbnk3SnI5UWhDaER0WURVd3NJd09CS0FCVmRN?=
 =?utf-8?B?cDQydE9keStNNTZFQS91dncyNyszSFVpeXUxQ3J3Tjh1bEllcHQ4dk5ZTXJj?=
 =?utf-8?B?QnhCN05ydll3eTZHaGxrMUdydFBsSm1hRW1ZN01DWWZUeEhkNVNVdlFtQ3BC?=
 =?utf-8?B?Q2h5djB4UUY5ZjYwUnBnSG5UamJITXZVcDNCc0lWNDVUN2NEN3ZDYzEydWFR?=
 =?utf-8?B?cnIyWmdYeGpTUVgwbnRDdDBqSW4vRFNCRFo5V3VVQXpEdWl1dXRHcjZ1UG0y?=
 =?utf-8?B?Tk5Za1VSR0FJMXdHUXJKaDduVEM0Vk9wT2JvSmVFbUJ4dkQ1QjRjbXdjeStI?=
 =?utf-8?B?ZHhkOGJQSGVReHBOK0JNT0hHL1JXRzYzN0JkaVhxMmR2T3J4bjhxcCtGdXZF?=
 =?utf-8?Q?anpXdTg5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e31ba-abe9-46e3-c230-08d8c1fdf152
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 13:26:09.1080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIvnsp2oATgPzpM25gstIYUwUaVNfqmKCGSL3SFOLd/tO7Qy0GtrpbPAKYXgFZAsdYmyN1a+mTRlz1vxGkYyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611667575; bh=4pHs0o46eW4a1FM4QtyAwyG1ES7lq5uXSD8gdctxFLQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=A4ofysvhPHrPEzHg/yiE2HC+JKn+sSikaDXdysOvX8MiZduhtbzP9JtgzYQTAzq9H
 wThYXDbF2D9y25Lqso5Q4fCPYZuYrKh4MHvFNNjuxMsO6JgpFOaa/syFZMEAtD+y46
 deV7W+oVlXfucBJylWpDGKuqECAqYzcVH2PDWlsOBKmtoqX4nG2rhow+6QSDNxE//w
 JamtLbdMEmcWBjFmpb++BVh0fA2TPeAS9vnWiEYuUkEJoD4Xv4hUBduUtW9ACilf/C
 r9M5GacrJZu3uXLKH5/fl3xIwzu7cK7URvcjUV9tkXbW/A2lyqkoAPBmAlgaqstKoE
 dEaE3MWcI2Xvg==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: David Ahern <dsahern@gmail.com>
> Sent: Tuesday, January 26, 2021 9:53 AM
> 
> Looks fine. A few comments below around code re-use.
> 
> On 1/22/21 4:26 AM, Parav Pandit wrote:
> > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c new file mode 100644 index
> > 00000000..942524b7
> > --- /dev/null
> > +++ b/vdpa/vdpa.c
> > @@ -0,0 +1,828 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <stdio.h>
> > +#include <getopt.h>
> > +#include <errno.h>
> > +#include <linux/genetlink.h>
> > +#include <linux/vdpa.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/netlink.h>
> > +#include <libmnl/libmnl.h>
> > +#include "mnl_utils.h"
> > +
> > +#include "version.h"
> > +#include "json_print.h"
> > +#include "utils.h"
> > +
> > +static int g_indent_level;
> > +
> > +#define INDENT_STR_STEP 2
> > +#define INDENT_STR_MAXLEN 32
> > +static char g_indent_str[INDENT_STR_MAXLEN + 1] = "";
> 
> The indent code has a lot of parallels with devlink -- including helpers below
> around indent_inc and _dec. Please take a look at how to refactor and re-
> use.
> 
Ok. Devlink has some more convoluted code with next line etc.
But I will see if I can consolidate without changing the devlink's flow/logic.

> > +
> > +struct vdpa_socket {
> > +	struct mnl_socket *nl;
> > +	char *buf;
> > +	uint32_t family;
> > +	unsigned int seq;
> > +};
> > +
> > +static int vdpa_socket_sndrcv(struct vdpa_socket *nlg, const struct
> nlmsghdr *nlh,
> > +			      mnl_cb_t data_cb, void *data) {
> > +	int err;
> > +
> > +	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
> > +	if (err < 0) {
> > +		perror("Failed to send data");
> > +		return -errno;
> > +	}
> > +
> > +	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
> MNL_SOCKET_BUFFER_SIZE,
> > +				   data_cb, data);
> > +	if (err < 0) {
> > +		fprintf(stderr, "vdpa answers: %s\n", strerror(errno));
> > +		return -errno;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int get_family_id_attr_cb(const struct nlattr *attr, void
> > +*data) {
> > +	int type = mnl_attr_get_type(attr);
> > +	const struct nlattr **tb = data;
> > +
> > +	if (mnl_attr_type_valid(attr, CTRL_ATTR_MAX) < 0)
> > +		return MNL_CB_ERROR;
> > +
> > +	if (type == CTRL_ATTR_FAMILY_ID &&
> > +	    mnl_attr_validate(attr, MNL_TYPE_U16) < 0)
> > +		return MNL_CB_ERROR;
> > +	tb[type] = attr;
> > +	return MNL_CB_OK;
> > +}
> > +
> > +static int get_family_id_cb(const struct nlmsghdr *nlh, void *data) {
> > +	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
> > +	struct nlattr *tb[CTRL_ATTR_MAX + 1] = {};
> > +	uint32_t *p_id = data;
> > +
> > +	mnl_attr_parse(nlh, sizeof(*genl), get_family_id_attr_cb, tb);
> > +	if (!tb[CTRL_ATTR_FAMILY_ID])
> > +		return MNL_CB_ERROR;
> > +	*p_id = mnl_attr_get_u16(tb[CTRL_ATTR_FAMILY_ID]);
> > +	return MNL_CB_OK;
> > +}
> > +
> > +static int family_get(struct vdpa_socket *nlg) {
> > +	struct genlmsghdr hdr = {};
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	hdr.cmd = CTRL_CMD_GETFAMILY;
> > +	hdr.version = 0x1;
> > +
> > +	nlh = mnlu_msg_prepare(nlg->buf, GENL_ID_CTRL,
> > +			       NLM_F_REQUEST | NLM_F_ACK,
> > +			       &hdr, sizeof(hdr));
> > +
> > +	mnl_attr_put_strz(nlh, CTRL_ATTR_FAMILY_NAME,
> VDPA_GENL_NAME);
> > +
> > +	err = mnl_socket_sendto(nlg->nl, nlh, nlh->nlmsg_len);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err = mnlu_socket_recv_run(nlg->nl, nlh->nlmsg_seq, nlg->buf,
> > +				   MNL_SOCKET_BUFFER_SIZE,
> > +				   get_family_id_cb, &nlg->family);
> > +	return err;
> > +}
> > +
> > +static int vdpa_socket_open(struct vdpa_socket *nlg) {
> > +	int err;
> > +
> > +	nlg->buf = malloc(MNL_SOCKET_BUFFER_SIZE);
> > +	if (!nlg->buf)
> > +		goto err_buf_alloc;
> > +
> > +	nlg->nl = mnlu_socket_open(NETLINK_GENERIC);
> > +	if (!nlg->nl)
> > +		goto err_socket_open;
> > +
> > +	err = family_get(nlg);
> > +	if (err)
> > +		goto err_socket;
> > +
> > +	return 0;
> > +
> > +err_socket:
> > +	mnl_socket_close(nlg->nl);
> > +err_socket_open:
> > +	free(nlg->buf);
> > +err_buf_alloc:
> > +	return -1;
> > +}
> 
> The above 4 functions duplicate a lot of devlink functionality. Please create a
> helper in lib/mnl_utils.c that can be used in both.
> 
Will do.

> > +
> > +static unsigned int strslashcount(char *str) {
> > +	unsigned int count = 0;
> > +	char *pos = str;
> > +
> > +	while ((pos = strchr(pos, '/'))) {
> > +		count++;
> > +		pos++;
> > +	}
> > +	return count;
> > +}
> 
> you could make that a generic function (e.g., str_char_count) by passing '/' as
> an input.
> 
Yes.

> > +
> > +static int strslashrsplit(char *str, const char **before, const char
> > +**after) {
> > +	char *slash;
> > +
> > +	slash = strrchr(str, '/');
> > +	if (!slash)
> > +		return -EINVAL;
> > +	*slash = '\0';
> > +	*before = str;
> > +	*after = slash + 1;
> > +	return 0;
> > +}
> 
> similarly here. If you start with things like this in lib/utils you make it easier for
> follow on users to find.
> 
Will do.
Thanks for the review.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
