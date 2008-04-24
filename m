From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH/RFC] virtio: export more headers to userspace
Date: Thu, 24 Apr 2008 14:02:11 +1000
Message-ID: <200804241402.12567.rusty__45273.9298264079$1209009879$gmane$org@rustcorp.com.au>
References: <200804231257.00427.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804231257.00427.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 April 2008 20:57:00 Christian Borntraeger wrote:
> Rusty,
>
> is there a reason why we dont export the virtio headers for
> 9p, balloon, console, pci, and virtio_ring? kvm uses make sync,
> but I think it is still useful to heave these headers exported
> as they might be useful for other userspace tools.

Applied, thanks.

Cheers,
Rusty.
