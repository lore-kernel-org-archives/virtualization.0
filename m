From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 00/15] kvm on big iron
Date: Thu, 20 Mar 2008 17:24:30 +0100
Message-ID: <1206030270.6690.51.camel__12059.2726314955$1206030594$gmane$org@cotte.boeblingen.de.ibm.com>
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
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>
Cc: cotte@de.ibm.com, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch series introduces a backend for kvm to run on IBM System z
machines that uses the mainframe's sie virtualization capability. This
work runs 64bit guests on z800/z890/z900/z990/z9/z10 class machines with
a 64bit linux host. Userspace will follow once we're done brushing it
over.

The patch queue consists of the following patches, which can be applied
in sequence on top of kvm.git master as of 2008-03-20 hash g914bd66:
[RFC/PATCH 01/15] preparation: provide hook to enable pgstes in user 
                               pagetable
[RFC/PATCH 02/15] preparation: host memory management changes for s390 
                               kvm
[RFC/PATCH 03/15] preparation: address of the 64bit extint parm in 
                               lowcore
[RFC/PATCH 04/15] preparation: split sysinfo defintions for kvm use
[RFC/PATCH 05/15] kvm-s390: s390 arch backend for the kvm kernel module
[RFC/PATCH 06/15] kvm-s390: sie intercept handling
[RFC/PATCH 07/15] kvm-s390: interrupt subsystem, cpu timer, waitpsw
[RFC/PATCH 08/15] kvm-s390: intercepts for privileged instructions
[RFC/PATCH 09/15] kvm-s390: interprocessor communication via sigp
[RFC/PATCH 10/15] kvm-s390: intercepts for diagnose instructions
[RFC/PATCH 11/15] kvm-s390: add kvm to kconfig on s390
[RFC/PATCH 12/15] kvm-s390: API documentation
[RFC/PATCH 13/15] kvm-s390: update maintainers
[RFC/PATCH 14/15] guest: detect when running on kvm
[RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls


Recommended reading:
If you're interrested in integration into kvm common code, you should
read patches 05-07, and 10.
If you're interrested in sie on s390, you should read patches 05-10.
If you're interrested in memory management, you should read patches
01-02.
If you're Rusty Russell, you should read patch 15.

We would kindly like to ask for review of our work for upstream
inclusion in kvm.git.

with kind regards,
Carsten
