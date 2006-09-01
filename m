From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Fri, 01 Sep 2006 08:56:02 -0700
Message-ID: <1157126162.28577.104.camel@localhost.localdomain>
References: <20060901110908.GB15684@skybase>
	<1157124821.28577.88.camel@localhost.localdomain>
	<1157125420.21733.28.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1157125420.21733.28.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: schwidefsky@de.ibm.com
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 17:43 +0200, Martin Schwidefsky wrote:
> This question did come up already. arch_free_page() is done before the
> PageReserved() check so it isn't suitable for stable/unused state
> transitions. You can argue that arch_free_page() should be moved but who
> knows what the architecture defined function is supposed to do?
> page_set_stable/page_set_unused on the other hand have a clearly defined
> meaning. =


With a patch set this large, I think it would at least be a nice thing
to go through and review the other architectures' uses.

-- Dave
