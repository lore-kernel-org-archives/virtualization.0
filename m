Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A373FC7EE23
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 07:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24620817A5;
	Thu,  1 Jun 2023 07:58:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24620817A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NUgl_6YozYI; Thu,  1 Jun 2023 07:58:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F852814B8;
	Thu,  1 Jun 2023 07:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F852814B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF76C007A;
	Thu,  1 Jun 2023 07:58:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CEDAC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14775610BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:58:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14775610BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nvmn4h8qivKJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D335960C05
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D335960C05
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:58:50 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1q4dCh-00013e-Hr; Thu, 01 Jun 2023 09:58:39 +0200
Message-ID: <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
Date: Thu, 1 Jun 2023 09:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To: Christian Brauner <brauner@kernel.org>,
 Mike Christie <michael.christie@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
In-Reply-To: <20230519-vormittag-dschungel-83607e9d2255@brauner>
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1685606330;9b4b6e38;
X-HE-SMSGID: 1q4dCh-00013e-Hr
Cc: axboe@kernel.dk,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, oleg@redhat.com,
 nicolas.dichtel@6wind.com
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

On 19.05.23 14:15, Christian Brauner wrote:
> On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
>> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
>>> This patch allows the vhost and vhost_task code to use CLONE_THREAD,
>>> CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
>>> normal testing, haven't coverted vsock and vdpa, and I know you guys
>>> will not like the first patch. However, I think it better shows what
>>
>> Just to summarize the core idea behind my proposal is that no signal
>> handling changes are needed unless there's a bug in the current way
>> io_uring workers already work. All that should be needed is
>> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
[...]
>> So it feels like this should be achievable by adding a callback to
>> struct vhost_worker that get's called when vhost_worker() gets SIGKILL
>> and that all the users of vhost workers are forced to implement.
>>
>> Yes, it is more work but I think that's the right thing to do and not to
>> complicate our signal handling.
>>
>> Worst case if this can't be done fast enough we'll have to revert the
>> vhost parts. I think the user worker parts are mostly sane and are
> 
> As mentioned, if we can't settle this cleanly before -rc4 we should
> revert the vhost parts unless Linus wants to have it earlier.

Meanwhile -rc5 is just a few days away and there are still a lot of
discussions in the patch-set proposed to address the issues[1]. Which is
kinda great (albeit also why I haven't given it a spin yet), but on the
other hand makes we wonder:

Is it maybe time to revert the vhost parts for 6.4 and try again next cycle?

[1]
https://lore.kernel.org/all/20230522025124.5863-1-michael.christie@oracle.com/

Ciao, Thorsten "not sure if I'm asking because I'm affected, or because
it's my duty as regression tracker" Leemhuis
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
