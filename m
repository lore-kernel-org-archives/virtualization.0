From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 09:33:42 -0700
Message-ID: <45FAC6E6.5090000@goop.org>
References: <45FA054F.6020107@vmware.com>
	<m17itho10v.fsf@ebiederm.dsl.xmission.com>
	<45FAC4EF.4060305@goop.org> <20070316163118.GA12999@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070316163118.GA12999@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> that's what is the case right now, but much of the intention behind the =

> vma based vDSO is to enable per-process randomized vdso locations, and =

> various distributions do that. So the 'modern' vDSO concept is very much =

> relocatable.

No, the point is that it never needs relocating.  The kernel can map it
anywhere and userspace can cope.  Its only the broken glibcs which
require relocation.

    J
