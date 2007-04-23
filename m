From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 15:14:33 -0600
Message-ID: <m1mz0yvlmu.fsf@ebiederm.dsl.xmission.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>
	<46284B40.5010106@goop.org> <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org> <462D1CBC.6050405@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D1CBC.6050405@vmware.com> (Zachary Amsden's message of "Mon,
	23 Apr 2007 13:53:16 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden <zach@vmware.com> writes:

>
>>> 2) You must support dynamic re-linking - the kernel has to boot and
>>> use builtin native style operations before switching over to the
>>> virtualized operations.  So you have to have some kind of jettisonable
>>> early binding support.
>>>
>>
>> I don't think there's any particular reason we can't do this very early,
>> at the same time we currently populate paravirt_ops.  I think the idea
>> is that if you do nothing, the calls will all point to the native
>> versions, so if you do the late-paravirtualization (do you still do
>> that?) then you'll get native ops initially.
>>
>
> Yes, we still do late paravirtualization.  My point is that because of that, you
> can't just link once and be done with it - you must relink the paravirt-ops
> later, which is more complex than a one time pre-execution link.

Then if it is causing problems and making the code more complex (and it sounds
like it is) please let's get rid of late paravirtualization.

arch/i386 is in bad enough shape with tons of unnecessary special cases.
We don't need the paravirtualization support adding more.

Eric
