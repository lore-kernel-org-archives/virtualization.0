Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402ACC7EE23
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 18:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B928F41889;
	Thu, 18 May 2023 18:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B928F41889
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYPK6eCt6JDX; Thu, 18 May 2023 18:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB1A542834;
	Thu, 18 May 2023 18:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB1A542834
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A307C0036;
	Thu, 18 May 2023 18:38:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF190C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86FF742761
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86FF742761
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0H4X5mFVYfT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:38:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9123C41FF6
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9123C41FF6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 18:38:39 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:38250)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pziWL-00DkSF-Ep; Thu, 18 May 2023 12:38:37 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41956
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pziWK-00DKMU-8V; Thu, 18 May 2023 12:38:37 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-6-michael.christie@oracle.com>
 <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
 <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com>
Date: Thu, 18 May 2023 13:38:29 -0500
In-Reply-To: <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com> (Mike
 Christie's message of "Thu, 18 May 2023 10:03:32 -0500")
Message-ID: <87ttw9fpsq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1pziWK-00DKMU-8V; ; ;
 mid=<87ttw9fpsq.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1/dXqWsNhfo08htcPvm8Hc3O6X+eIhc/TM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 5/8] vhost: Add callback that stops new work and
 waits on running ones
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: axboe@kernel.dk, Christian Brauner <brauner@kernel.org>, mst@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, linux@leemhuis.info,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

Mike Christie <michael.christie@oracle.com> writes:

> On 5/18/23 9:18 AM, Christian Brauner wrote:
>>> @@ -352,12 +353,13 @@ static int vhost_worker(void *data)
>>>  		if (!node) {
>>>  			schedule();
>>>  			/*
>>> -			 * When we get a SIGKILL our release function will
>>> -			 * be called. That will stop new IOs from being queued
>>> -			 * and check for outstanding cmd responses. It will then
>>> -			 * call vhost_task_stop to exit us.
>>> +			 * When we get a SIGKILL we kick off a work to
>>> +			 * run the driver's helper to stop new work and
>>> +			 * handle completions. When they are done they will
>>> +			 * call vhost_task_stop to tell us to exit.
>>>  			 */
>>> -			vhost_task_get_signal();
>>> +			if (vhost_task_get_signal())
>>> +				schedule_work(&dev->destroy_worker);
>>>  		}
>> 
>> I'm pretty sure you still need to actually call exit here. Basically
>> mirror what's done in io_worker_exit() minus the io specific bits.
>
> We do call do_exit(). Once destory_worker has flushed the device and
> all outstanding IO has completed it call vhost_task_stop(). vhost_worker()
> above then breaks out of the loop and returns and vhost_task_fn() does
> do_exit().

I am not certain how you want to structure this but you really should
not call get_signal after it returns positive before you call do_exit.

You are in complete uncharted and untested waters calling get_signal
multiple times, when get_signal figures the proper response is to
call do_exit itself.

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
