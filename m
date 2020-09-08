Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55138C43461
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E9206A5
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Sq4RSBxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B79C2152A;
	Tue,  8 Sep 2020 17:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Od7MXo8t3t2U; Tue,  8 Sep 2020 17:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0C203204A4;
	Tue,  8 Sep 2020 17:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1297C0859;
	Tue,  8 Sep 2020 17:53:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A75D1C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8B17F87277
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBsrOeF3Czr2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:53:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com
 [148.163.155.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 98E098726C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:53:21 +0000 (UTC)
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 088Hoxon006256; Tue, 8 Sep 2020 10:53:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=koXXIwNSHx1ZEUjyncLcH7GEnDnLa+UYnqwSfQnX1lc=;
 b=Sq4RSBxrzXW42yrFPKOXgA0KSKY+y/QqRwwvOtbIVaUvjzcoE/WWprjX2eksW+hjZzZu
 isp5QwKapOFyyFX6IAlrAjDLK6NeGLrPkZRCMCadB8+3NnbcamsjBxKzmrsux7LZ5+CX
 KlRxJs0e9l+UK1Q3sx0vdtaFDtknneekjiFjBI7wX+lhY7oNcDWswJGhGRUi1CoHJkiJ
 xLmoIN0vlYD5rcctRlrG/BUJhYOYsghz3PI5+u/aBmdGxOElEuXO7OfUpMHcxhNJ36+y
 +YhN6ZnxIYBgHh8K/qlY4WE7EmJZxlRkDc097XJ4PIJ8/JIva/ZDqGnwayu8XrhBdgeE 5w== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
 by mx0b-002c1b01.pphosted.com with ESMTP id 33c879xcp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2020 10:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNk83o1a1RTW/bgU/FMUb70QCKWk9Jsp9F6ibVUn9zKBLjPQBTHZKeUYGedDCwPqDfMbCKdZqus446is6CsLqCGnA9PBnXUnSvXV8Thh01eecZN5xDgD/8tRhrR/PEI380z+pPlN5kz1av7GMX2Q5KZeHbv/8CrtRYVUf6Y8LEFD7Bh+Fm2q48Hsri+EJzOyZCVsHTxJiM/Fj8w+uK9ANaQh/q2ceHfgyjOPWEOyZivS833HWFZeWW5UY6GkdX0nwdChsg9K6x9Ew1O94DzPbyxT4OpWtsXRwFGUal23uO78R3izTmorkqlLAk3+nhpdFvW2+MqbofQ6LPo3fFV1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koXXIwNSHx1ZEUjyncLcH7GEnDnLa+UYnqwSfQnX1lc=;
 b=PZCx/9xfO/hm8OM3pk28BKIMb7rNQept2xvKDJp9LxcwZ00m7OkDcFKV/EONEtjarWyUbJPcmy0ZhWGPy1/gtLLOImg2O7/UeXR1n78DhMvmfSsXBRxecS4OVLHdJ3RIGL+SVFEeaIis+Mjg+ed7S8itxUHzprxHamDB8Dny+rVplAf+GW2tALVZo5dAc3lrAB8CwF4q8o5fuU91XxO9yQZq6S0dNcu/w++7IHAblLlrsJIKOVqvgATBoGpC3jWhdja2GTE/ZsHMC41wCEfvwefB+JFfH8FNYf5uvXAI+iV3ULeZcBxih5B1SDkr9xCjLWiyw6HpZ88TbpKrxgGhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4358.namprd02.prod.outlook.com (2603:10b6:a03:11::17)
 by BYAPR02MB5847.namprd02.prod.outlook.com (2603:10b6:a03:11f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 17:53:17 +0000
Received: from BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::10ac:913c:6898:decd]) by BYAPR02MB4358.namprd02.prod.outlook.com
 ([fe80::10ac:913c:6898:decd%3]) with mapi id 15.20.3305.032; Tue, 8 Sep 2020
 17:53:17 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] Rescan the entire target on transport reset when LUN is 0
Thread-Topic: [PATCH] Rescan the entire target on transport reset when LUN is 0
Thread-Index: AdZ9NZ5vwNLMSE8+SVisPIkQE+RzLgItcvIAAAdguYA=
Date: Tue, 8 Sep 2020 17:53:16 +0000
Message-ID: <CCFAFEBB-8250-4627-B25D-3B9054954C45@nutanix.com>
References: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
 <200ad446-1242-9555-96b6-4fa94ee27ec7@redhat.com>
In-Reply-To: <200ad446-1242-9555-96b6-4fa94ee27ec7@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [82.9.225.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c0e595-523f-417b-3e18-08d8542010c6
x-ms-traffictypediagnostic: BYAPR02MB5847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB58476B89F81EE2A162CCAFC7D7290@BYAPR02MB5847.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8oBDGg2yo4iz3DkhfT2vWRCp8Oagwf0vuH+5yoCtsjbKfdKvMCeo4l39Fb8rOHhkX2XCriFmyeUF9jxXKVeLgVJaRp+3WMm8AQLsXVahemLJjDa2a3WrkfmBE0VrpAJvdptqa20K7WLbAqAvq/N+OUiFpUwgEj+FZLwniMQsT3DBSGJV0/3o4lJhXUKZJDPXn12Rh7r3uW/hSWdp5XTfw3z2lLNX5dW/Dy5x3eEbB8r5oeKNxZ2ZuqrOlUFs/MbTs8yACCBVId+SnETgpiANnBie0iX4Qn52Dpg3u8gCGKCgr+aHI2SzaDB7ywQYWUha8TEVyw0LY/RsLqHnACHMUvge0lcsqic1KLmcIAXv6XWQpM6tUe+mmIFjNwVR1Li7n1dYV4TagdWyJHA8rOHUTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4358.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(53546011)(54906003)(33656002)(6506007)(478600001)(2616005)(8936002)(966005)(6486002)(316002)(7416002)(8676002)(83380400001)(110136005)(186003)(26005)(4326008)(6512007)(64756008)(71200400001)(86362001)(66946007)(5660300002)(2906002)(66476007)(66556008)(66446008)(36756003)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HWf/0jLefwfV2/suSnp0sCThr8QPx+hI+gv0DwkTUueuMGEdaGnd4IjW6DFo9PQqlbkxsrch5epaDHHNU0+TMPZDcyLKWbKgCw8m7p9MIFqGPucBM/QYLdKPfBbotUVz49eunyIuyLEyN50EfiUTEoNThD2wa3wNCKYPik/oA4hfUsNcWm3jbe3G7ibJHqzYe0tdBSGkSK2isvv+ohXS4ZSOsS/qr//A2F96MWpa0m9B3+I7PieEH3sp+rGa4jmYn6KuqBZ3Wifg84Jw2++NiFJf/ry9mj/LlU49BrgfQTDs6ro9gvQ7JTtXRcQir4ldm107C1tW/SkD8poODnzmhJ5Ra1oytwT4a+KcSZ7NhCoTzwVOMDniYP2fwQTLWSHz7CHKDxRuhmTtf6fOrNRwOniD4MBf4f1wHhyyMH6dRiWZwelhbmjl1LwTihJFUK9lrQ99O8U/gwVaBq6JMV7vnmkOWRxV7XB3S//5SC1DoamSx3Yca8YjH/Dbe4X7ogp5wXsb06xELYLGRXKv8BEd7GN1VojPuA0kROklzwiSXDMQZ72e8pF41a6njDTol0wJnRsms8FJfBJb2dGtdtliNXDwoVxIhJE6uM0nOY7JwtlficT4ADettGwobIcIgICJBUu9uZztELemBeB8X4CMqA==
Content-ID: <111E2BF6B540CF429832F4411553C8D4@namprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4358.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c0e595-523f-417b-3e18-08d8542010c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 17:53:16.7820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VauQjLFhF18gT5sYjfva4OWq/By0fakS0Wmbj6RiaNkPP/Coet79hHut+BKpeG/ZWgXoca9t2+yvil0f0jSGx4u0ZweNNktdAlL1RTRZ2pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5847
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-08_09:2020-09-08,
 2020-09-08 signatures=0
X-Proofpoint-Spam-Reason: safe
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Matej Genci <matej.genci@nutanix.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>
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



> On Sep 8, 2020, at 3:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> On 28/08/20 14:21, Matej Genci wrote:
>> VirtIO 1.0 spec says
>>    The removed and rescan events ... when sent for LUN 0, they MAY
>>    apply to the entire target so the driver can ask the initiator
>>    to rescan the target to detect this.
>> 
>> This change introduces the behaviour described above by scanning the
>> entire scsi target when LUN is set to 0. This is both a functional and a
>> performance fix. It aligns the driver with the spec and allows control
>> planes to hotplug targets with large numbers of LUNs without having to
>> request a RESCAN for each one of them.
>> 
>> Signed-off-by: Matej Genci <matej@nutanix.com>
>> Suggested-by: Felipe Franciosi <felipe@nutanix.com>
>> ---
>> drivers/scsi/virtio_scsi.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
>> index bfec84aacd90..a4b9bc7b4b4a 100644
>> --- a/drivers/scsi/virtio_scsi.c
>> +++ b/drivers/scsi/virtio_scsi.c
>> @@ -284,7 +284,12 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>> 
>> 	switch (virtio32_to_cpu(vscsi->vdev, event->reason)) {
>> 	case VIRTIO_SCSI_EVT_RESET_RESCAN:
>> -		scsi_add_device(shost, 0, target, lun);
>> +		if (lun == 0) {
>> +			scsi_scan_target(&shost->shost_gendev, 0, target,
>> +					 SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
>> +		} else {
>> +			scsi_add_device(shost, 0, target, lun);
>> +		}
>> 		break;
>> 	case VIRTIO_SCSI_EVT_RESET_REMOVED:
>> 		sdev = scsi_device_lookup(shost, 0, target, lun);
>> 
> 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Cc: stable@vger.kernel.org

Thanks, Paolo.

I'm Cc'ing stable as I believe this fixes a driver bug where it
doesn't follow the spec. Per commit message, today devices are
required to issue RESCAN events for each LUN behind a target when
hotplugging, or risking the driver not seeing the new LUNs.

Is this enough? Or should we resend after merge per below?
https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

F.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
