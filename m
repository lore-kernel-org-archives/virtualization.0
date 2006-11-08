From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 16:15:17 -0800
Message-ID: <45512195.3060101@goop.org>
References: <4550E512.1020706@goop.org> <45510672.4000301@vmware.com>
	<45510AFF.3040304@goop.org> <455117C0.2030202@vmware.com>
	<455119DB.2000704@goop.org> <45511DD4.80307@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45511DD4.80307@vmware.com>
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
> "Who can discern his errors?  Forgive my hidden faults."
In general that Book doesn't give much in the way of architectural =

certainty.  3.12 IA32SDM isn't much better:

    Whenever a page-directory or page-table entry is changed (including
    when the present flag is set to zero), the operating-system must
    immediately invalidate the corresponding entry in the TLB so that it
    can be updated the next time the entry is referenced.

The parenthetic clause is annoyingly ambiguous: does it mean "when the =

present flag is currently set to 0" or "when setting the present flag to =

0"?  The passive voice should always be avoided.


> Oh, wow.  Unfortunately, the complexity isn't from how frequent or =

> rare a kmapped PT access is, it is from it being there at all.

We'll see how it works out.  What actually needs to do cross-process =

pagetable manipulation?  Fork?  ptrace?

    J
