From: Zachary Amsden <zach@vmware.com>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 22:59:22 -0800
Message-ID: <45CC1BCA.8060003@vmware.com>
References: <45CC0672.7090201@vmware.com>	
	<1171000474.2718.8.camel@localhost.localdomain>	
	<45CC10B7.2060100@vmware.com>
	<1171003468.2718.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171003468.2718.10.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thu, 2007-02-08 at 22:12 -0800, Zachary Amsden wrote:
>   =

>> I think the only other open issue we had was how to cleanly do the =

>> sysenter disable for Xen.  We want it on for sure, and so does native, =

>> but Xen needs to disable it.
>>     =

>
> I disable it too: you simply make sure cpuid says it doesn't have SEP
> and it's all good...
>
> A little confused,
> Rusty.
>   =


I believe there was a patch that got applied that turned it off by =

default if CONFIG_PARAVIRT was enabled.  Doing it the cpuid way is the =

right solution, IMHO.

Zach
