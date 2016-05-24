From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/virtio/ringtest: add usage example to README
Date: Tue, 24 May 2016 15:41:04 +0300
Message-ID: <20160524124104.GB4725@rapoport-lnx>
References: <1462342376-16065-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1462342376-16065-1-git-send-email-rppt@linux.vnet.ibm.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael,

Any updates on this?

On Wed, May 04, 2016 at 09:12:55AM +0300, Mike Rapoport wrote:
> Having typical usage example in the README file is more convinient than in
> the git history...
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  tools/virtio/ringtest/README | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/virtio/ringtest/README b/tools/virtio/ringtest/README
> index 34e94c4..d83707a 100644
> --- a/tools/virtio/ringtest/README
> +++ b/tools/virtio/ringtest/README
> @@ -1,2 +1,6 @@
>  Partial implementation of various ring layouts, useful to tune virtio design.
>  Uses shared memory heavily.
> +
> +Typical use:
> +
> +# sh run-on-all.sh perf stat -r 10 --log-fd 1 -- ./ring
> -- 
> 1.9.1
> 
