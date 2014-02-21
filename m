From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH] virtio: Use pci_enable_msix_range() instead of
	pci_enable_msix()
Date: Fri, 21 Feb 2014 17:59:47 +0100
Message-ID: <20140221165946.GJ17353@dhcp-26-207.brq.redhat.com>
References: <1392804931-30671-9-git-send-email-agordeev@redhat.com>
	<87eh2yblsk.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87eh2yblsk.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty et al,

Based on recently accepted to the mainline pci_enable_msix_exact() function,
I am sending a updated version of the patch. Please, let me know if it does
not work for you and you need and incremental update from the previous version.

Thanks!


-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
