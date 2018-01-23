From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Ping Re: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling
	it all
Date: Tue, 23 Jan 2018 15:31:32 +1100
Message-ID: <87h8rdp55n.fsf__33517.3205975027$1516681809$gmane$org@concordia.ellerman.id.au>
References: <459e2097-f20a-18f8-17d9-2d9ed011211d@infradead.org>
	<20180107113356.2806-1-vincent.legoll@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180107113356.2806-1-vincent.legoll@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Vincent Legoll <vincent.legoll@gmail.com> writes:

> No need to get into the submenu to disable all VIRTIO-related
> config entries.
>
> This makes it easier to disable all VIRTIO config options
> without entering the submenu. It will also enable one
> to see that en/dis-abled state from the outside menu.
>
> This is only intended to change menuconfig UI, not change
> the config dependencies.
>
> v2: Added "default y" to avoid breaking existing configs
> v3: Fixed wrong indentation, added *-by from Randy
>
> Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # works for me
> ---
>  drivers/virtio/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This has been broken in linux-next for ~6 weeks now, can we please merge
this and get it fixed.

cheers
