From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 13:42:06 -0800
Message-ID: <45EF31AE.1070800@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	
	<1173178774.24738.311.camel@localhost.localdomain>	
	<45EDD82F.90204@vmware.com>	
	<1173225182.24738.507.camel@localhost.localdomain>	
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	
	<1173228544.24738.514.camel@localhost.localdomain>	
	<45EE0D10.7070807@vmware.com>	
	<1173230305.24738.529.camel@localhost.localdomain>	
	<45EE1EA3.90803@vmware.com>	
	<1173256666.24738.576.camel@localhost.localdomain>	
	<45EEF966.6060902@goop.org>
	<1173300032.24738.750.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173300032.24738.750.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tglx@linutronix.de
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/07/2007 12:40 PM, Thomas Gleixner wrote:
> Real hardware copes well with relative deltas for the events, even when
> it is match register based. I thought long about the support for
> absolute expiry values in cycles and decided against them to avoid that
> math hackery, which you folks now demand.

First of all, I'm not "demanding" anything. I'm just trying to have a =

technical discussion about the issues.  If it comes out that absolute =

expiry can't be done cleanly, and the cost out weighs the benefit, then =

so be it.  But, what's so wrong about having the discussion?

When you do have match register (or count and compare, whatever you want =

to call it) based timers in real hardware, the relative expiry interface =

in software is a bit suboptimal.  You still have no idea how much time =

has already gone by between the time you calculated the delta and when =

you setup the hardware (you have a pretty good estimate, but can't know =

for sure unless you disable caches and all other sources of =

non-determinate latencies).  So, you will always be a little late in =

your timer firing.  You may argue that no client of clockevents cares =

about this little bit of lateness.  But, it does exist, and can be =

solved with a software interface that talks in terms of absolute expiries.

Perhaps we can't get around the 128-bit math problem, or maybe we can =

think of a clever solution.  If we can't, then maybe fixing the lateness =

is not worth the cost 128-bit math.  But, maybe there is a clean way =

around the 128-bit math and we just need to approach it from another angle.

Dan
