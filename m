From: Andrew Morton <akpm@osdl.org>
Subject: warnings in rc4-mm2
Date: Thu, 2 Nov 2006 15:25:07 -0800
Message-ID: <20061102152507.70ab4dd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


i386 allmodconfig

arch/i386/power/cpu.c: In function '__save_processor_state':
arch/i386/power/cpu.c:29: warning: passing argument 1 of 'paravirt_ops.stor=
e_gdt' from incompatible pointer type
arch/i386/power/cpu.c:30: warning: passing argument 1 of 'paravirt_ops.stor=
e_idt' from incompatible pointer type
arch/i386/power/cpu.c: In function '__restore_processor_state':
arch/i386/power/cpu.c:102: warning: passing argument 1 of 'paravirt_ops.loa=
d_gdt' from incompatible pointer type
arch/i386/power/cpu.c:103: warning: passing argument 1 of 'paravirt_ops.loa=
d_idt' from incompatible pointer type
arch/i386/kernel/paravirt.c:481: warning: initialization from incompatible =
pointer type
