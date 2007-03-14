From: Rik van Riel <riel@redhat.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 16:02:04 -0400
Message-ID: <45F854BC.8020600@redhat.com>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<45F850BF.5030702@redhat.com> <45F8516E.0@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F8516E.0@goop.org>
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
Cc: dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, paulus@au.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, schwidefsky@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Rik van Riel wrote:

>> Steal time allows you to see the difference between a busy
>> system and an overloaded system.
> =

> Sure, the various accounting tools can go into as much detail as you
> want.  I just added stolen time accounting to the xen-pv_ops patchset
> which is equivalent to the xen-unstable stolen time accounting.  Is that
> sufficient for these purposes?

Yes, that works.

-- =

Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
