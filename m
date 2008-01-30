From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Use PCI revision field to indicate virtio PCI ABI
	version
Date: Wed, 30 Jan 2008 22:10:26 +1100
Message-ID: <200801302210.26874.rusty@rustcorp.com.au>
References: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
	<200801292338.03916.rusty@rustcorp.com.au>
	<479F4E5E.6070909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479F4E5E.6070909@us.ibm.com>
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 30 January 2008 03:03:42 Anthony Liguori wrote:
> Rusty Russell wrote:
> > On Tuesday 29 January 2008 19:03:26 Avi Kivity wrote:
> >> But that's done at the wrong level.  Anthony agreed the revision ID
> >> should indicate the device ABI, not just the virtio ABI.  If we move to
> >> that level, bumping just one device rev id on the host will break all
> >> devices on the guest.
> >
> > OK, I'll drop it.
>
> Please pull in the patch again.

That's OK: I lied, I never dropped it :)

Cheers,
Rusty.
