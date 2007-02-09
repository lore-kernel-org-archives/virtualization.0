From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Fri, 09 Feb 2007 16:54:34 +1100
Message-ID: <1171000474.2718.8.camel@localhost.localdomain>
References: <45CC0672.7090201@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC0672.7090201@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-02-08 at 21:28 -0800, Zachary Amsden wrote:
> So, as 2.6.21-rc1 is approaching, what is the upstream merge status for =

> the paravirt-ops backends?  I believe VMI is in Andi's tree, plus or =

> minus some bugfixes that are still being whittled in, but Andi, do you =

> think the VMI code is in good shape for merging?
> =

> It would be nice for everyone to clarify their upstream plans - is the =

> goal still to get Xen and lguest merged for the next kernel release?
> =

> Rusty, you mentioned you had a patchset to push, when do you expect to =

> have it ready?

I'm just doing the final file moving now (everything in
arch/i386/lguest), expect to send out something within 48 hours (I need
to sync up to latest git tree, too).

> One of which is separating the paravirt-ops into GPL =

> and non-GPL exports, which we need consensus on where the line is, but =

> can't really achieve it until everyone is happy with the finalized set =

> of paravirt-ops.  Any patch that tries to do this now would just cause =

> rejects later and slow all of our merges.

Yes, I have a patch, but it breaks kvm.  I'm waiting until things settle
before fixing it.

Cheers,
Rusty.
