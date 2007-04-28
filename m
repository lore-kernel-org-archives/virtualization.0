From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 09:24:46 -0600
Message-ID: <m1fy6kfrnl.fsf@ebiederm.dsl.xmission.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<200704281042.48440.ak@suse.de>
	<m1k5vwg8qy.fsf@ebiederm.dsl.xmission.com>
	<200704281137.52460.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281137.52460.ak@suse.de> (Andi Kleen's message of "Sat, 28
	Apr 2007 11:37:52 +0200")
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
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen <ak@suse.de> writes:

> On Saturday 28 April 2007 11:15:33 Eric W. Biederman wrote:
>
> Scary thought. But I don't see why people using embedded x86s should suddenly
> design new interrupt controllers etc. - after all the main value of using x86s
> embedded is some degree of compatibility to PC software.  Ok, we'll see what
> happens.

Right but visws main difference was that it did not run a x86 BIOS
as I recall.  My memory says all of it's hardware was standard.

>> So I think it makes a lot of sense to see if we can fold mach-visws
>> and mach-voyager into appropriate pluggable interfaces.
>
> For voyager and NUMAQ i think it's fine to just wait until the last machine dies
> (James, how many do you have left? @] iirc the number of NUMAQs still in
> operation
> is also slowly decreasing) 

Maybe.  Again if we could convert them along with everything else to
a modern structure it probably would not matter.

I honestly think it is irresponsible to keep code in tree and not at least
try to keep it working.

Eric
