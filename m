From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Sun, 27 Jan 2008 15:22:33 +0200
Message-ID: <479C8599.60007__36697.866061195$1201440381$gmane$org@qumranet.com>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801240118.09032.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Dor Laor <dor.laor@gmail.com>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> +
> +static void vp_reset(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	/* 0 status means a reset. */
> +	return iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
>  }
>   

pci has something called FLR for function-level reset.  If we use that 
as the reset mechanism, then reset can be initiated from outside the 
virtio layer, if the guest OS supports that.

-- 
error compiling committee.c: too many arguments to function
