From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: IO APIC emulation failure with qemu-kvm
Date: Fri, 4 Feb 2011 19:05:17 +0530
Message-ID: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT__10901.666180189$1296826863$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,
 I'm Initializing the Local and IO APIC for a propeitary operating
system running in Virtualized Environment  .
 Im facing some problem with qemu-kvm  but the code runs fine with qemu.
 when i run my kernel image with qemu-kvm it gives emulation error failure
trying to execute the code outside ROM or RAM at fec00000(IO APIC base address)
but the same code runs fine with qemu. can anyone please point me
where might be the problem or how to find out this one?
Warm Regards,
Ravi Kulkarni.
