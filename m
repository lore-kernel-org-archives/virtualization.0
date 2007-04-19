From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Thu, 19 Apr 2007 14:35:21 -0700
Message-ID: <4627E099.209@goop.org>
References: <20070414204154.871250608@goop.org>
	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>
	<200704192304.01053.ak@suse.de> <4627DB0C.2010804@zytor.com>
	<4627DDAD.4070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4627DDAD.4070805@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Chuck Ebbert wrote:
> H. Peter Anvin wrote:
>   
>> Andi Kleen wrote:
>>     
>>> Then we would have seen reports surely?
>>>       

Yes, I would have thought so.  It surprised me that such an obvious bug
could be there, apparently for a long time.  But it's real, and
potentially affects everyone.  It probably doesn't affect highly modular
distros much, since the kernel itself will be relatively small.

> I never saw a description of the symptoms of encountering this bug.
> Does it just hang, or what?
>   

You get an early-fault message on-screen, assuming that's enabled;
otherwise it will just appear to hang.  It happens in pagetable_init,
when it allocates a new pagetable above the head.S mapping (8M in my
case).  It will only hit if the kernel size approaches a 4M boundary,
since it won't leave enough space mapped to construct the lowmem mappings.

It only affects native booting, since under Xen all those mappings have
already been constructed.  It happened to me with a paravirt kernel that
happened to Xen compiled into it, but that was irrelevent (though
misleading; the 40k difference in kernel size was enough to make it not
happen in a non-Xen kernel).

    J
