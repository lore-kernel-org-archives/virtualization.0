From: Rusty Russell <rusty@ozlabs.org>
Subject: Re: [PATCH] VirtioConsole support.
Date: Thu, 03 Nov 2011 08:32:13 +1030
Message-ID: <87k47itc7u.fsf@rustcorp.com.au>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
	<1319770558.2529.20.camel@Joe-Laptop>
	<4EAAF23C.8050102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4EAAF23C.8050102@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Boyd <sboyd@codeaurora.org>, Joe Perches <joe@perches.com>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 28 Oct 2011 11:19:40 -0700, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Even better would be kmemdup().

OK, this driver is horribly unloved, and ugly.  Noone claims to really
understand it, but people keep poking it.

Ben, Christian, can you figure out what's going on?  Is it time for a
complete rewrite?

Thanks,
Rusty.
