From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: add missing __dev{init,exit} markings
Date: Wed, 20 May 2009 00:10:51 +0930
Message-ID: <200905200010.51786.rusty__26006.8643176512$1242744215$gmane$org@rustcorp.com.au>
References: <1242632349-15894-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1242632349-15894-1-git-send-email-vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 May 2009 05:09:09 pm Mike Frysinger wrote:
> -static int virtblk_probe(struct virtio_device *vdev)
> +static int __devinit virtblk_probe(struct virtio_device *vdev)

This makes sense, I think, but then it implies that virtio_dev_probe() should 
also be __devinit, right?

And I look at pci_bus_probe(), and it's not __devinit.

Is the PCI code just slack?
Rusty.
