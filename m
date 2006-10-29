From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 0/7] x86 paravirtualization infrastructure
Date: Sat, 28 Oct 2006 19:45:04 -0700
Message-ID: <20061029024504.760769000@sous-sol.org>
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
To: akpm@osdl.org, ak@muc.de
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The following patches introduce the core infrastructure needed to
paravirtualize the 32-bit x86 Linux kernel.  This is done by moving
virtualization sensitive insn's or code paths to a function table,
paravirt_ops.  This structure can be populated with hypervisor specific
calls or native stubs and currently support running on bare metal, VMI,
Xen, or Lhype.  These patches apply to 2.6.19-rc2-mm2 plus the last set
of paravirt prep patches that Rusty sent.

thanks,
-chris
--
