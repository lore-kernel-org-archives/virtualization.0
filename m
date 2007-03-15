From: Dan Hecht <dhecht@vmware.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Thu, 15 Mar 2007 13:07:36 -0700
Message-ID: <45F9A788.1010008@vmware.com>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<45F85A62.8050001@vmware.com> <45F85BBB.70707@goop.org>
	<45F85F43.9030803@vmware.com> <45F866AF.9060609@goop.org>
	<45F999D4.6080602@vmware.com> <45F9A42D.7090205@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F9A42D.7090205@goop.org>
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

On 03/15/2007 12:53 PM, Jeremy Fitzhardinge wrote:
> Dan Hecht wrote:
>> Available time is defined to be (real_time - stolen_time).  i.e. time
>> in which the vcpu is either running or not ready to run [because it is
>> halted, and nothing is pending]).
> =

> Hm, the Xen definition of stolen time is "time VCPU spent in runnable
> (vs running) or offline state".  If the VCPU was blocked anyway, then
> its never considered to be stolen.  Offline means the VCPU was paused by
> the administrator, or during suspend/resume.
> =

>

Yes, the part in the "i.e." above is describing available time.  So, it =

is essentially is the same definition of stolen time VMI uses:

stolen time     =3D=3D ready to run but not running
available time  =3D=3D running or not ready to run

Basically, a vcpu starts off running (and this time is counted as =

available time).  Eventually, it will either be preempted by the =

hypervisor and descheduled (then this time becomes stolen since the vcpu =

is still ready), or it will decide to halt (then the time remains =

accounted towards available time).  Once the vcpu is halted, then =

eventually something happens and we should deliver a virtual interrupt =

to the vcpu.  The time between that something happening (e.g. host I/O =

completing, an alarm expiring) and the vcpu actually starting to run =

again is accounted as stolen.
