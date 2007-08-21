From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: =?iso-8859-1?q?Re=3A_=5Bkvm-devel=5D_R=E9f=2E_=3A_Re=3A_=5BPATCH?=
	=?iso-8859-1?q?_0/4=5D_Virtual_Machine_Time_Accounting?=
Date: Tue, 21 Aug 2007 14:47:21 -0300
Message-ID: <5d6222a80708211047x1393524j962afc0a02af5ba3__17223.228296689$1187718557$gmane$org@mail.gmail.com>
References: <OF945F7B1F.FF4B4672-ONC125733D.006266E7-C125733D.00626843@frec.bull.fr>
	<5d6222a80708201334q27fc6cbcr7ce6a9d7147437a2@mail.gmail.com>
	<200708211006.42938.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708211006.42938.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, "laurent.vivier@bull.net" <laurent.vivier@bull.net>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/21/07, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Am Montag, 20. August 2007 schrieb Glauber de Oliveira Costa:
> > Although I don't know KVM to a that deep level, I think it should be
> > possible to keep the virtual cpus in different process (or threads),
> > and take the accounting time from there. Perfectly possible to know
> > the time we spent running (user time), and the time the hypervisor
> > spent doing things on our behalf (system time).
>
> I disagree here. First thing, you dont want to have the virtual cpu in a
> different process than the hypervisor control code for that cpu. Otherwise
> communication has to be made via IPC.
> Secondly, Its not qemu/kvm that does the accouting. Its existing userspace
> code like top/snmp agents and clients! etc. that would require additional
> knowledge which thread is guest code.

Yes, the second argument kills me, and I think it leaves no further
room from discussion in my side. Thanks for the enlightenment.

> I personally like the approach Laurent has taken. Maybe it needs some polish
> and maybe we want an account_guest_time function, but in general I think he
> is doing the right thing.
>
Now, me too.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
