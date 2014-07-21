From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 23/25] virtio: Replace DEFINE_PCI_DEVICE_TABLE macro use
Date: Mon, 21 Jul 2014 10:52:48 +0930
Message-ID: <87oawjzes7.fsf@rustcorp.com.au>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
	<1405697232-11785-24-git-send-email-benoit.taine@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1405697232-11785-24-git-send-email-benoit.taine@lip6.fr>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: benoit.taine@lip6.fr, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Benoit Taine <benoit.taine@lip6.fr> writes:
> We should prefer `struct pci_device_id` over `DEFINE_PCI_DEVICE_TABLE` to meet
> kernel coding style guidelines. This issue was reported by checkpatch.
>
> Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>

Thanks, applied.

Cheers,
Rusty.
