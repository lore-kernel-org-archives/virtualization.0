From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 09:57:13 +1000
Message-ID: <1177286233.17026.8.camel@localhost.localdomain>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>
	<46284B40.5010106@goop.org> <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-04-22 at 08:28 -0600, Eric W. Biederman wrote:
> Yes.  Has anyone thought more about David Miller's suggesting of just
> using the linker and not doing the fancy binary replacement?
> 
> Especially if you are beginning to reimplement the linker anyway.

Nope.  It doesn't do what we need.  See discussion which followed it.

Rusty.
