From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Section mismatch in parainstructions
Date: Tue, 12 Dec 2006 11:14:35 +1100
Message-ID: <1165882475.2132.1.camel@localhost.localdomain>
References: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: akpm <akpm@osdl.org>, virtualization@lists.osdl.org, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-12-10 at 15:58 -0800, Randy Dunlap wrote:
> Is it OK for section .parainstructions to reference
> exit.text?

Yep, it can (and will) reference any section.


> From: Randy Dunlap <randy.dunlap@oracle.com>
> =

> Section .parainstructions should not warn about section mismatches.
> =

> WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exi=
t.text: from .parainstructions after '' (at offset 0x0)
> WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exi=
t.text: from .parainstructions after '' (at offset 0x8)
> =

> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
