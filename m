From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: =?iso-8859-1?q?Re=3A_R=E9f=2E_=3A_Re=3A_=5BPATCH_0/4=5D_Virtual_?=
	=?iso-8859-1?q?Machine_Time_Accounting?=
Date: Tue, 21 Aug 2007 14:46:02 -0300
Message-ID: <5d6222a80708211046xe248cdcw5193a0dc8f4ff0a8__12671.0109915168$1187718478$gmane$org@mail.gmail.com>
References: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843@frec.bull.fr>
	<5d6222a80708201334q27fc6cbcr7ce6a9d7147437a2@mail.gmail.com>
	<46CA9831.4080309@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46CA9831.4080309@bull.net>
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
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 8/21/07, Laurent Vivier <Laurent.Vivier@bull.net> wrote:
> Glauber de Oliveira Costa wrote:
> >> by doing this at kernel level, we can:
> >> - measure exactly the guest time,
> >> - move this part of system time to user time (as you think it should be
> >> user time),
> >> - have consistency between system, user and guest time,
> >> - report values in /proc/state and /proc/<pid>/state, at system wide level
> >>
> >> I'm not sure we can measure the guest time at the qemu user level.
> >>
> >> Perhaps Rusty can say what he thinks about this ?
> >>
> > Even if we cannot _now_, isn't that an easier, and safer change? (and
> > I don't think we lose anything by design).
>
> Could you explain ? How should I do this ?
> I'm _sure_ it is not easier to do that at qemu level.
>
> I don't like to patch kernel (it is the last thing I do to solve a problem: I
> know there is always at least one guy to not agree the patch :-P ) but in this
> case I think this is the best way to do that.
>
> I think the virtualization notion should be introduced at the kernel level, at
> least in the kernel statistics: it is generic, it can be used by other
> virtualization tools. As I said, until know CPUs have got only two states
> reflected in statistics by "user time" and "system time". Since recently, they
> have introduced a third state, the virtual CPU, that, in my opinion, should be
> also reflected in the CPU statistics as the "guest time".

After a second thought on this, you seem to be right.

> >
> > Although I don't know KVM to a that deep level, I think it should be
> > possible to keep the virtual cpus in different process (or threads),
> > and take the accounting time from there. Perfectly possible to know
> > the time we spent running (user time), and the time the hypervisor
> > spent doing things on our behalf (system time).
>
> But we have always user time accounted as system time. CPU stats are wrong if we
> do not modify the kernel. Can you live with wrong statistics ? (yes, I think,
> you can, but perhaps someone else not)
>
No, I can't. Just because I suggested an alternate way (even if it was
wrong), it does not mean I want things to be done wrongly.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
