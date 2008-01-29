From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Tue, 29 Jan 2008 23:38:03 +1100
Message-ID: <200801292338.03916.rusty@rustcorp.com.au>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<200801291421.00278.rusty@rustcorp.com.au>
	<479EDDCE.8000000@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479EDDCE.8000000@qumranet.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 29 January 2008 19:03:26 Avi Kivity wrote:
> Rusty Russell wrote:
> > On Tuesday 29 January 2008 02:59:59 Anthony Liguori wrote:
> >> As Avi pointed out, as we continue to massage the virtio PCI ABI, we can
> >> make things a little more friendly to users by utilizing the PCI
> >> revision field to indicate which version of the ABI we're using.  This
> >> is a hard ABI version and incrementing it will cause the guest driver to
> >> break.
> >>
> >> This is the necessary changes to virtio_pci to support this.
> >>
> >> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> >
> > Applied, thanks.
>
> But that's done at the wrong level.  Anthony agreed the revision ID
> should indicate the device ABI, not just the virtio ABI.  If we move to
> that level, bumping just one device rev id on the host will break all
> devices on the guest.

OK, I'll drop it.

It's dumb anyway, since we can just change the ID if we want to break drivers.  
Having multiple ways of doing something we don't want to do seems silly.

Cheers,
Rusty.
