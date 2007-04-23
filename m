From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 15:24:25 -0700
Message-ID: <462D3219.9080301@vmware.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org> <462D1CBC.6050405@vmware.com>
	<462D252D.5090008@goop.org> <462D2AF9.9010609@vmware.com>
	<462D300C.8000700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D300C.8000700@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I'm not keen on *requiring* patching to occur, in general.  The
> performance without patching is only a few percent worse than
> native/patched, so its not like its a desperate problem to defer
> implementing it.  (I.e, requiring patching just raises the
> implementation barrier for a pv_ops backend.)
>   

Well, this approach could be used, but it is overloading a bit and does 
make some extra burden on the backends.  Can't argue that.

> Overloading patching for dealing with module exports is interesting, but
> well, I guess I don't see the problem in just exporting paravirt_ops. 
> The two arguments I've seen against it are "security" and "GPL issues",
> but neither seems particularly good.
>   

Yes, I agree on that.  The other argument was "interface flux".

So, Rusty, back to splitting exports or just EXPORT_SYMBOL the thing?

Zach
