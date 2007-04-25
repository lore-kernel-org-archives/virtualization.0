From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
	mappings
Date: Wed, 25 Apr 2007 14:54:08 -0600
Message-ID: <m1abwwqiof.fsf@ebiederm.dsl.xmission.com>
References: <20070414204154.871250608@goop.org>
	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>
	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>
	<4627DDAD.4070805@redhat.com> <4627E099.209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4627E099.209@goop.org> (Jeremy Fitzhardinge's message of "Thu,
	19 Apr 2007 14:35:21 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Chuck Ebbert wrote:
>> H. Peter Anvin wrote:
>>   
>>> Andi Kleen wrote:
>>>     
>>>> Then we would have seen reports surely?
>>>>       
>
> Yes, I would have thought so.  It surprised me that such an obvious bug
> could be there, apparently for a long time.  But it's real, and
> potentially affects everyone.  It probably doesn't affect highly modular
> distros much, since the kernel itself will be relatively small.
>
>> I never saw a description of the symptoms of encountering this bug.
>> Does it just hang, or what?
>>   
>
> You get an early-fault message on-screen, assuming that's enabled;
> otherwise it will just appear to hang.  It happens in pagetable_init,
> when it allocates a new pagetable above the head.S mapping (8M in my
> case).  It will only hit if the kernel size approaches a 4M boundary,
> since it won't leave enough space mapped to construct the lowmem mappings.
>
> It only affects native booting, since under Xen all those mappings have
> already been constructed.  It happened to me with a paravirt kernel that
> happened to Xen compiled into it, but that was irrelevent (though
> misleading; the 40k difference in kernel size was enough to make it not
> happen in a non-Xen kernel).

Jeremy did your kernel have PAE enabled?

It just occurred to me that we have at all of the memory below 1M (say about
512K) mapped and available to setup new mappings.

The only way I can see a page fault happening is if you were using a PAE
enabled kernel (so you were not updating the current page tables) and
you have more than 256M of low memory, and we don't get any much extra
from always mapping 4M at a time.

Eric
