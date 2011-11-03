From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] VirtioConsole support.
Date: Thu, 3 Nov 2011 10:15:01 -0400
Message-ID: <20111103141501.GB26799@phenom.dumpdata.com>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
	<1319770558.2529.20.camel@Joe-Laptop>
	<4EAAF23C.8050102@codeaurora.org> <87k47itc7u.fsf@rustcorp.com.au>
	<4EB28B37.8030301@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4EB28B37.8030301@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: xen-devel@lists.xensource.com, Stephen Boyd <sboyd@codeaurora.org>, Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, Rusty Russell <rusty@ozlabs.org>, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 03, 2011 at 01:38:15PM +0100, Christian Borntraeger wrote:
> On 02/11/11 23:02, Rusty Russell wrote:
> > Ben, Christian, can you figure out what's going on?  Is it time for a
> > complete rewrite?
> 
> You are talking about hvc console? Yes it has so many users that it is now
> something like a console/tty layer extension, but it was never designed to be
> one. 
> 
> I think the hardest part would be to get all users together (for testing and
> requirements) and then to find someone that is actually doing that rework. Dont

I am volunteering myself to test the Xen user of it. Perhaps even add some patches,
albeit my knowledge of the hvc console is that "it works" (well, with this minor
speed bump).

> know if the pain level is already that high?
> 
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
