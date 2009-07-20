From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 00/54] [Announce] Microsoft Hyper-V drivers for Linux
Date: Mon, 20 Jul 2009 12:57:54 -0700
Message-ID: <20090720195754.GB30483@suse.de>
References: <20090720160025.GA20249@kroah.com>
	<20090720162810.GA22102@kroah.com>
	<20090720165941.GA15660@redhat.com>
	<20090720170345.GA23990@suse.de> <871vob4047.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <871vob4047.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: devel@driverdev.osuosl.org, Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 20, 2009 at 09:37:12PM +0200, Andi Kleen wrote:
> Greg KH <gregkh@suse.de> writes:
> >
> > It's the "normal" way of cleaning up code.  Start with a known-working
> > piece of stuff, and incrementally clean it up. 
> 
> I have to agree with David. This is essentially unreviewable
> in the original state. It would be good if you could
> do all the obvious cleanups first and then post a consolidated
> series.
> 
> Most "obvious" cleanups should not change the binary, so
> you can easily check they are correct by comparing the assembler
> code.

Unfortunatly, some of these cleanups do change the binary, as they are
removing wrapper functions.

Anyway, I agree, for a "proper" review, I will show the final, cleaned
up version, like normal.  But we aren't there just yet, that is why this
code is going to live in the staging tree for a while.  Give us some
time to get it fixed up.

thanks,

greg k-h
