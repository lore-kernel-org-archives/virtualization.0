From: Andrew Morton <akpm@osdl.org>
Subject: paravirt patches in -mm
Date: Sat, 30 Sep 2006 21:01:29 -0700
Message-ID: <20060930210129.6ea99bd1.akpm@osdl.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


Guys, could you please confirm that these patches from -mm:

paravirt-remove-read-hazard-from-cow.patch
paravirt-pte-clear-not-present.patch
paravirt-lazy-mmu-mode-hooks.patch
paravirt-combine-flush-accessed-dirty.patch
paravirt-kpte-flush.patch
paravirt-optimize-ptep-establish-for-pae.patch
paravirt-remove-set-pte-atomic.patch
paravirt-pae-compile-fix.patch
paravirt-update-pte-hook.patch

are suitable for mainline inclusion?

Thanks.
