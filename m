From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: pgd_alloc and [cd]tors
Date: Thu, 16 Nov 2006 16:50:59 -0800
Message-ID: <455D0773.2050906@goop.org>
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
To: Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Is there any real use in having a ctor/dtor for the pgd cache?  Given
that all pgd allocation happens via pgd_alloc/pgd_free, why not just
fold the [cd]tor in?

I'm asking because Xen wants pgd[3] to be unshared in the PAE case, and
it looks to me like the easiest way to handle that is by making
pgd_alloc/free pv-ops and doing the appropriate thing in the Xen code. =

Would need to sort out the vmalloc mapping replication as well, but I
think that's pretty straightforward.

    J
