From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 03:05:01 -0600
Message-ID: <m1odl8g98i.fsf@ebiederm.dsl.xmission.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<200704281045.11461.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281045.11461.ak@suse.de> (Andi Kleen's message of "Sat, 28
	Apr 2007 10:45:11 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen <ak@suse.de> writes:

>> 
>> I think we should be intercepting this startup call at a higher level,
>> where we can just say:  Start secondary cpu with this stack
>> and with this esp.  Or something like that.
>
> The reason VMI tends to thing lower level is that most of its 
> interfaces are like real hardware and of the code
> would be just copied then if it did high level interfaces.
>
> I suspect this specific hook could only be made better if 
> smpboot.c was refactored into more pieces and callable, but I doubt
> that would be a big overall improvement.

We have to functions do_boot_cpu that does all of the basic
setup.  And wakeup_secondary_cpu that does the arch specific
stuff to setup a cpu.  (That is the current pre paravirt factoring).

Guess what.  Instead of making the hook wakeup_secondary_cpu.
The hook is lost in the guts of one of the implementations of
wakeup_secondary_cpu.   Where the variable it wants t pass
are not even available except as globals.  It's ridiculous.

We should have init_wakeup_secondary_cpu, nmi_wakeup_secondary_cpu,
and vmi_wakeup_secondary_cpu.

Having init_wakeup_secondary_cpu and vmi_wakeup_secondary_cpu
share code looks like a strong false code sharing, and a major code
pain.

Further it skips the early setup in head.S, which is wrong.
Either we need to do it or it needs to be removed from the smp
startup path in head.S

Further because it doesn't expose the difference at the same
place we setup parameters and do something subtle and sneaky
it is very easy to overlook and I suspect it is going to break
just as often as voyager, because it is hard to see that
the dependencies are there.

So yes this is a real problem, and maybe we need to do a little
refactoring to make it better because it doesn't need the initial
boot code page.  But there is no way it is a good long term
solution the way it is.  I doubt it does the correct thing to begin
with.

Eric
