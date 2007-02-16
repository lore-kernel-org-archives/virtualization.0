From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and disable
	unsupported config options.
Date: Fri, 16 Feb 2007 01:24:14 -0700
Message-ID: <m1ire2h5n5.fsf@ebiederm.dsl.xmission.com>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org> <45D54BFF.80100@vmware.com>
	<m11wkqimjd.fsf@ebiederm.dsl.xmission.com>
	<1171613663.20666.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171613663.20666.30.camel@localhost.localdomain> (Ian Campbell's
	message of "Fri, 16 Feb 2007 08:14:22 +0000")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@XenSource.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell <Ian.Campbell@XenSource.com> writes:

> On Fri, 2007-02-16 at 00:33 -0700, Eric W. Biederman wrote:
>> I know there actually has been some work to get kexec actually working u=
nder
>> Xen but I don't know where that has gone.
>
> kexec/kdump works with Xen 3.0.4 but it's a dom0 only thing so it
> doesn't appear in this patchset.

Ok but we still need to get the failure to user space for domU instead
of trying what works on real hardware and failing.

Eric
