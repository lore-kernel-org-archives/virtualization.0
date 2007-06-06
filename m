From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC 0/7] proposed updates to boot protocol and paravirt
	booting
Date: Wed, 06 Jun 2007 15:58:37 -0700
Message-ID: <20070606225837.654272428@goop.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This series:
 1. Updates the boot protocol to version 2.07
 2. Clean up the existing build process, to get rid of tools/build and
    make the linker do more heavy lifting
 3. Make the bzImage payload an ELF file.  The bootloader can extract
    this as a naked ELF file by skipping over boot_params.setup_sects worth
    of 16-bit setup code.
 4. Update the boot_params to 2.07, and update the kernel's head.S to
    jump to the appropriate subarch-specific kernel entrypoint.  The
    very earliest code is common (copy boot_params, clear bss); the
    split happens just before the initial pagetable setup.
+ random little changes to make it all hang together

This boots native for me, so everything basically works.  But I haven't
tested it end-to-end yet, because I haven't done the Xen bits yet.
Perhaps Rusty can do the lguest version to verify that its all sound in
principle (hint hint ;).

So, how does it look?

	J
-- 
