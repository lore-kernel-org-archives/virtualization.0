From: laurent.vivier@bull.net
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_=5BPATCH_0/4=5D_Virtual_Machin?=
 =?iso-8859-1?q?e_Time?=  Accounting
Date: Mon, 20 Aug 2007 19:54:52 +0200
Message-ID: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843__34731.9470406093$1187632350$gmane$org@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Laurent Vivier <Laurent.Vivier@bull.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org


> Laurent Vivier wrote:
> functionnalities:
>
> > - allow to measure time spent by a CPU in a virtual CPU.
> > - allow to display in /proc/state this value by CPU
> > - allow to display in /proc/<pid>/state this value by process
> > - allow KVM to use these 3 previous functionnalities
> >
>
> So, currently time spent in a kvm guest is accumulated as qemu-kvm
> usertime, right?  Given that qemu knows when its running in qemu vs

No, it is accumulated as kvm system time.

> guest context, couldn't it provide the breakdown between user and guest
> time (ditto lguest)?

by doing this at kernel level, we can:
- measure exactly the guest time,
- move this part of system time to user time (as you think it should be
user time),
- have consistency between system, user and guest time,
- report values in /proc/state and /proc/<pid>/state, at system wide level

I'm not sure we can measure the guest time at the qemu user level.

Perhaps Rusty can say what he thinks about this ?

Regards,
Laurent
