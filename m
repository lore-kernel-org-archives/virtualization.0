From: Gerd Hoffmann <kraxel@suse.de>
Subject: paravirt & xen & SMP
Date: Wed, 10 Jan 2007 16:23:26 +0100
Message-ID: <45A504EE.5050409@suse.de>
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
To: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

Anyone has this working?  Looks like there is a chicken-and-egg issue
with pda setup:

  * xen_load_gdt() uses multicalls, thus depends on cpu-specific
    variables (per-cpu mc buffer) which in turn requires pda being
    setup already.
  * pda setup can't be done before xen_load_gdt() ...

Next question while looking at xen_load_gdt(): why does it use
multicalls in the first place?  Seems that function puts only one
hypercall into the multicall array, so there is no obvious point in
using multicalls ...

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
