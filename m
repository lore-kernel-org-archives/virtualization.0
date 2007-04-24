From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: SMP lockup in virtualized environment
Date: Tue, 24 Apr 2007 11:04:15 -0700
Message-ID: <462E469F.6060502__35716.1087719307$1177437966$gmane$org@xensource.com>
References: <462E4223.1050109@trango-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462E4223.1050109@trango-systems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LAPLACE Cyprien <cyprien.laplace@trango-systems.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

LAPLACE Cyprien wrote:
> I wonder how the guest domain can be denied timer interrupts for such a
> long time ? The only reason I see is that the guest domain is not
> scheduled at all (host domain or another higher priority guest running).
>
> Now in SMP host and guest, what happens if a guest CPU is not scheduled
> for a while ?
>   

I think this mostly happens when you're doing an inherently
time-stealing thing, like pausing vcpus or suspend/resume.  But I guess
it could happen with a low-prio domain/vcpu on a busy system.

> An example: in kernel/pid.c:alloc_pid(), if one of the guest CPUs is
> descheduled when holding the pidmap_lock, what happens to the other
> guest CPUs who want to alloc/free pids ? Are they blocked too ?
>   

Yep; its a problem.  If a vcpu holding locks and not running, then
everyone else will be prevented from taking those locks.  If you have a
very busy system, then presumably all the vcpus will be similarly loaded
and the fact that it takes a long time to get locks just means you're
trying to run too many vcpus for your hardware's capacity.

The other problem is if you've got two vcpus sharing one real cpu, and
vcpu A spins while waiting for vcpu B to release a lock, and vcpu B is
waiting for A to get off the physical CPU.  I don't know how often this
is a real problem in practice.

    J
