From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Tue, 21 Aug 2007 09:30:56 +1000
Message-ID: <1187652656.19435.143.camel__49393.9425833107$1187652803$gmane$org@localhost.localdomain>
References: <46C99371.7070705@bull.net>
	<18121.39541.790665.686081@stoffel.org> <46C9A7AB.1030003@bull.net>
	<46C9BD8F.4070807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C9BD8F.4070807@goop.org>
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

On Mon, 2007-08-20 at 09:13 -0700, Jeremy Fitzhardinge wrote:
> Laurent Vivier wrote:
> > functionnalities:
> >
> > - allow to measure time spent by a CPU in a virtual CPU.
> > - allow to display in /proc/state this value by CPU
> > - allow to display in /proc/<pid>/state this value by process
> > - allow KVM to use these 3 previous functionnalities
> >   
> 
> So, currently time spent in a kvm guest is accumulated as qemu-kvm
> usertime, right?  Given that qemu knows when its running in qemu vs
> guest context, couldn't it provide the breakdown between user and guest
> time (ditto lguest)?

No, unfortunately it's accumulated as system time.

Rusty.
