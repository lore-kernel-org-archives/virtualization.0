From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Mon, 20 Aug 2007 09:13:03 -0700
Message-ID: <46C9BD8F.4070807__3907.73896729133$1187626497$gmane$org@goop.org>
References: <46C99371.7070705@bull.net> <18121.39541.790665.686081@stoffel.org>
	<46C9A7AB.1030003@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C9A7AB.1030003@bull.net>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, John Stoffel <john@stoffel.org>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
> functionnalities:
>
> - allow to measure time spent by a CPU in a virtual CPU.
> - allow to display in /proc/state this value by CPU
> - allow to display in /proc/<pid>/state this value by process
> - allow KVM to use these 3 previous functionnalities
>   

So, currently time spent in a kvm guest is accumulated as qemu-kvm
usertime, right?  Given that qemu knows when its running in qemu vs
guest context, couldn't it provide the breakdown between user and guest
time (ditto lguest)?

    J
