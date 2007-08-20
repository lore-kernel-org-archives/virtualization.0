From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: =?iso-8859-1?q?Re=3A_R=E9f=2E_=3A_Re=3A_=5BPATCH_0/4=5D_Virtual_?=
	=?iso-8859-1?q?Machine_Time_Accounting?=
Date: Mon, 20 Aug 2007 17:34:49 -0300
Message-ID: <5d6222a80708201334q27fc6cbcr7ce6a9d7147437a2__18740.507370285$1187642213$gmane$org@mail.gmail.com>
References: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843@frec.bull.fr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "laurent.vivier@bull.net" <laurent.vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

> by doing this at kernel level, we can:
> - measure exactly the guest time,
> - move this part of system time to user time (as you think it should be
> user time),
> - have consistency between system, user and guest time,
> - report values in /proc/state and /proc/<pid>/state, at system wide level
>
> I'm not sure we can measure the guest time at the qemu user level.
>
> Perhaps Rusty can say what he thinks about this ?
>
Even if we cannot _now_, isn't that an easier, and safer change? (and
I don't think we lose anything by design).

Although I don't know KVM to a that deep level, I think it should be
possible to keep the virtual cpus in different process (or threads),
and take the accounting time from there. Perfectly possible to know
the time we spent running (user time), and the time the hypervisor
spent doing things on our behalf (system time).

$0.02.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
