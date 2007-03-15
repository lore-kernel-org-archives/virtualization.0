From: Dan Hecht <dhecht@vmware.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Thu, 15 Mar 2007 13:35:41 -0700
Message-ID: <45F9AE1D.7080203@vmware.com>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<45F85A62.8050001@vmware.com> <45F85BBB.70707@goop.org>
	<45F85F43.9030803@vmware.com> <45F866AF.9060609@goop.org>
	<45F999D4.6080602@vmware.com> <45F9A42D.7090205@goop.org>
	<45F9A788.1010008@vmware.com> <45F9A93A.2030400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F9A93A.2030400@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rik van Riel <riel@redhat.com>
Cc: dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, paulus@au.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, schwidefsky@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 03/15/2007 01:14 PM, Rik van Riel wrote:
> Dan Hecht wrote:
> =

>> Yes, the part in the "i.e." above is describing available time.  So, =

>> it is essentially is the same definition of stolen time VMI uses:
> =

>> stolen time     =3D=3D ready to run but not running
>> available time  =3D=3D running or not ready to run
> =

> S390 too.  We were quite careful to make sure that steal time
> means the same on the different platforms when the code was
> introduced.
> =


The S390 folks should correct me if I'm mistaken, but I think S390 works =

a bit differently.  I don't think their "steal clock" will differentiate =

between idle time and stolen time (since it's implemented as a hardware =

clock that counts the time a particular vcpu context is executing on the =

pcpu).  So they need the kernel to differentiate between really stolen =

time and just idle time.  At least, I assume this is why =

account_steal_time() can then sometimes account steal time towards idle, =

and looking at arch/s390/kernel/vtime.c seems to indicate this.

In the Xen and VMI case, the hypervisor differentiates between stolen =

and idle time, which is why we use the hack to call into =

account_steal_time with NULL tsk (so that all of steal gets accounted to =

stolen, even if the idle task happened to be current).  This allows us =

to account stolen time that happened on the tail end of an idle period.
