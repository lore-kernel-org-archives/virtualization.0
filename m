From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Stolen and degraded time and schedulers
Date: Fri, 16 Mar 2007 09:38:28 +0100
Message-ID: <20070316083828.GA22168@elte.hu>
References: <1173816769.22180.14.camel@localhost> <45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<20070314203826.GA15394@elte.hu> <45F86247.40109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F86247.40109@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, paulus@au.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, schwidefsky@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> > touching the 'timer tick' is the wrong approach. 'stolen time' only =

> > matters to the /scheduler tick/. So extend the hypervisor interface to =

> > allow the injection of 'virtual' scheduler tick events: via the use of =
a =

> > special clockevents device - do not change clockevents itself.
> =

> I didn't.  I was using sloppy terminology: I hang the stolen time =

> accounting off the Xen timer interrupt routine, just so that it gets =

> run every now and again.

i dont understand: how are you separating 'stolen time' drifts from =

events generated for absolute timeouts?

> I suppose I could explicitly hook stolen time accounting into the =

> scheduler, but its not obvious to me that it's necessary.

right now i dont see any clean way to solve this problem without having =

two clockevents drivers: one for the scheduler, one for timer events.

	Ingo
