From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: pgd_alloc and [cd]tors
Date: Thu, 16 Nov 2006 23:14:22 -0800
Message-ID: <455D614E.4010607@goop.org>
References: <455D0773.2050906@goop.org> <455D1A0C.6010001@vmware.com>
	<455D42C7.4070203@goop.org> <455D454C.9040808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <455D454C.9040808@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> No, it doesn't exist under PAE, since PAE uses a common pgd[3]
> therefore the init_mm pgd never needs changing for large page / split
> page PD transitions.  The code is there for non-PAE, but compiled out
> of the PAE version. =


Yep, but it would work if it were restored, right.  I'm adding
SHARED_KERNEL_PMD to replace all the tests on PTRS_PER_PMD, and a
shared_kernel_pmd flag to pvops.

    J
