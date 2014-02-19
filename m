From: Adam Litke <alitke@redhat.com>
Subject: Re: Users of ballooning, please come forth!
Date: Wed, 19 Feb 2014 09:49:14 -0500
Message-ID: <20140219144914.GA18487@redhat.com>
References: <8761om2no9.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3DEFC681
	for <virtualization@lists.linuxfoundation.org>;
	Wed, 19 Feb 2014 14:49:22 +0000 (UTC)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CB7661FB21
	for <virtualization@lists.linuxfoundation.org>;
	Wed, 19 Feb 2014 14:49:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8761om2no9.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: msivak@redhat.com, virtualization@lists.linuxfoundation.org, dfediuck@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> On Tue Feb 11 06:01:10 UTC 2014, Rusty Russell wrote:
> Hi all!
> 
>         We're debating the design of the balloon for the OASIS spec.
> Noone likes the current one, but there are fundamental usage pattern
> questions which we're fumbling with.
> 
> So if you know anyone who is using it in production?  If, so, how?  In
> particular, would you be happy with guests simply giving the host back
> whatever memory they can spare (as Xen's self-balloon does)?  Or do
> you
> require the host-forcing approach?  Comment or email please!

Hi Rusty,

I do not maintain any production setups but I have played with
ballooning (especially automatic ballooning) for quite some time now.
Most recently, I am working with the oVirt project [1] to enable
memory over-commitment and offer SLAs around VM memory usage.

To address the question about whether the Xen self-balloon approach
would be enough...  I think a guest-driven approach such as this would
work very well in self-hosted/private cloud deployments where a single
entity owns all of the virtual machines that are sharing memory.  As
soon as you move to a "public" cloud environment where multiple
customers are sharing a single host then you will need a "bad cop" to
enforce some limits.  (Yes I know ballooning always requires guest
cooperation, but when you combine it with punative cgroups on the host
the guest has a compelling reason to cooperate.)  When I say "bad
cop", I mean a completely host-controlled balloon as we currently do
in oVirt with the Memory Overcommitment Manager [2].  This allows
customers to expect a certain minimum amount of performance.

In order to support both modes of operation (at the same time) how
about supporting two virtio configuration variables in the balloon
driver: auto_min and auto_max.  These variables would allow the host
to restrict the range in which the auto-balloon algorithm may operate.
Setting both to 0 would disable auto-ballooning and require all
inflate/deflate commands to come from the host.  I think there are
some very interesting possibilities how auto-balloon can be combined
with host directed ballooning to yield good results in a variety of
configurations [3].

[1] http://www.ovirt.org/Home
[2] http://www.ovirt.org/MoM

[3] While composing this email I thought of an idea for making limited
use of auto-balloon in a public cloud environment to provide the host
with a memory stress heuristic for guests.  In this scenario, auto_min
and auto_max would be zero (most of the time) and ballooning would be
controlled by MOM.  Occasionally, auto_min and auto_max would be set
to values slightly above and below the current balloon size.  MOM
would then observe the change in balloon size to gauge whether the
guest currently has a memory surplus or deficit.

-- 
Adam Litke
