From: Haneef Syed <Haneef.Syed@lntinfotech.com>
Subject: kvm (on core 2 duo) freezes shortly after startup
Date: Tue, 28 Jul 2009 11:47:43 +0530
Message-ID: <OFEF50E5F7.F2F63D2F-ON65257601.0021F8F6-65257601.002295B3__12796.0963095122$1248762060$gmane$org@lntinfotech.com>
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
To: kvm@vger.kernel.org, kvm-owner@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: haydn.solomon@gmail.com, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Description:
kvm (on core 2 duo) freezes shortly after startup.

Additional info:
* package version(s)
kernel 2.6.21
qemu 0.9.1-1

* config and/or log files etc.
[redhat as guest]
dmesg:
kvm: guest NX capability removed

Steps to reproduce:
modprobe kvm-intel

[redhat]
qemu-kvm -hda new.qcow2 -m 512 -cdrom rhel-server-5.3-i386-dvd.iso -boot d

just after issuing above command, kvm (on core 2 duo) freezes shortly 
after startup, please suggest me on this problem..?

Thanks & Regards, 

Haneef Syed 

"Unless you try to do something beyond what 
  you have already mastered, 
  you will never grow." 


______________________________________________________________________
