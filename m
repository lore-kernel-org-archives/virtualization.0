From: LAPLACE Cyprien <cyprien.laplace@trango-systems.com>
Subject: SMP lockup in virtualized environment
Date: Tue, 24 Apr 2007 19:45:07 +0200
Message-ID: <462E4223.1050109__22264.9704934613$1177436838$gmane$org@trango-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

In a previous mail, Jeremy Fitzhardinge wrote:
> The softlockup watchdog is currently a nuisance in a virtual machine,
> since the whole system could have the CPU stolen from it for a long
> period of time.  While it would be unlikely for a guest domain to be
> denied timer interrupts for over 10s, it could happen and any
> softlockup message would be completely spurious.

I wonder how the guest domain can be denied timer interrupts for such a
long time ? The only reason I see is that the guest domain is not
scheduled at all (host domain or another higher priority guest running).

Now in SMP host and guest, what happens if a guest CPU is not scheduled
for a while ?

An example: in kernel/pid.c:alloc_pid(), if one of the guest CPUs is
descheduled when holding the pidmap_lock, what happens to the other
guest CPUs who want to alloc/free pids ? Are they blocked too ?


-- 
Cyprien Laplace
