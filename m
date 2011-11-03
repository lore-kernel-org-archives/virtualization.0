From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] VirtioConsole support.
Date: Thu, 03 Nov 2011 13:38:15 +0100
Message-ID: <4EB28B37.8030301@de.ibm.com>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
	<1319770558.2529.20.camel@Joe-Laptop>
	<4EAAF23C.8050102@codeaurora.org> <87k47itc7u.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k47itc7u.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@ozlabs.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/11/11 23:02, Rusty Russell wrote:
> Ben, Christian, can you figure out what's going on?  Is it time for a
> complete rewrite?

You are talking about hvc console? Yes it has so many users that it is now
something like a console/tty layer extension, but it was never designed to be
one. 

I think the hardest part would be to get all users together (for testing and
requirements) and then to find someone that is actually doing that rework. Dont
know if the pain level is already that high?

Christian
