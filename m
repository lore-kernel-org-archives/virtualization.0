From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] 2.6.21 - VMI logic error
Date: Fri, 13 Apr 2007 16:32:39 +0200
Message-ID: <200704131632.39464.ak@suse.de>
References: <461EEADE.8060400@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461EEADE.8060400@vmware.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@osdl.org>, Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 13 April 2007 04:28:46 Zachary Amsden wrote:
> So there is a logic error that would prevent us from ever using NOP =

> relocations, thus stopping any unnecessary callouts into a VMI ROM.  It =

> doesn't affect us so much, but could conceivably affect open source =

> implementations of a VMI ROM in the future.  It is not absolutely =

> critical, but it would be extremely nice to get it fixed in 2.6.21 so =

> there are no broken older kernels floating around that mandate having a =

> workaround for this or else breaking compatibility with these kernels.

Patch is fine for me.

-Andi
