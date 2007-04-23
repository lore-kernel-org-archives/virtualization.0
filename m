From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 10:22:29 -0700
Message-ID: <462CEB55.9070508@zytor.com>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de>
	<4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de>
	<4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com>
	<4627E099.209@goop.org> <m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
	<462CE027.4030302@goop.org> <462CE1E0.9060007@zytor.com>
	<462CE69E.8040207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462CE69E.8040207@goop.org>
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
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> H. Peter Anvin wrote:
>> Since we allocate the maximum possible memory statically, I fail to
>> see how holes could make the situation any worse, or better. 
> 
> No, we map enough space to map 4G (~4 pages), but we don't actually map
> 4G.  If a hole happened to start within that 4 page mapping, then the
> memory still wouldn't be available for allocation.
> 
> I think this is a bit of a spurious argument though, since if it were
> really a problem we'd have to worry about holes hitting the kernel image
> too.  As far as I can see, that's not considered to be a problem.
> 
> I think the real point is that there's currently a subtle dependency
> between head.S and bootmem allocation which happens between start_kernel
> and pagetable_init.  Your patch preventing over-mapping should make them
> easier to smoke out as it currently stands, but eliminating the problem
> by making alloc_bootmem create the mappings for itself does have
> appeal.  There would still be the dependency on head.S to map the kernel
> itself and the bootmem allocator bitmap.
> 

Agreed.  However, saying that your patch shouldn't go into the mainline 
kernel until that has been fixed is spurious and wrong.  It fixes a real 
problem with minimal risk.

	-hpa
