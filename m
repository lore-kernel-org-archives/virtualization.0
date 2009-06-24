From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-serial: A guest <-> host interface for simple communication
Date: Wed, 24 Jun 2009 13:45:01 +0930
Message-ID: <200906241345.02051.rusty__15044.9130371728$1245816938$gmane$org@rustcorp.com.au>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 23 Jun 2009 10:12:31 pm Amit Shah wrote:
> Hello,
>
> Here are two patches. One implements a virtio-serial device in qemu
> and the other is the driver for a guest kernel.
>
> While working on a vmchannel interface that is needed for communication
> between guest userspace and host userspace, I saw that most of the
> interface can be abstracted out as a "serial" device with "ports".

OK, I don't think the "naming" idea works though.  A userspace user would have 
to open each one in turn to get its name.  I'd stick with numbers.

You also don't have dynamic creation and removal, except by hotpluging the 
entire device (which was on your requirements page).

I'd put a size and bitmap in the configuration space, and use that to indicate 
what ports exist.  Register on the change interrupt to get updates.  Drop the 
control vq entirely.

Cheers,
Rusty.
