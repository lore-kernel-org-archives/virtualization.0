From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Thu, 15 Mar 2007 12:18:40 -0700
Message-ID: <45F99C10.1070500@goop.org>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<45F85A62.8050001@vmware.com> <45F85BBB.70707@goop.org>
	<45F85F43.9030803@vmware.com> <45F866AF.9060609@goop.org>
	<45F999D4.6080602@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F999D4.6080602@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dan Hecht <dhecht@vmware.com>
Cc: dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, paulus@au.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, schwidefsky@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> So, yes, it is per-vcpu.  But, the sched_clock() samples are rebased
> when processes are migrated between runqueues; search sched.c for
> most_recent_timestamp.  It's not perfect since most_recent_timestamp
> between cpu0 and cpu1 do not correspond to the exact same instant, but
> does prevent negative sleep time and is fairly close.

Yes, I noticed that when I looked more carefully, but I wasn't sure
whether it would be sufficient to make it all work out.

    J
