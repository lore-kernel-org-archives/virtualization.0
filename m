From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: Users of ballooning, please come forth!
Date: Thu, 20 Feb 2014 08:42:46 -0500
Message-ID: <20140220084246.2b22c0bc@redhat.com>
References: <20140219144914.GA18487@redhat.com>
	<87bny2befb.fsf@rustcorp.com.au>
	<20140220131706.GB18487@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B4C60681
	for <virtualization@lists.linuxfoundation.org>;
	Thu, 20 Feb 2014 13:42:51 +0000 (UTC)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2FBA220195
	for <virtualization@lists.linuxfoundation.org>;
	Thu, 20 Feb 2014 13:42:51 +0000 (UTC)
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
Cc: msivak@redhat.com, Daniel Kiper <daniel.kiper@oracle.com>, dfediuck@redhat.com, virtualization@lists.linuxfoundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 20 Feb 2014 08:17:06 -0500
Adam Litke <alitke@redhat.com> wrote:

> On 20/02/14 14:53 +1030, Rusty Russell wrote:
> >Adam Litke <alitke@redhat.com> writes:
> >>> On Tue Feb 11 06:01:10 UTC 2014, Rusty Russell wrote:
> >>> Hi all!
> >>>
> >>>         We're debating the design of the balloon for the OASIS spec.
> >>> Noone likes the current one, but there are fundamental usage pattern
> >>> questions which we're fumbling with.
> >>>
> >>> So if you know anyone who is using it in production?  If, so, how?  In
> >>> particular, would you be happy with guests simply giving the host back
> >>> whatever memory they can spare (as Xen's self-balloon does)?  Or do
> >>> you
> >>> require the host-forcing approach?  Comment or email please!
> >>
> >> Hi Rusty,
> >>
> >> I do not maintain any production setups but I have played with
> >> ballooning (especially automatic ballooning) for quite some time now.
> >> Most recently, I am working with the oVirt project [1] to enable
> >> memory over-commitment and offer SLAs around VM memory usage.
> >
> >Hi Adam,
> >
> >        Thanks for the comprehensive thoughts.
> >
> >> To address the question about whether the Xen self-balloon approach
> >> would be enough...  I think a guest-driven approach such as this would
> >> work very well in self-hosted/private cloud deployments where a single
> >> entity owns all of the virtual machines that are sharing memory.  As
> >> soon as you move to a "public" cloud environment where multiple
> >> customers are sharing a single host then you will need a "bad cop" to
> >> enforce some limits.  (Yes I know ballooning always requires guest
> >> cooperation, but when you combine it with punative cgroups on the host
> >> the guest has a compelling reason to cooperate.)  When I say "bad
> >> cop", I mean a completely host-controlled balloon as we currently do
> >> in oVirt with the Memory Overcommitment Manager [2].  This allows
> >> customers to expect a certain minimum amount of performance.
> >
> >It's interesting that Dan Magenheimer made the opposite point: that
> >if you're charging customers by the MB of memory, it's easy to get them
> >to balloon themselves.
> 
> Sure, it's all about how the incentives are structured and what the
> workload is.  Some people will insist on having a certain amount of
> memory "reserved" and available immediately.  If you meter memory
> usage you would certainly shift the burden of conservation onto the
> guest and this could be preferred for some customers.
> 
> >
> >> In order to support both modes of operation (at the same time) how
> >> about supporting two virtio configuration variables in the balloon
> >> driver: auto_min and auto_max.  These variables would allow the host
> >> to restrict the range in which the auto-balloon algorithm may operate.
> >> Setting both to 0 would disable auto-ballooning and require all
> >> inflate/deflate commands to come from the host.  I think there are
> >> some very interesting possibilities how auto-balloon can be combined
> >> with host directed ballooning to yield good results in a variety of
> >> configurations [3].
> >
> >I think we're headed to the same destination here; the variant which I
> >came up with (and suggested to Daniel and Luiz, CC'd) is similar: the
> >guest self-balloons, giving up pages when it can, but the host sets a
> >ceiling.
> >
> >This way, if the host really needs to set a limit, it can: a disobedient
> >guest will start paging.  But generally, a guest should use its
> >judgement to balloon its own pages as it can (below the ceiling).
> 
> It sounds similar but it sounds like you are suggesting one limit
> value and I am suggesting two.  Your ceiling value sounds like a soft
> limit on total guest memory (aka minimum balloon size).  This is the
> more important limit of the two I have suggested.  Do you think it's
> also worthwhile to have a maximum balloon size (floor value) to keep
> the allowable balloon size between two points?

I was already planning for everything you asked (QMP commands to
disable/enable automatic ballooning, min and max sizes). I still have to
think a bit how those settings will fit in the guest-led design, but it
it should be fine in principle.
