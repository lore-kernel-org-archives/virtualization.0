From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] xen block: remove driver_data direct access of struct
	device
Date: Thu, 30 Apr 2009 16:38:41 -0700
Message-ID: <20090430233841.GA2676@kroah.com>
References: <20090430222448.GA18690@kroah.com>
	<20090430223535.GO3036@sequoia.sous-sol.org>
	<20090430223757.GB16369@kroah.com>
	<20090430224337.GP3036@sequoia.sous-sol.org>
	<49FA3370.7010802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49FA3370.7010802@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2009 at 04:25:36PM -0700, Jeremy Fitzhardinge wrote:
> Chris Wright wrote:
> > * Greg KH (greg@kroah.com) wrote:
> >   
> >> Thanks, will add it.  Any objections for this to go through my
> >> driver-core tree to Linus for 2.6.31?
> >>     
> >
> > None from me.
> >   
> 
> Fine by me.
> 
> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Thanks, will add this ack and push it myself.

greg k-h
