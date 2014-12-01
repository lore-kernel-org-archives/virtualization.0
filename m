From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 13/46] virtio: simplify feature bit handling
Date: Mon, 1 Dec 2014 09:06:18 +0100
Message-ID: <20141201090618.3ca35baa@thinkpad-w530>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
	<1417359787-10138-14-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417359787-10138-14-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> Now that we use u64 for bits, we can simply & them together.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
