From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
Date: Sat, 5 Aug 2006 14:58:40 -0700
Message-ID: <20060805145840.653912a2.akpm@osdl.org>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
	<20060802231912.ed77f930.akpm@osdl.org>
	<44D1A6B6.8040003@vmware.com>
	<20060803004144.554d9882.akpm@osdl.org>
	<44D1BAB8.8070509@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44D1BAB8.8070509@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 03 Aug 2006 01:58:32 -0700
Zachary Amsden <zach@vmware.com> wrote:

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which
> might not happen until userspace is already running, and also provides a
> useful tool to benchmark the performance impact of reduced lowmem address
> space.

Andi has gone and rotorooted the x86 boot parameter handling in there. =

This patch now looks like this:


From: Zachary Amsden <zach@vmware.com>

Add a boot parameter to reserve high linear address space for hypervisors. =

This is necessary to allow dynamically loaded hypervisor modules, which mig=
ht
not happen until userspace is already running, and also provides a useful t=
ool
to benchmark the performance impact of reduced lowmem address space.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/kernel-parameters.txt |    5 +++++
 arch/i386/kernel/setup.c            |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff -puN arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-=
linear-address-space arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-line=
ar-address-space
+++ a/arch/i386/kernel/setup.c
@@ -149,6 +149,12 @@ static char command_line[COMMAND_LINE_SI
 =

 unsigned char __initdata boot_params[PARAM_SIZE];
 =

+static int __init setup_reservetop(char *s)
+{
+	return 1;
+}
+__setup("reservetop", setup_reservetop);
+
 static struct resource data_resource =3D {
 	.name	=3D "Kernel data",
 	.start	=3D 0,
@@ -814,6 +820,24 @@ static int __init parse_vmalloc(char *ar
 early_param("vmalloc", parse_vmalloc);
 =

 /*
+ * reservetop=3Dsize reserves a hole at the top of the kernel address spac=
e which
+ * a hypervisor can load into later.  Needed for dynamically loaded hyperv=
isors,
+ * so relocating the fixmap can be done before paging initialization.
+ */
+static int __init parse_reservetop(char *arg)
+{
+	unsigned long address;
+
+	if (!arg)
+		return -EINVAL;
+
+	address =3D memparse(arg, &arg);
+	reserve_top_address(address);
+	return 0;
+}
+early_param("reservetop", parse_reservetop);
+
+/*
  * Callback for efi_memory_walk.
  */
 static int __init
diff -puN Documentation/kernel-parameters.txt~x86-add-a-bootparameter-to-re=
serve-high-linear-address-space Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt~x86-add-a-bootparameter-to-reserv=
e-high-linear-address-space
+++ a/Documentation/kernel-parameters.txt
@@ -1357,6 +1357,11 @@ running once the system is up.
 =

 	reserve=3D	[KNL,BUGS] Force the kernel to ignore some iomem area
 =

+	reservetop=3D	[IA-32]
+			Format: nn[KMG]
+			Reserves a hole at the top of the kernel virtual
+			address space.
+
 	resume=3D		[SWSUSP]
 			Specify the partition device for software suspend
 =

_
