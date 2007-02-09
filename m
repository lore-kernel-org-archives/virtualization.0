From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Fri, 09 Feb 2007 17:44:28 +1100
Message-ID: <1171003468.2718.10.camel@localhost.localdomain>
References: <45CC0672.7090201@vmware.com>
	<1171000474.2718.8.camel@localhost.localdomain>
	<45CC10B7.2060100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC10B7.2060100@vmware.com>
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

On Thu, 2007-02-08 at 22:12 -0800, Zachary Amsden wrote:
> I think the only other open issue we had was how to cleanly do the =

> sysenter disable for Xen.  We want it on for sure, and so does native, =

> but Xen needs to disable it.

I disable it too: you simply make sure cpuid says it doesn't have SEP
and it's all good...

A little confused,
Rusty.
