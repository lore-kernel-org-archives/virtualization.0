From: Zachary Amsden <zach@vmware.com>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 22:12:07 -0800
Message-ID: <45CC10B7.2060100@vmware.com>
References: <45CC0672.7090201@vmware.com>
	<1171000474.2718.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171000474.2718.8.camel@localhost.localdomain>
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
>
>> Rusty, you mentioned you had a patchset to push, when do you expect to =

>> have it ready?
>>     =

>
> I'm just doing the final file moving now (everything in
> arch/i386/lguest), expect to send out something within 48 hours (I need
> to sync up to latest git tree, too).
>   =


Cool.

>   =

>> One of which is separating the paravirt-ops into GPL =

>> and non-GPL exports, which we need consensus on where the line is, but =

>> can't really achieve it until everyone is happy with the finalized set =

>> of paravirt-ops.  Any patch that tries to do this now would just cause =

>> rejects later and slow all of our merges.
>>     =

>
> Yes, I have a patch, but it breaks kvm.  I'm waiting until things settle
> before fixing it.
>   =


I think the only other open issue we had was how to cleanly do the =

sysenter disable for Xen.  We want it on for sure, and so does native, =

but Xen needs to disable it.  This could be tied into some nosegneg =

stuff, I can't remember exactly if they were separate patches or what =

happened to the nosegneg stuff.  Presumedly, Xen still needs that as well?

Zach
