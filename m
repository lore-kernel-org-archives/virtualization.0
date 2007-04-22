From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Sun, 22 Apr 2007 10:31:18 -0700
Message-ID: <462B9BE6.6040302@goop.org>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zamsden@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Doing nothing is a BUG, even before this change.  If you can't patch
> in a properly virtualizable substitute for a non-virtualizable
> sequence, the kernel will not work.  The only way for the patching to
> fail is for lack of space or failure to meet clobber constraints, both
> of which would be fatal even without the patching.

Could you give a specific example?  Because the intent is that if you do
nothing (ie, don't apply patching at all), then you'll just end up with
indirect calls which will be a bit expensive but completely functional. 
The idea is that every time there's a paravirt call, it must be
surrounded with push/pops to make the C call compatible with the
callsite's register usage.  Or are you talking about something else?

> 2) You must support dynamic re-linking - the kernel has to boot and
> use builtin native style operations before switching over to the
> virtualized operations.  So you have to have some kind of jettisonable
> early binding support.

I don't think there's any particular reason we can't do this very early,
at the same time we currently populate paravirt_ops.  I think the idea
is that if you do nothing, the calls will all point to the native
versions, so if you do the late-paravirtualization (do you still do
that?) then you'll get native ops initially.

    J
