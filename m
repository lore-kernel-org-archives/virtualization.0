From: Zachary Amsden <zach@vmware.com>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 18:35:38 -0800
Message-ID: <45EE24FA.7090002@vmware.com>
References: <45ECC076.9050209@goop.org> <45ECC91D.1020809@vmware.com>
	<45ECC9B6.1060209@goop.org> <20070306081909.GA9331@elte.hu>
	<45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu>
	<20070306194612.GG19575@sequoia.sous-sol.org>
	<20070306203018.GA21736@elte.hu>
	<20070306205351.GA10574@sequoia.sous-sol.org>
	<20070306210334.GC26348@elte.hu>
	<20070306212855.GB10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306212855.GB10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> I agree that changing the interface to the low-level platform is tricky
> and less isolated.  But how does the VMI protect you from those changes?
> It simply doesn't, the changes are still necessary.  And the inflexibility
> means the tough corner cases swept under the VMI rug are more difficult
> to debug, get right, etc...
>   =


I actually disagree here.  Yes, it will change over time.  VMI was =

designed to be extensible and flexible - you can omit implementation for =

any calls you don't require, and with consensus, you can add new flags, =

fields, and calls where you need them.  But VMI as it stands today is =

simply not sufficient to support the hypervisors which are here now.  =

There are gaps, particularly with SMP support, which require significant =

changes to either the hypervisors, the kernel, or the VMI itself.  There =

are many reasons these gaps still exist, but most prominently, the big =

reason is that nobody wanted to use a single ABI to interface to the =

hypervisor a year ago when we first proposed the VMI interface as a =

virtualization solution for Linux.  In the end, I see no reason the =

technical issues can't be solved, but the larger questions about the =

future evolution of the interface and also some largely non-technical =

points, valid or not, have stalled the growth which we originally desired.

At this point, the question of whether to pursue a common ABI is no =

longer a technical issue, it's no longer a management or evolutionary =

issue at all.  It's a pragmatic issue about getting code that works into =

Linux today.  It's about working together using what we have as a base, =

which is paravirt-ops, to get working code to users.  We can always =

evolve the code in tree if we find a workable cross-vendor ABI that =

solves everyone's problems.  But that is neither here nor there, because =

it isn't here today.

Zach
