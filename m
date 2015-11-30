From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] tools/virtio: move list macro stubs
Date: Mon, 30 Nov 2015 11:07:22 +0100
Message-ID: <20151130110722.4bc1948d.cornelia.huck@de.ibm.com>
References: <1448872891-13717-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448872891-13717-1-git-send-email-mst@redhat.com>
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
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 30 Nov 2015 10:41:35 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Makes them more generally available.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tools/virtio/linux/kernel.h | 6 ++++++
>  tools/virtio/linux/virtio.h | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)

Create a dummy list.h? Or would that be overkill?
