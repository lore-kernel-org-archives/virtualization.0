From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 03/11] UAPI: virtio_net: Fix use of C++ keywords as
	structural members
Date: Wed, 5 Sep 2018 13:35:29 -0400
Message-ID: <20180905125636-mutt-send-email-mst__28170.5076843084$1536168811$gmane$org@kernel.org>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
	<153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Howells <dhowells@redhat.com>
Cc: linux-api@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 05, 2018 at 04:54:55PM +0100, David Howells wrote:
> The virtio_net_ctrl_hdr struct uses a C++ keyword as structural members.  Fix
> this by inserting an anonymous union that provides an alternative name and
> then hide the reserved name in C++.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "Michael S. Tsirkin" <mst@redhat.com>
> cc: Jason Wang <jasowang@redhat.com>
> cc: virtualization@lists.linux-foundation.org
> ---
> 
>  include/uapi/linux/virtio_net.h |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..967142bc0e05 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -150,7 +150,12 @@ struct virtio_net_hdr_mrg_rxbuf {
>   * command goes in between.
>   */
>  struct virtio_net_ctrl_hdr {
> -	__u8 class;
> +	union {
> +#ifndef __cplusplus
> +		__u8 class;
> +#endif
> +		__u8 _class;
> +	};
>  	__u8 cmd;
>  } __attribute__((packed));


As long as you do not intend to use any classes, how about
simply adding

-Dclass=_class

to your command line?

Seems to work fine with gcc 8.1.1 on Fedora.

-- 
MST
