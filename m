From: Karl Rister <kmr@us.ibm.com>
Subject: Re: lhype guest oops
Date: Mon, 8 Jan 2007 14:26:47 -0600
Message-ID: <200701081426.47884.kmr@us.ibm.com>
References: <200701051614.31125.kmr@us.ibm.com>
	<1168061023.20372.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1168061023.20372.7.camel@localhost.localdomain>
Content-Disposition: inline
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 05 January 2007 11:23 pm, Rusty Russell wrote:
> On Fri, 2007-01-05 at 16:14 -0600, Karl Rister wrote:
> > I am trying to experiment with lhype on a 32bit Intel box and when I
> > launch a guest I get the following oops message:
> >
> > EIP: [<c0101223>] mwait_idle_with_hints+0x1e/0x3a SS:ESP 0069:c03c9f74
>
> Hi Karl!
>
> 	There are two possible solutions to this.  First is to upgrade to the
> latest patch, which fixes this (and speed up lhype significantly), or
> boot the guest with "idle=3Dhalt".
>
> 	The problem is caused by lhype not masking out the MWAIT capability, so
> the guest thinks it can use that instruction (it can't).
>
> Thanks for the bug report!
> Rusty.

Upgrading to the latest patch as suggested fixed it.  Thanks.

-- =

Karl Rister
