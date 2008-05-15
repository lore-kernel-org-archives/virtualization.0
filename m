From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_net: free transmit skbs in a timer
Date: Fri, 16 May 2008 09:25:17 +1000
Message-ID: <200805160925.18087.rusty__30393.3061114096$1210894819$gmane$org@rustcorp.com.au>
References: <1209565906-9019-1-git-send-email-markmc@redhat.com>
	<1210865380.16012.15.camel@muff> <482C579F.4030509@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482C579F.4030509@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 May 2008 01:32:47 Avi Kivity wrote:
> Mark McLoughlin wrote:
> > I think Rusty is speaking from the POV of the guest driver - i.e. that
> > virtio_net should never disable notifications on the xmit queue using
> > disable_cb()?
> >
> > Sounds like you think agree, but that the host side should throttle the
> > rate of xmit notifications?
>
> Yes.

But performance is going to suck in the meantime, as currently our host 
doesn't do this.

Rusty.
