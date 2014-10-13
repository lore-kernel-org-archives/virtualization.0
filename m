From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 08/11] virtio_blk: use virtio v1.0 endian
Date: Mon, 13 Oct 2014 16:28:32 +1030
Message-ID: <878ukkecjb.fsf__22725.6761667833$1413183304$gmane$org@rustcorp.com.au>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692792-12325-9-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692792-12325-9-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> Note that we care only about the fields still in use for virtio v1.0.
>
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Hi Cornelia,

        These patches all look good; I'm a bit nervous about our testing
missing some conversion, so we'll need qemu patches for PCI so we can
test on other platforms too.

Thanks,
Rusty.
