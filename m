From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] virtio: drop a useless config read
Date: Tue, 31 Mar 2015 15:02:01 +0200
Message-ID: <20150331150201.34cb8823.cornelia.huck@de.ibm.com>
References: <1427802906-7743-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427802906-7743-1-git-send-email-mst@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 31 Mar 2015 13:55:42 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> commit d71de9ec6ba806104439d3a669befda84757b5af
>     "virtio: core support for config generation"
> fixed reading up 64 bit values, adding generation
> checks for such reads.
> 
> By mistake, it left an explicit get call in place
> as well. the result is that the value is read twice,
> the first result is discarded.
> 
> Not a big deal since this only happens with virtio
> blk and only on boot ATM, so performance isn't
> affected, but let's clean it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
