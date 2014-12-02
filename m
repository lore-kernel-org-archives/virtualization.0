From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 1/2] virtio_balloon: convert to virtio 1.0 endian-ness
Date: Tue, 2 Dec 2014 19:39:30 +0100
Message-ID: <20141202193930.2b8750f7.cornelia.huck__8811.06127421862$1417545590$gmane$org@de.ibm.com>
References: <1417520617-2135-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417520617-2135-1-git-send-email-mst@redhat.com>
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2 Dec 2014 13:44:06 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> balloon device is not part of virtio 1.0 spec.  Still, it's easy enough
> to make it handle endian-ness exactly as other virtio 1.0 devices: what
> we gain from this, is that there's no need to special-case it in virtio
> core.

Well, the balloon is weird in a number of ways, including its always
little-endian config space.

But I'm not quite sure the spec covers this?

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_balloon.h | 5 +++--
>  drivers/virtio/virtio_balloon.c     | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 

>  struct virtio_balloon_stat {
> -	__u16 tag;
> -	__u64 val;
> +	__virtio16 tag;
> +	__virtio64 val;
>  } __attribute__((packed));

Would the respective fields in the spec need updating? While it is
actually talking about legacy requirements, the fields are not
specified as __virtio{16,64}.

Also, is changing the stat fields enough? I've not looked into balloon
operation, but does the payload need some endianess conversion as well?
