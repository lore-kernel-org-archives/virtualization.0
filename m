From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and disable
	unsupported config options.
Date: Fri, 16 Feb 2007 00:33:58 -0700
Message-ID: <m11wkqimjd.fsf@ebiederm.dsl.xmission.com>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org> <45D54BFF.80100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D54BFF.80100@vmware.com> (Zachary Amsden's message of "Thu, 15
	Feb 2007 22:15:27 -0800")
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden <zach@vmware.com> writes:

>
> We do support different HZ values, although 100HZ is actually preferable =
for us,
> so I don't object to that.  PREEMPT is supported by us, but not as tested=
 as I
> would like, so I also don't object to dropping it for generic paravirt gu=
ests -
> Rusty - Avi any objections to dropping preempt in terms of lguest/KVM
> paravirtualization?
>
> Paravirt-ops definitely needs a hook for kexec, although we should not di=
sable
> kexec for the natively booted paravirt-ops.  Eric - is there a way to dis=
able it
> at runtime?
>
> We do support the doublefault task gate, and it would be good to keep it,=
 but I
> can't complain so much if it is gone from generic paravirt kernels for no=
w,
> because it is non-essential, and generally fatal anyway.  We do need it f=
or
> native boots of paravirt-ops kernels, however, so turning off the config =
option
> still needs to be revisited

Have machine_kexec_prepare fail.

I think your machine description or paravirt_ops or whatever it is needs
to hook both machine_kexec_prepare and machine_kexec.

I know there actually has been some work to get kexec actually working under
Xen but I don't know where that has gone.

Eric
