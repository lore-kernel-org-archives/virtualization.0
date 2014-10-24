From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v4 07/17] virtio_config: endian conversion for v1.0
Date: Fri, 24 Oct 2014 10:53:27 +0200
Message-ID: <20141024105327.11377ea5.cornelia.huck@de.ibm.com>
References: <1414081380-14623-1-git-send-email-mst@redhat.com>
	<1414081380-14623-8-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1414081380-14623-8-git-send-email-mst@redhat.com>
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

On Thu, 23 Oct 2014 19:24:30 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We (ab)use virtio conversion functions for device-specific
> config space accesses.
> 
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Not objecting to the patch, but something seems to have gotten messed
up wrt authorship? You only adapted it, right?
