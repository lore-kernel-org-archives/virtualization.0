From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Users of ballooning, please come forth!
Date: Fri, 21 Feb 2014 11:58:09 +1030
Message-ID: <87txbt8dau.fsf@rustcorp.com.au>
References: <20140219144914.GA18487@redhat.com>
	<87bny2befb.fsf@rustcorp.com.au>
	<20140220131706.GB18487@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2916582D
	for <virtualization@lists.linuxfoundation.org>;
	Fri, 21 Feb 2014 02:31:01 +0000 (UTC)
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4EF11FFF6
	for <virtualization@lists.linuxfoundation.org>;
	Fri, 21 Feb 2014 02:31:00 +0000 (UTC)
In-Reply-To: <20140220131706.GB18487@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <alitke@redhat.com>
Cc: msivak@redhat.com, Daniel Kiper <daniel.kiper@oracle.com>, virtualization@lists.linuxfoundation.org, dfediuck@redhat.com, Luiz Capitulino <lcapitulino@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Adam Litke <alitke@redhat.com> writes:
> On 20/02/14 14:53 +1030, Rusty Russell wrote:
>>I think we're headed to the same destination here; the variant which I
>>came up with (and suggested to Daniel and Luiz, CC'd) is similar: the
>>guest self-balloons, giving up pages when it can, but the host sets a
>>ceiling.
>>
>>This way, if the host really needs to set a limit, it can: a disobedient
>>guest will start paging.  But generally, a guest should use its
>>judgement to balloon its own pages as it can (below the ceiling).
>
> It sounds similar but it sounds like you are suggesting one limit
> value and I am suggesting two.  Your ceiling value sounds like a soft
> limit on total guest memory (aka minimum balloon size).  This is the
> more important limit of the two I have suggested.  Do you think it's
> also worthwhile to have a maximum balloon size (floor value) to keep
> the allowable balloon size between two points?

It's a little simpler to have a ceiling only.

And if everyone (guests and host) are feeling like they have plenty of
memory, it's probably best sitting in the host.

1) It can quickly go to a guest if necessary.
2) The host could coalesce/shuffle memory.
3) The host could turn off RAM to save power.

Cheers,
Rusty.
