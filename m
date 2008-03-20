From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_pci: unregister virtio device at device remove
Date: Thu, 20 Mar 2008 16:46:44 +1100
Message-ID: <200803201646.45006.rusty__18906.5259801739$1205992280$gmane$org@rustcorp.com.au>
References: <1205976904-19592-1-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1205976904-19592-1-git-send-email-aliguori@us.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 20 March 2008 12:35:04 Anthony Liguori wrote:
> Make sure to call unregister_virtio_device() when a virtio device is
> removed. Otherwise, virtio_pci.ko cannot be rmmod'd.
>
> This was spotted by Marcelo Tosatti.
>
> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Thanks, applied.

Rusty.
