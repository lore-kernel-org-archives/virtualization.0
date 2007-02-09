From: Zachary Amsden <zach@vmware.com>
Subject: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 21:28:18 -0800
Message-ID: <45CC0672.7090201@vmware.com>
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
To: Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

So, as 2.6.21-rc1 is approaching, what is the upstream merge status for =

the paravirt-ops backends?  I believe VMI is in Andi's tree, plus or =

minus some bugfixes that are still being whittled in, but Andi, do you =

think the VMI code is in good shape for merging?

It would be nice for everyone to clarify their upstream plans - is the =

goal still to get Xen and lguest merged for the next kernel release?

Rusty, you mentioned you had a patchset to push, when do you expect to =

have it ready?

Chris / Jeremy - perhaps I missed it, but I haven't seen updated Xen =

paravirt-ops patches go out yet - is 2.6.21 still the merge target?

I don't want to be pushy, but I do want our code to get merged, and =

time's a ticking.  I think we're all in good shape, but the sooner the =

code all gets merged the sooner we can tackle the remaining cleanup / =

polishing tasks.  One of which is separating the paravirt-ops into GPL =

and non-GPL exports, which we need consensus on where the line is, but =

can't really achieve it until everyone is happy with the finalized set =

of paravirt-ops.  Any patch that tries to do this now would just cause =

rejects later and slow all of our merges.

Zach
