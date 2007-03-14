From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 21:38:26 +0100
Message-ID: <20070314203826.GA15394@elte.hu>
References: <45F6D1D0.6080905@goop.org> <1173816769.22180.14.camel@localhost>
	<45F70A71.9090205@goop.org> <1173821224.1416.24.camel@dwalker1>
	<45F71EA5.2090203@goop.org> <45F74515.7010808@vmware.com>
	<45F77C27.8090604@goop.org> <45F846AB.6060200@vmware.com>
	<45F84E39.7030507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F84E39.7030507@goop.org>
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

> I added stolen time accounting to xen-pv_ops last night.  For Xen, at =

> least, it wasn't hard to fit into the clockevent infrastructure.  I =

> just update the stolen time accounting for each cpu when it gets a =

> timer tick; they seem to get a tick every couple of seconds even when =

> idle.

touching the 'timer tick' is the wrong approach. 'stolen time' only =

matters to the /scheduler tick/. So extend the hypervisor interface to =

allow the injection of 'virtual' scheduler tick events: via the use of a =

special clockevents device - do not change clockevents itself.

	Ingo
