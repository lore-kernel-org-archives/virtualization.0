From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 16:03:54 +0530
Message-ID: <20090929103354.GA3766__16883.8320336819$1254220698$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<20090922154549.GA11379@amit-x200.redhat.com>
	<20090929092431.GA3368@amit-x200.redhat.com>
	<200909291209.25775.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909291209.25775.borntraeger@de.ibm.com>
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
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Sep 29 2009 [12:09:25], Christian Borntraeger wrote:
> Am Dienstag 29 September 2009 11:24:31 schrieb Amit Shah:
> > OK; how I solved this is: a new internal message between the guest and
> > the host. If a host is a console port, the host has to indicate that by
> > passing a message to the guest and the guest then hooks it up with hvc.
> 
> I am curious how you going to make this compatible with existing code that 
> currently uses virtio console.

I've tested old qemu new kernel, new qemu old kernel, new qemu, new
kernel and all the cases work fine.

Please see the virtcons_probe() function for the details.

		Amit
