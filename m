From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 0/3] tcm_vhost lock and flush fix
Date: Sun, 17 Mar 2013 13:03:44 +0200
Message-ID: <20130317110344.GA31111@redhat.com>
References: <1363310047-21652-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363310047-21652-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 15, 2013 at 09:14:04AM +0800, Asias He wrote:
> Hello Nicholas & Michael,
> 
> Could any of you pick this series up?
> 
> Changes in v3
> - Add more comments
> 
> Changes in v2
> - Use vq->private_data insteadof vs->vs_endpoint 
> - Add label in vhost_scsi_clear_endpoint to simply unlock code. 
> 
> Asias He (3):
>   tcm_vhost: Add missed lock in vhost_scsi_clear_endpoint()
>   tcm_vhost: Flush vhost_work in vhost_scsi_flush()
>   tcm_vhost: Use vq->private_data to indicate if the endpoint is setup
> 
>  drivers/vhost/tcm_vhost.c | 59 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 10 deletions(-)

Applied, thanks.

> -- 
> 1.8.1.4
