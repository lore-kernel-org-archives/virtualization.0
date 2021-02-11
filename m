Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C293C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 15:11:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81E164EC1
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 15:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81E164EC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3FB4872F9;
	Thu, 11 Feb 2021 15:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUmjb5e0G8+j; Thu, 11 Feb 2021 15:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBE0086F66;
	Thu, 11 Feb 2021 15:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2D64C0174;
	Thu, 11 Feb 2021 15:11:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F618C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C8816EFB5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fb1Lrc2fWJRc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:11:13 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 0B9E16F521; Thu, 11 Feb 2021 15:11:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDB8B6EFB5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 15:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+SaJdNaJQ9W7jtyl74M84XbYP+26mJbkRzkN2ScGrhk2mqgPb5i+76b3lIJjbAOtMJ9tcrpP295bs9a0ZJlLhs0Hmm/BbACjOssEv0VgFDJiMWl5kyzOm3ipuCXbSCD56606Bm6p0pJGWL5vFWJPzSDba3t9+uPSIt0g1+61qSeAfnxGAy7ad/qznqbOMncFZEfGk8VQzlQXnd6sbVcxldl43NKVQORI/w10unxb+AB07JITcrQ9CMhPJnjx+eRwPim7741HTUEAYpwerPje1JOOeHABOh+OqkTZ563ebB6Ai8jIa4gv3wSf7Qe0M464Q9T/WAcy30PO9oC/YX+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWSgv36ooJWwO5uMfLjf4Soy1EyxgizvrYla3eZoyLQ=;
 b=mk7IOz/ndKKDPlSm3j5cC7hCQj2gmcZAXFHGGZz79QB2UDee+cMc7FQ1GgsmFHTw2G/w95GR1jMFnt2Quo9smVcXScc/CSeeXnXdaqn1vJXPqinNu87qvB0L4xOGqOyotSnfGrNMVWvc4SlFSNjjjCsmtidSWxH6GzvFv5rfG+ZHqnWakj8gQn/s6TPKfbcQOftIGizYhso9uT/Uh2xK76ya/w8674ECv3E2wqwi6EYyqwJkXtH4bLq5EKBZePfNJ11owTr5HTxSVp89Htl6TTmze31ELQrZvIl4CDcot1P4DTmbEOCaPgBZT/5KUbhAqHJDIrQD+xQs81OtjTgs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWSgv36ooJWwO5uMfLjf4Soy1EyxgizvrYla3eZoyLQ=;
 b=HCyC8kbhxnYAKbLyj+4qKJ2LOciUockgStA39X2Gis0RmtzLpDmsosr1VNZKpGkdEpoaQq5SiPKqeQq2Ivh/qjWMlQfkTwkdvtaGpKEEzNFZg53IgYz0p6vKFP7Qfel55d2iMwGefMWhLkmGSd/KYu9Kih3BBKMS1coq/YortvM=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DM6PR05MB4137.namprd05.prod.outlook.com (2603:10b6:5:81::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.11; Thu, 11 Feb 2021 15:11:07 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::6d72:f94:9524:f08]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::6d72:f94:9524:f08%4]) with mapi id 15.20.3805.007; Thu, 11 Feb 2021
 15:11:07 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 02/17] af_vsock: separate wait data loop
Thread-Topic: [RFC PATCH v4 02/17] af_vsock: separate wait data loop
Thread-Index: AQHW/WQCwqS0yBcnrEK6IKbM45zX3qpTFHoA
Date: Thu, 11 Feb 2021 15:11:07 +0000
Message-ID: <4094442C-C2A1-49D6-9901-7F3C73FABFC9@vmware.com>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151451.804498-1-arseny.krasnov@kaspersky.com>
In-Reply-To: <20210207151451.804498-1-arseny.krasnov@kaspersky.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kaspersky.com; dkim=none (message not signed)
 header.d=none;kaspersky.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [83.92.5.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec2e6bee-83ed-4807-9375-08d8ce9f41d2
x-ms-traffictypediagnostic: DM6PR05MB4137:
x-microsoft-antispam-prvs: <DM6PR05MB4137055EE9DBC0AD39B894CDDA8C9@DM6PR05MB4137.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uj9DpNr7KUo6sfIY7h2D8kX/DLWbphyqeuV7rON7yD6+XUeOMjQl7G8HGI8M7+mEbKpAtyC76Lu2BHF5x1IDNrXziHcq8y6WX1vix8/7U/rA/hIBfRgMqnrd00QFzfhucx0hgQfbY8hY6ukMM2hGViJbrQ6pQCox+SCYncOBCxGPXMTlEwiIWr8jiSmXQSPFv/M0dTC8WhfI2tkh07BqOsoWvHQhJiFMIsNxfYO4Lt66vIIYfLuaRy9onwzIloSPN++8o3r+bYaOH8mB0X62HziyPB8FEZ0eTUWpJGuZjK6Mz9D8rlCjoqRng4NXhDGdFvemDyqxg8vgYb/6yJAApYGCoOZbkoIUa/G7bMXODLMc/u/ONgP27lfcrlbdlqHyVNugymzOGw7JWwYRy4RO4mjs0UH6vbVK6vgLTr3neYIaL63qo9f0vyTznl1mqInMyOAeN+w5APC4F4l/lx2Tin/Rpgl7VS3q6saBbDsuwOcIglYxU+OarqrX2Xe8p9LWDLNeU6CEebLAVyFpbb/Y4wV1qCYvC3+1SVZuvWcTh7Zo2qKN16TEXo4yBEBAQKiQmMNohnhoWSPHAfv70ZhSiT8HtOOQJw2tvRnEv10fSDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR05MB3452.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(66556008)(64756008)(66476007)(66946007)(66446008)(6512007)(478600001)(26005)(8676002)(6916009)(2616005)(8936002)(316002)(4326008)(7416002)(91956017)(76116006)(5660300002)(86362001)(53546011)(186003)(2906002)(83380400001)(36756003)(54906003)(6486002)(6506007)(71200400001)(33656002)(21314003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vb2fVwirFK9m7/zDeNiHBdzFyurqCC9pKGCl8hOOI9smI9RiBhsKLRTaCsTF?=
 =?us-ascii?Q?zNsKSwtaeSlqfY7e5zuFHXwyO+IB0iynNAr5kwUaGXGSLHHgJ90mIjn7S4+e?=
 =?us-ascii?Q?6n3GLrNWF4Xqq2Qben8oZA954VvYhjTPD+xlSx0zNRkAjUeGYXtq7S9Eghw4?=
 =?us-ascii?Q?e5Zhm+qG9Fz3YdUI0i3tsuZISTZgOU0X5WvE32GbnpIL5cJ6FMvh0u+hmAre?=
 =?us-ascii?Q?hc/LZD4q926dxQxYVVOx1izJ5mBPB+U2PCoU6yha/7K5KZYu61V5xg/MYRKL?=
 =?us-ascii?Q?naZOWGzMDBU7y9SA35z0aArn1j/DlZ2/4/gAyFQT8KCNYbJRaG48Zm2PG46n?=
 =?us-ascii?Q?wIqXr4N5H6AUfQoNmKVyJp+Qy7t8yvsR8Eo4LBHU+XM8UHKY/wpGyF4iqqbQ?=
 =?us-ascii?Q?NL3zRSG6KWQqkRFVtVvJQxXXZvKU/ljSaMa5wxdVo1m6UBaFjJUNvcoC4Zq9?=
 =?us-ascii?Q?DcdTYmsoY/4wSmBp/Bwh2kzmSohU8F8WzjlU7bMB5c4fu3raTCAMVlvCbbFV?=
 =?us-ascii?Q?0LCUImLHjhY9RAkWb+BtRx1qSEBNoqdBX4DgYPCDPMktk2HkH/OmLLpF3GER?=
 =?us-ascii?Q?6GY8KXtnvENqlBUQr1r7tRqpXXrk1rvXO+KAp1D0pR0ITZbO6mNker4IdHkE?=
 =?us-ascii?Q?+IPVkqBxL4Z/T/xDeRVIb6l9B6HgHxywrjlaQ3zCjDJ0YUHmjdFbJc1OL/nW?=
 =?us-ascii?Q?1sqyzxMY+22D0MfDFRXKRfhmDT9OAWRnfgJba1e7709FPOtg+BLn93albc1P?=
 =?us-ascii?Q?XMK7if+d62mrfpc1ldKTrPhvNF6Ag8WwKBH9NViqGkHOyVsqtm6Hz/S4XfYc?=
 =?us-ascii?Q?Z+D4PAEtys3ZIYmqholuHgdK88xWxiq40VNq121NCvAfcoRMDBqAi0vL7vSu?=
 =?us-ascii?Q?Yyp0FETPmQTWyolTrfgw61fxsqXqLIMg3HIG/SjMtxj07w/U4IwrSm5iPgUZ?=
 =?us-ascii?Q?8nXz5oq0RLsQoFUu+8tfNBKctCK8sByJpJWtwgw4Y4QZvw9HT+9x71h5teoc?=
 =?us-ascii?Q?Qr6TXh9C/HQqP0FZyaemcQtr2pgGMiFB2uLomy/dBczh9tKnG4Tn1vWUtjnh?=
 =?us-ascii?Q?PNcQ89IRx5S8afQpXqXnT0Iklc7f+j9sJBa7G74t+U5n/sTJficGA1Jmu8h/?=
 =?us-ascii?Q?HaUGtoqBfbfSx2lsUgYNbjSERy8gqS9gDMUuhx6a+1QtWSkUHop4Huth8H5d?=
 =?us-ascii?Q?jqldi05bdG9ODxZZvQSyUy4XEawt2Ezon7UOHfuhZsTsyYHk/zJnD4Ka3fSN?=
 =?us-ascii?Q?NYuZC3Y+M4G3ElfO0GO3GDlQeOi4x/Zx0t+H1xqpTOAVIBrVme6muMNAiUJ2?=
 =?us-ascii?Q?vZvsQsNi5ZjZSdCmURM22Npx?=
x-ms-exchange-transport-forked: True
Content-ID: <A15A07775C85CF43BD670CCB0D4EB204@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2e6bee-83ed-4807-9375-08d8ce9f41d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 15:11:07.1736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZSNAxYHhyj6WqMwyWYmfeZJ4169ljmGpm+1Vr6f0G7rekNY0DMW2WoHb/kiqe2hLK3O2ZmanB+x2Puq8OaHPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4137
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> On 7 Feb 2021, at 16:14, Arseny Krasnov <arseny.krasnov@kaspersky.com> wrote:
> 
> This moves wait loop for data to dedicated function, because later
> it will be used by SEQPACKET data receive loop.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
> net/vmw_vsock/af_vsock.c | 158 +++++++++++++++++++++------------------
> 1 file changed, 86 insertions(+), 72 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f4fabec50650..38927695786f 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1833,6 +1833,71 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return err;
> }
> 
> +static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
> +			   long timeout,
> +			   struct vsock_transport_recv_notify_data *recv_data,
> +			   size_t target)
> +{
> +	const struct vsock_transport *transport;
> +	struct vsock_sock *vsk;
> +	s64 data;
> +	int err;
> +
> +	vsk = vsock_sk(sk);
> +	err = 0;
> +	transport = vsk->transport;
> +	prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
> +
> +	while ((data = vsock_stream_has_data(vsk)) == 0) {
> +		if (sk->sk_err != 0 ||
> +		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> +		    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
> +			goto out;
> +		}
> +
> +		/* Don't wait for non-blocking sockets. */
> +		if (timeout == 0) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +
> +		if (recv_data) {
> +			err = transport->notify_recv_pre_block(vsk, target, recv_data);
> +			if (err < 0)
> +				goto out;
> +		}
> +
> +		release_sock(sk);
> +		timeout = schedule_timeout(timeout);
> +		lock_sock(sk);
> +
> +		if (signal_pending(current)) {
> +			err = sock_intr_errno(timeout);
> +			goto out;
> +		} else if (timeout == 0) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +	}
> +
> +	finish_wait(sk_sleep(sk), wait);
> +
> +	/* Invalid queue pair content. XXX This should
> +	 * be changed to a connection reset in a later
> +	 * change.
> +	 */

Since you are here, could you update this comment to something like:

/* Internal transport error when checking for available
 * data. XXX This should be changed to a connection
 * reset in a later change.
 */

> +	if (data < 0)
> +		return -ENOMEM;
> +
> +	/* Have some data, return. */
> +	if (data)
> +		return data;
> +
> +out:
> +	finish_wait(sk_sleep(sk), wait);
> +	return err;
> +}

I agree with Stefanos suggestion to get rid of the out: part  and just have the single finish_wait().

> +
> static int
> vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			  int flags)
> @@ -1912,85 +1977,34 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 
> 
> 	while (1) {
> -		s64 ready;
> +		ssize_t read;
> 
> -		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> -		ready = vsock_stream_has_data(vsk);
> -
> -		if (ready == 0) {
> -			if (sk->sk_err != 0 ||
> -			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -			    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
> -				finish_wait(sk_sleep(sk), &wait);
> -				break;
> -			}
> -			/* Don't wait for non-blocking sockets. */
> -			if (timeout == 0) {
> -				err = -EAGAIN;
> -				finish_wait(sk_sleep(sk), &wait);
> -				break;
> -			}
> -
> -			err = transport->notify_recv_pre_block(
> -					vsk, target, &recv_data);
> -			if (err < 0) {
> -				finish_wait(sk_sleep(sk), &wait);
> -				break;
> -			}
> -			release_sock(sk);
> -			timeout = schedule_timeout(timeout);
> -			lock_sock(sk);
> -
> -			if (signal_pending(current)) {
> -				err = sock_intr_errno(timeout);
> -				finish_wait(sk_sleep(sk), &wait);
> -				break;
> -			} else if (timeout == 0) {
> -				err = -EAGAIN;
> -				finish_wait(sk_sleep(sk), &wait);
> -				break;
> -			}
> -		} else {
> -			ssize_t read;
> +		err = vsock_wait_data(sk, &wait, timeout, &recv_data, target);
> +		if (err <= 0)
> +			break;

There is a small change in the behaviour here if vsock_stream_has_data(vsk)
returned something < 0. Since you just do a break, the err value can be updated
if there is an sk->sk_err, a receive shutdown has been performed or data has
already been copied. That should be ok, though.

> -			finish_wait(sk_sleep(sk), &wait);
> -
> -			if (ready < 0) {
> -				/* Invalid queue pair content. XXX This should
> -				* be changed to a connection reset in a later
> -				* change.
> -				*/
> -
> -				err = -ENOMEM;
> -				goto out;
> -			}
> -
> -			err = transport->notify_recv_pre_dequeue(
> -					vsk, target, &recv_data);
> -			if (err < 0)
> -				break;
> +		err = transport->notify_recv_pre_dequeue(vsk, target,
> +							 &recv_data);
> +		if (err < 0)
> +			break;
> 
> -			read = transport->stream_dequeue(
> -					vsk, msg,
> -					len - copied, flags);
> -			if (read < 0) {
> -				err = -ENOMEM;
> -				break;
> -			}
> +		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
> +		if (read < 0) {
> +			err = -ENOMEM;
> +			break;
> +		}
> 
> -			copied += read;
> +		copied += read;
> 
> -			err = transport->notify_recv_post_dequeue(
> -					vsk, target, read,
> -					!(flags & MSG_PEEK), &recv_data);
> -			if (err < 0)
> -				goto out;
> +		err = transport->notify_recv_post_dequeue(vsk, target, read,
> +						!(flags & MSG_PEEK), &recv_data);
> +		if (err < 0)
> +			goto out;
> 
> -			if (read >= target || flags & MSG_PEEK)
> -				break;
> +		if (read >= target || flags & MSG_PEEK)
> +			break;
> 
> -			target -= read;
> -		}
> +		target -= read;
> 	}
> 
> 	if (sk->sk_err)
> -- 
> 2.25.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
