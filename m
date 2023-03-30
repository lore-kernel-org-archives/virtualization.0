Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD21C77B61
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 21:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D70876163C;
	Thu, 30 Mar 2023 21:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D70876163C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=1gNZPNzg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xE8_L1WPzLeJ; Thu, 30 Mar 2023 21:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EB4C60773;
	Thu, 30 Mar 2023 21:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EB4C60773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2462DC0037;
	Thu, 30 Mar 2023 21:49:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79751C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 21:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EF1A41F2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 21:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EF1A41F2B
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=1gNZPNzg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id auwDZfnoIg8t
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 21:49:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EE0241F16
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com
 (mail-westus2azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EE0241F16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 21:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVETcXAx5qbI4AlRsB5QdmJ7uE55on40p+z9LvU/FToCI/EkBu7dQ/K7atJE+rYp3a670CjAbY322qJ787y7mO7MjXha7ZWH+wRPco0z470/4WgA/A1Ke9q65pIRh72HgrbOrVfLuZfE3ZFyU4PZwQDc5Zv8KWfD5iqLSDaG/5mU95F/94n3BFPa/zA6Y0f2caihFkVkDbV/s3tPkPloAw1myg7pOyVdY0KGBrDTfnp7zIYglLQAPZUXdf4ahQpxKJRcaS9CwmhDUITJFzKkcUtOWPx6lQcMOgSjjkHYS8FWLgB4NfWOplE9gh8fBp4Xtk5BzF1WK4QxaptHLXyJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzSfgg5QiGHaZ4BhMDOAFKS8HSIAVGmIcVRIO5rctVE=;
 b=mBvkCf845lzsPShNzvysLGg9tphvYddVPk2BgAWHSNDhCfWqQZUgY5rztcPR+xH5Eyqao6yQQzz5R9cFcn0Yk85U4olKaUIpAaj87kmZZ3N/EQq4bENxLq6W9gxEj/Jaq9xUbgHfjlXPaMkVGZ7/ve1YErWLCqBrUG4FdoFXT8hSF1iDmZCZRhO7ixV4nVfO1ZE5xGTYySB2EOH4l3H8J0jVX7/1woVeJluwPh+E571cD2rlFvzGl53bT2p6D6j8vA9uV2cULhk6rz6CIrKnttgDpbA0vvW4oSu/F841yIF+s8O6XTL9UlP50nTxr8RmvT5qj7ajPDvQAgCifnLZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzSfgg5QiGHaZ4BhMDOAFKS8HSIAVGmIcVRIO5rctVE=;
 b=1gNZPNzgWhvLQutMTJrFMrBroYuZ/hW7bEjtiJ3kr0Iqztdb+buxEE18w3siiNlZ1BQKTt/G+hIApovn8TFeSC3JJTIGyyo5bD5U1rQ8rPx1LvRD9aUfgwsNlrWIAkCz5kFN0SQ9MJVSR0rWlG5JkCSPE3CdDVhGrYHseRKj1Ns=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by SN4PR0501MB3885.namprd05.prod.outlook.com (2603:10b6:803:44::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 21:49:12 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8cb8:9578:d0c0:83d3]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::8cb8:9578:d0c0:83d3%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 21:49:12 +0000
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/4] vsock/vmci: convert VMCI error code to -ENOMEM
 on receive
Thread-Topic: [RFC PATCH v3 2/4] vsock/vmci: convert VMCI error code to
 -ENOMEM on receive
Thread-Index: AQHZY0Sj2XCJ41BR6k66SiCaGaLi868TwxQAgAAZQ4A=
Date: Thu, 30 Mar 2023 21:49:12 +0000
Message-ID: <B95BC5A0-EB56-4921-8FFB-C41CFB7929C5@vmware.com>
References: <4d34fac8-7170-5a3e-5043-42a9f7e4b5b3@sberdevices.ru>
 <9fd06ca5-ace9-251d-34af-aca4db9c3ee0@sberdevices.ru>
In-Reply-To: <9fd06ca5-ace9-251d-34af-aca4db9c3ee0@sberdevices.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|SN4PR0501MB3885:EE_
x-ms-office365-filtering-correlation-id: 0241472e-c164-496a-9c6f-08db3168997e
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 307uygRGKp1UaJZOZHfe0vRRwBgqf/mpIgRtOfd7W0yS34kpcU+trxBl4N3hV+7TPY0YAgzkhQlRTDIDh39ivtP/9vfteSWFzwaEbG3H3fVnTy7liykM6/6LwhII0BL+oh5WpRgEJWMm1hktNpCjLooeEGQOxXSxxKdeJWdUck8WB8K5mjCbt/d2VzjgZebCRsHf8h9J55gA9aq/8fGEWOah1nUjDzA8lLwIXdXZzRP+dl8ckhslqQsnF56sP5m5x8OXmI5oIdmCGvnap/FiTKjWRSCZMG6ingkmdpf4SCc7wA370Ut4uzPYbrqxxpvbsZDwmkmQoXJFtMy6BFS3ou6xm0VxNMRO5SUkDUjrCS91xbr/QfMQtdJwcZKhBx2dgDNBuVkLMlVCU5+Nn+S1AwuELOhWlQKQ0WNTnQ1Z5gFTcyHCGfAxL7vER/832Xrd3Cwl6J+kqaqqr68/BBZ0Y3OpTgI6N8FrmreGH//HweQ03/9m0QX1SgjNk3RRpY7p2drLwY4E0YFG64VH7V+Pi3snFAS9yRzWbGzR3+RgHgEx+BmkMMySMKG8TGwxu560x2awGImOIuyyFkKUUvc/EeDppD/Pmc5JCaqOtLy4cRWYkaNtCrkBon5F2I2cu/ByAQUg0b5H6vu+nfWzd1/xhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(38070700005)(86362001)(7416002)(36756003)(83380400001)(53546011)(33656002)(2616005)(5660300002)(186003)(122000001)(8936002)(2906002)(6512007)(107886003)(6506007)(6486002)(71200400001)(41300700001)(4326008)(6916009)(66946007)(38100700002)(54906003)(316002)(76116006)(64756008)(8676002)(66446008)(478600001)(66476007)(66556008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hff6RxoN0jvfRuPk1WS8cm3OL2lU1TAD0V1/yiiNJysj418BkL3AlmxIl8WG?=
 =?us-ascii?Q?VuVUWFluuU/QtP4fPfHAj7D5xs1gmg5k7LMpPr0nM6a/Sq37pNyZqv4cJjel?=
 =?us-ascii?Q?IGcactGidOCkLuNV1JeONUAloBFXsuR8M9buWWrErYL2s3BI9EG+NdgK4w+j?=
 =?us-ascii?Q?gO/u0rmkFSKpYpfdqR22qeMg5U4HxON8WPMw3BYI/2mQMcQ6v/p36z4iRPGt?=
 =?us-ascii?Q?Wn7OkSfgvDeJpXZr7Dr3VFx0Fo8UwYDyHuO2fqMDf+DiucIU2PBseGlJKYJQ?=
 =?us-ascii?Q?ndghNbK5/nKO8wNevUtNKtx1/MXpPKSvAMatDnfXK9fnsxIQrL2Im43jBtdf?=
 =?us-ascii?Q?zSD8gx3ky1lXlOZ6H8hQqykEIhpSQjfi2xhx/lBp0ytnXR1lQqIE5fWGV483?=
 =?us-ascii?Q?+5HdRh3tv2arEnoUooJM/E27gFSXhpYG07WzY4kd8q19Spgz6/a5Gcrk4hfK?=
 =?us-ascii?Q?BJBcIuLPKGlGvg8MUSX1oYN25DjE6JNiQV47HOiq/0RMXPljbkOUVRb8dpsv?=
 =?us-ascii?Q?FPlreTC5KPDQtpjiZprAItqUPjspLNmTGZWfqx7OHeDYUW1qYKwnsjcPyEeX?=
 =?us-ascii?Q?jiy0aBfPxov1Y8o1TTxFooohucQspTMtXCOvxu/DG/8OpxfDsHQPxx+66YyE?=
 =?us-ascii?Q?aH83gq72Fy4RIroK9n6fpHa3ykbxBI8B64VmK9UkOua1N6/zNDd2TOGaH4lv?=
 =?us-ascii?Q?ZI6VK84k9DZ5FAvEloin50nqzhWUHMuKubddh6SUrtDZnjnHa2ODqC+E4XQN?=
 =?us-ascii?Q?H7Idd8WIGLokIxxzPtWV1YAn7VfJyWmGsNDhyjSGN+GGt7i7Y0Z5+XDFMg5l?=
 =?us-ascii?Q?jBnddKxqdZO18bmHZp4zwQhHmncVxg+UuOqaGlENdoQfVS4Xlz7hUQQM3nB4?=
 =?us-ascii?Q?AS/xeRH5Nx8kTcTDdJ11qxH9vNC5vSW4+bUTJ3926ZByJ5ZITyU1CDQGOW1p?=
 =?us-ascii?Q?Ztw2GdaBLMPZ406K4oeYPp0S7ji1B57e5mSTcfOifAlY8YHaU/zj8hNmNftq?=
 =?us-ascii?Q?HAN6GUWJUxzYkIZ80oDFKeijgGnonVm0M2JCwFBUzNQwY2aEWLL2bM5esX0x?=
 =?us-ascii?Q?wSoCydq+YUKUNg1C5/+X4OyMbWdX7rWUI7I52l8Vqj3gBtJ9PxAjNnjm/P9O?=
 =?us-ascii?Q?N1Lnewqm72k+0mDW+N2CP4NvuJUCYQHuY4o2WGpIgpAYKyFZZtpzrIBhG9we?=
 =?us-ascii?Q?YhuP8UEbDHOuw6wNbQiGryTtrey9DTf4NdwhuD9+NN9yTBoMhnq2dE6nb2d9?=
 =?us-ascii?Q?L6Q0VQgP/KsSLjc5xSz9gVSeDwkNPmiepRewzM/TTnkhxg6dHH8bKx5jgfFe?=
 =?us-ascii?Q?2OePr9/XU3721mxtP6+ANR0dWS15vyi65y2u6HlxiQA3YuqngFWwW4jYR/8Z?=
 =?us-ascii?Q?aT9EragZzHbIALf15zH0eNdg2dtUWldK171lE1SsaGekvwRqOJmGQb3iHDEO?=
 =?us-ascii?Q?cJwe6waGUtJb7UDHSlTsKlST1A19DJ9DPK6Cdj4Fes7qxEsHg+jCoBt8wo4W?=
 =?us-ascii?Q?HmGX04Yx9EA0F/GWvclEVd9/pscN4vhWnsdmq8Q6RymtkIFeQTl8yM7H7Rbx?=
 =?us-ascii?Q?D1bgolC+F/ERzYcLoM9ruCD7Yn2IBOBw8Or9fJU/FgKi7kihV3dEmNifN/GC?=
 =?us-ascii?Q?b+2+C3SCqB6j/7/7454II4mPkh4nmggTLTFfxN3jTYxL?=
Content-ID: <498EA72511E78B44B30020065927A9BB@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0241472e-c164-496a-9c6f-08db3168997e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 21:49:12.4038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUfRSDBZBBWNAFJurx6q5xdoUA6SMr4KAyop6RR+uhLqVBFui+C1RmIKgBsk72Kmb+99pNzqLeL3QBhldx0kfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0501MB3885
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Pv-drivers <Pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>, Bryan Tan <bryantan@vmware.com>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "kernel@sberdevices.ru" <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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
From: Vishnu Dasa via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Vishnu Dasa <vdasa@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> On Mar 30, 2023, at 1:18 PM, Arseniy Krasnov <AVKrasnov@sberdevices.ru> wrote:
> 
> !! External Email
> 
> On 30.03.2023 23:13, Arseniy Krasnov wrote:
>> This adds conversion of VMCI specific error code to general -ENOMEM. It
>> is needed, because af_vsock.c passes error value returned from transport
>> to the user, which does not expect to get VMCI_ERROR_* values.
> 
> @Stefano, I have some doubts about this commit message, as it says "... af_vsock.c
> passes error value returned from transport to the user ...", but this
> behaviour is implemented only in the next patch. Is it ok, if both patches
> are in a single patchset?
> 
> For patch 1 I think it is ok, as it fixes current implementation.
> 
> Thanks, Arseniy
> 
>> 
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Code change looks good to me.  Will let you figure out the commit message
with Stefano. Thanks!

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>

>> ---
>> net/vmw_vsock/vmci_transport.c | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>> index 95cc4d79ba29..b370070194fa 100644
>> --- a/net/vmw_vsock/vmci_transport.c
>> +++ b/net/vmw_vsock/vmci_transport.c
>> @@ -1831,10 +1831,17 @@ static ssize_t vmci_transport_stream_dequeue(
>>      size_t len,
>>      int flags)
>> {
>> +     ssize_t err;
>> +
>>      if (flags & MSG_PEEK)
>> -             return vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
>> +             err = vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
>>      else
>> -             return vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>> +             err = vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>> +
>> +     if (err < 0)
>> +             err = -ENOMEM;
>> +
>> +     return err;
>> }
>> 
>> static ssize_t vmci_transport_stream_enqueue(
> 
> !! External Email: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
