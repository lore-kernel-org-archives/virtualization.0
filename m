Return-Path: <SRS0=Cini=I5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF6C433C1
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 09:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8426B6198F
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 09:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8426B6198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36195607B2;
	Wed, 31 Mar 2021 09:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9G3-5llBeEi; Wed, 31 Mar 2021 09:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEF13606AE;
	Wed, 31 Mar 2021 09:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90093C000B;
	Wed, 31 Mar 2021 09:26:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F919C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 09:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35EE084811
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 09:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDBWrBOL4-2N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 09:26:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E29FA84810
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 09:26:56 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V9Ov1P189484;
 Wed, 31 Mar 2021 09:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KPySmHLqAP61MyIasZoJ5OyxdVnPRXNfupUZxb+81o4=;
 b=CNdULtE6FqBc1YNYMuecY1hB4+Y+Egnrln6yDmvtd7+uCZD2hxu+6kYad9UAJV196U0I
 WImipTF6nRHSHNksC77MniLcPIJ/VHI+6Kg2I3gVkwuBbML8ujXC/3RjF4fFWkZGi/ZY
 shWoHk2FxL7uIoYuoxIL7d8mAK5RcK59ysBgkQ4qyxXBxxYpuAFi1+P5JCY8//MI8JtU
 Uyfu4iVZreoOezdTkZuQfoshBWlGhvLiQbHBXJI1/IoqAmvgujegOu3P0WO2KQHYsYsT
 HjqiSXvF7xdGcEZWN1KuGJRla2F/sQxQ3iCcFh6VtXR8cHDl/HwksIFGsiAuiQo135uJ QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 37mafv1k9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 09:26:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V9JcZT067590;
 Wed, 31 Mar 2021 09:26:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 37mabp6beh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Mar 2021 09:26:43 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12V9Qa8G007579;
 Wed, 31 Mar 2021 09:26:36 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 31 Mar 2021 02:26:36 -0700
Date: Wed, 31 Mar 2021 12:26:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v6 01/10] file: Export receive_fd() to modules
Message-ID: <20210331092624.GI2088@kadam>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-2-xieyongji@bytedance.com>
 <20210331091545.lr572rwpyvrnji3w@wittgenstein>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331091545.lr572rwpyvrnji3w@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310068
X-Proofpoint-ORIG-GUID: YHYYseNx9ByGLpeYrfNz0NmGPzPCiw_B
X-Proofpoint-GUID: YHYYseNx9ByGLpeYrfNz0NmGPzPCiw_B
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310068
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, christian.brauner@canonical.com,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

On Wed, Mar 31, 2021 at 11:15:45AM +0200, Christian Brauner wrote:
> On Wed, Mar 31, 2021 at 04:05:10PM +0800, Xie Yongji wrote:
> > Export receive_fd() so that some modules can use
> > it to pass file descriptor between processes without
> > missing any security stuffs.
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> 
> Yeah, as I said in the other mail I'd be comfortable with exposing just
> this variant of the helper.
> Maybe this should be a separate patch bundled together with Christoph's
> patch to split parts of receive_fd() into a separate helper.
> This would also allow us to simplify a few other codepaths in drivers as
> well btw. I just took a hasty stab at two of them:
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56a..3c716bf6d84b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3728,8 +3728,9 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
>         int ret = 0;
> 
>         list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
> -               int fd = get_unused_fd_flags(O_CLOEXEC);
> +               int fd = receive_fd(fixup->file, O_CLOEXEC);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Assignment duplicated on the next line.

> 
> +               fd = receive_fd(fixup->file, O_CLOEXEC);
>                 if (fd < 0) {
>                         binder_debug(BINDER_DEBUG_TRANSACTION,
>                                      "failed fd fixup txn %d fd %d\n",

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
